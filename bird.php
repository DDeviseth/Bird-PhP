<?php
// ============================================================
// Database Connection
// ============================================================
$host     = 'localhost';
$dbname   = 'bird';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die('<p class="db-error">Database connection failed: ' . htmlspecialchars($e->getMessage()) . '</p>');
}

// ============================================================
// Fetch all published birds with their category and image
// ============================================================
$stmt = $pdo->prepare("
    SELECT
        b.id,
        b.typeOfBirds,
        b.summary,
        b.content,
        b.created,
        c.name        AS continent,
        i.file        AS image_file,
        i.alt         AS image_alt
    FROM birds b
    JOIN category c ON b.category_id = c.id
    LEFT JOIN image i ON b.image_id = i.id
    WHERE b.published = 1
    ORDER BY c.id, b.id
");
$stmt->execute();
$birds = $stmt->fetchAll(PDO::FETCH_ASSOC);

// ============================================================
// DEBUG — remove this block once images are working
// ============================================================
if (isset($_GET['debug'])) {
    echo '<style>body{font-family:monospace;padding:20px;} .ok{color:green;} .fail{color:red;}</style>';
    echo '<h2>🔍 Image Debug</h2>';
    echo '<p><strong>PHP file location:</strong> ' . __DIR__ . '</p>';
    echo '<p><strong>Expected img/ path:</strong> ' . __DIR__ . '/img/</p>';
    echo '<hr>';
    foreach ($birds as $b) {
        $file = $b['image_file'] ?? 'NULL';
        $fullPath = __DIR__ . '/img/' . $file;
        $exists = file_exists($fullPath);
        $icon = $exists ? '✅' : '❌';
        $cls  = $exists ? 'ok' : 'fail';
        echo "<p class='$cls'>$icon &nbsp; <strong>{$b['typeOfBirds']}</strong> → <code>img/$file</code></p>";
    }
    die();
}
// ============================================================

// Group birds by continent
$byContinent = [];
foreach ($birds as $bird) {
    $byContinent[$bird['continent']][] = $bird;
}

// Continent emoji map
$continentEmoji = [
    'Asia'        => '🌸',
    'Europe'      => '🏔️',
    'Americas'    => '🌎',
    'Africa'      => '🌍',
    'Oceania'     => '🦘',
    'Antarctica'  => '🧊',
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Birds of the World</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        /* ================================================
           RESET & BASE
        ================================================ */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --cream:      #f5f0e8;
            --parchment:  #ede5d3;
            --ink:        #1a1510;
            --bark:       #5c3d1e;
            --moss:       #3d5a3e;
            --sky:        #4a7fa5;
            --rust:       #b85c2a;
            --gold:       #c9943a;
            --soft-white: #fdfaf5;
            --shadow:     rgba(26, 21, 16, 0.15);
        }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'DM Sans', sans-serif;
            background-color: var(--cream);
            color: var(--ink);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* ================================================
           HEADER
        ================================================ */
        .site-header {
            background: var(--ink);
            color: var(--cream);
            text-align: center;
            padding: 4rem 2rem 3rem;
            position: relative;
            overflow: hidden;
        }

        .site-header::before {
            content: '';
            position: absolute;
            inset: 0;
            background:
                radial-gradient(ellipse at 20% 50%, rgba(61,90,62,0.3) 0%, transparent 60%),
                radial-gradient(ellipse at 80% 50%, rgba(74,127,165,0.25) 0%, transparent 60%);
            pointer-events: none;
        }

        .header-eyebrow {
            font-family: 'DM Sans', sans-serif;
            font-size: 0.72rem;
            font-weight: 500;
            letter-spacing: 0.3em;
            text-transform: uppercase;
            color: var(--gold);
            margin-bottom: 1rem;
            position: relative;
        }

        .site-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2.8rem, 6vw, 5rem);
            font-weight: 700;
            line-height: 1.1;
            position: relative;
        }

        .site-header h1 em {
            font-style: italic;
            color: var(--gold);
        }

        .header-sub {
            margin-top: 1.2rem;
            font-size: 1rem;
            font-weight: 300;
            color: rgba(245,240,232,0.65);
            letter-spacing: 0.04em;
            position: relative;
        }

        /* Decorative feather line */
        .header-rule {
            display: flex;
            align-items: center;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            position: relative;
        }
        .header-rule span {
            display: block;
            height: 1px;
            width: 80px;
            background: linear-gradient(90deg, transparent, var(--gold));
        }
        .header-rule span:last-child {
            background: linear-gradient(90deg, var(--gold), transparent);
        }
        .header-rule .feather {
            font-size: 1.1rem;
        }

        /* ================================================
           NAV TABS
        ================================================ */
        .continent-nav {
            background: var(--soft-white);
            border-bottom: 2px solid var(--parchment);
            position: sticky;
            top: 0;
            z-index: 50;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            scrollbar-width: none;
        }
        .continent-nav::-webkit-scrollbar { display: none; }

        .continent-nav ul {
            display: flex;
            list-style: none;
            padding: 0 2rem;
            width: max-content;
            min-width: 100%;
        }

        .continent-nav li a {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            padding: 1rem 1.4rem;
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 500;
            letter-spacing: 0.05em;
            color: var(--bark);
            border-bottom: 3px solid transparent;
            transition: all 0.2s ease;
            white-space: nowrap;
        }
        .continent-nav li a:hover {
            color: var(--moss);
            border-bottom-color: var(--moss);
        }

        /* ================================================
           MAIN CONTENT
        ================================================ */
        .main {
            max-width: 1300px;
            margin: 0 auto;
            padding: 3rem 2rem 6rem;
        }

        /* ================================================
           CONTINENT SECTION
        ================================================ */
        .continent-section {
            margin-bottom: 5rem;
        }

        .continent-heading {
            display: flex;
            align-items: baseline;
            gap: 1rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--parchment);
        }

        .continent-emoji {
            font-size: 1.6rem;
            line-height: 1;
        }

        .continent-heading h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 700;
            color: var(--ink);
        }

        .continent-count {
            font-size: 0.78rem;
            font-weight: 500;
            letter-spacing: 0.15em;
            text-transform: uppercase;
            color: var(--gold);
            margin-left: auto;
        }

        /* ================================================
           BIRD GRID
        ================================================ */
        .bird-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
        }

        /* ================================================
           BIRD CARD
        ================================================ */
        .bird-card {
            background: var(--soft-white);
            border-radius: 4px;
            overflow: hidden;
            box-shadow: 0 2px 8px var(--shadow);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
            cursor: pointer;
        }

        .bird-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 32px var(--shadow);
        }

        .bird-card:hover .card-img img {
            transform: scale(1.06);
        }

        .bird-card:hover .card-overlay {
            opacity: 1;
        }

        .card-img {
            position: relative;
            aspect-ratio: 4 / 3;
            overflow: hidden;
            background: var(--parchment);
        }

        .card-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            transition: transform 0.5s ease;
        }

        /* Placeholder when no image */
        .card-img-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.5rem;
            background: linear-gradient(135deg, var(--parchment) 0%, #ddd5c0 100%);
        }

        .card-overlay {
            position: absolute;
            inset: 0;
            background: rgba(26,21,16,0.45);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .card-overlay-label {
            font-size: 0.75rem;
            font-weight: 500;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: #fff;
            border: 1px solid rgba(255,255,255,0.7);
            padding: 0.5rem 1.1rem;
            border-radius: 2px;
        }

        .card-body {
            padding: 1.1rem 1.2rem 1.3rem;
        }

        .card-name {
            font-family: 'Playfair Display', serif;
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--ink);
            margin-bottom: 0.35rem;
            line-height: 1.3;
        }

        .card-summary {
            font-size: 0.82rem;
            color: var(--bark);
            font-weight: 400;
            line-height: 1.5;
        }

        /* ================================================
           MODAL
        ================================================ */
        .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 10, 5, 0.82);
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.35s ease, visibility 0.35s ease;
            backdrop-filter: blur(6px);
            -webkit-backdrop-filter: blur(6px);
        }

        .modal-overlay.is-open {
            opacity: 1;
            visibility: visible;
        }

        .modal {
            background: var(--soft-white);
            border-radius: 6px;
            max-width: 880px;
            width: 100%;
            max-height: 90vh;
            overflow-y: auto;
            display: grid;
            grid-template-columns: 1fr 1fr;
            box-shadow: 0 40px 100px rgba(0,0,0,0.6);
            transform: translateY(30px) scale(0.97);
            transition: transform 0.35s cubic-bezier(0.34,1.56,0.64,1);
            position: relative;
        }

        .modal-overlay.is-open .modal {
            transform: translateY(0) scale(1);
        }

        /* Modal Left — large image */
        .modal-img-wrap {
            position: relative;
            overflow: hidden;
            background: var(--ink);
            min-height: 380px;
        }

        .modal-img-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            opacity: 0;
            transform: scale(1.05);
            transition: opacity 0.5s ease 0.1s, transform 0.6s ease 0.1s;
        }

        .modal-overlay.is-open .modal-img-wrap img {
            opacity: 1;
            transform: scale(1);
        }

        .modal-img-placeholder {
            width: 100%;
            height: 100%;
            min-height: 380px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 5rem;
            background: linear-gradient(135deg, #2a2018 0%, #1a1510 100%);
        }

        /* Continent badge on image */
        .modal-continent-badge {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background: rgba(26,21,16,0.75);
            color: var(--gold);
            font-size: 0.7rem;
            font-weight: 500;
            letter-spacing: 0.18em;
            text-transform: uppercase;
            padding: 0.35rem 0.75rem;
            border-radius: 2px;
            backdrop-filter: blur(4px);
        }

        /* Modal Right — info */
        .modal-info {
            padding: 2.2rem 2rem 2rem;
            display: flex;
            flex-direction: column;
            overflow-y: auto;
        }

        .modal-eyebrow {
            font-size: 0.7rem;
            font-weight: 500;
            letter-spacing: 0.22em;
            text-transform: uppercase;
            color: var(--rust);
            margin-bottom: 0.6rem;
        }

        .modal-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: 700;
            line-height: 1.2;
            color: var(--ink);
            margin-bottom: 0.5rem;
        }

        .modal-summary {
            font-size: 0.88rem;
            font-weight: 500;
            color: var(--bark);
            font-style: italic;
            margin-bottom: 1.4rem;
            padding-bottom: 1.2rem;
            border-bottom: 1px solid var(--parchment);
            line-height: 1.5;
        }

        .modal-content {
            font-size: 0.9rem;
            line-height: 1.78;
            color: #3a3020;
            flex: 1;
        }

        .modal-date {
            margin-top: 1.6rem;
            font-size: 0.72rem;
            color: #a09070;
            letter-spacing: 0.08em;
        }

        /* Close button */
        .modal-close {
            position: absolute;
            top: 1rem;
            right: 1rem;
            width: 36px;
            height: 36px;
            background: rgba(26,21,16,0.65);
            border: none;
            border-radius: 50%;
            color: #fff;
            font-size: 1.1rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10;
            transition: background 0.2s ease, transform 0.2s ease;
            backdrop-filter: blur(4px);
        }
        .modal-close:hover {
            background: var(--rust);
            transform: rotate(90deg);
        }

        /* ================================================
           RESPONSIVE
        ================================================ */
        @media (max-width: 700px) {
            .modal {
                grid-template-columns: 1fr;
                max-height: 92vh;
            }
            .modal-img-wrap {
                min-height: 240px;
                max-height: 260px;
            }
            .modal-info {
                padding: 1.5rem;
            }
            .modal-title {
                font-size: 1.4rem;
            }
            .continent-nav ul {
                padding: 0 1rem;
            }
        }

        @media (max-width: 480px) {
            .bird-grid {
                grid-template-columns: 1fr 1fr;
                gap: 0.9rem;
            }
            .card-body { padding: 0.8rem; }
            .card-name { font-size: 0.9rem; }
            .card-summary { font-size: 0.75rem; }
        }

        /* ================================================
           SCROLLBAR (modal)
        ================================================ */
        .modal-info::-webkit-scrollbar { width: 5px; }
        .modal-info::-webkit-scrollbar-track { background: transparent; }
        .modal-info::-webkit-scrollbar-thumb { background: var(--parchment); border-radius: 10px; }

        /* ================================================
           FOOTER
        ================================================ */
        .site-footer {
            text-align: center;
            padding: 2.5rem;
            font-size: 0.78rem;
            color: var(--bark);
            border-top: 1px solid var(--parchment);
            letter-spacing: 0.06em;
        }

        .db-error {
            background: #fee;
            color: #c00;
            padding: 1rem 2rem;
            font-family: monospace;
        }
    </style>
