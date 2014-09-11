From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 05/16] tty: serial: 8250_core: remove UART_IER_RDI in
 serial8250_stop_rx()
Date: Thu, 11 Sep 2014 14:19:31 +0300
Message-ID: <20140911111931.GC17476@xps8300>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-6-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410377411-26656-6-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 10, 2014 at 09:30:00PM +0200, Sebastian Andrzej Siewior wrote:
> serial8250_do_startup() adds UART_IER_RDI and UART_IER_RLSI to ier.
> serial8250_stop_rx() should remove both.
> This is what the serial-omap driver has been doing and is now moved to
> the 8250-core since it does no look to be *that* omap specific.
> 
> Cc: heikki.krogerus@linux.intel.com

Looks good to me. FWIW...

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index ac88e66df65d..139f3d2b8aa9 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1390,7 +1390,7 @@ static void serial8250_stop_rx(struct uart_port *port)
>  
>  	serial8250_rpm_get(up);
>  
> -	up->ier &= ~UART_IER_RLSI;
> +	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
>  	up->port.read_status_mask &= ~UART_LSR_DR;
>  	serial_port_out(port, UART_IER, up->ier);
>  
> -- 
> 2.1.0

Thanks,

-- 
heikki
