import Foundation

var player1: String = "Игрок 1"
var player2: String = "Игрок 2"
var turn = true //true == player1, false == player2
var life1 = 3, life2 = 3, item_number: Int
var choise = "-1"//0 взять оружие, 1 стрельба во врага, 2 стрельба в себя
var inv1: [String] = ["-", "-", "-", "-"]
var inv2: [String] = ["-", "-", "-", "-"]
var action = 7
var currentCamora = 0
var holdGun = false

var armor1 = false, armor2 = false, double_damage = false
var baraban: [Bool] = [false, false, false, false, false, false]
var item_list: [String] = ["Аптечка", "Ножовка", "Броня"]

func clearConsole(){
    print("\u{001b}[2J")
    print("\u{001b}[H")
}

func findItemInInventory(inv: [String], nameOfItem: String) -> Int{
    for i in 0..<inv.count{
        if inv[i] == nameOfItem{
            return i
        }
    }
    return 0
}

func useItemInInventory(inv: [String], numberOfItem: Int){
    switch inv[numberOfItem]{
    case "Аптечка":
        aidkit()
        return
    case "Ножовка":
        saw()
        return
    case "Броня":
        armor()
        return
    default:
        return
    }
}

func aidkit(){
    if turn == true{
        if life1 >= 3{
            print("Максимум хп")
            sleep(1)
        }
        else{
            life1 += 1
            inv1[findItemInInventory(inv: inv1, nameOfItem: "Аптечка")] = "-"
        }
    }
    else{
        if life2 >= 3{
            print("Максимум хп")
            sleep(1)
        }
        else{
            life2 += 1
            inv2[findItemInInventory(inv: inv2, nameOfItem: "Аптечка")] = "-"
        }
    }
}

func saw(){
    if double_damage == true{
        print("Урон уже удвоен")
        sleep(1)
    }
    else{
        double_damage = true
        if turn == true{
            inv1[findItemInInventory(inv: inv1, nameOfItem: "Ножовка")] = "-"
        }
        else{
            inv2[findItemInInventory(inv: inv2, nameOfItem: "Ножовка")] = "-"
        }
    }
}

func armor(){
    if turn == true{
        if armor1 == true{
            print("Броня уже использована")
            sleep(1)
        }
        else{
            armor1 = true
            inv1[findItemInInventory(inv: inv1, nameOfItem: "Броня")] = "-"
        }
    }
    else{
        if armor2 == true{
            print("Броня уже использована")
            sleep(1)
        }
        else{
            armor2 = true
            inv2[findItemInInventory(inv: inv2, nameOfItem: "Броня")] = "-"
        }
    }
}

func addItems(){
    for _ in 1...2{
        for j in 0...3{
            if inv1[j] == "-"{
                inv1[j] = item_list[Int.random(in: 0...2)]
                break
            }
        }
    }
    for _ in 1...2{
        for j in 0...3{
            if inv2[j] == "-"{
                inv2[j] = item_list[Int.random(in: 0...2)]
                break
            }
        }
    }
}

func reloadBaraban(){
    for i in 0...5{
        baraban[i] = false
    }
    let bullets = Int.random(in: 2...4)
    for _ in 1...bullets{
        while true{
            let camora = Int.random(in: 0...5)
            if baraban[camora] == false{
                baraban[camora] = true
                break
            }
        }
    }
    currentCamora = 0
    print("Сегодня патронов у нас будет:", bullets)
    sleep(3)
}

func rotate_baraban(){
    currentCamora += 1
}