</head>
<body>

<!-- ============================================================
     HEADER
============================================================ -->
<header class="site-header">
    <p class="header-eyebrow">A Field Guide</p>
    <h1>Birds of the <em>World</em></h1>
    <p class="header-sub">36 species across 6 continents — click any bird to discover more</p>
    <div class="header-rule">
        <span></span>
        <span class="feather">🪶</span>
        <span></span>
    </div>
</header>

<!-- ============================================================
     CONTINENT NAV
============================================================ -->
<nav class="continent-nav" aria-label="Jump to continent">
    <ul>
        <?php foreach ($byContinent as $continent => $list): ?>
            <li>
                <a href="#<?= htmlspecialchars(strtolower($continent)) ?>">
                    <?= $continentEmoji[$continent] ?? '🌐' ?>
                    <?= htmlspecialchars($continent) ?>
                </a>
            </li>
        <?php endforeach; ?>
    </ul>
</nav>

<!-- ============================================================
     MAIN
============================================================ -->
<main class="main">

    <?php foreach ($byContinent as $continent => $list): ?>
    <section
        class="continent-section"
        id="<?= htmlspecialchars(strtolower($continent)) ?>"
    >
        <div class="continent-heading">
            <span class="continent-emoji"><?= $continentEmoji[$continent] ?? '🌐' ?></span>
            <h2><?= htmlspecialchars($continent) ?></h2>
            <span class="continent-count"><?= count($list) ?> species</span>
        </div>

        <div class="bird-grid">
            <?php foreach ($list as $bird): ?>
            <article
                class="bird-card"
                role="button"
                tabindex="0"
                aria-label="View details for <?= htmlspecialchars($bird['typeOfBirds']) ?>"
                onclick="openModal(this)"
                onkeydown="if(event.key==='Enter'||event.key===' ') openModal(this)"
                data-name="<?= htmlspecialchars($bird['typeOfBirds']) ?>"
                data-summary="<?= htmlspecialchars($bird['summary']) ?>"
                data-content="<?= htmlspecialchars($bird['content']) ?>"
                data-continent="<?= htmlspecialchars($continent) ?>"
                data-emoji="<?= $continentEmoji[$continent] ?? '🌐' ?>"
                data-image="<?= htmlspecialchars($bird['image_file'] ?? '') ?>"
                data-alt="<?= htmlspecialchars($bird['image_alt'] ?? $bird['typeOfBirds']) ?>"
                data-created="<?= htmlspecialchars(date('F j, Y', strtotime($bird['created']))) ?>"
            >
                <!-- Card thumbnail -->
                <div class="card-img">
                    <?php if (!empty($bird['image_file'])): ?>
                    <img
                        src="img/<?= htmlspecialchars($bird['image_file']) ?>"
                        alt="<?= htmlspecialchars($bird['image_alt'] ?? $bird['typeOfBirds']) ?>"
                        loading="lazy"
                        onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                    >
                    <div class="card-img-placeholder" style="display:none">🐦</div>
                    <?php else: ?>
                    <div class="card-img-placeholder">🐦</div>
                    <?php endif; ?>

                    <div class="card-overlay">
                        <span class="card-overlay-label">View Bird</span>
                    </div>
                </div>

                <!-- Card info -->
                <div class="card-body">
                    <h3 class="card-name"><?= htmlspecialchars($bird['typeOfBirds']) ?></h3>
                    <p class="card-summary"><?= htmlspecialchars($bird['summary']) ?></p>
                </div>
            </article>
            <?php endforeach; ?>
        </div>
    </section>
    <?php endforeach; ?>

