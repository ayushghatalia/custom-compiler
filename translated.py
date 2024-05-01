import sys
sys.path.append('../')
from engine import *

#PRIMITIVE:
Somename = 0
Someothername = 1
difficulty = 1
foreground_col = 5
background_col = 1
height = 20
width = 10
lower_bound = 1
prob = 2
upper_bound = 74
update_duration = 100
move_down_duration = 100
speed_increase_factor = 1
speed_decrease_factor = 1
difficulty = 3
direction = 1
shadow = 0
next = 0

#FUNCTIONS:
def Func2():
    Someothername = Someothername + Somename

def run():
    Somename = tetris_engine.move_piece(direction = 1)

def Func3():
    while 3 + 5 :
        while 3 + 5 :
            Someothername = 5


#ENGINE:
if __name__ == '__main__':
	tetris_engine = TetrisEngine(height,width,update_duration,move_down_duration,background_col,foreground_col,difficulty,lower_bound,upper_bound,prob)


