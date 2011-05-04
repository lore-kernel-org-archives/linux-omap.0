From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 05/12] OMAP: Serial: Hold console lock for console usage.
Date: Wed, 04 May 2011 13:43:24 -0700
Message-ID: <87vcxqp577.fsf@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-6-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1304080796-625-6-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 29 Apr 2011 18:09:49 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Acquire console lock before enabling and writing to console-uart
> to avoid any recursive prints from console write.
> for ex:
> 	--> printk
> 	  --> uart_console_write
> 	    --> get_sync
> 	      --> printk from omap_device enable
> 		--> uart_console write

By this time, since the device's runtime PM hooks have been called, the
device's rutime PM state should be set to RPM_SUSPENDING (not yet
RPM_SUSPENDED).  

In addition to the console lock, you should be able to use that flag to
avoid console writes while the console is in the process of suspending.

> Also during bootup console_lock is not available.
>        --> uart_add_one_port
> 	   --> console_register
> 	       --> console_lock
> 	        --> console_unlock
> 	             --> call_console_drivers (here yet console_lock is not released)
> 		          --> uart_console_write
>
> Hence convert prints from omap_device_enable/disable to pr_debug.

And what if you add 'debug' to your kernel command line?  IOW, you're
only solving the problem if you debug printk's are not going to the
console.

You're also not solving the problem that will happen down the road when
someone else adds a printk to low-level code in order to debug something
deep in the idle sequence.  

The recursive locking needs to be solved, not avoided. 

Kevin

> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/plat-omap/omap_device.c |    8 ++++----
>  drivers/tty/serial/omap-serial.c |    8 +++++++-
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 9bbda9a..f7c6dca 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -145,12 +145,12 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
>  			odpl->activate_lat_worst = act_lat;
>  			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
>  				odpl->activate_lat = act_lat;
> -				pr_warning("omap_device: %s.%d: new worst case "
> +				pr_debug("omap_device: %s.%d: new worst case "
>  					   "activate latency %d: %llu\n",
>  					   od->pdev.name, od->pdev.id,
>  					   od->pm_lat_level, act_lat);
>  			} else
> -				pr_warning("omap_device: %s.%d: activate "
> +				pr_debug("omap_device: %s.%d: activate "
>  					   "latency %d higher than exptected. "
>  					   "(%llu > %d)\n",
>  					   od->pdev.name, od->pdev.id,
> @@ -213,12 +213,12 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
>  			odpl->deactivate_lat_worst = deact_lat;
>  			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
>  				odpl->deactivate_lat = deact_lat;
> -				pr_warning("omap_device: %s.%d: new worst case "
> +				pr_debug("omap_device: %s.%d: new worst case "
>  					   "deactivate latency %d: %llu\n",
>  					   od->pdev.name, od->pdev.id,
>  					   od->pm_lat_level, deact_lat);
>  			} else
> -				pr_warning("omap_device: %s.%d: deactivate "
> +				pr_debug("omap_device: %s.%d: deactivate "
>  					   "latency %d higher than exptected. "
>  					   "(%llu > %d)\n",
>  					   od->pdev.name, od->pdev.id,
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 633dfb4..7d8ca45 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1007,7 +1007,10 @@ serial_omap_console_write(struct console *co, const char *s,
>  	struct uart_omap_port *up = serial_omap_console_ports[co->index];
>  	unsigned long flags;
>  	unsigned int ier;
> -	int locked = 1;
> +	int console_lock = 0, locked = 1;
> +
> +	if (console_trylock())
> +		console_lock = 1;
>  
>  	local_irq_save(flags);
>  	if (up->port.sysrq)
> @@ -1043,6 +1046,9 @@ serial_omap_console_write(struct console *co, const char *s,
>  	if (up->msr_saved_flags)
>  		check_modem_status(up);
>  
> +	if (console_lock)
> +		console_unlock();
> +
>  	serial_omap_port_disable(up);
>  	if (locked)
>  		spin_unlock(&up->port.lock);
