import java.util.stream.*;
import java.util.*;

// Simulate infected agents moving through a space
ArrayList<Agent> agents = new ArrayList<Agent>();
PrintWriter data = createWriter("AgentSISData.csv");

// Assumed constant values
float tao, c, a;
int w, n;

void setup() {
  size(500, 500);
  for (int i = 0; i<500; i++) {
    Agent a = new Agent();
    agents.add(a);
  }
  data.println("Susceptible, Infected, Recovered");
}

void draw() {
  background(64);
  int[] counts = new int[3];
  for (Agent a : agents) {
    a.update();
    counts[a.status]++;
    a.draw();
  }
  data.println(""+counts[0]+","+counts[1]+","+counts[2]);
}

void keyPressed() {
  if (key=='d') {
    // dump data
    data.flush();
    data.close();
    exit();
  }
}
