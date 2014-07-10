From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] tty: serial: 8250 core: add runtime pm
Date: Wed, 9 Jul 2014 23:28:12 -0700
Message-ID: <20140710062812.GF28884@atomide.com>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
 <1404928177-26554-4-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404928177-26554-4-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, mika.westerberg@linux.intel.com
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140709 10:52]:
> While comparing the OMAP-serial and the 8250 part of this I noticed that
> the the latter does not use runtime-pm. Here are the pieces. It is
> basically a get before first register access and a last_busy + put after
> last access.
> If I understand this correct, it should do nothing as long as
> pm_runtime_use_autosuspend() + pm_runtime_enable() isn't invoked on the
> device.
...

> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -571,7 +573,17 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
>  			serial_out(p, UART_EFR, 0);
>  			serial_out(p, UART_LCR, 0);
>  		}
> +
> +		if (!device_may_wakeup(p->port.dev)) {
> +			if (sleep)
> +				pm_runtime_forbid(p->port.dev);
> +			else
> +				pm_runtime_allow(p->port.dev);
> +		}
>  	}
> +out:
> +	pm_runtime_mark_last_busy(p->port.dev);
> +	pm_runtime_put_autosuspend(p->port.dev);
>  }

The device_may_wakeup logic here is wrong as I described in the
earlier thread. For runtime PM, the wake-up events should be
always enabled. So the device_may_wakeup checks should be only
done for suspend and resume.

Regards,

Tony
