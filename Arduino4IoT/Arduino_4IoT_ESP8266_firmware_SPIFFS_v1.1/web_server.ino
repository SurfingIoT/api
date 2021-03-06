String content;
String st;
int statusCode;

void createWebServer(int webtype) {
  server.on("/", []() {
    IPAddress ip = WiFi.softAPIP();
    String ipStr = String(ip[0]) + '.' + String(ip[1]) + '.' + String(ip[2]) + '.' + String(ip[3]);
    content = "<!DOCTYPE HTML>\r\n<html> ";
    content += deviceName;
    content += " IP:";
    content += ipStr;
    content += "<p>";
    content += st;
    content += "</p><form method='get' action='setup'><label>SSID: </label>";
    content += "<input name='ssid' length=32 value='";
    content += ssid + "'>";
    content += "<input name='pass' type='password' length=16 value='";
    content += password + "'><br/>";

    content += "<label>MQTT Broker: </label><input name='mqtt_server' length=32 value='";
    content += mqtt_server + "'><br/>";
    content += "<label>Sensor Publishing Interval (MS): </label><input name='sensor_interval' length=16 value='";
    String s_t = String(sensor_interval);
    content += s_t + "'><br/>";

    content += "<label>MQTT Broadcast Queue: </label><input name='queue_broadcast' length=64 value='";
    content += queue_broadcast + "'><br/>";

    content += "<label>MQTT Listener Queue: </label><input name='queue_listener' length=64 value='";
    content += queue_listener + "'><br/>";

    content += "<label>MQTT Sensors Queue: </label><input name='queue_sensors' length=64 value='";
    content += queue_sensors + "'><br/>";

    content += "<label>MQTT Rendezvous Queue: </label><input name='queue_rendezvous' length=64 value='";
    content += queue_rendezvous + "'><br/>";

    content += "<br/><input type='submit'></form>";
    content += "</html>";
    server.send(200, "text/html", content);
  });
  server.on("/sensors", []() {
    Serial.print("sensors");
    Serial.flush();
    String sensors = Serial.readString();
    toChar(sensors);
    server.send(200, "application/json", buffer);
  });
  server.on("/control", []() {
    String command = server.arg("thing");
    command.replace("=", "?");
    Serial.print(command);
    Serial.flush();
    String resp = Serial.readString();
    toChar(resp);
    server.send(200, "application/json", buffer);
  });
  server.on("/restore", []() {
    restore();
    beep();
    server.send(200, "application/json", buffer);
  });
  server.on("/setup", []() {
    ssid = server.arg("ssid");
    password = server.arg("pass");
    mqtt_server = server.arg("mqtt_server");
    queue_listener = server.arg("queue_listener");
    queue_broadcast = server.arg("queue_broadcast");
    queue_sensors = server.arg("queue_sensors");
    queue_rendezvous = server.arg("queue_rendezvous");
    String t_interval = server.arg("sensor_interval");
    sensor_interval = atoi(t_interval.c_str());
    save();
    beep();

    server.send(200, "application/json", "{success: restart your board}" );
  });
}
