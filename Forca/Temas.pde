// ============================================================
//  TEMAS.PDE — Base de dados de palavras e temas
//  Cada entrada: { "PALAVRA", "Dica sobre a palavra" }
// ============================================================

static class Temas {

  // Recordes por tema (em memória)
  static int[] recordesTemas = {0, 0, 0, 0, 0, 0};

  // ---- TEMA 0: FRUTAS ----------------------------------------
  static String[][] frutas = {
    {"ABACAXI",    "Fruta tropical com coroa de folhas"},
    {"MANGA",      "Fruta amarela e suculenta, rei das frutas"},
    {"MELANCIA",   "Fruta vermelha por dentro, verde por fora"},
    {"GOIABA",     "Fruta rosa usada em goiabada"},
    {"MARACUJA",   "Fruta do maracujazeiro, azeda e refrescante"},
    {"CAJU",       "Fruta símbolo do Nordeste, tem castanha"},
    {"ACEROLA",    "Pequena fruta vermelha rica em vitamina C"},
    {"PITANGA",    "Fruta nativa brasileira, vermelha e aromática"},
    {"CARAMBOLA",  "Fruta em formato de estrela"},
    {"GRAVIOLA",   "Fruta grande com polpa branca e cremosa"},
    {"JABUTICABA", "Fruta preta que nasce direto no tronco"},
    {"UMBU",       "Fruta típica do sertão nordestino"},
    {"CUPUACU",    "Fruta amazônica usada em chocolates"},
    {"GUARANA",    "Fruta vermelha famosa por dar energia"},
    {"BURITI",     "Fruta do cerrado, rica em betacaroteno"},
    {"PEQUI",      "Fruta do cerrado com polpa amarela"},
    {"TAMARINDO",  "Vagem ácida usada em doces e bebidas"},
    {"SAPOTI",     "Fruta marrom por fora, doce por dentro"},
    {"JACA",       "A maior fruta do mundo, de casca espinhosa"},
    {"FRUTA",      "Produto comestível de uma planta com flor"},
  };

  // ---- TEMA 1: CIDADES BRASILEIRAS ---------------------------
  static String[][] cidades = {
    {"RECIFE",          "Capital de Pernambuco, Veneza brasileira"},
    {"SALVADOR",        "Capital da Bahia, berço da cultura afro"},
    {"FORTALEZA",       "Capital do Ceará, famosas praias"},
    {"MANAUS",          "Capital do Amazonas, no coração da floresta"},
    {"BELEM",           "Capital do Pará, porta de entrada da Amazônia"},
    {"NATAL",           "Capital do Rio Grande do Norte, cidade do sol"},
    {"MACEIO",          "Capital de Alagoas, mar turquesa"},
    {"JOAO PESSOA",     "Capital da Paraíba, a cidade mais a leste"},
    {"TERESINA",        "Capital do Piauí, uma das cidades mais quentes"},
    {"SAO LUIS",        "Capital do Maranhão, Atenas Brasileira"},
    {"PALMAS",          "Capital mais jovem do Brasil, no Tocantins"},
    {"CUIABA",          "Capital do Mato Grosso, coração do Brasil"},
    {"GOIANIA",         "Capital de Goiás, cidade planejada"},
    {"CAMPO GRANDE",    "Capital do Mato Grosso do Sul"},
    {"PORTO VELHO",     "Capital de Rondônia, às margens do Madeira"},
    {"RIO BRANCO",      "Capital do Acre, cidade seringueira"},
    {"MACAPA",          "Capital do Amapá, cortada pelo Equador"},
    {"BOA VISTA",       "Capital de Roraima, no extremo norte"},
    {"PORTO ALEGRE",    "Capital do Rio Grande do Sul"},
    {"FLORIANOPOLIS",   "Capital de Santa Catarina, Ilha da Magia"},
    {"CURITIBA",        "Capital do Paraná, cidade modelo"},
    {"BELO HORIZONTE",  "Capital de Minas Gerais, Beagá"},
    {"VITORIA",         "Capital do Espírito Santo"},
    {"SAO PAULO",       "Maior cidade do Brasil"},
    {"RIO DE JANEIRO",  "Cidade Maravilhosa"},
    {"BRASILIA",        "Capital federal do Brasil"},
    {"ARACAJU",         "Capital de Sergipe, menor capital nordestina"},
    {"OLINDA",          "Cidade histórica pernambucana, Patrimônio Mundial"},
    {"PETROLINA",       "Cidade pernambucana às margens do São Francisco"},
    {"CARUARU",         "Cidade do interior de PE, capital do forró"},
  };

