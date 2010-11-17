From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH] OMAP: Serial: Define register access modes in LCR
Date: Wed, 17 Nov 2010 14:36:59 +0530
Message-ID: <AANLkTins9SKmugD344NddhpAJ8POGZy2ZS_=dbChm3Ta@mail.gmail.com>
References: <1289982712-7309-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48637 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934139Ab0KQJHZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 04:07:25 -0500
In-Reply-To: <1289982712-7309-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org, linux-serial@vger.kernel.org

On Wed, Nov 17, 2010 at 2:01 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>
> Access to some registers depends on register access mode
> Three different modes are available for OMAP (at least)
> =95 Operational mode =A0 =A0 LCR_REG[7] =3D 0x0
> =95 Configuration mode A LCR_REG[7] =3D 0x1 and LCR_REG[7:0]! =3D 0xB=
=46
> =95 Configuration mode B LCR_REG[7] =3D 0x1 and LCR_REG[7:0] =A0=3D 0=
xBF
>
> Define access modes and remove redefinitions and magic numbers
> in serial drivers (and later in bluetooth driver).
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 12 ++++----
> =A0arch/arm/plat-omap/include/plat/omap-serial.h | =A0 =A09 ------
> =A0drivers/serial/8250.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 26 +++++++++---------
> =A0drivers/serial/omap-serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 34 ++++++++++++------------
> =A0include/linux/serial_reg.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A07 +++++
> =A05 files changed, 43 insertions(+), 45 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seria=
l.c
> index edd7c99de38dde5bf877788fb4e48055c0d9fbfa..14c87157d70758d420359=
3f78f2eaf4c2f2cca68 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -218,7 +218,7 @@ static void omap_uart_save_context(struct omap_ua=
rt_state *uart)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0lcr =3D serial_read_reg(uart, UART_LCR);
> - =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, 0xBF);
> + =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0uart->dll =3D serial_read_reg(uart, UART_DLL);
> =A0 =A0 =A0 =A0uart->dlh =3D serial_read_reg(uart, UART_DLM);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_LCR, lcr);
> @@ -226,7 +226,7 @@ static void omap_uart_save_context(struct omap_ua=
rt_state *uart)
> =A0 =A0 =A0 =A0uart->sysc =3D serial_read_reg(uart, UART_OMAP_SYSC);
> =A0 =A0 =A0 =A0uart->scr =3D serial_read_reg(uart, UART_OMAP_SCR);
> =A0 =A0 =A0 =A0uart->wer =3D serial_read_reg(uart, UART_OMAP_WER);
> - =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, 0x80);
> + =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_A);
> =A0 =A0 =A0 =A0uart->mcr =3D serial_read_reg(uart, UART_MCR);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_LCR, lcr);
>
> @@ -250,19 +250,19 @@ static void omap_uart_restore_context(struct om=
ap_uart_state *uart)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_write_reg(uart, UART_OMAP_MDR1,=
 UART_OMAP_MDR1_DISABLE);
