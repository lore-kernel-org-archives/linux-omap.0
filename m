From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] omap: serial: Add RS-485 standard support
Date: Thu, 3 Nov 2011 20:06:58 +0100
Message-ID: <CAAwP0s3upt6W5Z6f=N_6ZdZnK9YtdD6SdUUvEhZgB=P8=z7Yuw@mail.gmail.com>
References: <1319843084-16948-1-git-send-email-martinez.javier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55642 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab1KCTYg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 15:24:36 -0400
In-Reply-To: <1319843084-16948-1-git-send-email-martinez.javier@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Cox <alan@linux.intel.com>, Govindraj Raja <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Javier Martinez Canillas <martinez.javier@gmail.com>

On Sat, Oct 29, 2011 at 1:04 AM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> This patch adds TIA/EIA-485 standard support to OMAP-UART controller =
driver
> by adding handlers for TIOCSRS485 and TIOCGRS485 ioctl commands.
>
> This patch is based on Ilya Yanok <yanok@emcraft.com> patch [1] but i=
t changes
> the function serial_omap_update_rts() that raises and lows the Ready-=
to-Send
> control signal. Also, it forces to update the RTS signal when the ser=
ial-core
> calls serial_omap_set_mctrl().
>
> [1]: http://www.spinics.net/lists/linux-omap/msg58546.html
>
> Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
> ---
> =C2=A0arch/arm/plat-omap/include/plat/omap-serial.h | =C2=A0 =C2=A02 =
+
> =C2=A0drivers/tty/serial/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0drivers/tty/serial/omap-serial.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0139 ++++++++++++++++++++++--
> =C2=A0include/linux/serial_reg.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +
> =C2=A04 files changed, 132 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm=
/plat-omap/include/plat/omap-serial.h
> index 2682043..b7c2c29 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -111,6 +111,8 @@ struct uart_omap_port {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 msr_saved_flags;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 port_activity;
> + =C2=A0 =C2=A0 =C2=A0 struct serial_rs485 =C2=A0 =C2=A0 rs485;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tx_in_progress:1, tx_wait_end:1;
> =C2=A0};
>
> =C2=A0#endif /* __OMAP_SERIAL_H__ */
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefil=
e
> index 83b4da6..865f238 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -71,7 +71,7 @@ obj-$(CONFIG_SERIAL_VR41XX) +=3D vr41xx_siu.o
> =C2=A0obj-$(CONFIG_SERIAL_SGI_IOC4) +=3D ioc4_serial.o
> =C2=A0obj-$(CONFIG_SERIAL_SGI_IOC3) +=3D ioc3_serial.o
> =C2=A0obj-$(CONFIG_SERIAL_ATMEL) +=3D atmel_serial.o
> -obj-$(CONFIG_SERIAL_UARTLITE) +=3D uartlite.o
> +#obj-$(CONFIG_SERIAL_UARTLITE) +=3D uartlite.o
> =C2=A0obj-$(CONFIG_SERIAL_MSM) +=3D msm_serial.o
> =C2=A0obj-$(CONFIG_SERIAL_MSM_HS) +=3D msm_serial_hs.o
> =C2=A0obj-$(CONFIG_SERIAL_NETX) +=3D netx-serial.o
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index 5e713d3..d1789f4 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -37,6 +37,7 @@
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/serial_core.h>
> =C2=A0#include <linux/irq.h>
> +#include <linux/uaccess.h>
>
> =C2=A0#include <plat/dma.h>
> =C2=A0#include <plat/dmtimer.h>
> @@ -114,6 +115,56 @@ static void serial_omap_enable_ms(struct uart_po=
rt *port)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0serial_out(up, UART_IER, up->ier);
> =C2=A0}
>
> +static inline void serial_omap_enable_ier_thri(struct uart_omap_port=
 *up)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!(up->ier & UART_IER_THRI)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->ier |=3D UART_=
