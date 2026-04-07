// ============================================================
//  JOGO DA FORCA - Versão Deluxe
//  Desenvolvido em Processing
// ============================================================

PFont fonteTitulo, fonteTexto, fonteGrande, fontePequena;

// --- Estados do jogo ---
final int TELA_MENU      = 0;
final int TELA_TEMA      = 1;
final int TELA_JOGO      = 2;
final int TELA_VITORIA   = 3;
final int TELA_DERROTA   = 4;
final int TELA_RECORDE   = 5;

int estadoAtual = TELA_MENU;

// --- Dados do jogo ---
String palavraSecreta   = "";
String palavraDica      = "";
char[] letrasReveladas;
ArrayList<Character> letrasErradas  = new ArrayList<Character>();
ArrayList<Character> letrasCorretas = new ArrayList<Character>();
int erros = 0;
final int MAX_ERROS = 6;
int temaSelecionado = 0;
int pontuacao = 0;
int recorde   = 0;
int rodada    = 1;
boolean usouDica = false;
int tempoInicio;
int tempoFinal;

// --- Animações ---
float[] particulas_x     = new float[60];
float[] particulas_y     = new float[60];
float[] particulas_vy    = new float[60];
float[] particulas_vx    = new float[60];
float[] particulas_alpha = new float[60];
color[] particulas_cor   = new color[60];
boolean mostrarParticulas = false;
int timerParticulas = 0;

float sacudirX = 0;
boolean sacudindo = false;
int timerSacudir = 0;

float alphaTransicao = 0;
boolean fadeIn = false;

// --- Botões ---
Botao[] botoesTema;
Botao btnDica, btnMenu, btnProxima, btnJogarNovamente;

// --- Cores do tema ---
color COR_FUNDO    = color(15, 20, 35);
color COR_MADEIRA2 = color(139, 90, 43);
color COR_CORDA    = color(210, 180, 140);
color COR_BONECO   = color(240, 200, 150);
color COR_DESTAQUE = color(255, 200, 50);
color COR_ERRO     = color(220, 60, 60);
color COR_ACERTO   = color(80, 200, 120);
color COR_TEXTO    = color(230, 225, 210);

// ============================================================
void setup() {
  size(900, 600);
  smooth(4);
  fonteTitulo  = createFont("Georgia-Bold", 48);
  fonteTexto   = createFont("Georgia", 22);
  fonteGrande  = createFont("Courier-Bold", 36);
  fontePequena = createFont("Georgia", 14);
  inicializarBotoes();
  inicializarParticulas();
  fadeIn = true;
  alphaTransicao = 255;
}

// ============================================================
void draw() {
  background(COR_FUNDO);
  desenharFundo();
  switch (estadoAtual) {
    case TELA_MENU:    desenharMenu();    break;
    case TELA_TEMA:    desenharTema();    break;
    case TELA_JOGO:    desenharJogo();    break;
    case TELA_VITORIA: desenharVitoria(); break;
    case TELA_DERROTA: desenharDerrota(); break;
    case TELA_RECORDE: desenharRecorde(); break;
  }
  atualizarParticulas();
  atualizarSacudir();
  atualizarFade();
}

// ============================================================
//  FUNDO DECORATIVO
// ============================================================
void desenharFundo() {
  for (int i = 0; i < height / 2; i++) {
    float alpha = map(i, 0, height / 2, 40, 0);
    stroke(100, 120, 180, alpha);
    line(0, i, width, i);
  }
  noStroke();
  randomSeed(42);
  fill(255, 255, 255, 30);
  for (int i = 0; i < 80; i++) {
    float px = random(width);
    float py = random(height);
    float sz = random(1, 3);
    ellipse(px, py, sz, sz);
  }
}

