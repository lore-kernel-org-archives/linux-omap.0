From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: omap-serial: Move info message to probe function
Date: Thu, 13 Feb 2014 10:56:33 +0100
Message-ID: <20140213095633.GA17650@pengutronix.de>
References: <1390583381-9076-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38445 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbaBMJ4z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 04:56:55 -0500
Content-Disposition: inline
In-Reply-To: <1390583381-9076-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, kernel@pengutronix.de, Tony Lindgren <tony@atomide.com>

On Fri, Jan 24, 2014 at 06:09:41PM +0100, Markus Pargmann wrote:
> Currently the info message about a missing wakeirq for uart is printe=
d
> every time the serial driver's startup function is called. This happe=
ns
> multiple times and not just once.
>=20
> This patch moves the infomessage to the probe function to display it
> only once.
>=20
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/omap-serial.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index fa511eb..2051581 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -738,9 +738,6 @@ static int serial_omap_startup(struct uart_port *=
port)
>  			return retval;
>  		}
>  		disable_irq(up->wakeirq);
> -	} else {
> -		dev_info(up->port.dev, "no wakeirq for uart%d\n",
> -			 up->port.line);
>  	}
> =20
>  	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
> @@ -1687,6 +1684,9 @@ static int serial_omap_probe(struct platform_de=
vice *pdev)
>  	up->port.iotype =3D UPIO_MEM;
>  	up->port.irq =3D uartirq;
>  	up->wakeirq =3D wakeirq;
> +	if (!up->wakeirq)
> +		dev_info(up->port.dev, "no wakeirq for uart%d\n",
> +			 up->port.line);
> =20
>  	up->port.regshift =3D 2;
>  	up->port.fifosize =3D 64;
> --=20
> 1.8.5.2
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