IER_THRI;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_out(up, UAR=
T_IER, up->ier);
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static inline void serial_omap_disable_ier_thri(struct uart_omap_por=
t *up)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (up->ier & UART_IER_THRI) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->ier &=3D ~UART=
_IER_THRI;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_out(up, UAR=
T_IER, up->ier);
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static inline void serial_omap_thri_mode(struct uart_omap_port *up)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned char scr =3D serial_in(up, UART_OMAP_=
SCR);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (up->tx_wait_end)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scr |=3D UART_OMAP=
_SCR_TX_EMPTY_CTL_IT;
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scr &=3D ~UART_OMA=
P_SCR_TX_EMPTY_CTL_IT;
> + =C2=A0 =C2=A0 =C2=A0 serial_out(up, UART_OMAP_SCR, scr);
> +}
> +
> +
> +static inline void serial_omap_update_rts(struct uart_omap_port *up)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned char mcr =3D up->mcr;
> + =C2=A0 =C2=A0 =C2=A0 int rts_on_send =3D up->rs485.flags & SER_RS48=
5_RTS_ON_SEND;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (up->rs485.flags & SER_RS485_ENABLED) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (up->tx_in_prog=
ress) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (rts_on_send)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mcr |=3D UART_MCR_RTS;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mcr &=3D ~UART_MCR_RTS;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (rts_on_send)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mcr &=3D ~UART_MCR_RTS;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mcr |=3D ~UART_MCR_RTS;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 serial_out(up, UART_MCR, mcr);
> +}
> +
> =C2=A0static void serial_omap_stop_tx(struct uart_port *port)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct uart_omap_port *up =3D (struct uart=
_omap_port *)port;
> @@ -131,9 +182,14 @@ static void serial_omap_stop_tx(struct uart_port=
 *port)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0up->uart_dma.t=
x_dma_channel =3D OMAP_UART_DMA_CH_FREE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 if (up->ier & UART_IER_THRI) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->ier &=3D ~UART=
_IER_THRI;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_out(up, UAR=
T_IER, up->ier);
> + =C2=A0 =C2=A0 =C2=A0 if (!(up->rs485.flags & SER_RS485_ENABLED))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_omap_disabl=
e_ier_thri(up);
> + =C2=A0 =C2=A0 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->tx_in_progress=
 =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_omap_update=
_rts(up);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->tx_wait_end =3D=
 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_omap_thri_m=
ode(up);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_omap_enable=
_ier_thri(up);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> @@ -246,14 +302,6 @@ static void transmit_chars(struct uart_omap_port=
 *up)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial_omap_st=
op_tx(&up->port);
> =C2=A0}
>
> -static inline void serial_omap_enable_ier_thri(struct uart_omap_port=
 *up)
> -{
> - =C2=A0 =C2=A0 =C2=A0 if (!(up->ier & UART_IER_THRI)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->ier |=3D UART_=
IER_THRI;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_out(up, UAR=
T_IER, up->ier);
> - =C2=A0 =C2=A0 =C2=A0 }
> -}
> -
> =C2=A0static void serial_omap_start_tx(struct uart_port *port)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct uart_omap_port *up =3D (struct uart=
_omap_port *)port;
> @@ -261,6 +309,18 @@ static void serial_omap_start_tx(struct uart_por=
t *port)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int start;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;
>
> + =C2=A0 =C2=A0 =C2=A0 if (up->rs485.flags & SER_RS485_ENABLED) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!up->tx_in_pro=
gress) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 up->tx_in_progress =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 serial_omap_update_rts(up);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (up->tx_wait_en=
d) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 up->tx_wait_end =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 serial_omap_thri_mode(up);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 serial_omap_disable_ier_thri(up);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!up->use_dma) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial_omap_en=
able_ier_thri(up);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> @@ -343,6 +403,11 @@ static unsigned int check_modem_status(struct ua=
rt_omap_port *up)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0}
>
> +static inline unsigned int __serial_omap_tx_empty(struct uart_omap_p=
ort *up)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return serial_in(up, UART_LSR) & UART_LSR_TEMT=
 ? TIOCSER_TEMT : 0;
