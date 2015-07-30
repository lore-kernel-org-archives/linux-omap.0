From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/3] serial: 8250: move rx_running out of the bitfield
Date: Thu, 30 Jul 2015 19:24:22 -0400
Message-ID: <55BAB226.6090706@hurleysoftware.com>
References: <87fv452r4k.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87fv452r4k.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org, nsekhar@ti.com, nm@ti.com, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/30/2015 06:54 PM, John Ogness wrote:
> That bitfield is modified by read + or + write operation. If someone
> sets any of the other two bits it might render the lock useless.

Good catch.
Let's just make all of the fields not bitfield though.

Regards,
Peter Hurley

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index c43f74c..78f5e3a 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -44,7 +44,7 @@ struct uart_8250_dma {
>  
>  	unsigned char		tx_running:1;
>  	unsigned char		tx_err: 1;
> -	unsigned char		rx_running:1;
> +	unsigned char		rx_running;
>  };
>  
>  struct old_serial_port {
> 
