__Author__ = "Yingjie Qiao"

"""
This script takes `assembly_nc.txt` as input, which is the assembly code without any comments
The outputs are `func_addr.json` which contains the address of each function
and `output.txt` which is the machine code instruction of the assembly code file.
"""

import json


OPCODE = {
    "ADD" : "100000",
    "ADDC": "110000",
    "AND" : "101000",
    "ANDC": "111000",
    "OR"  : "101001",
    "SHR" : "101101",
    "ST"  : "011001",
    "LD"  : "011000",
    "RAND": "011011", # same OPCODE as JMP
    "JMP": "011011", 
    "BF"  : "011101",
    "BEQ" : "011101",
    "BT"  : "011110",
    "BNE" : "011110",
    "SHL" : "101100",
    "LDR" : "011111",
    "MOVE": "100000",
    "MULC": "110010",
    "CMPLEC": "110110",
    "CMPEQC": "110100",
    "CMPLTC": "110101",
    "CMPEQ" : "100100",
    "CMPLT" : "100101",
    "CMPLE" : "100110"

}

REGISTERS = {
    "R0": "00000",
    "R1": "00001",
    "R2": "00010",
    "R3": "00011",
    "R4": "00100",
    "R5": "00101",
    "R6": "00110",
    "R7": "00111",
    "R8": "01000",
    "R9": "01001",
    "R10": "01010",
    "R11": "01011",
    "R12": "01100",
    "R13": "01101",
    "R14": "01110",
    "R15": "01111",
    "R16": "10000",
    "R17": "10001",
    "R18": "10010",
    "R19": "10011",
    "R20": "10100",
    "R21": "10101",
    "R22": "10110",
    "R23": "10111",
    "R24": "11000",
    "R25": "11001",
    "R26": "11010",
    "R27": "11011",
    "R28": "11100",
    "R29": "11101",
    "R30": "11110",
    "R31": "11111"
}

BINARY_NUMBERS = {
    "0": "00000",
    "1": "00001",
    "2": "00010",
    "3": "00011",
    "4": "00100",
    "5": "00101",
    "6": "00110",
    "7": "00111",
    "8": "01000",
    "9": "01001",
    "10": "01010",
    "11": "01011",
    "12": "01100",
    "13": "01101",
    "14": "01110",
    "15": "01111",
    "16": "10000",
    "17": "10001",
    "18": "10010",
    "19": "10011",
    "20": "10100",
    "21": "10101",
    "22": "10110",
    "23": "10111",
    "24": "11000",
    "25": "11001",
    "26": "11010",
    "27": "11011",
    "28": "11100",
    "29": "11101",
    "30": "11110",
    "31": "11111"
}

FUNC_ADDR = {
    # populated in get_func_addr(sourcefile)
    # saved as a json for reference
}

B2H = { # not used
    0:'0', 
    1:'1', 
    2:'2', 
    3:'3', 
    4:'4', 
    5:'5', 
    6:'6', 
    7:'7', 
    8:'8', 
    9:'9', 
    10:'A', 
    11:'B', 
    12:'C', 
    13:'D', 
    14:'E', 
    15:'F'
}


def main():
    path = "/Users/yingjieqiao/Desktop/term4/50002/yingjie/assemly_nc.txt"
    # update the path as you need
    sourcefile = open(path, "r")
    lines = sourcefile.readlines()

    get_func_addr(sourcefile, lines)
    print("line addr written")

    generate_instr(sourcefile, lines)
    print("INSTR written")
    
    sourcefile.close()
    print("DONE")


def get_func_addr(sourcefile, lines):
    count = 0
    print(lines)
    for line in lines:
        if line == "\n":
            # print(line, count)
            continue
        if line[0].isalpha() and line[0].islower():
            FUNC_ADDR[line.strip()[:-1]] = count
        else:
            count += 4
    with open("func_addr.json", "w") as file:
        json.dump(FUNC_ADDR, file)