>
> - =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, 0xBF); /* Config B mod=
e */
> + =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0efr =3D serial_read_reg(uart, UART_EFR);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_EFR, UART_EFR_ECB);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_LCR, 0x0); /* Operational =
mode */
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_IER, 0x0);
> - =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, 0xBF); /* Config B mod=
e */
> + =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_DLL, uart->dll);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_DLM, uart->dlh);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_LCR, 0x0); /* Operational =
mode */
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_IER, uart->ier);
> - =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, 0x80);
> + =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_A);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_MCR, uart->mcr);
> - =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, 0xBF); /* Config B mod=
e */
> + =A0 =A0 =A0 serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_EFR, efr);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_LCR, UART_LCR_WLEN8);
> =A0 =A0 =A0 =A0serial_write_reg(uart, UART_OMAP_SCR, uart->scr);
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm=
/plat-omap/include/plat/omap-serial.h
> index 6a17880146111ddfabef564583e464c1c75bb379..b3e0bad9b77eb5138fe01=
253bd99bfc62bd6ac2d 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -33,15 +33,6 @@
>
> =A0#define OMAP_MODE13X_SPEED =A0 =A0 230400
>
> -/*
> - * LCR =3D 0XBF: Switch to Configuration Mode B.
> - * In configuration mode b allow access
> - * to EFR,DLL,DLH.
> - * Reference OMAP TRM Chapter 17
> - * Section: 1.4.3 Mode Selection
> - */
> -#define OMAP_UART_LCR_CONF_MDB 0XBF
> -
> =A0/* WER =3D 0x7F
> =A0* Enable module level wakeup in WER reg
> =A0*/
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 4d8e14b7aa931bcf3de11c6e5805005e0bf413ca..aaf9907e6014f547f28a6=
17504125e6ffd177cbe 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -653,13 +653,13 @@ static void serial8250_set_sleep(struct uart_82=
50_port *p, int sleep)
> =A0{
> =A0 =A0 =A0 =A0if (p->capabilities & UART_CAP_SLEEP) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p->capabilities & UART_CAP_EFR) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(p, UART_LCR=
, 0xBF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(p, UART_LCR=
, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(p, UART_EF=
R, UART_EFR_ECB);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(p, UART_LC=
R, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(p, UART_IER, sleep ? UART_=
IERX_SLEEP : 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (p->capabilities & UART_CAP_EFR) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(p, UART_LCR=
, 0xBF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(p, UART_LCR=
, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(p, UART_EF=
R, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(p, UART_LC=
R, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -752,7 +752,7 @@ static int size_fifo(struct uart_8250_port *up)
> =A0 =A0 =A0 =A0serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0UART_FCR_CLEAR_RCVR | UART_FCR=
_CLEAR_XMIT);
> =A0 =A0 =A0 =A0serial_outp(up, UART_MCR, UART_MCR_LOOP);
> - =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_DLAB);
> + =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_A);
> =A0 =A0 =A0 =A0old_dl =3D serial_dl_read(up);
> =A0 =A0 =A0 =A0serial_dl_write(up, 0x0001);
> =A0 =A0 =A0 =A0serial_outp(up, UART_LCR, 0x03);
> @@ -764,7 +764,7 @@ static int size_fifo(struct uart_8250_port *up)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_inp(up, UART_RX);
> =A0 =A0 =A0 =A0serial_outp(up, UART_FCR, old_fcr);
> =A0 =A0 =A0 =A0serial_outp(up, UART_MCR, old_mcr);
> - =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_DLAB);
> + =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_A);
> =A0 =A0 =A0 =A0serial_dl_write(up, old_dl);
> =A0 =A0 =A0 =A0serial_outp(up, UART_LCR, old_lcr);
>
> @@ -782,7 +782,7 @@ static unsigned int autoconfig_read_divisor_id(st=
ruct uart_8250_port *p)
> =A0 =A0 =A0 =A0unsigned int id;
>
> =A0 =A0 =A0 =A0old_lcr =3D serial_inp(p, UART_LCR);
> - =A0 =A0 =A0 serial_outp(p, UART_LCR, UART_LCR_DLAB);
> + =A0 =A0 =A0 serial_outp(p, UART_LCR, UART_LCR_CONF_MODE_A);
>
> =A0 =A0 =A0 =A0old_dll =3D serial_inp(p, UART_DLL);
> =A0 =A0 =A0 =A0old_dlm =3D serial_inp(p, UART_DLM);
> @@ -836,7 +836,7 @@ static void autoconfig_has_efr(struct uart_8250_p=
ort *up)
> =A0 =A0 =A0 =A0 * recommended for new designs).
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0up->acr =3D 0;
> - =A0 =A0 =A0 serial_out(up, UART_LCR, 0xBF);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, UART_EFR_ECB);
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, 0x00);
> =A0 =A0 =A0 =A0id1 =3D serial_icr_read(up, UART_ID1);
> @@ -945,7 +945,7 @@ static void autoconfig_16550a(struct uart_8250_po=
rt *up)
> =A0 =A0 =A0 =A0 * Check for presence of the EFR when DLAB is set.
> =A0 =A0 =A0 =A0 * Only ST16C650V1 UARTs pass this test.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_DLAB);
> + =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_A);
> =A0 =A0 =A0 =A0if (serial_in(up, UART_EFR) =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(up, UART_EFR, 0xA8);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (serial_in(up, UART_EFR) !=3D 0) {
> @@ -963,7 +963,7 @@ static void autoconfig_16550a(struct uart_8250_po=
rt *up)
> =A0 =A0 =A0 =A0 * Maybe it requires 0xbf to be written to the LCR.
> =A0 =A0 =A0 =A0 * (other ST16C650V2 UARTs, TI16C752A, etc)
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 serial_outp(up, UART_LCR, 0xBF);
> + =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0if (serial_in(up, UART_EFR) =3D=3D 0 && !broken_efr(up=
)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DEBUG_AUTOCONF("EFRv2 ");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0autoconfig_has_efr(up);
> @@ -1024,7 +1024,7 @@ static void autoconfig_16550a(struct uart_8250_=
port *up)
> =A0 =A0 =A0 =A0serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_=
=46CR7_64BYTE);
> =A0 =A0 =A0 =A0status1 =3D serial_in(up, UART_IIR) >> 5;
> =A0 =A0 =A0 =A0serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
> - =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_DLAB);
> + =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_A);
> =A0 =A0 =A0 =A0serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_=
=46CR7_64BYTE);
> =A0 =A0 =A0 =A0status2 =3D serial_in(up, UART_IIR) >> 5;
> =A0 =A0 =A0 =A0serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
> @@ -1183,7 +1183,7 @@ static void autoconfig(struct uart_8250_port *u=
p, unsigned int probeflags)
> =A0 =A0 =A0 =A0 * We also initialise the EFR (if any) to zero for lat=
er. =A0The
> =A0 =A0 =A0 =A0 * EFR occupies the same register location as the FCR =
and IIR.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 serial_outp(up, UART_LCR, 0xBF);
> + =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0serial_outp(up, UART_EFR, 0);
> =A0 =A0 =A0 =A0serial_outp(up, UART_LCR, 0);
>
> @@ -1952,7 +1952,7 @@ static int serial8250_startup(struct uart_port =
*port)
> =A0 =A0 =A0 =A0if (up->port.type =3D=3D PORT_16C950) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Wake up and initialize UART */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->acr =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_LCR, 0xBF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_CONF=
_MODE_B);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(up, UART_EFR, UART_EFR_ECB=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(up, UART_IER, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(up, UART_LCR, 0);
> @@ -2002,7 +2002,7 @@ static int serial8250_startup(struct uart_port =
*port)
> =A0 =A0 =A0 =A0if (up->port.type =3D=3D PORT_16850) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned char fctr;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_LCR, 0xbf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_CONF=
_MODE_B);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fctr =3D serial_inp(up, UART_FCTR) & ~=
(UART_FCTR_RX|UART_FCTR_TX);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(up, UART_FCTR, fctr | UART=
_FCTR_TRGD | UART_FCTR_RX);
> @@ -2363,7 +2363,7 @@ serial8250_do_set_termios(struct uart_port *por=
t, struct ktermios *termios,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (termios->c_cflag & CRTSCTS)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0efr |=3D UART_EFR_CTS;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_LCR, 0xBF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_outp(up, UART_LCR, UART_LCR_CONF=
_MODE_B);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_outp(up, UART_EFR, efr);
> =A0 =A0 =A0 =A0}
>
> diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-seria=
l.c
> index 03a96db67de4a5b3120e094b25e10e2364b8be86..1201eff1831e976910cef=
ebed09882c26e2fcf01 100644
> --- a/drivers/serial/omap-serial.c
> +++ b/drivers/serial/omap-serial.c
> @@ -570,7 +570,7 @@ serial_omap_configure_xonxoff
> =A0 =A0 =A0 =A0unsigned char efr =3D 0;
>
> =A0 =A0 =A0 =A0up->lcr =3D serial_in(up, UART_LCR);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, OMAP_UART_LCR_CONF_MDB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0up->efr =3D serial_in(up, UART_EFR);
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, up->efr & ~UART_EFR_ECB);
>
> @@ -598,7 +598,7 @@ serial_omap_configure_xonxoff
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0efr |=3D OMAP_UART_SW_RX;
>
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_DLAB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
>
> =A0 =A0 =A0 =A0up->mcr =3D serial_in(up, UART_MCR);
>
> @@ -612,14 +612,14 @@ serial_omap_configure_xonxoff
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->mcr |=3D UART_MCR_XONANY;
>
> =A0 =A0 =A0 =A0serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, OMAP_UART_LCR_CONF_MDB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
> =A0 =A0 =A0 =A0/* Enable special char function UARTi.EFR_REG[5] and
> =A0 =A0 =A0 =A0 * load the new software flow control mode IXON or IXO=
=46F
> =A0 =A0 =A0 =A0 * and restore the UARTi.EFR_REG[4] ENHANCED_EN value.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, efr | UART_EFR_SCD);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_DLAB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
>
> =A0 =A0 =A0 =A0serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, up->lcr);
> @@ -724,22 +724,22 @@ serial_omap_set_termios(struct uart_port *port,=
 struct ktermios *termios,
> =A0 =A0 =A0 =A0 * baud clock is not running
> =A0 =A0 =A0 =A0 * DLL_REG and DLH_REG set to 0.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_DLAB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
> =A0 =A0 =A0 =A0serial_out(up, UART_DLL, 0);
> =A0 =A0 =A0 =A0serial_out(up, UART_DLM, 0);
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, 0);
>
> - =A0 =A0 =A0 serial_out(up, UART_LCR, OMAP_UART_LCR_CONF_MDB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>
> =A0 =A0 =A0 =A0up->efr =3D serial_in(up, UART_EFR);
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
>
> - =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_DLAB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
> =A0 =A0 =A0 =A0up->mcr =3D serial_in(up, UART_MCR);
> =A0 =A0 =A0 =A0serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
> =A0 =A0 =A0 =A0/* FIFO ENABLE, DMA MODE */
> =A0 =A0 =A0 =A0serial_out(up, UART_FCR, up->fcr);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, OMAP_UART_LCR_CONF_MDB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>
> =A0 =A0 =A0 =A0if (up->use_dma) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_TI752_TLR, 0);
> @@ -748,27 +748,27 @@ serial_omap_set_termios(struct uart_port *port,=
 struct ktermios *termios,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, up->efr);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_DLAB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
