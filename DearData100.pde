// Dear Data 100 - my Valorant trades
// Each row in data/trades.csv is one round I played.
// Each match is a row of circles, each circle is one round:
//   colour  = round won (teal) or lost (red)
//   size    = how many kills I got that round
//   ring    = I won a trade (killed someone who just killed a teammate)
//   dot     = I died that round

Table rounds;

int cell = 30;       // horizontal space for each round (28 rounds must fit)
int rowGap = 46;     // vertical space between matches
int marginX = 140;
int marginY = 110;

color BG = color(15, 25, 35);
color WIN = color(75, 227, 176);
color LOSS = color(255, 70, 85);

void setup() {
  size(1000, 700);
  rounds = loadTable("trades.csv", "header");
  noLoop();   // the data doesn't change, so only draw once
}

void draw() {
  background(BG);
  drawTitle();

  if (rounds.getRowCount() == 0) {
    fill(200);
    textAlign(LEFT, CENTER);
    text("No rounds recorded yet - add some to data/trades.csv", marginX, marginY);
    return;
  }

  for (TableRow row : rounds.rows()) {
    drawRound(row);
  }
  drawMatchLabels();
  drawSummary();
}

void drawTitle() {
  fill(255);
  textAlign(LEFT, TOP);
  textSize(24);
  text("Dear Data 100 - my Valorant trades", 40, 30);
  textSize(12);
}

void drawRound(TableRow row) {
  float x = marginX + (row.getInt("round") - 1) * cell + cell / 2;
  float y = marginY + (row.getInt("match") - 1) * rowGap;
  float d = roundSize(row.getInt("kills"));

  noStroke();
  if (row.getInt("round_won") == 1) {
    fill(WIN);
  } else {
    fill(LOSS);
  }
  ellipse(x, y, d, d);

  if (row.getInt("trades_won") > 0) {
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(x, y, d + 8, d + 8);
  }

  if (row.getInt("died") == 1) {
    noStroke();
    fill(BG);
    ellipse(x, y, 6, 6);
  }
}

// 0 kills = small circle, 5 kills (ace) = big circle
float roundSize(int kills) {
  return 12 + kills * 4;
}

// Writes the map name at the start of each match's row
void drawMatchLabels() {
  fill(200);
  noStroke();
  textAlign(RIGHT, CENTER);
  for (TableRow row : rounds.rows()) {
    if (row.getInt("round") == 1) {
      float y = marginY + (row.getInt("match") - 1) * rowGap;
      text(row.getString("map"), marginX - 15, y);
    }
  }
}

// Adds up every value in one column, e.g. sumColumn("kills")
int sumColumn(String column) {
  int total = 0;
  for (TableRow row : rounds.rows()) {
    total += row.getInt(column);
  }
  return total;
}

// What percentage of my deaths did a teammate trade?
float percentTraded() {
  int deaths = sumColumn("died");
  if (deaths == 0) {
    return 0;
  }
  return 100.0 * sumColumn("got_traded") / deaths;
}

// How many rounds did my team win?
int countRoundsWon() {
  return sumColumn("round_won");
}

void drawSummary() {
  fill(255);
  noStroke();
  textAlign(LEFT, BOTTOM);
  textSize(14);
  text("Rounds: " + rounds.getRowCount()
    + "    Won: " + countRoundsWon()
    + "    Kills: " + sumColumn("kills")
    + "    Trades won: " + sumColumn("trades_won")
    + "    Deaths: " + sumColumn("died")
    + "    Deaths traded by team: " + nf(percentTraded(), 0, 1) + "%",
    40, height - 30);
  textSize(12);
}
