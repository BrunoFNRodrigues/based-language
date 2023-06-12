
class SymbolTable():
    reserved = ["println", "readline", "while", "if", "else"]
        
    def __init__(self):
        self.table = {}
        
    def Getter(self, key):
        if key in SymbolTable.reserved:
            raise Exception("Você é fraco lhe falta erros: Palavra reservada")
        if key in self.table.keys():
            return self.table[key]
    
    def Setter(self, key, value):
        if key in self.table.keys():
            self.table[key] = value 
        else:            
            self.table[key] = value

    def Create(self, key, value):
        if key in self.table.keys():
            raise Exception("Você é fraco lhe falta erros: Variavel já existe")
        else:
            self.table[key] = ("Int",value)

