From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: serial_core: Add mechanism to identify port
 closure.
Date: Mon, 23 Apr 2012 11:07:22 +0100
Message-ID: <20120423110722.7d8dd2c0@pyramind.ukuu.org.uk>
References: <1334919473-18870-1-git-send-email-govindraj.raja@ti.com>
	<20120420142740.053b9981@pyramind.ukuu.org.uk>
	<CAMrsUdLaamf9boyMF824iTXdDce0qB3AiUfMiM3a1gL2DcVPqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35045 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822Ab2DWKEp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 06:04:45 -0400
In-Reply-To: <CAMrsUdLaamf9boyMF824iTXdDce0qB3AiUfMiM3a1gL2DcVPqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 9c4c05b..c176ff2 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1426,6 +1426,9 @@ static void uart_port_shutdown(struct tty_port *port)
>  	 */
>  	uport->ops->shutdown(uport);
> 
> +	if (uport->ops->set_wake)
> +		uport->ops->set_wake(uport, false);
> +
>  	/*
>  	 * Ensure that the IRQ handler isn't running on another CPU.
>  	 */
> @@ -1512,6 +1515,9 @@ static int uart_open(struct tty_struct *tty,
> struct file *filp)
>  		goto err_dec_count;
>  	}
> 
> +	if (uport->ops->set_wake)
> +		uport->ops->set_wake(uport, true);
> +
>  	/*
>  	 * Make sure the device is in D0 state.
>  	 */

This is probably the right approach for now. In the ideal world we should
probably use the struct device * and device power management but that is
a big upheaval and would mean fixing lots of other stuff first.

So this looks good to me - providing it doesn't break anything else.

Alan
