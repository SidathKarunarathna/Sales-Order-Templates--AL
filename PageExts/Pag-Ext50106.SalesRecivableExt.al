pageextension 50106 "Sales & Recivable Ext" extends "Sales & Receivables Setup"
{
    layout{
        addafter("Document Default Line Type"){
            field("Enable Template";Rec."Enable Template"){
                ApplicationArea=all;
            }
        }
    }
}
