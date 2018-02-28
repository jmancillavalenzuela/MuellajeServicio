using System;
using MuellajeServicio.Models;

namespace MuellajeServicio
{
    [System.Web.Script.Services.ScriptService]
    public partial class AccesosMuelleBase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod]
        public static bool buscarPersonaAcceso(string rut, string fechaHoy)
        {
            DateTime fecha = DateTime.Parse(fechaHoy);
            AccesosMuelleDAC acc = new AccesosMuelleDAC();
            if (acc.buscarPersonaAcceso(rut, fecha))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        [System.Web.Services.WebMethod]
        public static void entradaPersonaAcceso(string rut, string horaIngreso, int sinSalida, string motivoSinSalida)
        {
            TimeSpan hora = TimeSpan.Parse(horaIngreso);
            AccesosMuelleDAC acc = new AccesosMuelleDAC();
            acc.entradaPersonaAcceso(rut, hora, sinSalida, motivoSinSalida);
        }

        [System.Web.Services.WebMethod]
        public static bool salidaPersonaAcceso(string rut, string horaSalida, string fecha)
        {
            DateTime fechaSalida = DateTime.Parse(fecha);
            TimeSpan hora = TimeSpan.Parse(horaSalida);
            AccesosMuelleDAC acc = new AccesosMuelleDAC();
            if (acc.salidaPersonaAcceso(rut, hora, fechaSalida))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}