func printInterface(shot: Bool = false){
    if turn == true{
        clearConsole()
        print("Очередь", player1, "нажать на спуск\n")
        print(player2, "\tHP =", life2)
        if armor2 == true{
            print("\tARM")
        }
        print("")
        for i in 0...3{
            print(i+1, ":", inv2[i], ";", terminator: "")
        }
        if choise == "0" && holdGun == true{
            print("\n\nНажми 1 чтобы стрельнуть в опонента\n", "\nНажми 2 чтобы стрельнуть в себя\n")
        }
        else if choise == "1" && holdGun == true{
            if shot == true{
                print("\n\nBANG!\n\n")
            }
            else{
                print("\n\nЩёлк\n\n")
            }
        }
        else if choise == "2" && holdGun == true{
            if shot == true{
                print("\n\nBANG!\n\n")
            }
            else{
                print("\n\nЩёлк\n\n")
            }
        }
        else{
            print("\n\nНажми 0 чтобы взять пушку\n\n")
        }
        print(player1, "\tHP =", life1, terminator: "")
        if armor1 == true{
            print("\tARM", terminator: "")
        }
        if double_damage == true{
            print("\tDMG+")
        }
        print("")
        for i in 0...3{
            print(i+1, ":", inv1[i], ";", terminator: "")
        }
        print("")
    }
    else{
        clearConsole()
        print("Очередь", player2, "нажать на спуск\n")
        print(player1, "\tHP =", life1)
        if armor1 == true{
            print("\tARM")
        }
        print("")
        for i in 0...3{
            print(i+1, ":", inv1[i], ";", terminator: "")
        }
        if choise == "0" && holdGun == true{
            print("\n\nНажми 1 чтобы стрельнуть в опонента\n", "\nНажми 2 чтобы стрельнуть в себя\n")
        }
        else if choise == "1" && holdGun == true{
            if shot == true{
                print("\n\nBANG!\n\n")
            }
            else{
                print("\n\nЩёлк\n\n")
            }
        }
        else if choise == "2" && holdGun == true{
            if shot == true{
                print("\n\nBANG!\n\n")
            }
            else{
                print("\n\nЩёлк\n\n")
            }
        }
        else{
            print("\n\nНажми 0 чтобы взять пушку\n\n")
        }
        print(player2, "\tHP =", life2, terminator: "")
        if armor2 == true{
            print("\tARM", terminator: "")
        }
        if double_damage == true{
            print("\tDMG+")
        }
        print("")
        for i in 0...3{
            print(i+1, ":", inv2[i], ";", terminator: "")
        }
        print("")
    }
}

func pullTheTrigger() -> Bool{
    if turn == true{
        if choise == "1"{
            if baraban[currentCamora] == true{
                var damage = 1
                if double_damage == true{
                    damage += 1
                    double_damage = false
                }
                if armor2 == true{
                    damage = 0
                    armor2 = false
                }
                life2 -= damage
                rotate_baraban()
                return true
            }
            double_damage = false
            rotate_baraban()
            return false
        }
        else if choise == "2"{
            if baraban[currentCamora] == true{
                var damage = 1
                if double_damage == true{
                    damage += 1
                    double_damage = false
                }
                if armor1 == true{
                    damage = 0
                    armor1 = false
                }
                life1 -= damage
                rotate_baraban()
                return true
            }
            double_damage = false
            rotate_baraban()
            return false
        }
    }
    else{
        if choise == "1"{
            if baraban[currentCamora] == true{
                var damage = 1
                if double_damage == true{
                    damage += 1
                    double_damage = false
                }
                if armor1 == true{
                    damage = 0
                    armor1 = false
                }
                life1 -= damage
                rotate_baraban()
                return true
            }
            double_damage = false
            rotate_baraban()
            return false
        }
        else if choise == "2"{
            if baraban[currentCamora] == true{
                var damage = 1
                if double_damage == true{
                    damage += 1
                    double_damage = false
                }
                if armor2 == true{
                    damage = 0
                    armor2 = false
                }
                life2 -= damage
                rotate_baraban()
                return true
            }
            double_damage = false
            rotate_baraban()
            return false
        }
    }
    return false
}

