table 50107 "Sales Order Templates Line"
{
    Caption = 'Sales Order Templates Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Template Code"; Code[20])
        {
            Caption = 'Template Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Type"; Enum "Sales Line Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(3; "Line no"; Integer)
        {
            Caption = 'Line no';
            DataClassification = ToBeClassified;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST(Item)) Item;

            trigger OnValidate()
            var
                Item: Record Item;
                GLAccount: Record "G/L Account";
                Resource: Record Resource;
                FixedAsset: Record "Fixed Asset";
                ItemCharge: Record "Item Charge";
            begin
                case Rec.Type of
                    Type::Item:
                        begin
                            if Item.Get("No.") then begin
                                Rec.Description := Item.Description;
                            end
                        end;
                    Type::"G/L Account":
                        begin
                            if GLAccount.Get("No.") then begin
                                Rec.Description := GLAccount.Name;
                            end;
                        end;
                    Type::"Fixed Asset":
                        begin
                            if FixedAsset.Get("No.") then begin
                                Rec.Description := FixedAsset.Description;
                            end;
                        end;
                    Type::Resource:
                        begin
                            if Resource.Get("No.") then begin
                                Rec.Description := Resource.Name;
                            end;
                        end;
                    Type::"Charge (Item)":
                        begin
                            if ItemCharge.get("No.") then begin
                                Rec.Description := ItemCharge.Description;
                            end;
                        end;
                end;
            end;
        }
        field(5; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
    }
    keys
    {
        key(PK; "Template Code", "Line no")
        {
            Clustered = true;
        }
    }
}