</main>

<!-- ============================================================
     FOOTER
============================================================ -->
<footer class="site-footer">
    🪶 Birds of the World &mdash; <?= count($birds) ?> species catalogued across <?= count($byContinent) ?> continents
</footer>

<!-- ============================================================
     MODAL
============================================================ -->
<div
    class="modal-overlay"
    id="birdModal"
    role="dialog"
    aria-modal="true"
    aria-labelledby="modalTitle"
    onclick="handleOverlayClick(event)"
>
    <div class="modal">
        <button class="modal-close" onclick="closeModal()" aria-label="Close">&times;</button>

        <!-- Left: image -->
        <div class="modal-img-wrap" id="modalImgWrap">
            <!-- Filled by JS -->
        </div>

        <!-- Right: details -->
        <div class="modal-info">
            <p class="modal-eyebrow" id="modalContinent"></p>
            <h2 class="modal-title" id="modalTitle"></h2>
            <p class="modal-summary" id="modalSummary"></p>
            <p class="modal-content" id="modalContent"></p>
            <p class="modal-date" id="modalDate"></p>
        </div>
    </div>
</div>

<!-- ============================================================
     JAVASCRIPT
============================================================ -->
<script>
    const modal        = document.getElementById('birdModal');
    const modalImgWrap = document.getElementById('modalImgWrap');
    const modalContinent = document.getElementById('modalContinent');
    const modalTitle   = document.getElementById('modalTitle');
    const modalSummary = document.getElementById('modalSummary');
    const modalContent = document.getElementById('modalContent');
    const modalDate    = document.getElementById('modalDate');

    // Image pairs: clicking shows a "detail" version
    // Convention: primary = images/birds/NAME.jpg
    //             detail  = images/birds/NAME-detail.jpg
    // Falls back gracefully if detail doesn't exist.

    function openModal(card) {
        const name      = card.dataset.name;
        const summary   = card.dataset.summary;
        const content   = card.dataset.content;
        const continent = card.dataset.continent;
        const emoji     = card.dataset.emoji;
        const image     = card.dataset.image;
        const alt       = card.dataset.alt;
        const created   = card.dataset.created;

        // Strip any extension to get base name
        // e.g. "annashummingbird.webp" → "annashummingbird"
        // e.g. "european-robin.jpg"    → "european-robin"
        const baseName     = image.replace(/\.(webp|jpg|jpeg|png)$/i, '');
        const primaryImage = image;                  // original file as-is from DB
        const detailWebp   = baseName + '2.webp';   // try webp detail first
        const detailJpg    = baseName + '2.jpg';    // fallback jpg detail

        // Populate text
        modalContinent.textContent = emoji + '  ' + continent;
        modalTitle.textContent     = name;
        modalSummary.textContent   = summary;
        modalContent.textContent   = content;
        modalDate.textContent      = 'Catalogued ' + created;

        // Populate image — try detail version, fallback to original
        modalImgWrap.innerHTML = '';

        if (image) {
            // Continent badge
            const badge = document.createElement('span');
            badge.className = 'modal-continent-badge';
            badge.textContent = continent;
            modalImgWrap.appendChild(badge);

            const img = document.createElement('img');
            img.alt = alt;

            // Try: detail.webp → detail.jpg → original → placeholder
            img.src = 'img/' + detailWebp;
            img.onerror = function() {
                if (this.src.endsWith(detailWebp)) {
                    // try jpg detail
                    this.src = 'img/' + detailJpg;
                } else if (this.src.endsWith(detailJpg)) {
                    // fall back to original
                    this.onerror = function() {
                        this.remove();
                        const ph = document.createElement('div');
                        ph.className = 'modal-img-placeholder';
                        ph.textContent = '🐦';
                        modalImgWrap.prepend(ph);
                    };
                    this.src = 'img/' + primaryImage;
                }
            };

            modalImgWrap.appendChild(img);
        } else {
            const ph = document.createElement('div');
            ph.className = 'modal-img-placeholder';
            ph.textContent = '🐦';
            modalImgWrap.appendChild(ph);
        }

        // Open
        modal.classList.add('is-open');
        document.body.style.overflow = 'hidden';

        // Focus the modal for accessibility
        modal.querySelector('.modal-close').focus();
    }

    function closeModal() {
        modal.classList.remove('is-open');
        document.body.style.overflow = '';
    }

    function handleOverlayClick(e) {
        if (e.target === modal) closeModal();
    }

    // Close on Escape
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && modal.classList.contains('is-open')) {
            closeModal();
        }
    });
</script>

</body>
</html>