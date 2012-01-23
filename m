From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 1/2] tty: serial: OMAP: ensure FIFO levels are set
 correctly in non-DMA mode
Date: Mon, 23 Jan 2012 15:51:54 +0530
Message-ID: <CAAL8m4xHzdESmWy8eKwX5-Zb1z8FSRzBxF67bkf=N3JjCL9rBg@mail.gmail.com>
References: <20120121071934.18707.64258.stgit@dusk> <20120121072737.18707.77811.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120121072737.18707.77811.stgit@dusk>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Govindraj Raja <govindraj.r@ti.com>, Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, alan@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Sat, Jan 21, 2012 at 12:57 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Ensure FIFO levels are set correctly in non-DMA mode (the default).
> This patch will cause a receive FIFO threshold interrupt to be raised=
 when
> there is at least one byte in the RX FIFO. =A0It will also cause a tr=
ansmit
> FIFO threshold interrupt when there is only one byte remaining in the=
 TX
> FIFO.
>
> These changes fix the receive interrupt problem and part of the
> transmit interrupt problem. =A0A separate set of issues must be worke=
d
> around for the transmit path to have a basic level of functionality; =
a
> subsequent patch will address these.
>
> DMA operation is unaffected by this patch.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Govindraj Raja <govindraj.r@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
> =A0drivers/tty/serial/omap-serial.c | =A0 35 ++++++++++++++++++++++++=
+++++++----
> =A01 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index d192dcb..9de7d71 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -46,6 +46,18 @@
>
> =A0#define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
>
> +/* SCR register bitmasks */
> +#define OMAP_UART_SCR_RX_TRIG_GRANU1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 7)
> +#define OMAP_UART_SCR_TX_TRIG_GRANU1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 6)
> +
> +/* FCR register bitmasks */
> +#define OMAP_UART_FCR_RX_FIFO_TRIG_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 6
> +#define OMAP_UART_FCR_RX_FIFO_TRIG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 6)
> +#define OMAP_UART_FCR_TX_FIFO_TRIG_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 4
> +
> +/* TLR register bitmasks */
> +#define OMAP_UART_TLR_TX_FIFO_TRIG_DMA_SHIFT =A0 =A0 =A0 =A0 =A0 0
> +
> =A0static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>
> =A0/* Forward declaration of functions */
> @@ -694,6 +706,7 @@ serial_omap_set_termios(struct uart_port *port, s=
truct ktermios *termios,
> =A0 =A0 =A0 =A0unsigned char efr =3D 0;
> =A0 =A0 =A0 =A0unsigned long flags =3D 0;
> =A0 =A0 =A0 =A0unsigned int baud, quot;
> + =A0 =A0 =A0 u32 tlr;
>
> =A0 =A0 =A0 =A0switch (termios->c_cflag & CSIZE) {
> =A0 =A0 =A0 =A0case CS5:
> @@ -811,14 +824,28 @@ serial_omap_set_termios(struct uart_port *port,=
 struct ktermios *termios,
> =A0 =A0 =A0 =A0up->mcr =3D serial_in(up, UART_MCR);
> =A0 =A0 =A0 =A0serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
> =A0 =A0 =A0 =A0/* FIFO ENABLE, DMA MODE */
> - =A0 =A0 =A0 serial_out(up, UART_FCR, up->fcr);
> - =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> +
> + =A0 =A0 =A0 up->scr |=3D OMAP_UART_SCR_TX_TRIG_GRANU1_MASK;
> + =A0 =A0 =A0 up->scr |=3D OMAP_UART_SCR_RX_TRIG_GRANU1_MASK;
>
> =A0 =A0 =A0 =A0if (up->use_dma) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial_out(up, UART_TI752_TLR, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->scr |=3D (UART_FCR_TRIGGER_4 | UART=
_FCR_TRIGGER_8);

Any reasons for removing scr config for dma mode ?


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tlr =3D 0;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->scr &=3D ~OMAP_UART_SCR_TX_EMPTY;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set receive FIFO threshold to 1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->fcr &=3D ~OMAP_UART_FCR_RX_FIFO_TRI=
G_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->fcr |=3D (0x1 << OMAP_UART_FCR_RX_F=
IFO_TRIG_SHIFT);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set TX FIFO threshold to "63" (actua=
lly 1) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->fcr |=3D (0x3 << OMAP_UART_FCR_TX_F=
IFO_TRIG_SHIFT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tlr =3D (0xf << OMAP_UART_TLR_TX_FIFO_T=
RIG_DMA_SHIFT);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 serial_out(up, UART_TI752_TLR, tlr);
> + =A0 =A0 =A0 serial_out(up, UART_FCR, up->fcr);
> + =A0 =A0 =A0 serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> +
> =A0 =A0 =A0 =A0serial_out(up, UART_OMAP_SCR, up->scr);
>
> =A0 =A0 =A0 =A0serial_out(up, UART_EFR, up->efr);
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
