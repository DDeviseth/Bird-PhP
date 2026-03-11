--
-- Database: `phpbook-birds`
-- Birds of the World — 6 species per continent
-- --------------------------------------------------------

--
-- Table structure for table `birds`
-- FIXED: unified table name, corrected column names
--

CREATE TABLE `birds` (
  `id` int(11) NOT NULL,
  `typeOfBirds` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `image_id` int(11) DEFAULT NULL,
  `published` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `birds`
-- 6 species per continent | category_id: 1=Asia, 2=Europe, 3=Americas, 4=Africa, 5=Oceania, 6=Antarctica
--

INSERT INTO `birds` (`id`, `typeOfBirds`, `summary`, `content`, `created`, `category_id`, `member_id`, `image_id`, `published`) VALUES

-- ASIA (category_id = 1) — Starting with cute Japanese birds!
(1,  'Japanese Robin', 'A tiny, flame-chested songbird of Japan''s mountain forests', 'The Japanese Robin (Larvivora akahige) is one of Japan''s most beloved birds, known locally as "Komadori." With its vivid orange breast and soft brown plumage, it resembles a glowing autumn leaf perched among bamboo. It sings a gentle, flute-like melody at dawn and dusk, making it a symbol of peaceful forest mornings in Japanese poetry and art.', '2024-01-10 08:00:00', 1, 1, 1, 1),
(2,  'Red-crowned Crane', 'Japan''s sacred crane — the bird of luck and longevity', 'The Red-crowned Crane (Grus japonensis), called "Tancho" in Japanese, is one of the rarest cranes on Earth. Standing nearly 1.5 metres tall with striking white plumage and a bold red crown, it performs an elaborate and graceful mating dance in the snowy fields of Hokkaido. It is considered a national treasure in Japan and a symbol of happiness, fidelity, and long life.', '2024-01-11 09:00:00', 1, 1, 2, 1),
(3,  'Narcissus Flycatcher', 'A jewel-bright songbird found only in East Asia', 'The Narcissus Flycatcher (Ficedula narcissina) is named for its dazzling colours — the male sports a golden-yellow throat, jet-black wings, and a white wing patch. Found across Japan, Korea, and eastern China, it migrates south each winter. Its cheerful, bubbling song echoes through deciduous forests in spring, making it a favourite among birdwatchers visiting Japanese parks and woodlands.', '2024-01-12 10:00:00', 1, 2, 3, 1),
(4,  'Varied Tit', 'A curious and acrobatic little tit native to Japan and Korea', 'The Varied Tit (Sittiparus varius), or "Yamagara" in Japanese, is a small but bold bird with a chestnut belly, black cap, and white cheeks. It is famously intelligent — in Japanese culture, trained Varied Tits were historically used to pull tiny fortune-telling cards from shrines. Today it is a common and cheerful visitor to Japanese garden feeders and wooded hillsides.', '2024-01-13 11:00:00', 1, 2, 4, 1),
(5,  'Japanese White-eye', 'A delicate green sprite flitting through cherry blossoms', 'The Japanese White-eye (Zosterops japonicus), known as "Mejiro," is a tiny, bright green bird with a distinctive white eye-ring that makes it look perpetually wide-eyed and surprised. It is one of the most frequently depicted birds in Japanese painting and poetry, often shown perched among plum or cherry blossoms. It feeds on nectar and soft fruit and moves in cheerful, chattering flocks.', '2024-01-14 12:00:00', 1, 3, 5, 1),
(6,  'Eurasian Kingfisher', 'A flash of iridescent blue along Asia''s rivers and streams', 'The Common Kingfisher (Alcedo atthis) is found from Ireland to Japan and is considered one of the most beautiful birds in Asia. In Japan it is called "Kawasemi," meaning "river cicada." Its back gleams electric blue-green and its underside blazes copper-orange. It perches motionless above clear streams before diving with pinpoint precision to catch small fish, making it a favourite subject in East Asian brushwork paintings.', '2024-01-15 13:00:00', 1, 3, 6, 1),

-- EUROPE (category_id = 2)
(7,  'European Robin', 'Britain''s beloved red-breasted garden companion', 'The European Robin (Erithacus rubecula) is arguably Europe''s most recognised bird. Its round body, beady black eye, and famously bold red breast make it a year-round fixture in gardens from Iceland to the Mediterranean. Robins are notably fearless and will often follow gardeners closely, hoping to snatch unearthed worms. In the UK it is the unofficial national bird and a perennial symbol of Christmas.', '2024-01-16 08:00:00', 2, 1, 7, 1),
(8,  'Atlantic Puffin', 'The clown of the sea — a charming seabird with a painted beak', 'The Atlantic Puffin (Fratercula arctica) breeds on rocky sea cliffs from Iceland to the British Isles and spends the rest of its life far out at sea. Its extraordinary multicoloured beak — striped in orange, yellow, and blue-grey — is used to attract mates and is shed in winter. Puffins are remarkable divers, using their wings to "fly" underwater at depths of up to 60 metres in pursuit of sand eels.', '2024-01-17 09:00:00', 2, 1, 8, 1),
(9,  'European Bee-eater', 'A rainbow-coloured acrobat of the southern European sky', 'The European Bee-eater (Merops apiaster) is one of Europe''s most dazzling birds, adorned in chestnut, yellow, turquoise, and black. True to its name, it feeds almost exclusively on bees and wasps, catching them in mid-air and rubbing them against a branch to remove the sting before swallowing. It nests colonially in sandy river banks and its liquid, rolling call fills warm Mediterranean afternoons.', '2024-01-18 10:00:00', 2, 2, 9, 1),
(10, 'White Stork', 'Europe''s legendary baby-deliverer and rooftop nester', 'The White Stork (Ciconia ciconia) is one of Europe''s most iconic large birds, famous for nesting on rooftops and chimneys across Germany, Poland, and Spain. Standing over a metre tall with snow-white plumage and a bright red bill, it migrates to sub-Saharan Africa each winter in vast, soaring flocks. In folklore it is said to bring good luck and, of course, newborn babies.', '2024-01-19 11:00:00', 2, 2, 10, 1),
(11, 'Barn Swallow', 'Europe''s most graceful aerial insect hunter', 'The Barn Swallow (Hirundo rustica) is one of the world''s most widespread birds and a beloved harbinger of summer across Europe. Its deep blue-black back, rusty-red throat, and deeply forked tail make it instantly recognisable. It skims over fields and ponds at breathtaking speed, snapping up insects in flight. Swallows return to the same barn or eave every year, forging a deep cultural bond with the farmers who welcome them.', '2024-01-20 12:00:00', 2, 3, 11, 1),
(12, 'Eurasian Hoopoe', 'A striking crested bird with a crown fit for royalty', 'The Eurasian Hoopoe (Upupa epops) is unmistakable — a sandy-pink bird with bold black-and-white striped wings and a spectacular fan-shaped crest tipped in black. Found across southern Europe and Asia, it probes soil with its long curved bill for insects and grubs. Its low, resonant "oop-oop-oop" call carries far across olive groves and vineyards. It is the national bird of Israel and has appeared in human art since ancient Egypt.', '2024-01-21 13:00:00', 2, 3, 12, 1),

-- AMERICAS (category_id = 3)
(13, 'Resplendent Quetzal', 'The sacred emerald bird of the ancient Maya and Aztec', 'The Resplendent Quetzal (Pharomachrus mocinno) is widely regarded as the most beautiful bird in the Western Hemisphere. The male has iridescent emerald-green plumage and trailing tail feathers up to 1 metre long. Sacred to the Maya and Aztec civilisations, its feathers were used in the headdresses of kings. Today it is the national bird of Guatemala and a symbol of freedom and beauty throughout Central America.', '2024-01-22 08:00:00', 3, 1, 13, 1),
(14, 'Toco Toucan', 'The Amazon''s most iconic and colourful beak', 'The Toco Toucan (Ramphastos toco) is the largest toucan species, famous for its enormous orange and black beak — which, despite appearances, is hollow, lightweight, and used to regulate body temperature. Found across South America''s open woodlands and forest edges, it feeds on fruit, eggs, and small reptiles. Its loud, frog-like croaking call echoes through the rainforest canopy and its image has become synonymous with tropical biodiversity.', '2024-01-23 09:00:00', 3, 1, 14, 1),
(15, 'Anna''s Hummingbird', 'A hovering jewel — North America''s glittering nectar seeker', 'Anna''s Hummingbird (Calypte anna) is one of the most common hummingbirds along the western coast of North America. The male''s entire head and throat shimmer in brilliant rose-pink iridescence, flashing like a living gemstone. It is one of the few hummingbirds that does not migrate, remaining year-round in gardens and chaparral. It can beat its wings up to 40 times per second and enter a deep, hibernation-like sleep called torpor each night.', '2024-01-24 10:00:00', 3, 2, 15, 1),
(16, 'Scarlet Macaw', 'The vivid, voice-filled giant of the tropical rainforest', 'The Scarlet Macaw (Ara macao) is one of the largest and most spectacular parrots in the world, blazing in red, yellow, and blue against the green rainforest canopy. Found from Mexico to the Amazon basin, it mates for life and pairs are rarely seen apart. Scarlet Macaws are highly intelligent and vocal, capable of mimicking sounds and communicating in complex flocks. They are threatened by habitat loss and the illegal pet trade.', '2024-01-25 11:00:00', 3, 2, 16, 1),
(17, 'Blue-footed Booby', 'The dancing bird with the most improbable blue feet', 'The Blue-footed Booby (Sula nebouxii) of the Galápagos Islands and Pacific coasts of the Americas is famous for its brilliantly blue feet, which the male shows off in an elaborate high-stepping courtship dance. The bluer the feet, the healthier the male — females choose partners accordingly. Despite their comical appearance on land, boobies are spectacular plunge-divers, folding their wings and hitting the water at up to 100 km/h.', '2024-01-26 12:00:00', 3, 3, 17, 1),
(18, 'American Flamingo', 'The pink wading giant of the Caribbean and South America', 'The American Flamingo (Phoenicopterus ruber) is the brightest of all flamingo species, coloured deep pink to coral-red from the carotenoid pigments in the algae and shrimp it filters from shallow lagoons. Found in the Caribbean, Galápagos, and coastal South America, it stands in vast, noisy colonies of thousands. Its distinctively bent bill is uniquely adapted to filter-feeding upside-down in the water.', '2024-01-27 13:00:00', 3, 3, 18, 1),

-- AFRICA (category_id = 4)
(19, 'African Pygmy Kingfisher', 'A tiny jewel darting through the African bush', 'The African Pygmy Kingfisher (Ispidina picta) is one of the smallest and most dazzling birds of sub-Saharan Africa. No bigger than a large bumblebee, it flashes violet, rufous-orange, and turquoise through dense bush and riverine thickets. Unlike most kingfishers, it rarely fishes — it hunts insects, frogs, and lizards in the undergrowth. Its size and speed make it a delightful challenge for birdwatchers across the continent.', '2024-01-28 08:00:00', 4, 1, 19, 1),
(20, 'Lilac-breasted Roller', 'Africa''s most colourful acrobat of the open savanna', 'The Lilac-breasted Roller (Coracias caudatus) is often cited as the most beautiful bird in Africa. It displays an astonishing palette — turquoise, lilac, chestnut, green, and electric blue — all in a single compact bird. It perches prominently on dead trees and fence posts across eastern and southern Africa''s savannas, scanning for insects and small prey. During courtship, it performs dramatic rolling dives through the air, showing off every colour in succession.', '2024-01-29 09:00:00', 4, 1, 20, 1),
(21, 'African Grey Parrot', 'The most intelligent parrot — a master of speech and problem solving', 'The African Grey Parrot (Psittacus erithacus) is widely considered the most cognitively gifted of all parrots. Native to the rainforests of Central and West Africa, it can develop a vocabulary of over 1,000 words and demonstrably understands concepts of colour, shape, and number. The famous research subject Alex could identify objects, count, and even express emotions. Sadly, heavy trapping for the pet trade has made it endangered in the wild.', '2024-01-30 10:00:00', 4, 2, 21, 1),
(22, 'Secretary Bird', 'The long-legged raptor that hunts snakes on foot', 'The Secretary Bird (Sagittarius serpentarius) is one of Africa''s most extraordinary raptors — a large eagle-like bird that hunts entirely on foot across the open grasslands of sub-Saharan Africa. It stomps on prey with powerful legs, delivering lethal kicks to snakes and rodents. Its name likely comes from the long black feathers behind its head, resembling the quill pens that 19th-century secretaries tucked behind their ears.', '2024-01-31 11:00:00', 4, 2, 22, 1),
(23, 'Superb Starling', 'A metallic-sheened beauty of the East African plains', 'The Superb Starling (Lamprotornis superbus) of Kenya and Tanzania is the very definition of its name. Its back and wings gleam in iridescent blue-green, its belly burns rufous-orange, and a clean white band separates them. Found in open woodlands and Maasai Mara camps — where it has learned to dine alongside tourists — it is gregarious, noisy, and completely fearless, making it many visitors'' first and favourite African bird encounter.', '2024-02-01 12:00:00', 4, 3, 23, 1),
(24, 'Southern Yellow-billed Hornbill', 'The iconic "flying banana" of the African savanna', 'The Southern Yellow-billed Hornbill (Tockus leucomelas) is beloved across Botswana, Zimbabwe, and South Africa for its comically large yellow beak and bobbing, undulating flight. It has earned the affectionate nickname "flying banana." Made famous internationally as the inspiration for Zazu in The Lion King, it forages on the ground for insects, seeds, and small creatures, and famously seals the female inside a tree-hole nest during incubation.', '2024-02-02 13:00:00', 4, 3, 24, 1),

-- OCEANIA (category_id = 5)
(25, 'Superb Fairywren', 'Australia''s dazzling blue sprite of the backyard scrub', 'The Superb Fairywren (Malurus cyaneus) is one of Australia''s most cherished birds. The breeding male is a tiny, electric-blue gem with a long upright tail — a regular visitor to suburban gardens across eastern and southern Australia. Despite its vivid appearance, it is a surprisingly complex creature: females mate with multiple males, offspring help raise younger siblings, and males bring flower petals to females as a courtship display.', '2024-02-03 08:00:00', 5, 1, 25, 1),
(26, 'Kākāpō', 'The world''s heaviest parrot — a flightless nocturnal giant', 'The Kākāpō (Strigops habroptilus) of New Zealand is one of the world''s most extraordinary birds — a large, flightless, nocturnal parrot that can live for up to 90 years. Once widespread, it was driven to the brink of extinction by introduced predators. Today fewer than 250 individuals survive, all on predator-free islands managed by New Zealand''s intensive recovery programme. Each individual has a name and is personally monitored by conservation teams.', '2024-02-04 09:00:00', 5, 1, 26, 1),
(27, 'Tawny Frogmouth', 'Australia''s master of disguise — not an owl, but equally mysterious', 'The Tawny Frogmouth (Podargus strigoides) is one of Australia''s most cryptic and captivating birds. It is often mistaken for an owl but is more closely related to nightjars. By day it roosts motionless on a broken branch, its bark-patterned plumage making it nearly invisible. At night its enormous, wide beak opens to reveal a surprisingly large gape, perfect for catching moths, beetles, and small frogs in the dark.', '2024-02-05 10:00:00', 5, 2, 27, 1),
(28, 'Rainbow Lorikeet', 'A flying rainbow — Australia''s noisiest and most colourful parrot', 'The Rainbow Lorikeet (Trichoglossus moluccanus) is impossible to miss — or ignore. Clad in electric blue, vivid green, orange, yellow, and red, it descends on flowering trees in shrieking, jostling flocks. Native to eastern Australia and the islands of Indonesia and Papua New Guinea, it feeds on nectar and pollen using its specialised brush-tipped tongue. It has colonised many Australian cities and is a boisterous, sociable fixture of suburban parks.', '2024-02-06 11:00:00', 5, 2, 28, 1),
(29, 'New Zealand Kiwi', 'New Zealand''s beloved national symbol — a truly unique bird', 'The Brown Kiwi (Apteryx mantelli) is the most familiar of five kiwi species found only in New Zealand. About the size of a domestic chicken, it is the only bird in the world with nostrils at the tip of its bill, which it uses to sniff out earthworms in the dark. Kiwi are flightless, nocturnal, and lay the largest egg relative to body size of any bird. They are so deeply embedded in New Zealand identity that the country''s people are nicknamed "Kiwis."', '2024-02-07 12:00:00', 5, 3, 29, 1),
(30, 'Vogelkop Bowerbird', 'The architect of the bird world — builder of extraordinary art structures', 'The Vogelkop Bowerbird (Amblyornis inornata) of New Guinea''s Arfak Mountains is one of nature''s most remarkable artists. The drab brown male builds a large, hut-like bower decorated with carefully arranged colourful objects — berries, flowers, beetle wings, and moss — to attract females. Each bower is a unique artistic creation maintained and updated over years. Females visit multiple bowers before choosing the male with the most impressive construction.', '2024-02-08 13:00:00', 5, 3, 30, 1),

-- ANTARCTICA (category_id = 6)
(31, 'Emperor Penguin', 'The tallest, heaviest penguin — a survivor of the darkest winters on Earth', 'The Emperor Penguin (Aptenodytes forsteri) is the largest of all penguin species and the only animal that breeds during the Antarctic winter. Males balance a single egg on their feet for 65 days in temperatures as low as −60°C, huddling in rotating groups of thousands to share warmth. After hatching, both parents make exhausting journeys to the sea to collect fish and squid. No animal on Earth endures a more demanding reproductive journey.', '2024-02-09 08:00:00', 6, 1, 31, 1),
(32, 'Chinstrap Penguin', 'The punk penguin of the Southern Ocean', 'The Chinstrap Penguin (Pygoscelis antarcticus) is named for the thin black line under its chin, giving it the look of wearing a helmet strap. It is one of the most numerous penguins in the world, with colonies on the Antarctic Peninsula and sub-Antarctic islands numbering in the millions. Chinstraps are famously feisty — aggressively defending their pebble nests and boldly stealing stones from neighbours.', '2024-02-10 09:00:00', 6, 1, 32, 1),
(33, 'Snow Petrel', 'A pure-white ghost drifting over the polar ice', 'The Snow Petrel (Pagodroma nivea) is one of only three birds that breed exclusively in Antarctica. Entirely white — the colour of snow and pack ice — with coal-black eyes and bill, it looks like a living ghost against the grey polar sky. It nests in rock crevices on the continent''s ice-free outcrops and forages over open ocean and sea ice for fish, krill, and squid. It has been recorded further south than almost any other bird.', '2024-02-11 10:00:00', 6, 2, 33, 1),
(34, 'South Polar Skua', 'Antarctica''s bold and aggressive apex avian predator', 'The South Polar Skua (Stercorarius maccormicki) is the most southerly-breeding bird on Earth, having been recorded at the South Pole itself. A powerful, gull-like predator, it steals eggs and chicks from penguin colonies, pursues other seabirds to rob them of food, and scavenges on carrion. Despite its fierce reputation, pairs bond for life and both parents share incubation duties on their exposed, windswept nests.', '2024-02-12 11:00:00', 6, 2, 34, 1),
(35, 'Antarctic Tern', 'An elegant long-distance traveller of polar waters', 'The Antarctic Tern (Sterna vittata) spends its entire life in the cold waters of the Southern Ocean and sub-Antarctic. Unlike its famous cousin the Arctic Tern, it does not migrate to the Arctic — it simply moves between Antarctic and sub-Antarctic waters year-round. With its forked tail, red bill, and crisp black cap, it is one of the most graceful fliers in the southern sky, hovering delicately before plunging for fish.', '2024-02-13 12:00:00', 6, 3, 35, 1),
(36, 'Wandering Albatross', 'The greatest winged wanderer — master of the southern skies', 'The Wandering Albatross (Diomedea exulans) has the largest wingspan of any living bird — up to 3.5 metres — and uses it to soar effortlessly over the Southern Ocean for years without landing. Young birds may fly over a million kilometres before first breeding. It glides on dynamic air currents just above the waves, barely flapping for hours. Pairs reunite at their breeding islands every two years for an elaborate, graceful courtship dance that reaffirms their lifelong bond.', '2024-02-14 13:00:00', 6, 3, 36, 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
-- Represents continents
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `navigation` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- FIXED: INSERT INTO `category` (was incorrectly `continent` in original)
INSERT INTO `category` (`id`, `name`, `description`, `navigation`) VALUES
(1, 'Asia',        'Birds of the Asian continent, from Japan to the Himalayas', 1),
(2, 'Europe',      'Birds of Europe, from Arctic coasts to Mediterranean shores', 1),
(3, 'Americas',    'Birds of North, Central and South America', 1),
(4, 'Africa',      'Birds of the African continent and surrounding islands', 1),
(5, 'Oceania',     'Birds of Australia, New Zealand, and the Pacific islands', 1),
(6, 'Antarctica',  'Birds of the Antarctic continent and Southern Ocean', 1);

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `file` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `image` (`id`, `file`, `alt`) VALUES
-- Asia
(1,  'japaneserobin.jpg',                'Japanese Robin perched on a mossy branch in autumn forest'),
(2,  'redcrownedcrane.jpg',              'Red-crowned Cranes dancing in the snow in Hokkaido, Japan'),
(3,  'narcissusflycatcher.jpg',          'Male Narcissus Flycatcher showing bright yellow and black plumage'),
(4,  'variedtit.jpg',                    'Varied Tit clinging to a pine branch in a Japanese garden'),
(5,  'japanesewhiteeye.jpg',             'Japanese White-eye feeding among cherry blossoms'),
(6,  'eurasiankingfisher.jpg',           'Kingfisher hovering over a clear Japanese river'),
-- Europe
(7,  'europeanrobin.jpg',                'European Robin sitting on a snow-dusted garden fork'),
(8,  'atlanticpuffin.jpg',               'Atlantic Puffin with a beak full of sand eels on an Icelandic cliff'),
(9,  'europeanbeeeater.jpg',             'European Bee-eater in flight showing full colourful plumage'),
(10, 'whitestork.jpg',                   'White Stork standing in its rooftop nest in rural Poland'),
(11, 'barnswallow.jpg',                  'Barn Swallow in fast flight over a summer meadow'),
(12, 'eurasianhoopoe.jpg',               'Eurasian Hoopoe with crest fully raised on a Mediterranean stone wall'),
-- Americas
(13, 'resplendentquetzal.webp',          'Male Resplendent Quetzal with long tail feathers in cloud forest'),
(14, 'tocotoucan.jpg',                   'Toco Toucan perched on a rainforest branch in Brazil'),
(15, 'annashummingbird.webp',            'Male Anna''s Hummingbird hovering at a red flower'),
(16, 'scarletmacaw.jpg',                 'Pair of Scarlet Macaws in flight over the Amazon'),
(17, 'bluefootedbooby.webp',             'Blue-footed Booby performing courtship dance on the Galapagos'),
(18, 'americanflamingo.jpg',             'Flock of American Flamingos wading in a Caribbean lagoon'),
-- Africa
(19, 'africanpygmykingfisher.jpg',       'African Pygmy Kingfisher perched on a thin twig in the bush'),
(20, 'lilacbreastedroller.jpg',          'Lilac-breasted Roller in flight showing full colour spread'),
(21, 'africangreyparrot.jpg',            'African Grey Parrot in a dense West African rainforest'),
(22, 'secretarybird.jpg',                'Secretary Bird striding through tall grass on the savanna'),
(23, 'superbstarling.jpg',               'Superb Starling showing iridescent plumage in Kenya'),
(24, 'southernyellowbilledhornbill.jpg', 'Southern Yellow-billed Hornbill perched on an acacia branch'),
-- Oceania
(25, 'superbfairywren.jpg',              'Male Superb Fairywren in vivid blue breeding plumage'),
(26, 'kakapo.jpg',                       'Kākāpō face close-up showing green moss-like feathers'),
(27, 'tawnyfrogmouth.jpg',               'Tawny Frogmouth roosting camouflaged against a gum tree'),
(28, 'rainbowlorikeet.jpg',              'Rainbow Lorikeet feeding on bottlebrush flowers'),
(29, 'kiwi.webp',                        'Brown Kiwi probing leaf litter at night in New Zealand'),
(30, 'vogelkopbowerbird.jpg',            'Vogelkop Bowerbird bower decorated with colourful objects'),
-- Antarctica
(31, 'emperorpenguin.jpg',               'Emperor Penguin colony huddling in Antarctic blizzard'),
(32, 'chinstrappenguin.jpg',             'Chinstrap Penguins on rocky Antarctic shore'),
(33, 'snowpetrel.jpg',                   'Snow Petrel in flight over Antarctic pack ice'),
(34, 'southpolarskua.jpg',               'South Polar Skua on its nest in the Antarctic tundra'),
(35, 'antarctictern.jpg',                'Antarctic Tern hovering before diving for fish'),
(36, 'wanderingalbatross.jpg',           'Wandering Albatross gliding low over the Southern Ocean');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id` int(11) NOT NULL,
  `forename` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `joined` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `picture` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `member` (`id`, `forename`, `surname`, `email`, `password`, `joined`, `picture`) VALUES
(1, 'Ivy',   'Stone', 'ivy@eg.link',  'c63j-82ve-2sv9-qlb38', '2024-01-01 12:00:00', 'ivy.jpg'),
(2, 'Luke',  'Wood',  'luke@eg.link', 'saq8-2f2k-3nv7-fa4k',  '2024-01-01 12:15:00', NULL),
(3, 'Emiko', 'Ito',   'emi@eg.link',  'sk3r-vd92-3vn1-exm2',  '2024-01-01 12:30:00', 'emi.jpg');

-- --------------------------------------------------------
-- Indexes
-- --------------------------------------------------------

ALTER TABLE `birds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `typeOfBirds` (`typeOfBirds`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `image_id` (`image_id`);

ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `image`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `member`
  ADD PRIMARY KEY (`id`);

-- AUTO_INCREMENT
ALTER TABLE `birds`    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
ALTER TABLE `category` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `image`    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
ALTER TABLE `member`   MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- Foreign Key Constraints
ALTER TABLE `birds`
  ADD CONSTRAINT `category_exists` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `image_exists`    FOREIGN KEY (`image_id`)    REFERENCES `image` (`id`),
  ADD CONSTRAINT `member_exists`   FOREIGN KEY (`member_id`)   REFERENCES `member` (`id`);