// ============================================================
//  TELA MENU
// ============================================================
void desenharMenu() {
  textFont(fonteTitulo);
  textAlign(CENTER, CENTER);
  fill(0, 0, 0, 120);
  text("JOGO DA FORCA", width/2 + 3, 90 + 3);
  fill(COR_DESTAQUE);
  text("JOGO DA FORCA", width/2, 90);
  textFont(fonteTexto);
  fill(COR_TEXTO);
  text("Edicao Deluxe", width/2, 135);
  desenharBonecoMenu();
  Botao btnJogar = new Botao(width/2 - 120, 370, 240, 55, "JOGAR", COR_ACERTO, color(255));
  btnJogar.desenhar();
  Botao btnRec = new Botao(width/2 - 120, 440, 240, 55, "RECORDES", COR_DESTAQUE, color(20, 20, 20));
  btnRec.desenhar();
  textFont(fontePequena);
  fill(COR_TEXTO);
  text("Adivinhe a palavra antes que o boneco seja enforcado!", width/2, 520);
  text("Voce tem 6 tentativas. Use dicas com sabedoria!", width/2, 540);
  textAlign(RIGHT, BOTTOM);
  fill(COR_TEXTO);
  text("v1.0 Deluxe", width - 20, height - 10);
}

void desenharBonecoMenu() {
  pushMatrix();
  translate(width/2, 270);
  scale(0.8);
  desenharForca();
  stroke(COR_BONECO);
  strokeWeight(4);
  fill(COR_BONECO);
  ellipse(0, -140, 40, 40);
  line(0, -120, 0, -60);
  line(0, -110, -40, -130);
  line(0, -110, 40, -130);
  line(0, -60, -25, -20);
  line(0, -60, 25, -20);
  noStroke();
  popMatrix();
}

// ============================================================
//  TELA SELEÇÃO DE TEMA
// ============================================================
void desenharTema() {
  textFont(fonteTitulo);
  textAlign(CENTER, CENTER);
  fill(COR_DESTAQUE);
  text("ESCOLHA O TEMA", width/2, 80);
  textFont(fonteTexto);
  fill(COR_TEXTO);
  text("Selecione uma categoria de palavras:", width/2, 125);
  for (Botao b : botoesTema) b.desenhar();
  btnMenu.desenhar();
}

// ============================================================
//  TELA PRINCIPAL DO JOGO
// ============================================================
void desenharJogo() {
  float ox = sacudindo ? sacudirX : 0;
  desenharPainelForca(ox);
  desenharPainelDireito(ox);
  desenharTeclado(ox);
  if (mostrarParticulas) desenharParticulas();
}

void desenharPainelForca(float ox) {
  pushMatrix();
  translate(ox, 0);
  fill(30, 40, 60, 180);
  noStroke();
  rect(20, 20, 370, 340, 15);
  stroke(COR_DESTAQUE);
  strokeWeight(1.5);
  noFill();
  rect(20, 20, 370, 340, 15);
  noStroke();
  textFont(fontePequena);
  textAlign(LEFT, TOP);
  fill(COR_DESTAQUE);
  text("TEMA: " + Temas.getNomeTema(temaSelecionado).toUpperCase(), 35, 32);
  textAlign(RIGHT, TOP);
  fill(COR_TEXTO);
  text("Rodada " + rodada, 375, 32);
  pushMatrix();
  translate(205, 200);
  desenharForca();
  desenharBoneco(erros);
  popMatrix();
  textFont(fonteTexto);
  textAlign(CENTER, CENTER);
  if (erros >= 4) fill(COR_ERRO);
  else if (erros >= 2) fill(COR_DESTAQUE);
  else fill(COR_TEXTO);
  text(erros + " / " + MAX_ERROS + " erros", 205, 350);
  popMatrix();
}

