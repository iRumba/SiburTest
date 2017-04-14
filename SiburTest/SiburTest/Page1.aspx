<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Page1.aspx.cs" Inherits="SiburTest.Page1" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
    <asp:SqlDataSource ID="StuffSource" runat="server" ConnectionString="<%$ connectionStrings:SiburConnection %>"
        SelectCommand="
        SELECT 0 Id, NULL FirstName, NULL LastName, NULL MiddleName, NULL DepartmentId, NULL DepartmentName
        UNION ALL
        SELECT es.Id, FirstName, LastName, MiddleName, DepartmentId, ds.Name DepartmentName 
        FROM EmployeeSet es
        LEFT JOIN DepartmentSet ds ON ds.Id = es.DepartmentId"
        UpdateCommand="
        IF @Id > 0
            UPDATE EmployeeSet SET 
            FirstName = @FirstName, 
            LastName = @LastName,
            MiddleName = @MiddleName,
            DepartmentId = @DepartmentId
            WHERE Id = @Id
        ELSE
            INSERT INTO EmployeeSet (FirstName, LastName, MiddleName, DepartmentId) 
            VALUES (@FirstName, @LastName, @MiddleName, @DepartmentId)
        "
        DeleteCommand="DELETE FROM EmployeeSet WHERE Id = @Id">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DepartmentsSource" runat="server" ConnectionString="<%$ connectionStrings:SiburConnection %>"
        SelectCommand="
        SELECT 0 Id, NULL Name
        UNION ALL
        SELECT Id, Name FROM DepartmentSet"
        UpdateCommand="
        IF @Id > 0
            UPDATE DepartmentSet SET
            Name = @Name
            WHERE Id = @Id
        ELSE
            INSERT INTO DepartmentSet (Name) VALUES (@Name)" />
    <asp:SqlDataSource ID="DepartmentsSourceForChanging" runat="server" ConnectionString="<%$ connectionStrings:SiburConnection %>"
        SelectCommand="
        SELECT NULL Id, 'Не выбран' Name
        UNION ALL
        SELECT Id, Name FROM DepartmentSet" />
    <asp:GridView ID="gridDepartments" runat="server" DataSourceID="DepartmentsSource" ShowHeaderWhenEmpty="true"
        CssClass="col-sm-4" AutoGenerateColumns="false" DataKeyNames="Id">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton runat="server" Text="Создать" ID="btnNew" CommandName="Edit" CausesValidation="false"
                        Visible="<%# Container.DataItemIndex == 0 && gridDepartments.EditIndex != 0 %>"/>
                    <asp:LinkButton runat="server" Text="Правка" ID="btnEdit" CommandName="Edit" CausesValidation="false"
                        Visible="<%# gridDepartments.EditIndex != Container.DataItemIndex && Container.DataItemIndex > 0 %>" />
                    <asp:LinkButton runat="server" Text="Удалить" ID="btnDelete" CommandName="Delete" CausesValidation="false"
                        Visible="<%# gridDepartments.EditIndex != Container.DataItemIndex && Container.DataItemIndex > 0 %>" />
                    <asp:LinkButton runat="server" Text="Сохранить" ID="btnUpdate" CommandName="Update" 
                        Visible="<%# gridDepartments.EditIndex == Container.DataItemIndex %>" />
                    <asp:LinkButton runat="server" Text="Отмена" ID="btnCancel" CommandName="Cancel" CausesValidation="false"
                        Visible="<%# gridDepartments.EditIndex == Container.DataItemIndex %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Название отдела" >
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%#Eval("Name") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" Text='<%#Bind("Name") %>' Id="txtDN"/><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDN" ErrorMessage="Значение не должно быть пустым" 
                        Font-Bold="true" ForeColor="Red" Display="Dynamic" />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:GridView ID="grid" runat="server" DataSourceID="StuffSource" AutoGenerateColumns="False" DataKeyNames="Id"
        OnRowDataBound="grid_RowDataBound"
        ShowHeaderWhenEmpty="True" 
        OnRowEditing="grid_RowEditing" OnRowCancelingEdit="grid_RowCancelingEdit" CssClass="col-sm-8" >
        <HeaderStyle BackColor="DimGray" ForeColor="White" Font-Bold="true" 
            />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton runat="server" Text="Создать" ID="btnNew" CommandName="Edit" CausesValidation="false"
                        Visible="<%# Container.DataItemIndex == 0 && grid.EditIndex != 0 %>"/>
                    <asp:LinkButton runat="server" Text="Правка" ID="btnEdit" CommandName="Edit" CausesValidation="false"
                        Visible="<%# grid.EditIndex != Container.DataItemIndex && Container.DataItemIndex > 0 %>" />
                    <asp:LinkButton runat="server" Text="Удалить" ID="btnDelete" CommandName="Delete" CausesValidation="false"
                        Visible="<%# grid.EditIndex != Container.DataItemIndex && Container.DataItemIndex > 0 %>" />
                    <asp:LinkButton runat="server" Text="Сохранить" ID="btnUpdate" CommandName="Update" 
                        Visible="<%# grid.EditIndex == Container.DataItemIndex %>" />
                    <asp:LinkButton runat="server" Text="Отмена" ID="btnCancel" CommandName="Cancel" CausesValidation="false"
                        Visible="<%# grid.EditIndex == Container.DataItemIndex %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Имя" >
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%#Eval("FirstName") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" Text='<%#Bind("FirstName") %>' Id="txtFN"/><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFN" ErrorMessage="Значение не должно быть пустым" 
                        Font-Bold="true" ForeColor="Red" Display="Dynamic" />
                </EditItemTemplate>
            </asp:TemplateField>
           <asp:TemplateField HeaderText="Фамилия" >
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%#Eval("LastName") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" Text='<%#Bind("LastName") %>' Id="txtLN"/><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLN" ErrorMessage="Значение не должно быть пустым" 
                        Font-Bold="true" ForeColor="Red" Display="Dynamic" />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Отчество" DataField="MiddleName" />
            <asp:TemplateField HeaderText="Отдел" >
                <ItemTemplate>
                    <asp:Label runat="server" Text='<%# Eval("DepartmentName") %>' />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList runat="server" DataSourceID="DepartmentsSourceForChanging" DataValueField="Id" DataTextField="Name"
                         ID="DepartmentId" SelectedValue='<%# Bind("DepartmentId") %>' />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>

    </asp:GridView>
    
</asp:Content>
