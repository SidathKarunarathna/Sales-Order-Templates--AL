page 50100 "Sales Order Template Card"
{
    Caption = 'Sales Order Template Card';
    PageType = Card;
    SourceTable = "Sales Order Templates";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Template Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Posted No.Series"; Rec."Posted No.Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted No.Series field.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Your Reference field.';
                }
                field("Sell-to-Customer-No.";Rec."Sell-to-Customer-No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to-Customer-No."  field.';
                }
            }
            part("Sales Order Template Line"; "Sales Order Template Line")
            {
                SubPageLink = "Template Code" = field("Template Code");
                ApplicationArea = all;
                UpdatePropagation = Both;
            }
        }
    }
}