void desenharPainelDireito(float ox) {
  pushMatrix();
  translate(ox, 0);
  fill(30, 40, 60, 180);
  noStroke();
  rect(405, 20, 475, 200, 15);
  stroke(COR_DESTAQUE);
  strokeWeight(1.5);
  noFill();
  rect(405, 20, 475, 200, 15);
  noStroke();
  textFont(fontePequena);
  textAlign(LEFT, TOP);
  fill(COR_DESTAQUE);
  text("PONTUACAO", 420, 35);
  textFont(fonteGrande);
  fill(COR_TEXTO);
  text(nf(pontuacao, 5), 420, 55);
  textFont(fontePequena);
  fill(color(200, 170, 80));
  text("Recorde: " + nf(recorde, 5), 420, 100);
  int tempoDecorrido = (millis() - tempoInicio) / 1000;
  int min = tempoDecorrido / 60;
  int seg = tempoDecorrido % 60;
  fill(COR_TEXTO);
  text("Tempo: " + nf(min, 2) + ":" + nf(seg, 2), 420, 120);
  fill(COR_ERRO);
  text("Letras erradas:", 420, 150);
  String erradasStr = "";
  for (char c : letrasErradas) erradasStr += c + " ";
  textFont(fonteTexto);
  fill(COR_ERRO);
  text(erradasStr.isEmpty() ? "-" : erradasStr, 420, 170);
  btnDica.desenhar();
  if (usouDica) {
    textFont(fontePequena);
    fill(COR_TEXTO);
    textAlign(LEFT, TOP);
    text("Dica: " + palavraDica, 420, 225);
  }
  desenharPalavra(ox);
  popMatrix();
}

void desenharPalavra(float ox) {
  int n = palavraSecreta.length();
  int espacoLetra = 38;
  int totalLargura = n * espacoLetra;
  int startX = 405 + (475 - totalLargura) / 2;
  int y = 340;
  for (int i = 0; i < n; i++) {
    char c = palavraSecreta.charAt(i);
    int lx = startX + i * espacoLetra;
    if (c != ' ') {
      stroke(COR_CORDA);
      strokeWeight(2);
      line(lx, y + 5, lx + 28, y + 5);
      noStroke();
      if (letrasReveladas[i] != '_') {
        textFont(fonteGrande);
        textAlign(CENTER, BOTTOM);
        fill(COR_ACERTO);
        text(letrasReveladas[i], lx + 14, y + 3);
      }
    }
  }
  textFont(fontePequena);
  textAlign(CENTER, TOP);
  fill(COR_TEXTO);
  text(n + " letras", width/2 + 50, y + 12);
}

// ============================================================
//  TECLADO VIRTUAL
// ============================================================
void desenharTeclado(float ox) {
  String linhas = "QWERTYUIOPASDFGHJKLZXCVBNM";
  int[] tamLinhas = {10, 9, 7};
  int idx = 0;
  int bw = 44, bh = 38, gap = 4;
  int ky = 380;
  fill(20, 30, 50, 200);
  noStroke();
  rect(15 + ox, 370, 870, 200, 12);
  stroke(COR_DESTAQUE);
  strokeWeight(1);
  noFill();
  rect(15 + ox, 370, 870, 200, 12);
  noStroke();
  for (int linha = 0; linha < 3; linha++) {
    int tam = tamLinhas[linha];
    int totalW = tam * (bw + gap) - gap;
    int kx = (int)(width - totalW) / 2 + (int)ox;
    for (int col = 0; col < tam && idx < 26; col++) {
      char letra = linhas.charAt(idx);
      boolean errou   = letrasErradas.contains(letra);
      boolean acertou = letrasCorretas.contains(letra);
      color fundo, borda, textoC;
      if (errou) {
        fundo  = color(80, 20, 20);
        borda  = COR_ERRO;
        textoC = color(150, 60, 60);
      } else if (acertou) {
        fundo  = color(20, 70, 40);
        borda  = COR_ACERTO;
        textoC = COR_ACERTO;
      } else {
        fundo  = color(40, 55, 80);
        borda  = color(80, 100, 140);
        textoC = COR_TEXTO;
        int bx2 = kx + col * (bw + gap);
        if (mouseX > bx2 && mouseX < bx2 + bw && mouseY > ky && mouseY < ky + bh) {
          fundo = color(60, 80, 120);
          borda = COR_DESTAQUE;
        }
      }
      int bx = kx + col * (bw + gap);
      fill(fundo);
      stroke(borda);
      strokeWeight(1.5);
      rect(bx, ky, bw, bh, 6);
      noStroke();
      textFont(fonteTexto);
      textAlign(CENTER, CENTER);
      fill(textoC);
      text(letra, bx + bw/2, ky + bh/2);
      idx++;
    }
    ky += bh + gap + 2;
  }
}

