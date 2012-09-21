From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH] serial: omap: fix the overrun case
Date: Fri, 21 Sep 2012 16:48:18 +0530
Message-ID: <CAKdam54OLptnfY+ZvtVo4B9ZVWmeWHnFRRbg3JyX1ocGOX7uzg@mail.gmail.com>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 21, 2012 at 3:52 PM, Shubhrajyoti D <shubhrajyoti@ti.com> w=
rote:
> Overrun also causes an internal flag to be set, which disables furthe=
r
> reception. Before the next frame can
> be received, the MPU must:
> =95 Reset the RX FIFO.
> =95 clear the internal flag.
>
> In the uart mode a dummy read is needed. Add the same.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> - functional testing on omap4sdp
> - Verified idle and suspend path hits off on beagle.
>
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
>         unsigned int flag;
> +       unsigned char ch =3D 0;
> +
> +       if (!(lsr & UART_LSR_BRK_ERROR_BITS))
By using this flag, you are trying to take into account not just the
overrun case but also
frame, parity and break condition case as the flag is the OR of all the=
se.

I suppose the commit log should reflect this.
> +               return;
> +
> +       if (likely(lsr & UART_LSR_DR))
> +               ch =3D serial_in(up, UART_RX);
>
>         up->port.icount.rx++;
>         flag =3D TTY_NORMAL;
> --
> 1.7.5.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
