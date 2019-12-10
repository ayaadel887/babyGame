import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AnimalsL3.dart';
import 'dragObject.dart';
import 'package:audioplayers/audio_cache.dart';


class AnimalsL2 extends StatefulWidget {
  @override
  _AnimalsL2State createState() => _AnimalsL2State();
}

class _AnimalsL2State extends State<AnimalsL2> {
  Offset posCamel = Offset(170, 50);
  bool camelAcc = false;
  int score=0;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
]);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Your Score : $score",
                  style: TextStyle(fontSize: 25, color: Colors.yellow),
                ),
                Container(
                  height: 130,
                  child: score==100 ? Text("YOU WIN", style: TextStyle(fontSize: 50, color: Colors.red),): Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    buildDragTarget(
                        "assets/camel1.png", "assets/camel2.png", "camel", camelAcc),
                  
                   
                  ],
                )
              ],
            ),
         
            camelAcc
                ? Container()
                : DragObject(
                    image: "assets/camel1.png",
                    position: posCamel,
                    dataNama: "camel",
                  ),
            
          ],
        ),
      ),
    );
  }

  DragTarget<String> buildDragTarget(image, image2, nama, acc) {
    return DragTarget(
      builder: (context, List<String> data, rj) {
        return acc
            ? Image.asset(
                image,
                width: 130,
                height: 130,
              )
            : data.isEmpty
                ? Image.asset(
                    image2,
                    width: 130,
                    height: 130,
                  )
                : Opacity(
                    opacity: 0.7,
                    child: Image.asset(
                      image2,
                      width: 130,
                      height: 130,
                    ),
                  );
      },
      onAccept: (data) {
        if (data == nama) {
          setState(() {
            acc = true;
            score+=50;
             plyr.play('success.mp3');
               Navigator.push(
                                context,
          MaterialPageRoute(builder: (context) =>  AnimalsL3()),
               );
          });

          switch (nama) {
            case 'camel':
              setState(() {
                camelAcc = true;
              });
              break;
           
   
            default:
          }
        }
      },
    );
  }

  State<StatefulWidget> createState() {
  
    return null;
  }
}
AudioCache plyr = AudioCache();