  // ---- TEMA 2: ANIMAIS ----------------------------------------
  static String[][] animais = {
    {"ONCA PINTADA",    "Maior felino das Américas"},
    {"CAPIVARA",        "Maior roedor do mundo, nativa do Brasil"},
    {"BOTO",            "Golfinho de rio cor-de-rosa da Amazônia"},
    {"ARARA",           "Ave colorida símbolo do Brasil"},
    {"TUCANO",          "Ave com bico enorme e colorido"},
    {"ANTA",            "Maior mamífero terrestre da América do Sul"},
    {"TATU",            "Mamífero com carapaça óssea"},
    {"MICO LEAO",       "Primata em risco de extinção, laranja e belo"},
    {"PIRARUCU",        "Maior peixe de água doce do mundo"},
    {"ANACONDA",        "Maior cobra do mundo, vive na Amazônia"},
    {"JABUTI",          "Tartaruga terrestre, vive mais de 100 anos"},
    {"TAMANDUABANDEIRA","Mamífero que come formigas com língua longa"},
    {"LOBO GUARA",      "Canídeo do cerrado, pernas compridas"},
    {"MANTA",           "Raia gigante dos oceanos"},
    {"GAVIAO REAL",     "Maior águia das Américas"},
    {"SURICATO",        "Pequeno mamífero que vigia o bando em pé"},
    {"PINGUIM",         "Ave que não voa, vive em regiões frias"},
    {"PLATIPUS",        "Mamífero com bico de pato"},
    {"AXOLOTE",         "Salamandra que mantém forma juvenil para sempre"},
    {"TARDIGRADO",      "Micro-animal mais resistente da Terra"},
  };

  // ---- TEMA 3: ESPORTES ---------------------------------------
  static String[][] esportes = {
    {"FUTEBOL",       "Esporte mais popular do Brasil e do mundo"},
    {"VOLEIBOL",      "Esporte onde a bola não pode cair no chão"},
    {"BASQUETEBOL",   "Esporte com cesta suspensa a 3 metros"},
    {"NATACAO",       "Esporte olímpico praticado na água"},
    {"ATLETISMO",     "Conjunto de provas de corrida, salto e lançamento"},
    {"JUDÔ",          "Arte marcial japonesa olímpica"},
    {"CAPOEIRA",      "Arte marcial brasileira com elementos de dança"},
    {"XADREZ",        "Jogo de tabuleiro de estratégia milenar"},
    {"SURFE",         "Esporte de deslizar sobre ondas do mar"},
    {"SKATE",         "Esporte com prancha sobre rodas"},
    {"HANDEBOL",      "Esporte coletivo jogado com as mãos"},
    {"TENIS",         "Esporte com raquete e bola em quadra"},
    {"GOLFE",         "Esporte com tacos e buracos numerados"},
    {"BOXE",          "Arte marcial com luvas entre dois adversários"},
    {"CICLISMO",      "Esporte de velocidade em bicicleta"},
    {"REMO",          "Esporte olímpico praticado em barcos"},
    {"HIPISMO",       "Esporte que envolve cavalos e cavaleiros"},
    {"POLO AQUATICO", "Futebol jogado dentro da água"},
    {"BADMINTON",     "Esporte com peteca e raquete"},
    {"FRESCOBOL",     "Esporte de praia tipicamente brasileiro"},
  };

