#include <iostream>
#include <vector>
#include <llvm/Value.h>

class CodeGenContext;
class NStatement;
class NExpression;
class NVariableDeclaration;

typedef std::vector<NStatement*> StatementList;
typedef std::vector<NExpression*> ExpressionList;
typedef std::vector<NVariableDeclaration*> VariableList;

class Node {
public:
    virtual ~Node() {}
    virtual llvm::Value* codeGen(CodeGenContext& context) { }
};

class NExpression : public Node {
};

class NStatement : public Node {
};

class NInteger : public NExpression {
public:
    long long value;
    NInteger(long long value) : value(value) { }
    virtual llvm::Value* codeGen(CodeGenContext& context);
};

class NIdentifier : public NExpression {
public:
    std::string name;
    NIdentifier(const std::string& name) : name(name) { }
    virtual llvm::Value* codeGen(CodeGenContext& context);
};

class NMethodCall : public NExpression {
public:
    const NIdentifier& id;
    ExpressionList arguments;
    NMethodCall(const NIdentifier& id, ExpressionList& arguments) :
        id(id), arguments(arguments) { }
    NMethodCall(const NIdentifier& id) : id(id) { }
    virtual llvm::Value* codeGen(CodeGenContext& context);
};

class NBinaryOperator : public NExpression {
public:
    char op;
    NExpression& lhs;
    NExpression& rhs;
    NBinaryOperator(NExpression& lhs, char op, NExpression& rhs) :
        lhs(lhs), rhs(rhs), op(op) { }
    virtual llvm::Value* codeGen(CodeGenContext& context);
};

class NAssignment : public NExpression {
public:
    NIdentifier& lhs;
    NExpression& rhs;
    NAssignment(NIdentifier& lhs, NExpression& rhs) : 
        lhs(lhs), rhs(rhs) { }
    virtual llvm::Value* codeGen(CodeGenContext& context);
};

class NBlock : public NExpression {
public:
    StatementList statements;
    NBlock() { }
    virtual llvm::Value* codeGen(CodeGenContext& context);
};

class NExpressionStatement : public NStatement {
public:
    NExpression& expression;
    NExpressionStatement(NExpression& expression) : 
        expression(expression) { }
    virtual llvm::Value* codeGen(CodeGenContext& context);
};

class NVariableDeclaration : public NStatement {
public:
    NIdentifier& id;
    NExpression *assignmentExpr;
    NVariableDeclaration(const NIdentifier& id) :
        id(id) { }
    NVariableDeclaration(const NIdentifier& id, NExpression *assignmentExpr) :
        id(id), assignmentExpr(assignmentExpr) { }
    virtual llvm::Value* codeGen(CodeGenContext& context);
};

class NFunctionDeclaration : public NStatement {
public:
    const NIdentifier& id;
    VariableList arguments;
    NBlock& block;
    NFunctionDeclaration(const NIdentifier& id, 
            const VariableList& arguments, NBlock& block) :
        id(id), arguments(arguments), block(block) { }
    virtual llvm::Value* codeGen(CodeGenContext& context);
};

class NIfStatement : public NStatement {
public:
    struct ElseIfClause {
        NExpression& condition;
        NBlock& block;
        ElseIfClause(NExpression& condition, NBlock& block) : condition(condition), block(block) {}
    };

    NExpression& condition;
    NBlock& ifBlock;
    std::vector<ElseIfClause> elseIfClauses;
    NBlock* elseBlock;

    NIfStatement(NExpression& condition, NBlock& ifBlock, const std::vector<ElseIfClause>& elseIfClauses, NBlock* elseBlock) :
        condition(condition), ifBlock(ifBlock), elseIfClauses(elseIfClauses), elseBlock(elseBlock) {}

    virtual llvm::Value* codeGen(CodeGenContext& context);
};

class NWhileStatement : public NStatement {
public:
    NExpression& condition;
    NBlock& block;
    NWhileStatement(NExpression& condition, NBlock& block) :
        condition(condition), block(block) { }
    virtual llvm::Value* codeGen(CodeGenContext& context);
};