// ============================================================
//  FORCA GRÁFICA
// ============================================================
void desenharForca() {
  stroke(COR_MADEIRA2);
  strokeWeight(10);
  line(-80, 150, 80, 150);
  line(-40, 150, -40, -150);
  line(-40, -150, 30, -150);
  strokeWeight(6);
  line(-40, -110, -10, -150);
  stroke(COR_CORDA);
  strokeWeight(4);
  line(30, -150, 30, -120);
  noStroke();
}

// ============================================================
//  BONECO
// ============================================================
void desenharBoneco(int e) {
  stroke(COR_BONECO);
  strokeWeight(4);
  noFill();
  if (e >= 1) {
    fill(COR_BONECO);
    ellipse(30, -100, 40, 40);
    noFill();
    if (e >= MAX_ERROS) {
      stroke(COR_ERRO);
      line(22, -107, 26, -103); line(26, -107, 22, -103);
      line(34, -107, 38, -103); line(38, -107, 34, -103);
      arc(30, -95, 16, 10, 0, PI);
    } else {
      stroke(color(50, 30, 20));
      ellipse(24, -105, 5, 5);
      ellipse(36, -105, 5, 5);
    }
    stroke(COR_BONECO);
  }
  if (e >= 2) line(30, -80, 30, -30);
  if (e >= 3) line(30, -65,  0, -45);
  if (e >= 4) line(30, -65, 60, -45);
  if (e >= 5) line(30, -30,  5,  10);
  if (e >= 6) line(30, -30, 55,  10);
  noStroke();
}

// ============================================================
//  TELA VITÓRIA
// ============================================================
void desenharVitoria() {
  textFont(fonteTitulo);
  textAlign(CENTER, CENTER);
  fill(COR_ACERTO);
  text("PARABENS!", width/2, 100);
  textFont(fonteTexto);
  fill(COR_TEXTO);
  text("Voce adivinhou a palavra!", width/2, 150);
  textFont(fonteGrande);
  fill(COR_DESTAQUE);
  text(palavraSecreta, width/2, 200);
  textFont(fonteTexto);
  fill(COR_TEXTO);
  text("Erros: " + erros + " | Tempo: " + formatarTempo(tempoFinal) + " | Pontos: +" + calcularPontos(), width/2, 250);
  text("Pontuacao total: " + pontuacao, width/2, 285);
  if (pontuacao >= recorde && rodada > 1) {
    fill(COR_DESTAQUE);
    text("NOVO RECORDE!", width/2, 320);
  }
  desenharParticulas();
  btnProxima.desenhar();
  btnMenu.desenhar();
}

// ============================================================
//  TELA DERROTA
// ============================================================
void desenharDerrota() {
  textFont(fonteTitulo);
  textAlign(CENTER, CENTER);
  fill(COR_ERRO);
  text("GAME OVER", width/2, 90);
  textFont(fonteTexto);
  fill(COR_TEXTO);
  text("A palavra era:", width/2, 145);
  textFont(fonteGrande);
  fill(COR_DESTAQUE);
  text(palavraSecreta, width/2, 185);
  pushMatrix();
  translate(width/2, 310);
  scale(0.9);
  desenharForca();
  desenharBoneco(MAX_ERROS);
  popMatrix();
  textFont(fonteTexto);
  fill(COR_TEXTO);
  text("Pontuacao final: " + pontuacao, width/2, 460);
  btnJogarNovamente.desenhar();
  btnMenu.desenhar();
}

