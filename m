From: Johan Hovold <johan@kernel.org>
Subject: OMAP serial runtime PM and autosuspend (was: Re: [PATCH 4/7]
 dt-bindings: gnss: add u-blox binding))
Date: Wed, 9 May 2018 15:10:03 +0200
Message-ID: <20180509131003.GC2285@localhost>
References: <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180507175032.GR98604@atomide.com>
 <20180508065852.GW2285@localhost>
 <20180508152228.GV98604@atomide.com>
 <20180508154756.GW98604@atomide.com>
 <20180508155405.GX98604@atomide.com>
 <20180508164904.GZ98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180508164904.GZ98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

[ Updating subject and adding linux-serial, linux-pm and linux-omap. ]

On Tue, May 08, 2018 at 09:49:04AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180508 08:54]:
> > * Tony Lindgren <tony@atomide.com> [180508 08:47]:
> > > * Tony Lindgren <tony@atomide.com> [180508 08:22]:
> > > > * Johan Hovold <johan@kernel.org> [180508 07:00]:
> > > > > With the negative autosuspend set in both omap drivers probe functions,
> > > > > this is the expected behaviour. Which I think we must fix.
> > > > 
> > > > Yes indeed. I've been using my script for years now and have
> > > > completely missed the fact that the unused ports are not idled
> > > > at all on start-up when unused.
> > > 
> > > This might be all that's needed, care to try it and if it works
> > > I'll send out two separate proper patches?
> > > 
> > > I'm seeing this now on my bbb after temporarily disabling my
> > > UART idle init script:
> > > 
> > > # rwmem -s32 0x44e004b4           # uart 1 on l4_wkup
> > > 0x44e004b4 = 0x00000002
> > > 
> > > # rwmem -s32 0x44e0006c+0x10      # uart 2 - 5 on l4_per
> > > 0x44e0006c = 0x00030000
> > > 0x44e00070 = 0x00030000
> > > 0x44e00074 = 0x00030000
> > > 0x44e00078 = 0x00030000
> > > 
> > > # rwmem -s32 0x44e00038           # uart 6 on l4_per
> > > 0x44e00038 = 0x00030000
> > 
> > Hmm I forgot to remove status = "disabled" from the other ports,
> > still not idling the unused ports with the patch below it seems.
> 
> No need to enable/disable autosuspend except in startup and shutdown
> I think. The patch below works for me, now includes removal of the
> status = "disabled" flags too. Only tested with 8250_omap on bbb
> so far.
> 
> I wonder if other places still need fixing for autosuspend
> like console support?

While this seems to fix the idling of closed ports here too, I'm not
sure we can move use_autosuspend to startup() like this.

First, this flag should be set before registering the tty so that udev
can be used to update the attributes.

Second, this prevents setting the autosuspend delay through sysfs when
the port is closed (when autosuspend is disabled).

It seems we really should not be using the negative autosuspend to
configure the RPM behaviour the way these drivers do. Perhaps a new
mechanism is needed.

But I'm afraid I don't have time to look at this today.

Thanks,
Johan

> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -605,6 +605,7 @@ static int omap_8250_startup(struct uart_port *port)
>  			return ret;
>  	}
>  
> +	pm_runtime_use_autosuspend(port->dev);
>  	pm_runtime_get_sync(port->dev);
>  
>  	up->mcr = 0;
> @@ -685,8 +686,8 @@ static void omap_8250_shutdown(struct uart_port *port)
>  		serial_out(up, UART_LCR, up->lcr & ~UART_LCR_SBC);
>  	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
>  
> -	pm_runtime_mark_last_busy(port->dev);
> -	pm_runtime_put_autosuspend(port->dev);
> +	pm_runtime_dont_use_autosuspend(port->dev);
> +	pm_runtime_put_sync(port->dev);
>  	free_irq(port->irq, port);
>  	dev_pm_clear_wake_irq(port->dev);
>  }
> @@ -1226,7 +1227,7 @@ static int omap8250_probe(struct platform_device *pdev)
>  	spin_lock_init(&priv->rx_dma_lock);
>  
>  	device_init_wakeup(&pdev->dev, true);
> -	pm_runtime_use_autosuspend(&pdev->dev);
> +	/* See omap_8250_startup and shutdown for autosuspend */
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
>  
>  	pm_runtime_irq_safe(&pdev->dev);
> @@ -1265,8 +1266,8 @@ static int omap8250_probe(struct platform_device *pdev)
>  	}
>  	priv->line = ret;
>  	platform_set_drvdata(pdev, priv);
> -	pm_runtime_mark_last_busy(&pdev->dev);
> -	pm_runtime_put_autosuspend(&pdev->dev);
> +	pm_runtime_put_sync(&pdev->dev);
> +
>  	return 0;
>  err:
