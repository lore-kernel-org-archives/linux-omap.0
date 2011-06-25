From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 05/12] OMAP: Serial: Hold console lock for console usage.
Date: Fri, 24 Jun 2011 17:06:30 -0700
Message-ID: <87boxmsrjt.fsf@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-6-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:34193 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750799Ab1FYAGe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 20:06:34 -0400
In-Reply-To: <1307532194-13039-6-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 8 Jun 2011 16:53:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Acquire console lock before enabling and writing to console-uart
> to avoid any recursive prints from console write.
> for ex:
>         --> printk
>           --> uart_console_write
>             --> get_sync
>               --> printk from omap_device enable
>                 --> uart_console write
>
> Use RPM_SUSPENDING check to avoid below scenario during bootup
> As during bootup console_lock is not available.
>        --> uart_add_one_port
>            --> console_register
>                --> console_lock
>                 --> console_unlock
>                      --> call_console_drivers (here yet console_lock is not released)
>                           --> uart_console_write
>
> Acked-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  drivers/tty/serial/omap-serial.c |   20 +++++++++++++++++++-
>  1 files changed, 19 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 897416f..ee94291 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1008,7 +1008,22 @@ serial_omap_console_write(struct console *co, const char *s,
>  	struct uart_omap_port *up = serial_omap_console_ports[co->index];
>  	unsigned long flags;
>  	unsigned int ier;
> -	int locked = 1;
> +	int console_lock = 0, locked = 1;
> +
> +	if (console_trylock())
> +		console_lock = 1;

So now we take the console lock on *every* console write?  Even if the
device is not about to be idled?   This is rather over-protective, don't
you think?

> +	/*
> +	 * If console_lock is not available and we are in suspending
> +	 * state then we can avoid the console usage scenario

s/in suspending state/runtime suspending/

> +	 * as this may introduce recursive prints.
> +	 * Basically this scenario occurs during boot while
> +	 * printing debug bootlogs.

The exact scenario for triggering this still not well described, and
thus still I don't get it.

I still don't fully understand this problem, but if it's isolated to
runtime suspending, maybe you need a console lock in the runtime_suspend
path (like you already have in the static suspend path.)

> +	 */
> +
> +	if (!console_lock &&
> +		up->pdev->dev.power.runtime_status == RPM_SUSPENDING)
> +		return;

Assuming this was a printk, it's now lost, right?   Not sure that's an
acceptable solution.

>  	local_irq_save(flags);
>  	if (up->port.sysrq)
> @@ -1044,6 +1059,9 @@ serial_omap_console_write(struct console *co, const char *s,
>  	if (up->msr_saved_flags)
>  		check_modem_status(up);
>  
> +	if (console_lock)
> +		console_unlock();
> +
>  	serial_omap_port_disable(up);
>  	if (locked)
>  		spin_unlock(&up->port.lock);

Kevin