// ============================================================
//  TELA RECORDES
// ============================================================
void desenharRecorde() {
  textFont(fonteTitulo);
  textAlign(CENTER, CENTER);
  fill(COR_DESTAQUE);
  text("RECORDES", width/2, 90);
  textFont(fonteTexto);
  fill(COR_TEXTO);
  text("Sua melhor pontuacao:", width/2, 160);
  textFont(fonteGrande);
  fill(COR_DESTAQUE);
  text(nf(recorde, 5), width/2, 210);
  String[] nomes = Temas.getNomesTemas();
  int[] recordesTema = Temas.getRecordesTemas();
  textFont(fonteTexto);
  fill(COR_TEXTO);
  text("Recordes por tema:", width/2, 280);
  textFont(fontePequena);
  for (int i = 0; i < nomes.length; i++) {
    color c = (i % 2 == 0) ? COR_TEXTO : color(180, 200, 230);
    fill(c);
    text(nomes[i] + ": " + nf(recordesTema[i], 5), width/2, 310 + i * 28);
  }
  btnMenu.desenhar();
}

// ============================================================
//  PARTÍCULAS
// ============================================================
void inicializarParticulas() {
  for (int i = 0; i < particulas_x.length; i++) {
    particulas_x[i] = 0;
    particulas_y[i] = 0;
    particulas_alpha[i] = 0;
  }
}

void lancarParticulas() {
  mostrarParticulas = true;
  timerParticulas = millis();
  color[] cores = {COR_DESTAQUE, COR_ACERTO, color(255, 100, 100), color(100, 150, 255), color(255, 150, 50)};
  for (int i = 0; i < particulas_x.length; i++) {
    particulas_x[i]  = random(100, width - 100);
    particulas_y[i]  = random(100, 400);
    particulas_vx[i] = random(-3, 3);
    particulas_vy[i] = random(-5, -1);
    particulas_alpha[i] = 255;
    particulas_cor[i]   = cores[(int)random(cores.length)];
  }
}

void atualizarParticulas() {
  if (!mostrarParticulas) return;
  if (millis() - timerParticulas > 3000) { mostrarParticulas = false; return; }
  for (int i = 0; i < particulas_x.length; i++) {
    particulas_x[i]  += particulas_vx[i];
    particulas_y[i]  += particulas_vy[i];
    particulas_vy[i] += 0.15;
    particulas_alpha[i] = max(0, particulas_alpha[i] - 2);
  }
}

void desenharParticulas() {
  noStroke();
  for (int i = 0; i < particulas_x.length; i++) {
    if (particulas_alpha[i] <= 0) continue;
    fill(red(particulas_cor[i]), green(particulas_cor[i]), blue(particulas_cor[i]), particulas_alpha[i]);
    float sz = random(6, 14);
    rect(particulas_x[i], particulas_y[i], sz, sz, 2);
  }
}

// ============================================================
//  SACUDIR
// ============================================================
void iniciarSacudir() { sacudindo = true; timerSacudir = millis(); }

void atualizarSacudir() {
  if (!sacudindo) return;
  int t = millis() - timerSacudir;
  if (t > 500) { sacudindo = false; sacudirX = 0; return; }
  sacudirX = sin(t * 0.1) * 8 * (1 - t / 500.0);
}

// ============================================================
//  FADE
// ============================================================
void atualizarFade() {
  if (!fadeIn) return;
  alphaTransicao = max(0, alphaTransicao - 8);
  fill(0, alphaTransicao);
  noStroke();
  rect(0, 0, width, height);
  if (alphaTransicao <= 0) fadeIn = false;
}

void iniciarFade() { fadeIn = true; alphaTransicao = 255; }

// ============================================================
//  MOUSE
// ============================================================
void mousePressed() {
  switch (estadoAtual) {
    case TELA_MENU:    cliqueMenu();    break;
    case TELA_TEMA:    cliqueTema();    break;
    case TELA_JOGO:    cliqueJogo();    break;
    case TELA_VITORIA: cliqueVitoria(); break;
    case TELA_DERROTA: cliqueDerrota(); break;
    case TELA_RECORDE: cliqueRecorde(); break;
  }
}