func game(){
    inv1[0] = item_list[Int.random(in: 0...2)];inv1[1] = "-";inv1[2] = "-";inv1[3] = "-";
    inv2[0] = item_list[Int.random(in: 0...2)];inv2[1] = "-";inv2[2] = "-";inv2[3] = "-";
    life1 = 3; life2 = 3
    reloadBaraban()
    turn = true
    while true{
        action = 7
        choise = "-1"
        if life1 <= 0{
            clearConsole()
            print("Поздравляю ", player2, " с его победой")
            sleep(3)
            return
        }
        else if life2 <= 0{
            clearConsole()
            print("Поздравляю ", player1, " с его победой")
            sleep(3)
            return
        }
        if currentCamora >= 6{
            print("Кхм, вы сделали 6 выстрелов и ещё живы?\nВремя нового раунда")
            sleep(1)
            addItems()
            reloadBaraban()
        }
        while choise != "0"{
            printInterface()
            choise = readLine() ?? "-1"
            if turn == true{
                switch choise{
                case "1":
                    useItemInInventory(inv: inv1, numberOfItem: 0)
                    break
                case "2":
                    useItemInInventory(inv: inv1, numberOfItem: 1)
                    break
                case "3":
                    useItemInInventory(inv: inv1, numberOfItem: 2)
                    break
                case "4":
                    useItemInInventory(inv: inv1, numberOfItem: 3)
                    break
                default:
                    break
                }
            }
            else{
                switch choise{
                case "1":
                    useItemInInventory(inv: inv2, numberOfItem: 0)
                    break
                case "2":
                    useItemInInventory(inv: inv2, numberOfItem: 1)
                    break
                case "3":
                    useItemInInventory(inv: inv2, numberOfItem: 2)
                    break
                case "4":
                    useItemInInventory(inv: inv2, numberOfItem: 3)
                    break
                default:
                    break
                }
            }
        }
        holdGun = true
        printInterface()
        while choise != "1" && choise != "2"{
            choise = readLine() ?? "-1"
            
        }
        let shot = pullTheTrigger()
        printInterface(shot: shot)
        holdGun = false
        sleep(1)
        if turn == true{
            if shot == false && choise == "2"{
               turn = true
            }
            else{
                turn = false
            }
        }
        else{
            if shot == false && choise == "2"{
               turn = false
            }
            else{
                turn = true
            }
        }
        choise = "-1"
    }
}

func players(){
    clearConsole()
    print("Введите имя для игрока 1")
    player1 = readLine() ?? "Игрок 1"
    if player1 == ""{
        player1 = "Игрок 1"
    }
    print("Введите имя для игрока 2")
    player2 = readLine() ?? "Игрок 2"
    if player2 == ""{
        player2 = "Игрок 2"
    }
    game()
}

func information(){
    clearConsole()
    print("Добро пожаловать в игру путник",
          "\n Данная игра рассчитана на двух игроков",
          "\n\n  Правила:",
          "\n Стрельба: в игре вы можете направить пушку как на себя так и на соперника.",
          "\nВыстрел в себя хоть и является риском но дает сделать еще один выстрел.",
          "\nВыстрел во врага и так понятно чем полезен.",
          "\nПеред выстрелом вы можете использовать бонусы, но после взятия пушки в руки этого сделать нельзя.",
          "\n Бонусы: полезные предметы позволяющие склонить победу в свою сторону ну или наоборот.",
          "\n! Бонусы можно получить по окончанию раунда, т.е. когда закончатся каморы в барабане !",
          "\nАптечка - позволяет восстановить 1 жизнь, максимальное количество жизней 3.",
          "\nНожовка - позволяет укоротить длину пушки и удвоить урон. применяется один раз за ход.",
          "\nБроня - выдает игроку защиту от одного выстрела по нему.",
          "\nЭто все удачи в игре путник.")
    print("\n\n  **Чтобы продолжить введите любой символ**")
    readLine()
}

