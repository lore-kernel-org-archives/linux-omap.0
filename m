From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: omap-serial: Move info message to probe function
Date: Fri, 24 Jan 2014 09:37:32 -0800
Message-ID: <20140124173731.GA25488@atomide.com>
References: <1390583381-9076-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50354 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750997AbaAXRhl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jan 2014 12:37:41 -0500
Content-Disposition: inline
In-Reply-To: <1390583381-9076-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, kernel@pengutronix.de

* Markus Pargmann <mpa@pengutronix.de> [140124 09:12]:
> Currently the info message about a missing wakeirq for uart is printed
> every time the serial driver's startup function is called. This happens
> multiple times and not just once.
> 
> This patch moves the infomessage to the probe function to display it
> only once.

Makes sense to me:
 
Acked-by: Tony Lindgren <tony@atomide.com>

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/tty/serial/omap-serial.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index fa511eb..2051581 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -738,9 +738,6 @@ static int serial_omap_startup(struct uart_port *port)
>  			return retval;
>  		}
>  		disable_irq(up->wakeirq);
> -	} else {
> -		dev_info(up->port.dev, "no wakeirq for uart%d\n",
> -			 up->port.line);
>  	}
>  
>  	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
> @@ -1687,6 +1684,9 @@ static int serial_omap_probe(struct platform_device *pdev)
>  	up->port.iotype = UPIO_MEM;
>  	up->port.irq = uartirq;
>  	up->wakeirq = wakeirq;
> +	if (!up->wakeirq)
> +		dev_info(up->port.dev, "no wakeirq for uart%d\n",
> +			 up->port.line);
>  
>  	up->port.regshift = 2;
>  	up->port.fifosize = 64;
> -- 
> 1.8.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
