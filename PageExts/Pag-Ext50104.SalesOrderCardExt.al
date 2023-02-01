pageextension 50104 "Sales Order Card Ext" extends "Sales Order"
{
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        if GuiAllowed then
            if Rec."No." = '' then
                if DocumentNoVisibility.CustomerNoSeriesIsDefault then
                    NewMode := true;
    end;

    trigger OnAfterGetCurrRecord()
    var
        SalesOrderTemplateMgt: Codeunit "Sales Order Template Mgt";
        SalesOrdertemplate: Record "Sales Order Templates";
    begin
        if NewMode then begin
            TemplateCode := SalesOrderTemplateMgt.SelectCustomerTemplate();
            SalesOrdertemplate.get(TemplateCode);
            Rec.Init();
            Rec."Document Type" := rec."Document Type"::Order;
            Rec."Your Reference" := SalesOrdertemplate."Your Reference";
            Rec."No. Series" := SalesOrdertemplate."No. Series";
            Rec."Posting No. Series" := SalesOrdertemplate."Posted No.Series";
            Rec.Insert(true);
            NewMode := false;
        end;
    end;



    var
        NewMode: Boolean;
        TemplateCode: Code[20];

}