> +}
> +
> =C2=A0/**
> =C2=A0* serial_omap_irq() - This handles the interrupt from one port
> =C2=A0* @irq: uart port irq number
> @@ -359,6 +424,16 @@ static inline irqreturn_t serial_omap_irq(int ir=
q, void *dev_id)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NON=
E;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&up->port.lock, flags);
> + =C2=A0 =C2=A0 =C2=A0 if (up->tx_wait_end && (iir & UART_IIR_THRI) &=
&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __serial_omap_tx_empty(up)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->tx_wait_end =3D=
 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->tx_in_progress=
 =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_omap_thri_m=
ode(up);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_omap_update=
_rts(up);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_omap_disabl=
e_ier_thri(up);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqres=
tore(&up->port.lock, flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED=
;
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0lsr =3D serial_in(up, UART_LSR);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iir & UART_IIR_RLSI) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!up->use_d=
ma) {
> @@ -390,7 +465,7 @@ static unsigned int serial_omap_tx_empty(struct u=
art_port *port)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(up->port.dev, "serial_omap_tx_empt=
y+%d\n", up->pdev->id);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&up->port.lock, flags);
> - =C2=A0 =C2=A0 =C2=A0 ret =3D serial_in(up, UART_LSR) & UART_LSR_TEM=
T ? TIOCSER_TEMT : 0;
> + =C2=A0 =C2=A0 =C2=A0 ret =3D __serial_omap_tx_empty(up);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&up->port.lock, fla=
gs);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> @@ -434,6 +509,10 @@ static void serial_omap_set_mctrl(struct uart_po=
rt *port, unsigned int mctrl)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mcr |=3D UART_=
MCR_LOOP;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mcr |=3D up->mcr;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (up->rs485.flags & SER_RS485_ENABLED)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_omap_update=
_rts(up);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0serial_out(up, UART_MCR, mcr);
> =C2=A0}
>
> @@ -1028,6 +1107,41 @@ static inline void serial_omap_add_console_por=
t(struct uart_omap_port *up)
>
> =C2=A0#endif
>
> +static int
> +serial_omap_ioctl(struct uart_port *port, unsigned int cmd, unsigned=
 long arg)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct serial_rs485 rs485conf;
> + =C2=A0 =C2=A0 =C2=A0 struct uart_omap_port *up =3D (struct uart_oma=
p_port *)port;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (cmd) {
> + =C2=A0 =C2=A0 =C2=A0 case TIOCSRS485:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (copy_from_user=
(&rs485conf, (struct serial_rs485 *) arg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(rs485conf)))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -EFAULT;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(=
&up->port.lock, flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(rs485conf.fl=
ags & SER_RS485_ENABLED)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 up->tx_in_progress =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 up->tx_wait_end =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up->rs485 =3D rs48=
5conf;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_omap_update=
_rts(up);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_omap_thri_m=
ode(up);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqres=
tore(&up->port.lock, flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 case TIOCGRS485:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (copy_to_user((=
struct serial_rs485 *) arg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&(up->rs485), sizeof(rs485con=
f)))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -EFAULT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOIOCTLCM=
D;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> =C2=A0static struct uart_ops serial_omap_pops =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.tx_empty =C2=A0 =C2=A0 =C2=A0 =3D serial_=
omap_tx_empty,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_mctrl =C2=A0 =C2=A0 =C2=A0=3D serial_=
omap_set_mctrl,
> @@ -1041,6 +1155,7 @@ static struct uart_ops serial_omap_pops =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.shutdown =C2=A0 =C2=A0 =C2=A0 =3D serial_=
omap_shutdown,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_termios =C2=A0 =C2=A0=3D serial_omap_=
set_termios,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.pm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D serial_omap_pm,
> + =C2=A0 =C2=A0 =C2=A0 .ioctl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D s=
erial_omap_ioctl,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 serial_omap_type,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.release_port =C2=A0 =3D serial_omap_relea=
se_port,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.request_port =C2=A0 =3D serial_omap_reque=
st_port,
> diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
> index c75bda3..dc6a3f7 100644
> --- a/include/linux/serial_reg.h
> +++ b/include/linux/serial_reg.h
> @@ -362,5 +362,7 @@
> =C2=A0#define UART_OMAP_MDR1_CIR_MODE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x06 =C2=A0 =C2=A0/* CIR mode */
> =C2=A0#define UART_OMAP_MDR1_DISABLE =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x07=
 =C2=A0 =C2=A0/* Disable (default state) */
>
> +#define UART_OMAP_SCR_TX_EMPTY_CTL_IT =C2=A0 0x04 =C2=A0 =C2=A0/* TX=
 Empty IRQ mode */
> +
> =C2=A0#endif /* _LINUX_SERIAL_REG_H */
>
> --
> 1.7.4.1
>
>

Hello,

Any comments for this patch?

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
