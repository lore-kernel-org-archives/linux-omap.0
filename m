From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 02/16] tty: serial: 8250_core: add run time pm
Date: Mon, 29 Sep 2014 11:46:20 +0200
Message-ID: <20140929094620.GE13952@ci00147.xsens-tech.local>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410377411-26656-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 10, 2014 at 09:29:57PM +0200, Sebastian Andrzej Siewior wrote:
> +/*
> + * This two wrapper ensure, that enable_runtime_pm_tx() can be called more than

These two wrappers ensure that enable_runtime_pm_tx() ...

> + * once and disable_runtime_pm_tx() will still disable RPM because the fifo is
> + * empty and the HW can idle again.
> + */
> +static void serial8250_rpm_get_tx(struct uart_8250_port *p)
> +{
> +	unsigned char rpm_active;
> +
> +	if (!(p->capabilities & UART_CAP_RPM))
> +		return;
> +
> +	rpm_active = xchg(&p->rpm_tx_active, 1);
> +	if (rpm_active)
> +		return;
> +	pm_runtime_get_sync(p->port.dev);
> +}
> +
> +static void serial8250_rpm_put_tx(struct uart_8250_port *p)
> +{
> +	unsigned char rpm_active;
> +
> +	if (!(p->capabilities & UART_CAP_RPM))
> +		return;
> +
> +	rpm_active = xchg(&p->rpm_tx_active, 0);
> +	if (!rpm_active)
> +		return;
> +	pm_runtime_mark_last_busy(p->port.dev);
> +	pm_runtime_put_autosuspend(p->port.dev);
> +}
> +


> @@ -1469,7 +1531,12 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  
>  	DEBUG_INTR("THRE...");
>  
> -	if (uart_circ_empty(xmit))
> +	/*
> +	 * With RPM enabled, we have to wait once the FIFO is empty before the

s,once,until,? Or do I not understand the sentence correctly?

> +	 * HW can go idle. So we get here once again with empty FIFO and disable
> +	 * the interrupt and RPM in __stop_tx()
> +	 */
> +	if (uart_circ_empty(xmit) && !(up->capabilities & UART_CAP_RPM))
>  		__stop_tx(up);
>  }
>  EXPORT_SYMBOL_GPL(serial8250_tx_chars);