  // ---- TEMA 4: TECNOLOGIA ------------------------------------
  static String[][] tecnologia = {
    {"INTERNET",      "Rede mundial de computadores"},
    {"INTELIGENCIA ARTIFICIAL", "Simulação de inteligência por máquinas"},
    {"BLOCKCHAIN",    "Cadeia de blocos usada em criptomoedas"},
    {"PROGRAMACAO",   "Ato de escrever instruções para computadores"},
    {"ALGORITMO",     "Sequência de passos para resolver um problema"},
    {"BANCO DE DADOS","Sistema para armazenar e organizar dados"},
    {"NUVEM",         "Armazenamento e processamento remoto de dados"},
    {"CIBERSEGURANCA","Proteção de sistemas contra ataques digitais"},
    {"ROBOTICA",      "Ciência que estuda e cria robôs"},
    {"REALIDADE VIRTUAL","Ambiente digital imersivo simulado"},
    {"PROCESSADOR",   "Componente que executa instruções no computador"},
    {"MEMORIA RAM",   "Memória volátil de acesso rápido"},
    {"SATELITE",      "Objeto que orbita um planeta"},
    {"SMARTPHONE",    "Celular com capacidades de computador"},
    {"APLICATIVO",    "Software para dispositivos móveis"},
    {"OPEN SOURCE",   "Software com código aberto e livre"},
    {"MACHINE LEARNING","Aprendizado de máquina com dados"},
    {"PIXEL",         "Menor unidade de uma imagem digital"},
    {"BYTE",          "Unidade básica de informação digital"},
    {"FIREWALL",      "Barreira de segurança em redes"},
  };

  // ---- TEMA 5: CULINÁRIA NORDESTINA --------------------------
  static String[][] culinaria = {
    {"COXINHA",         "Salgado em forma de gota com frango"},
    {"ACARAJE",         "Bolinho de feijão frito no azeite de dendê"},
    {"CARNE DE SOL",    "Carne salgada e seca ao sol, típica do Nordeste"},
    {"BUCHADA",         "Prato típico nordestino feito com vísceras de bode"},
    {"BAIAO DE DOIS",   "Prato de feijão com arroz e queijo coalho"},
    {"PAOCA",           "Doce de amendoim torrado e rapadura"},
    {"MUNGUNZA",        "Canjica branca com leite de coco e amendoim"},
    {"CUSCUZ",          "Prato de milho cozido no vapor"},
    {"TAPIOCA",         "Beiju de goma de mandioca"},
    {"MANIÇOBA",        "Feijoada paraense com folhas de mandioca"},
    {"TACACÁ",          "Sopa paraense com tucupi e jambu"},
    {"VATAPA",          "Creme baiano com pão, camarão e dendê"},
    {"MOQUECA",         "Ensopado de peixe com leite de coco e dendê"},
    {"PIRÃO",           "Mingau de farinha de mandioca com caldo de peixe"},
    {"SARAPATEL",       "Prato com sangue e vísceras de porco"},
    {"GALINHA DE CABIDELA","Galinha cozida no próprio sangue"},
    {"ESCONDIDINHO",    "Purê de macaxeira com carne seca por baixo"},
    {"COCADA",          "Doce de coco ralado com açúcar"},
    {"RAPADURA",        "Bloco de açúcar mascavo não refinado"},
    {"LICURI",          "Coco pequeno típico da caatinga baiana"},
  };

  // ============================================================
  //  MÉTODOS
  // ============================================================
  static String[] getNomesTemas() {
    return new String[]{"🍎 Frutas", "🏙 Cidades", "🐾 Animais",
                        "⚽ Esportes", "💻 Tecnologia", "🍽 Culinária"};
  }

  static String getNomeTema(int i) {
    return getNomesTemas()[i].substring(3);
  }

  static int[] getRecordesTemas() {
    return recordesTemas;
  }

  static void atualizarRecorde(int tema, int pts) {
    if (pts > recordesTemas[tema]) recordesTemas[tema] = pts;
  }

  static String[] getPalavraAleatoria(int tema) {
    String[][] base;
    switch (tema) {
      case 0:  base = frutas;     break;
      case 1:  base = cidades;    break;
      case 2:  base = animais;    break;
      case 3:  base = esportes;   break;
      case 4:  base = tecnologia; break;
      default: base = culinaria;  break;
    }
    int idx = (int)(Math.random() * base.length);
    return base[idx];
  }
}
