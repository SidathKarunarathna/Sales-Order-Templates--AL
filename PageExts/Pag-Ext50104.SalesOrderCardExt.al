pageextension 50104 "Sales Order Card Ext" extends "Sales Order"
{

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if GuiAllowed then
            if Rec."No." = '' then
                NewMode := true;
    end;

    trigger OnAfterGetCurrRecord()
    var
        SalesOrderTemplateMgt: Codeunit "Sales Order Template Mgt";
        SalesOrdertemplate: Record "Sales Order Templates";
        SalesOrderTemplateLine: Record "Sales Order Templates Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesReciveable: Record "Sales & Receivables Setup";
    begin
        SalesReciveable.Get();
        if SalesReciveable."Enable Template" then
            if NewMode then begin
                TemplateCode := SalesOrderTemplateMgt.SelectCustomerTemplate();
                SalesOrdertemplate.get(TemplateCode);
                NoSeriesMgt.InitSeries(SalesOrdertemplate."No. Series", '', SalesHeader."Posting Date", SalesHeader."No.", SalesHeader."No. Series");
                NoSeriesMgt.InitSeries(SalesOrdertemplate."Posted No.Series", '', SalesHeader."Posting Date", SalesHeader."Posting No.", SalesHeader."Posting No. Series");
                SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                SalesHeader."Your Reference" := SalesOrdertemplate."Your Reference";
                SalesHeader.Validate("Sell-to Customer No.", SalesOrdertemplate."Sell-to-Customer-No.");
                SalesHeader.Insert(true);


                if SalesOrdertemplate."Sell-to-Customer-No." <> '' then begin
                    SalesOrderTemplateLine.SetRange("Template Code", TemplateCode);
                    if SalesOrderTemplateLine.FindSet() then
                        repeat begin
                            SalesLine.init();
                            SalesLine."Document Type" := SalesLine."Document Type"::Order;
                            SalesLine."Document No." := SalesHeader."No.";
                            SalesLine."Line No." := SalesOrderTemplateLine."Line no";
                            SalesLine.Type := SalesOrderTemplateLine.Type;
                            SalesLine.Validate("No.",SalesOrderTemplateLine."No.");
                            SalesLine.Validate(Quantity,SalesOrderTemplateLine.Quantity);
                            SalesLine.Insert();
                            //SalesLine.Modify();
                            //CurrPage.Update;
                        end until SalesOrderTemplateLine.Next() = 0;
                end;
                Rec.Copy(SalesHeader);
                CurrPage.Update(true);
                //CurrPage.Close();
                //Page.Run(42,Rec);
        
                NewMode := false;
            end;



    end;



    var
        NewMode: Boolean;
        TemplateCode: Code[20];

}
