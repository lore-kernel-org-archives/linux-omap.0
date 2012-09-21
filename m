From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] serial: omap: fix the overrun case
Date: Fri, 21 Sep 2012 07:18:54 -0700
Message-ID: <87a9wjfohd.fsf@deeprootsystems.com>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Fri, 21 Sep 2012 15:52:56 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sourav.poddar@ti.com
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Overrun also causes an internal flag to be set, which disables furthe=
r
> reception. Before the next frame can
> be received, the MPU must:
> =E2=80=A2 Reset the RX FIFO.
> =E2=80=A2 clear the internal flag.
>
> In the uart mode a dummy read is needed. Add the same.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> - functional testing on omap4sdp
> - Verified idle and suspend path hits off on beagle.

Tested-by: Kevin Hilman <khilman@ti.com>

This fixes the console hang I was seeing on 3530/Overo.

Thanks,

Kevin

>  drivers/tty/serial/omap-serial.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index a0d4460..bc22a2b 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -334,6 +334,13 @@ static unsigned int check_modem_status(struct ua=
rt_omap_port *up)
>  static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int=
 lsr)
>  {
>  	unsigned int flag;
> +	unsigned char ch =3D 0;
> +
> +	if (!(lsr & UART_LSR_BRK_ERROR_BITS))
> +		return;
> +
> +	if (likely(lsr & UART_LSR_DR))
> +		ch =3D serial_in(up, UART_RX);
> =20
>  	up->port.icount.rx++;
>  	flag =3D TTY_NORMAL;
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
