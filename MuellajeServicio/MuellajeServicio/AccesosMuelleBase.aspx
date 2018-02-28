<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccesosMuelleBase.aspx.cs" Inherits="MuellajeServicio.AccesosMuelleBase" %>
<!--JS Files-->
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<script>
    $(function () {
        document.getElementById("btEntrada").style.display = 'none';
        document.getElementById("btSalida").style.display = 'none';
        document.getElementById("isSinSalida").style.display = 'none';
        document.getElementById("SinSalida").style.display = 'none';
       
        $(document).on('change', 'input[type="checkbox"]', function (e) {
            if (this.id == "chkbSinSalida") {
                if (this.checked) {
                    document.getElementById("SinSalida").style.display = 'inline';
                } else {
                    document.getElementById("SinSalida").style.display = 'none';
                }
            }
        })
       
    });
    function buscarPersonaRut(textBoxInput) {
        var rut = textBoxInput.value;
        var f = new Date();
        var mes;
        if (f.getMonth() == 1) {
            mes = f.getMonth() + 1;
            mes = "0" + mes;
        }
        var fecha = f.getDate() + "/" + mes + "/" + f.getFullYear();
        for (var i = 0; i < rut.length; i++){
        rut = rut.replace(".", "");
        rut = rut.replace("-", "");
        }
        textBoxInput.value = rut;
        // Ajax
        $.ajax({
            type: "POST",
            url: "AccesosMuelleBase.aspx/buscarPersonaAcceso",
            data: "{'rut':" + JSON.stringify(rut) + " , 'fechaHoy':" + JSON.stringify(fecha) + "}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (!response.d) {
                    alert("Rut o Pasaporte Invalido; o de lo contrario La persona no tiene un Pase al muelle Asociado!");
                    document.getElementById("btEntrada").style.display = "none";
                    document.getElementById("btSalida").style.display = "none";
                    document.getElementById("isSinSalida").style.display = 'none';
                    document.getElementById("SinSalida").style.display = 'none';
                    document.getElementById("motivoSinSalida").style.display = 'none';
                } else {
                    document.getElementById("btEntrada").style.display = "inline";
                    document.getElementById("btSalida").style.display = "inline";
                    document.getElementById("isSinSalida").style.display = 'inline';
                }

            },
            failure: function () {
                alert('No Realizado.');
            }

        });
        //

    }

    function entradaPersona() {
        var rut = document.getElementById("txtRut").value;
        var momentoActual = new Date();
        var hora = momentoActual.getHours()
        var minuto = momentoActual.getMinutes()
        var segundo = momentoActual.getSeconds()
        var horaIngreso = hora + ":" + minuto + ":" + segundo;
        var sinSalida;
        var motivoSinSalida = document.getElementById("motivoSinSalida").value;
        alert(motivoSinSalida);
        ///////////////////////////////////////////////////////////////
        if (document.getElementById("chkbSinSalida").checked) {
                sinSalida = 1; // No saldra por muelle de servicio
                alert("La persona No saldra por el muelle de Servicio!");
            } else {
                sinSalida = 0; // Si saldra por muelle de servicio o no informa.
            }
        
        // Ajax
        $.ajax({
            type: "POST",
            url: "AccesosMuelleBase.aspx/entradaPersonaAcceso",
            data: "{'rut':" + JSON.stringify(rut) + " , 'horaIngreso':" + JSON.stringify(horaIngreso) + " , 'sinSalida':" + JSON.stringify(sinSalida) + " , 'motivoSinSalida':" + JSON.stringify(motivoSinSalida) + "}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                    alert("Entrada Registrada con Exito.");
                

            },
            failure: function () {
                alert('No Realizado.');
            }

        });
        //

    }

    function salidaPersona() {
        var rut = document.getElementById("txtRut").value;
        var momentoActual = new Date();
        var hora = momentoActual.getHours()
        var minuto = momentoActual.getMinutes()
        var segundo = momentoActual.getSeconds()
        var horaSalida = hora + ":" + minuto + ":" + segundo;

        var f = new Date();
        var mes;
        if (f.getMonth() == 1) {
            mes = f.getMonth() + 1;
            mes = "0" + mes;
        }
        var fecha = f.getDate() + "/" + mes + "/" + f.getFullYear();
        // Ajax
        $.ajax({
            type: "POST",
            url: "AccesosMuelleBase.aspx/salidaPersonaAcceso",
            data: "{'rut':" + JSON.stringify(rut) + " , 'horaSalida':" + JSON.stringify(horaSalida) + " , 'fecha':" + JSON.stringify(fecha) + "}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d) {
                    alert("Salida Registrada con Exito.");
                } else {
                    alert("La Salida No Pudo ser Registrada; Intentelo nuevamente.");
                }
                


            },
            failure: function () {
                alert('No Realizado.');
            }

        });
        //

    }
    
</script>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Accesos Muelle:<br />
        <br />
        Buscar Persona RUT:
        <asp:TextBox ID="txtRut" runat="server" onblur ="buscarPersonaRut(this)"></asp:TextBox>
        <asp:Label ID="lbAcceso" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:Button ID="btEntrada" runat="server" Text="Entrada" OnClientClick ="entradaPersona(); return false"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btSalida" runat="server" Text="Salida" OnClientClick ="salidaPersona(); return false" />
        </div>
        <div id ="isSinSalida">
            <asp:CheckBox ID="chkbSinSalida" runat="server" Text="Declara NO Salida" />
            </div>
            <br />
        <div id ="SinSalida">
            Motivo:&nbsp; <asp:TextBox ID="motivoSinSalida" runat="server" Height="17px" Width="275px"></asp:TextBox>
        </div>
    </form>
</body>
</html>
