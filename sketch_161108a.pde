import processing.serial.*; 
Serial port;    
int val;
PImage backImg; 
PImage catImg; 
PImage canoImg; 
PImage startImg; 
PImage gameoverImg;
int gamestate = 3; //gamestate eh o estado em que o jogo se encontra. Se for 1, eh a tela inicial do jogo
int score = 0,pontuacao =0, MaiorPonto = 0,SeuPonto=0;  //Pontuacao 
int x = -200, y, vy = 0;  //eixos do jogo e a velocidade no eixo y 
int[] wx, wy;  //Desenho das barreiras - new int[2] define que ira por 2 barreiras por vez na tela , como limitacao *Duvida* 




void setup() //Definicao basicas do jogo
{
  port = new Serial(this, "COM3", 9600); 
  backImg =loadImage("fundo.png");  //importando Imagem de fundo
  catImg =loadImage("gato.png");  //importando Imagem de gato
  canoImg =loadImage("cano.png");  //importando Imagem de cano
  startImg =loadImage("inicial.png");  //importando Imagem inicial
  gameoverImg = loadImage("fim.png"); //Imagem de game over 
   wx = new int[2];
   wy = new int[2];
  size(600,800); //Tamanho da tela do jogo, respectivamente,  tamanho e altura 
  fill(0);  //Cor da fonte do jogo
  textSize(30);    //Tamanho do texto
}
void draw() //Local de repeticao 
{ 
 
  if (0 < port.available()) {         //Teste da condicao do botao
    val = port.read();                   //Salvar o estado do botao - Codigo para o arduino 
  } 

  
  if(val!=0){  //Condicao de subida
    vy = -10;  //Velocidade para onde ele ira subir ao clicar 
  if(gamestate==1 || gamestate==3)
  {
    wx[0] = 600;
    wy[0] = y = height/2;
    wx[1] = 900;
    wy[1] = 600;
    x = gamestate = score = 0;  //Comeco do game mode 0
  }
    
  }
    else if(val==0){  //condicao de descida 
   vy = 7;  //Velocidade para onde ele ira subir ao clicar 
  
  }

  
  if(gamestate == 0)  //Jogo
  {  
    imageMode(CORNER);  //Ira mostrar a imagem de acordo com a parte superior esquerda do eixo 
    image(backImg, x, 0);
    image(backImg, x+backImg.width, 0);  //Repeticao do cenario de forma que o eixo X se movimente 
    x -= 5;  //Definindo que o fundo ira se mover para o lado esquedo 6 unidades
    vy += 1;  //aumento da velocidade do gato apos o inicio 
    y += vy;  //velocidade em que o gato vai se mover em Y 
    
    if(x == -1800) //Garante que o enxo x vai se repetir infinitamente quando chegar em seu limite 
    {
      x = 0;
    }
    for(int i = 0 ; i < 2; i++)  //Desenho das barreiras 
    {  
      imageMode(CENTER);          //Centralizar o cano,  para que o espasamento entre eles não se de em um local indevido - Retirar esta parte para tentar um desafio maior =)
      image(canoImg, wx[i], wy[i] - (canoImg.height/2+100));  
      image(canoImg, wx[i], wy[i] + (canoImg.height/2+100));  
      
      
      if(wx[i] < 0)   //Funcao randomica da altura dos cano 
      { 
        wy[i] = (int)random(200,height-200);
        wx[i] = width;
      }
      if(wx[i] == width/2)  //Sistema de pontuacao 
      {      
              MaiorPonto = max(++score, MaiorPonto);
      }
      if(y>height||y<0||(abs(width/2-wx[i])<25 && abs(y-wy[i])>100))  //Sistema de colisao, se ele estiver fora da tela e se atingir a distancia minima da parede voce perde  - Duvida sobre abs 
    {
      
  
    delay(500);
          
      gamestate=1;
    }
      wx[i] -= 6;
    }
    image(catImg, width/2, y);
    text(""+score, width/2-15, 700);   //Ira mostrar sua pontuacao no jogo 
  }
  else if(gamestate==1)  //Game over
  {
    imageMode(CENTER);
    image(gameoverImg, width/2,height/2);
    text("Maior Score: "+MaiorPonto, 50, width);
    text("Seu Score: "+score, 50, width+70);
    delay(100);
  }
  
  else if(gamestate==3) {  //Inicio
     imageMode(CENTER);
    image(startImg, width/2,height/2);
  }
}




/* Esta parte sera Utilizada sem o botão , caso queira retirar a funcção do botão   

void mousePressed() {
 
  vy = -17;  //Velocidade para onde ele ira subir ao clicar 
  if(gamestate==1 || gamestate==3)
  {
    wx[0] = 600;
    wy[0] = y = height/2;
    wx[1] = 900;
    wy[1] = 600;
    x = gamestate = score = 0;  //Comeco do game mode 0
  }*/
//}