def generate_instr(sourcefile, lines):
    count = 0
    bsimcheck = open ("bsimcheck.txt", "w") 
    with open("output.txt", "w") as file:
        for line in lines:
            s = ""
            if line[0:4] == "HALT":
                break
            if (line[0].isalpha() and line[0].islower()) or line == "\n":
                continue
            else:
                args = get_args(line)
                if line[0:6] in OPCODE.keys():
                    Ra, literal, Rc = args[0].strip(), args[1].strip(), args[2].strip()
                    literal = get_literal(literal, count)
                    s = OPCODE[line[0:6]] + REGISTERS[Rc] + REGISTERS[Ra] + literal

                elif line[0:5] in OPCODE.keys():
                    # print(line)
                    Ra, Rb, Rc = args[0].strip(), args[1].strip(), args[2].strip()
                    s = OPCODE[line[0:5]] + REGISTERS[Rc] + REGISTERS[Ra] + REGISTERS[Rb] + "0"*11  

                elif line[0:4] in OPCODE.keys():
                    if (line[0:4] == "ADDC" or line[0:4] == "SUBC" or line[0:4] == "MULC" 
                        or line[0:4] == "DIVC" or line[0:4] == "ANDC" or line[0:4] == "XORC"  
                        or line[0:4] == "SHLC" or line[0:4] == "SHRC" or line[0:4] == "SRAC"):
                        Ra, literal, Rc = args[0].strip(), args[1].strip(), args[2].strip()
                        literal = get_literal(literal, count)
                        s = OPCODE[line[0:4]] + REGISTERS[Rc] + REGISTERS[Ra] + literal
                    elif line[0:4] == "MOVE":
                        Ra, Rc = args[0].strip(), args[1].strip()
                        Rb = "11111"
                        s = OPCODE[line[0:4]] + REGISTERS[Rc] + REGISTERS[Ra] + Rb + "0"*11   
                    elif line[0:4] == "RAND":
                        Ra = args[0].strip()
                        Rc = "11111"
                        s = OPCODE[line[0:4]] + Rc + REGISTERS[Ra] + "0"*16

                elif line[0:3] in OPCODE.keys():
                    if line[0:3] == "ADD" or line[0:3] == "SUB" or line[0:3] == "MUL" \
                        or line[0:3] == "DIV" or line[0:3] == "AND" or line[0:3] == "XOR" \
                        or line[0:3] == "XOR" or line[0:3] == "SHL" or line[0:3] == "SHR" \
                        or line[0:3] == "SRA":
                        Ra, Rb, Rc = args[0].strip(), args[1].strip(), args[2].strip()
                        # print(Ra, Rb, Rc, line[0:3])
                        s = OPCODE[line[0:3]] + REGISTERS[Rc] + REGISTERS[Ra] + REGISTERS[Rb] + "0"*11           
                    elif line[0:3] == "BEQ" or line[0:3] == "BNE":
                        Ra, literal, Rc = args[0].strip(), args[1].strip(), args[2].strip()
                        literal = get_literal(literal, count)
                        s = OPCODE[line[0:3]] + REGISTERS[Rc] + REGISTERS[Ra] + literal
                    elif line[0:3] == "JMP":
                        Ra = args[0].strip()
                        Rc = "11111"
                        s = OPCODE[line[0:4]] + Rc + REGISTERS[Ra] + "0"*16
                    elif line[0:3] == "LDR":
                        literal, Rc = args[0].strip(), args[1].strip()
                        Ra = "11111"
                        s = OPCODE[line[0:3]] + REGISTERS[Rc] + REGISTERS[Ra] + literal
                    elif line[0:3] == "ORC":
                        Ra, literal, Rc = args[0].strip(), args[1].strip(), args[2].strip()
                        literal = get_literal(literal, count)
                        s = OPCODE[line[0:2]] + REGISTERS[Rc] + REGISTERS[Ra] + literal
                    else:
                        print("something goes wrong")
                        print(line)
                        print(count)
                        break

                elif line[0:2] in OPCODE.keys():
                    """
                    ST, LD, BF, BT, OR
                    """
                    if line[0:2] == "ST":
                        Rc, literal, Ra = args[0].strip(), args[1].strip(), args[2].strip()    
                        literal = get_literal(literal, count)
                        s = OPCODE[line[0:2]] + REGISTERS[Rc] + REGISTERS[Ra] + literal           
                    elif line[0:2] == "LD":
                        Ra, literal, Rc = args[0].strip(), args[1].strip(), args[2].strip()
                        literal = get_literal(literal, count)
                        s = OPCODE[line[0:2]] + REGISTERS[Rc] + REGISTERS[Ra] + literal
                    elif line[0:2] == "BF" or line[0:2] == "BT":
                        Ra, literal, Rc = args[0].strip(), args[1].strip(), args[2].strip()
                        literal = get_literal(literal, count)
                        s = OPCODE[line[0:2]] + REGISTERS[Rc] + REGISTERS[Ra] + literal
                    elif line[0:2] == "OR":
                        Ra, Rb, Rc = args[0].strip(), args[1].strip(), args[2].strip()
                        s = OPCODE[line[0:2]] + REGISTERS[Rc] + REGISTERS[Ra] + REGISTERS[Rb] + "0"*11 
                    else:
                        print("something goes wrong")
                        print(line)
                        print(count)
                        break

                else:
                    pass
                if s != "":
                    verify_bsim(s, bsimcheck)  # comment out as you see fit

                    s = s + ","
                    print(s)
                    file.write(s)
                    file.write("\n")
                count += 4  # do the increment at the end of an iteration


def get_args(s):
    """
    get the arguments in a instruction
    return a list eg [R1, R2, literal]
    """

    sout = ""
    left = 0
    right = 0
    for i in range(len(s)):
        if s[i] == "(":
            left = i
        if s[i] == ")":
            right = i
    sout = s[left+1:right]
    args = sout.split(",") # remember to strip
    return args


def get_literal(literal, count):
    """
    input literal is decimal or binary or func name
    return 16 bit binary
    """

    literal_return = "" # 16 bit
    if literal.startswith("0b"):
        literal = literal[2:]
        if len(literal) < 16:
            literal_return = "0"*(16-len(literal)) + literal
        else:
            literal_return = literal
    elif literal[0].isalpha():
        print(FUNC_ADDR[literal], count)
        l = (FUNC_ADDR[literal] - count)//4 -1
        # print(literal, FUNC_ADDR[literal], count, l)
        if l >= 0:
            literal_return = f'{l:016b}' 
        else:
            with0b = bin(l % (1<<16))
            literal_return = with0b[2:]
    else: # decimal
        literal_return = f'{int(literal):016b}'
    return literal_return


def verify_bsim(s, bsimcheck):
    check = ""
    check += hex(int(s, 2))
    check += "\n"
    bsimcheck.write(check)

if __name__ == "__main__":
    main()
