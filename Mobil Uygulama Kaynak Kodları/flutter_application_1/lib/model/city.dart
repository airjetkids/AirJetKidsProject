class City {
  final String name;
  final double latitude;
  final double longitude;
  final String arAsset; // 3D AR model dosya yolu (placeholder)
  final List<String> keywords; // Oyun mantığında kullanılacak anahtar kelime listesi
  final List<String> keywordHints; // Anahtar kelimenin kendisini vermeyen ipucu metinleri

  const City({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.arAsset,
    required this.keywords,
    required this.keywordHints,
  });
}

const City malatya = City(
  name: "Malatya",
  latitude: 38.3552,
  longitude: 38.3095,
  arAsset: "assets/kayisi.gltf",
  keywords: ["Kayısı", "Gölbaşı", "Erhaç"],
  keywordHints: [
    // Kayısı
    "Bölgenin eşsiz, tatlı ve kuru meyvesi, dünya çapında ün kazanmıştır.",
    // Gölbaşı
    "Sakin doğasıyla, huzurlu vakitlerin geçirilebileceği, yeşilin ve suyun buluştuğu bir mekan.",
    // Erhaç
    "Geçmişin izlerini ve yöresel kültürü içinde barındıran tarihi bir bölge."
  ],
);

const City ankara = City(
  name: "Ankara",
  latitude: 39.9208,
  longitude: 32.8541,
  arAsset: "assets/models/ankara_model.gltf",
  keywords: ["Anıtkabir", "Atakule", "Kocatepe"],
  keywordHints: [
    // İpucu, ulusun önderine ait anıtsal yapıyı çağrıştıran ama doğrudan ismi vermeyen bir ifade.
    "Ulusun önderine duyulan saygıyı ve modern anıt mimarisinin izlerini taşıyan anıt mekân.",
    // İpucu, şehrin panoramik manzarasını sunan simgesel gözlem kulesini ima eder.
    "Şehrin yüksek noktasından muhteşem manzaraları sunan, modern şehir silüetini yansıtan yapı.",
    // İpucu, geniş ve modern ibadet alanını andıran etkileyici bir yapı.
    "Modern mimarinin etkileyici örneğini sunan, geniş kitlelere hitap eden ibadet mekanı."
  ],
);

const City elazig = City(
  name: "Elazığ",
  latitude: 38.6800,
  longitude: 39.2264,
  arAsset: "assets/models/elazig_model.gltf",
  keywords: ["Harput Kalesi", "Çaydacıra", "Keban"],
  keywordHints: [
    // İpucu, tarihi dokuyu vurgulayan ama doğrudan kelimeyi vermeyen bir ifade.
    "Bölgedeki tarihi dokuyu yansıtan, antik izler taşıyan muhteşem yapı.",
    // İpucu, anahtar kelimeyi doğrudan ifade etmeden Elazığ'a özgü kültürel bir dansı çağrıştırır.
    "Elazığ’ın yöresel danslarından biri olan, geleneksel ritimleri anımsatan hareket.",
    // İpucu, yerel mutfağın kendine has lezzet dokusunu ima eder.
    "Şehrin kültürel simgelerinden biri olarak, özgün yerel tatları yansıtan eşsiz lezzet."
  ],
);

const City istanbul = City(
  name: "İstanbul",
  latitude: 41.0082,
  longitude: 28.9784,
  arAsset: "assets/models/istanbul_model.gltf",
  keywords: ["Ayasofya", "Sultanahmet", "Galata"],
  keywordHints: [
    // İpucu, Bizans ve Osmanlı dönemlerinin izlerini hissettiren eşsiz bir yapıyı ima eder.
    "Birçok medeniyete ev sahipliği yapmış, tarih derinliği hissettiren eşsiz yapı.",
    // İpucu, eski şehrin kalbindeki tarihî dokuyu çağrıştırır.
    "Eski İstanbul'un kalbinde, tarihi dokunun izlerini taşıyan büyüleyici bölge.",
    // İpucu, kentin silüetini farklılaştıran tarihi bir kule yapısını ima eder.
    "Şehir manzarasına özgün renk katan, tarihi dokusu ve eşsiz silüetiyle dikkat çeken yapı."
  ],
);

const City izmir = City(
  name: "İzmir",
  latitude: 38.4237,
  longitude: 27.1428,
  arAsset: "assets/models/izmir_model.gltf",
  keywords: ["Kordon", "Agora", "Konak"],
  keywordHints: [
    // İpucu, deniz kenarındaki canlı atmosferi ima eden popüler yürüyüş yolunu çağrıştırır.
    "Deniz kenarındaki canlı atmosferi ve gün batımını andıran yürüyüş güzelliği.",
    // İpucu, antik kalıntılardan izler taşıyan, geçmişe dair iz bırakan tarihi alanı ima eder.
    "Antik çağın izlerini taşıyan, geçmişin zengin kültürünü yansıtan arkeolojik kalıntı.",
    // İpucu, modern ve tarihî dokunun iç içe geçtiği merkezi noktayı çağrıştırır.
    "Modern yaşamla tarihî dokunun iç içe geçtiği, kentin ruhunu yansıtan merkez."
  ],
);

const City manisa = City(
  name: "Manisa",
  latitude: 38.6191,
  longitude: 27.4289,
  arAsset: "assets/models/manisa_model.gltf",
  keywords: ["Spil Dağı", "Sardes", "Mesir Macunu"],
  keywordHints: [
    // İpucu, efsanelere konu olan, doğanın bereketini ve mitolojik hikayeleri çağrıştıran görkemli dağı ima eder.
    "Mitolojik hikayelere konu olan, bereketli topraklarıyla ün salmış görkemli dağ.",
    // İpucu, antik kültürü ve ekonomik zenginliği yansıtan tarihi merkezi ima eder.
    "Antik çağın zengin kültürünü ve ekonomik gücünü yansıtan tarihi merkez.",
    // İpucu, geleneksel şifa sırlarından biri olarak, yöresel tatlarla anılan eşsiz lezzeti çağrıştırır.
    "Köklü geleneksel şifa kültürünü ve eşsiz yerel tatları yansıtan ünlü lezzet."
  ],
);

const City bursa = City(
  name: "Bursa",
  latitude: 40.1828,
  longitude: 29.0665,
  arAsset: "assets/models/bursa_model.gltf",
  keywords: ["Uludağ", "Yeşil Türbe", "Cumalıkızık"],
  keywordHints: [
    // İpucu, kış sporlarının merkezi ve doğal güzellikleriyle öne çıkan yüksek dağları ima eder.
    "Kış sporları ve doğa tutkunlarını kendine çeken, görkemli yüksek dağ.",
    // İpucu, mistik ve huzur veren tarihi dokuyu yansıtan, Osmanlı döneminin izlerini taşıyan bir yapıyı çağrıştırır.
    "Osmanlı mirasının mistik izlerini barındıran, huzur veren anıtsal yapı.",
    // İpucu, geleneksel mimarinin korunduğu ve zamanın durduğu tarihi köy yaşamını ima eder.
    "Zamanın adeta durduğu, geleneksel mimarinin ve kültürel dokunun yaşatıldığı tarihi köy."
  ],
);