func menu(){
    while true{
        clearConsole()
        
        print("  _   _          ___          _     _   \n",
              " | |_| |_  ___  | _ \\___ _  _| |___| |_ \n",
              " |  _| ' \\/ -_) |   / _ \\ || | / -_)  _|\n",
              "  \\__|_||_\\___| |_|_\\___/\\_,_|_\\___|\\__|\n",
              "                                        ")
        print("   1  * Приступим *", "\n   2  *  Памятка  *", "\n   3  *   Выход   *")
        let function = readLine()
        if function == "1" || function=="Приступим" || function=="приступим" || function=="ПРИСТУПИМ"{
            players()
        }
        else if function == "2" || function=="Памятка" || function=="памятка" || function=="ПАМЯТКА"{
            information()
        }
        else if function == "3" || function=="Выход" || function=="выход" || function=="ВЫХОД"{
            return
        }
    }
}


clearConsole()
print("\n⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣷⣾⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣿⣯⣽⡙⠿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⢠⣾⣿⡗⡞⣭⠭⡘⠋⠋⠀⣰⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⣀⣤⣿⣿⣿⣿⣿⠔⠃⠀⢀⣤⡶⠋⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⢀⣴⣾⣿⣿⣿⣿⣷⣮⡐⠀⠀⣰⣯⠟⠡⢀⣼⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⣰⣿⣿⣿⣿⣿⣛⠿⣿⣽⢿⣦⣨⡷⠋⠀⢸⣾⣿⣹⡾⢧⣀⠀⠀⠀⠀⠀⠀\n",
      "⣿⣿⡿⣻⣿⣿⣿⣷⣎⢻⣞⣿⡟⠀⡄⠀⣼⢿⣧⣿⣿⣷⣦⠛⣦⡀⠀⠀⠀\n",
      "⣿⣿⡇⣿⣿⣿⣿⣿⣿⡄⣿⣿⣇⠀⣷⣾⣟⣼⣿⣿⣿⣿⣿⣏⡤⠽⠦⡀⠀\n",
      "⣿⣿⣧⡻⣿⣿⣿⣿⡿⣸⣯⣿⣇⡜⢹⣷⣿⣿⣿⣿⣿⣿⡟⢛⠀⠀⠀⠐⡄\n",
      "⠈⢻⡿⣿⣾⣿⣿⣿⣾⣿⣿⣿⠋⣰⡿⠛⠻⣿⣿⣿⣿⡿⠈⠀⠀⠀⠀⢠⠃\n",
      "⠀⠈⣿⣳⣯⣿⠾⣳⢯⣿⠟⢁⣼⣿⢡⠖⠓⠲⣝⣿⣿⡏⢀⡠⣀⣀⡼⠃⠀\n",
      "⠀⠀⣿⣟⣿⣿⣿⣎⢟⣽⢀⣾⣿⣴⢸⣄⠀⠀⣸⣽⣿⡃⠎⠀⠀⡽⠁⠀⠀\n",
      "⠀⢀⣿⣟⢿⣿⣿⡟⣼⡟⣾⣿⢯⣿⠺⠽⠷⡾⠷⢏⠛⢧⡘⠢⣀⠇⠀⠀⠀\n",
      "⠀⠸⣿⣝⠷⣿⣽⠾⢟⣽⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠉⢨⠿⠷⠚⠀⠀⠀⠀\n",
      "⠀⠀⢹⣿⣿⣶⣶⣾⣿⣿⡟⢁⡀⢀⠀⢀⠀⠀⠀⠀⠀⡽⣂⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣷⣦⣜⣢⡉⢆⠂⣀⣀⡤⠞⢑⠇⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⡍⠉⠉⠉⠉⠉⠉⠀⠀⠀⡼⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⡌⣄⠢⢄⠠⡀⠀⠀⢀⣰⠃⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠈⢻⣿⣿⣿⡿⣿⠿⣴⢧⣮⠴⡥⠶⢚⣩⠆⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⢻⣿⣿⡖⢠⢐⡀⢀⠀⠄⠀⠀⡼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⠀⠙⢿⣟⣲⢦⣽⢒⡌⣌⡴⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n")
for _ in 1...30{
    print("#", terminator: "")
    usleep(50000)
}
print("\n\n**Запуск**")
sleep(1)
clearConsole()
menu()
