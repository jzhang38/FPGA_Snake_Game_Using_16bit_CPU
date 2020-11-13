f = open('generated.txt', 'w')
for i in range(0, 12):
    line = '      state.S{0}:\n        aluUnit.alufn = CASE{0}[1][5:0];\n        if (slowClockEdge.out){{\n          led_register.d[{0}] = b1;\n          if(aluUnit.out == CASE{0}[0]) state.d = state.S{1};\n          else state.d = state.FAIL;\n        }}\n'.format(i, i+1)
    print(line)
    f.write(line)
f.close()