void cliqueMenu() {
  Botao btnJogar = new Botao(width/2 - 120, 370, 240, 55, "", COR_ACERTO, color(255));
  Botao btnRec   = new Botao(width/2 - 120, 440, 240, 55, "", COR_DESTAQUE, color(20));
  if (btnJogar.clicado()) { estadoAtual = TELA_TEMA;    iniciarFade(); }
  if (btnRec.clicado())   { estadoAtual = TELA_RECORDE; iniciarFade(); }
}

void cliqueTema() {
  for (int i = 0; i < botoesTema.length; i++) {
    if (botoesTema[i].clicado()) { temaSelecionado = i; iniciarJogo(); return; }
  }
  if (btnMenu.clicado()) { estadoAtual = TELA_MENU; iniciarFade(); }
}

void cliqueJogo() {
  String linhas = "QWERTYUIOPASDFGHJKLZXCVBNM";
  int[] tamLinhas = {10, 9, 7};
  int idx = 0;
  int bw = 44, bh = 38, gap = 4;
  int ky = 380;
  for (int linha = 0; linha < 3; linha++) {
    int tam = tamLinhas[linha];
    int totalW = tam * (bw + gap) - gap;
    int kx = (width - totalW) / 2;
    for (int col = 0; col < tam && idx < 26; col++) {
      char letra = linhas.charAt(idx);
      int bx = kx + col * (bw + gap);
      if (mouseX > bx && mouseX < bx + bw && mouseY > ky && mouseY < ky + bh) {
        processarLetra(letra); return;
      }
      idx++;
    }
    ky += bh + gap + 2;
  }
  if (btnDica.clicado() && !usouDica) { usouDica = true; pontuacao = max(0, pontuacao - 50); }
  if (btnMenu.clicado()) voltarMenu();
}

void cliqueVitoria() {
  if (btnProxima.clicado()) { estadoAtual = TELA_TEMA; iniciarFade(); }
  if (btnMenu.clicado()) voltarMenu();
}

void cliqueDerrota() {
  if (btnJogarNovamente.clicado()) { pontuacao = 0; rodada = 1; estadoAtual = TELA_TEMA; iniciarFade(); }
  if (btnMenu.clicado()) voltarMenu();
}

void cliqueRecorde() {
  if (btnMenu.clicado()) voltarMenu();
}

// ============================================================
//  TECLADO FÍSICO
// ============================================================
void keyPressed() {
  if (estadoAtual != TELA_JOGO) return;
  if (key >= 'a' && key <= 'z') processarLetra(Character.toUpperCase(key));
  if (key >= 'A' && key <= 'Z') processarLetra(key);
}

// ============================================================
//  LÓGICA DO JOGO
// ============================================================
void iniciarJogo() {
  String[] entrada = Temas.getPalavraAleatoria(temaSelecionado);
  palavraSecreta = entrada[0].toUpperCase();
  palavraDica    = entrada[1];
  letrasReveladas = new char[palavraSecreta.length()];
  for (int i = 0; i < letrasReveladas.length; i++) {
    letrasReveladas[i] = (palavraSecreta.charAt(i) == ' ') ? ' ' : '_';
  }
  letrasErradas.clear();
  letrasCorretas.clear();
  erros = 0;
  usouDica = false;
  tempoInicio = millis();
  estadoAtual = TELA_JOGO;
  iniciarFade();
}

void processarLetra(char letra) {
  if (letrasErradas.contains(letra) || letrasCorretas.contains(letra)) return;
  boolean acertou = false;
  for (int i = 0; i < palavraSecreta.length(); i++) {
    if (palavraSecreta.charAt(i) == letra) {
      letrasReveladas[i] = letra;
      acertou = true;
    }
  }
  if (acertou) {
    letrasCorretas.add(letra);
    verificarVitoria();
  } else {
    letrasErradas.add(letra);
    erros++;
    iniciarSacudir();
    if (erros >= MAX_ERROS) {
      tempoFinal = (millis() - tempoInicio) / 1000;
      estadoAtual = TELA_DERROTA;
      Temas.atualizarRecorde(temaSelecionado, pontuacao);
      iniciarFade();
    }
  }
}