> =A0 =A0 =A0 =A0serial_out(up, UART_MCR, up->mcr);
>
> =A0 =A0 =A0 =A0/* Protocol, Baud Rate, and Interrupt Settings */
>
> =A0 =A0 =A0 =A0serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE)=
;
> - =A0 =A0 =A0 serial_out(up, UART_LCR, OMAP_UART_LCR_CONF_MDB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>
> =A0 =A0 =A0 =A0up->efr =3D serial_in(up, UART_EFR);
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
>
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, 0);
> =A0 =A0 =A0 =A0serial_out(up, UART_IER, 0);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, OMAP_UART_LCR_CONF_MDB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>
> =A0 =A0 =A0 =A0serial_out(up, UART_DLL, quot & 0xff); =A0 =A0 =A0 =A0=
 =A0/* LS of divisor */
> =A0 =A0 =A0 =A0serial_out(up, UART_DLM, quot >> 8); =A0 =A0 =A0 =A0 =A0=
 =A0/* MS of divisor */
>
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, 0);
> =A0 =A0 =A0 =A0serial_out(up, UART_IER, up->ier);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, OMAP_UART_LCR_CONF_MDB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, up->efr);
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, cval);
> @@ -782,18 +782,18 @@ serial_omap_set_termios(struct uart_port *port,=
 struct ktermios *termios,
>
> =A0 =A0 =A0 =A0if (termios->c_cflag & CRTSCTS) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0efr |=3D (UART_EFR_CTS | UART_EFR_RTS)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_DLAB)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_=
MODE_A);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->mcr =3D serial_in(up, UART_MCR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_MCR, up->mcr | UAR=
T_MCR_TCRTLR);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_LCR, OMAP_UART_LCR_=
CONF_MDB);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_=
MODE_B);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->efr =3D serial_in(up, UART_EFR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_EFR, up->efr | UAR=
T_EFR_ECB);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_TI752_TCR, OMAP_UA=
RT_TCR_TRIG);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_EFR, efr); /* Enab=
le AUTORTS and AUTOCTS */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_DLAB)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_=
MODE_A);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_MCR, up->mcr | UAR=
T_MCR_RTS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial_out(up, UART_LCR, cval);
> =A0 =A0 =A0 =A0}
> @@ -815,13 +815,13 @@ serial_omap_pm(struct uart_port *port, unsigned=
 int state,
> =A0 =A0 =A0 =A0unsigned char efr;
>
> =A0 =A0 =A0 =A0dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->pdev-=
>id);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, OMAP_UART_LCR_CONF_MDB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0efr =3D serial_in(up, UART_EFR);
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, efr | UART_EFR_ECB);
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, 0);
>
> =A0 =A0 =A0 =A0serial_out(up, UART_IER, (state !=3D 0) ? UART_IERX_SL=
EEP : 0);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, OMAP_UART_LCR_CONF_MDB);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, efr);
> =A0 =A0 =A0 =A0serial_out(up, UART_LCR, 0);
> =A0 =A0 =A0 =A0/* Enable module level wake up */
> diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
> index 6f3823474e6c070bd8456d4dd70559f4e18f2500..3ecb71a9e505901c1a0ff=
3a3780ba29d3c4c3741 100644
> --- a/include/linux/serial_reg.h
> +++ b/include/linux/serial_reg.h
> @@ -99,6 +99,13 @@
> =A0#define UART_LCR_WLEN7 =A0 =A0 =A0 =A0 0x02 /* Wordlength: 7 bits =
*/
> =A0#define UART_LCR_WLEN8 =A0 =A0 =A0 =A0 0x03 /* Wordlength: 8 bits =
*/
>
> +/*
> + * Access to some registers depends on register access / configurati=
on
> + * mode.
> + */
> +#define UART_LCR_CONF_MODE_A =A0 UART_LCR_DLAB =A0 /* Configutation =
mode A */
> +#define UART_LCR_CONF_MODE_B =A0 0xBF =A0 =A0 =A0 =A0 =A0 =A0/* Conf=
igutation mode B */

Looks fine to me.

Acked-by: Govindraj.R <govindraj.raja@ti.com>

--
Regards,
Govindraj.R

> +
> =A0#define UART_MCR =A0 =A0 =A0 4 =A0 =A0 =A0 /* Out: Modem Control R=
egister */
> =A0#define UART_MCR_CLKSEL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x80 /* Div=
ide clock by 4 (TI16C752, EFR[4]=3D1) */
> =A0#define UART_MCR_TCRTLR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x40 /* Acc=
ess TCR/TLR (TI16C752, EFR[4]=3D1) */
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
