<%@ page title="SINAD" language="C#" masterpagefile="~/SINADMaster.master" autoeventwireup="true" inherits="ACE_ActInventario, App_Web_q1nlxbda" stylesheettheme="SINAD_Basic" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript">
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginReq);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endReq);

        function beginReq(sender, args) {
        // shows the Popup 
        $find(ModalProgress).show();
        }

        function endReq(sender, args) {
        //  shows the Popup 
        $find(ModalProgress).hide();
        }

        var ModalProgress = '<%= mpeUpdateProgress.ClientID %>';     
     
        
      function capturaTecla(e) {
        if (document.all)
            tecla = event.keyCode;
        else {
            tecla = e.which;
        }
        if (tecla == 13) {
            document.getElementById('<%=ibtnBuscar.ClientID %>').click();
            return false;
        }
    }
    
     document.onkeydown = capturaTecla;
        
</script>
    <div>
        <asp:Panel ID="pnlUpdateProgress" Style="display: none" runat="server" CssClass="UpdateProgress">
            <asp:UpdateProgress ID="upsGeneral" DisplayAfter="0" runat="server">
                <ProgressTemplate>
                    <div style="position: relative; top: 30%; text-align: center;">
                        <asp:Image ID="imgLoading" runat="server" SkinID="skinIconCarga" Style="vertical-align: middle"
                            AlternateText="Processing" />
                        Procesando Información...
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </asp:Panel>
        <asp:ModalPopupExtender ID="mpeUpdateProgress" runat="server" TargetControlID="pnlUpdateProgress"
            BackgroundCssClass="ModalPopupExtenderBackground" PopupControlID="pnlUpdateProgress">
        </asp:ModalPopupExtender>    
        <div>
            <fieldset class="Div_Toolbar">
                <asp:UpdatePanel ID="upnlToolbar" runat="server">
                    <ContentTemplate>
                        <asp:ImageButton ID="ibtnNuevo" runat="server" SkinID="skinbtnNuevo" OnClick="ibtnNuevo_Click"
                            Visible="False" />
                        <asp:Image ID="imgSeparador" Visible="false" runat="server" SkinID="skinSeparador" />
                        <asp:ImageButton ID="ibtnBuscar" runat="server" SkinID="skinbtnBuscar" OnClick="ibtnBuscar_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Button ID="btnRefresh" runat="server" CssClass="Button_Oculto" OnClick="btnRefresh_Click" />
            </fieldset>
            <fieldset class="FieldSet_ContenidoFiltro">
                <div class="Div_Filtro">
                    <div class="Div_TituloFiltro">
                        Filtros de Búsqueda</div>
                    <div class="Div_Espacio">
                    </div>
                    <div class="Div_Etiqueta">
                        Fecha Extrema:
                    </div>
                    <div class="Div_ControlRegular">
                        <asp:DropDownList runat="server" ID="ddlFechaExtrema" CssClass="FuenteControles"
                            Width="80%" AutoPostBack="True" 
                            onselectedindexchanged="ddlFechaExtrema_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="Div_Etiqueta">
                        Nº Orden:</div>
                    <div class="Div_ControlRegular">
                        <asp:TextBox ID="txtNroOrden" runat="server" CssClass="TextBox_Style" Width="35%"  AutoCompleteType="Disabled" ></asp:TextBox>
                        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers"
                            TargetControlID="txtNroOrden">
                        </asp:FilteredTextBoxExtender>
                    </div>
                    <div class="Div_Espacio">
                    </div>
                    <asp:UpdatePanel ID="upnlUnidaOrganica" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="Div_Etiqueta">
                                Unidad Orgánica:</div>
                            <div class="Div_ControlMaximo">
                                <asp:TextBox ID="txtUnidadOrganica" runat="server" CssClass="FuenteControles" Width="80%"
                                    Visible="True" AutoCompleteType="None" AutoPostBack="true" MaxLength="200"></asp:TextBox>
                                <asp:AutoCompleteExtender ID="txtUnidadOrganica_AutoCompleteExtender" runat="server"
                                    DelimiterCharacters="" Enabled="True" ServicePath="SINADConsultas.asmx" ServiceMethod="GetCompletionListOficina"
                                    MinimumPrefixLength="4" CompletionSetCount="20" CompletionInterval="500" TargetControlID="txtUnidadOrganica">
                                </asp:AutoCompleteExtender>
                                <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="txtUnidadOrganica"
                                    FilterType="Custom, UppercaseLetters, LowercaseLetters,Numbers" ValidChars=" ,-,áéíóúÁÉÍÓÚñÑ">
                                </asp:FilteredTextBoxExtender>
                                <asp:HiddenField ID="hdfOficinaId" runat="server" OnValueChanged="hdfOficinaId_ValueChanged" />
                            </div>
                            <div class="Div_Espacio">
                            </div>
                            <div class="Div_Etiqueta">
                                Serie Documental:</div>
                            <div class="Div_ControlMaximo">
                                <asp:DropDownList ID="ddlSerieDocumental" runat="server" CssClass="FuenteControles"
                                    Width="250px" Enabled="False">
                                    <asp:ListItem Value="0">:::Seleccione:::</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="Div_Espacio">
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlFechaExtrema" 
                                EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <div class="Div_Etiqueta">
                        Tipo Transferencia:</div>
                    <div class="Div_ControlMaximo">
                        <asp:RadioButtonList ID="rblTipoTransferencia" CssClass="FuenteControles" runat="server"
                            Width="400px">
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div class="Div_Espacio">
                </div>
            </fieldset>
        </div>
        <div id="ListViewContainer" class="ListView_Container">
            <asp:UpdatePanel ID="upnlLista" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:ListView ID="lvDatos" runat="server" OnItemCommand="lvDatos_ItemCommand" DataKeyNames="NumeroTransferencia,DetalleTransferenciaId">
                        <LayoutTemplate>
                            <table class="ListView_Style">
                                <thead>
                                    <tr>
                                        <th>
                                        </th>
                                        <th>
                                            Unidad Orgánica
                                        </th>
                                        <th>
                                            Fec. Transf.
                                        </th>
                                        <th>
                                            Serie Documental
                                        </th>
                                        <th>
                                            L
                                        </th>
                                        <th>
                                            A
                                        </th>
                                        <th>
                                            F
                                        </th>
                                        <th>
                                            E
                                        </th>
                                        <th>
                                            CU
                                        </th>
                                        <th>
                                            B
                                        </th>
                                        <th>
                                            CA
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr id="ItemPlaceHolder" runat="server">
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th colspan="3" style="text-align: left; padding-left: 2px;">
                                            <asp:Label ID="lblResultado" runat="server" CssClass="FuenteControles"></asp:Label>
                                        </th>
                                        <th colspan="2" style="text-align: right; padding-right: 2px;">
                                            Nro. Página:
                                            <asp:DropDownList ID="ddlPaginas" runat="server" CssClass="FuenteControles" Width="50px"
                                                OnSelectedIndexChanged="ddlPaginas_SelectedIndexChanged" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </th>
                                        <th colspan="3" style="text-align: left; padding-right: 2px; padding-top: 2px;">
                                            <asp:ImageButton ID="ibtnInicio" runat="server" CommandArgument="First" SkinID="skinbtnPrimero"
                                                OnClick="ibtnPaginacion_Click" />
                                            <asp:ImageButton ID="ibtnAtras" runat="server" CommandArgument="Prev" SkinID="skinbtnAnterior"
                                                OnClick="ibtnPaginacion_Click" />
                                            <asp:ImageButton ID="btnAdelante" runat="server" CommandArgument="Next" SkinID="skinbtnSiguiente"
                                                OnClick="ibtnPaginacion_Click" />
                                            <asp:ImageButton ID="btnFinal" runat="server" CommandArgument="Last" SkinID="skinbtnUltimo"
                                                OnClick="ibtnPaginacion_Click" />
                                        </th>
                                    </tr>
                                </tfoot>
                            </table>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="ListView_Style_item">
                                <td>
                                    <asp:ImageButton ID="ibtnModificar" runat="server" CommandName="Editar" SkinID="skinIconModificar"
                                        ToolTip="Modificar" />
                                </td>
                                <td>
                                    <asp:Label ID="lblNumExped" runat="server"><%#Eval("UnidadOrganicaDes")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblTiempAtenc" Width="40px" runat="server"><%#String.Format("{0:dd/MM/yyyy}", Eval("FechaRemision"))%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAsunto" runat="server"><%#Eval("NombreSerieDocumental")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server"><%#Eval("LocalDes")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server"><%#Eval("Almacen")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label3" runat="server"><%#Eval("Filar")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label4" runat="server"><%#Eval("Estante")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label5" runat="server"><%#Eval("Cuerpo")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label6" runat="server"><%#Eval("Balda")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label7" runat="server"><%#Eval("Caja")%></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                            <tr class="ListView_Style_odd">
                                                                <td>
                                    <asp:ImageButton ID="ibtnModificar" runat="server" CommandName="Editar" SkinID="skinIconModificar"
                                        ToolTip="Modificar" />
                                </td>
                                <td>
                                    <asp:Label ID="lblNumExped" runat="server"><%#Eval("UnidadOrganicaDes")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblTiempAtenc" Width="40px" runat="server"><%#String.Format("{0:dd/MM/yyyy}", Eval("FechaRemision"))%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAsunto" runat="server"><%#Eval("NombreSerieDocumental")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server"><%#Eval("LocalDes")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server"><%#Eval("Almacen")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label3" runat="server"><%#Eval("Filar")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label4" runat="server"><%#Eval("Estante")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label5" runat="server"><%#Eval("Cuerpo")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label6" runat="server"><%#Eval("Balda")%></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label7" runat="server"><%#Eval("Caja")%></asp:Label>
                                </td>
                            </tr>
                        </AlternatingItemTemplate>
                    </asp:ListView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ibtnBuscar" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnRefresh" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <br />
    </div>
</asp:Content>