void verificarVitoria() {
  for (char c : letrasReveladas) { if (c == '_') return; }
  tempoFinal = (millis() - tempoInicio) / 1000;
  int pts = calcularPontos();
  pontuacao += pts;
  if (pontuacao > recorde) recorde = pontuacao;
  Temas.atualizarRecorde(temaSelecionado, pontuacao);
  rodada++;
  estadoAtual = TELA_VITORIA;
  lancarParticulas();
  iniciarFade();
}

int calcularPontos() {
  int base       = 100;
  int bonus_erros = (MAX_ERROS - erros) * 20;
  int bonus_tempo = max(0, 60 - tempoFinal) * 2;
  int bonus_dica  = usouDica ? 0 : 30;
  return base + bonus_erros + bonus_tempo + bonus_dica;
}

String formatarTempo(int seg) {
  return nf(seg / 60, 2) + ":" + nf(seg % 60, 2);
}

void voltarMenu() {
  estadoAtual = TELA_MENU;
  pontuacao = 0;
  rodada = 1;
  iniciarFade();
}

// ============================================================
//  INICIALIZAR BOTÕES
// ============================================================
void inicializarBotoes() {
  String[] nomes = Temas.getNomesTemas();
  botoesTema = new Botao[nomes.length];
  int cols = 3;
  int bw = 200, bh = 55, gap = 20;
  int totalW = cols * bw + (cols - 1) * gap;
  int startX = (width - totalW) / 2;
  int startY = 180;
  color[] temasCores = {
    color(200, 80, 80),  color(80, 160, 200), color(80, 180, 100),
    color(200, 150, 50), color(140, 80, 200), color(200, 100, 160)
  };
  for (int i = 0; i < nomes.length; i++) {
    int col = i % cols;
    int row = i / cols;
    botoesTema[i] = new Botao(
      startX + col * (bw + gap),
      startY + row * (bh + gap),
      bw, bh, nomes[i],
      temasCores[i % temasCores.length], color(255)
    );
  }
  btnDica           = new Botao(420, 215, 180, 38, "Dica (-50pts)", color(80, 80, 30), COR_DESTAQUE);
  btnMenu           = new Botao(width/2 - 90, 520, 180, 45, "Menu", color(50, 50, 80), COR_TEXTO);
  btnProxima        = new Botao(width/2 - 120, 360, 240, 50, "Proxima Palavra", COR_ACERTO, color(10));
  btnJogarNovamente = new Botao(width/2 - 120, 480, 240, 50, "Jogar Novamente", COR_DESTAQUE, color(10));
}

// ============================================================
//  CLASSE BOTÃO
// ============================================================
class Botao {
  float x, y, w, h;
  String rotulo;
  color corFundo, corTexto;

  Botao(float x, float y, float w, float h, String rotulo, color corFundo, color corTexto) {
    this.x = x; this.y = y; this.w = w; this.h = h;
    this.rotulo = rotulo;
    this.corFundo = corFundo;
    this.corTexto = corTexto;
  }

  void desenhar() {
    boolean hover = mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
    float brilho = hover ? 40 : 0;
    fill(0, 0, 0, 80);
    noStroke();
    rect(x + 3, y + 3, w, h, 10);
    fill(
      min(255, red(corFundo)   + brilho),
      min(255, green(corFundo) + brilho),
      min(255, blue(corFundo)  + brilho)
    );
    stroke(corTexto);
    strokeWeight(hover ? 2 : 1);
    rect(x, y, w, h, 10);
    noStroke();
    textFont(fonteTexto);
    textAlign(CENTER, CENTER);
    fill(corTexto);
    text(rotulo, x + w/2, y + h/2);
  }

  boolean clicado() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}
