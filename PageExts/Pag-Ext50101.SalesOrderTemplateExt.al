pageextension 50101 SalesOrderTemplateExt extends "Sales Order List"
{
    PromotedActionCategories = 'New,Process,Report,Request Approval,Order,Release,Posting,Print/Send,Navigate,Template';
    actions
    {
        addafter(Reopen)
        {
            action("Apply Template")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category10;
                trigger OnAction()
    
                begin


                end;

            }
        }
    }
    

    var
    NewMode:Boolean;
}
