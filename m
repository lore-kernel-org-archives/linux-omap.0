From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 03/12] mtd: nand: omap: Move IRQ handling from GPMC to
 NAND driver
Date: Mon, 3 Aug 2015 06:08:42 -0700
Message-ID: <20150803130842.GP16878@atomide.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
 <1436531019-18088-4-git-send-email-rogerq@ti.com>
 <20150713071008.GC26485@atomide.com>
 <55A38D2E.9010500@ti.com>
 <20150713124059.GF26485@atomide.com>
 <55B8C1D5.3090807@ti.com>
 <55BB4C1D.5080905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55BB4C1D.5080905-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [150731 03:24]:
> 
> One more observation I've had is that using irqchip modelling for
> the 2 NAND events causes a performance impact.
> 
> Using mtd_oobtest I see the following on dra7-evm
> 
> 1) v4.2-rc4 with prefetch-polled (no IRQs used)
> mtd_speedtest: eraseblock write speed is 7142 KiB/s
> mtd_speedtest: eraseblock read speed is 13721 KiB/s
> 
> 2) v4.2-rc4 with prefetch-irq (IRQchip model)
> eraseblock write speed is 5475 KiB/s
> eraseblock read speed is 6420 KiB/s
> 
> 3) this series (*) with prefetch-irq (no IRQchip model, nand driver
> directly accesses irqstatus/irqenable)
> eraseblock write speed is 6564 KiB/s
> eraseblock read speed is 10850 KiB/s
> 
> (*) diff at the end is required on top to fix an issue with this series.
> 
> So should we continue IRQchip modelling for the NAND events
> or use the GPMC interrupt as shared and add APIs to access
> the NAND bits of the IRQSTATUS/ENABLE register.

In the long run chained IRQ would be the most flexible solution
for sure.

It might be worth checking why we have so much overhead with
the irqchip modelling compared to shared IRQ. If the overhead
is really all the extra IRQ handling then it seems the shared
interrupt plus an API to access IRQSTATUS/ENABLE is the way
to go. Up to you.

Regards,

Tony

 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index fecc054..26ef2bd 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1832,13 +1832,14 @@ static int omap_get_dt_info(struct device *dev, struct omap_nand_info *info)
>  		for (i = 0; i < ARRAY_SIZE(nand_xfer_types); i++) {
>  			if (!strcasecmp(s, nand_xfer_types[i])) {
>  				info->xfer_type = i;
> -				break;
> +				goto next;
>  			}
>  		}
>  
>  		dev_err(dev, "unrecognized value for ti,nand-xfer-type\n");
>  		return -EINVAL;
>  	}
> +next:
>  
>  	of_get_nand_on_flash_bbt(child);
>  
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 26ef2bd..e8bdff5 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -670,17 +670,12 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
>  			goto done;
>  	}
>  
> -	/* Clear FIFOEVENT STATUS */
> -	irqstatus &= ~GPMC_IRQ_FIFOEVENT;
> -	writel(irqstatus, info->reg.gpmc_irqstatus);
> -
>  	return IRQ_HANDLED;
>  
>  done:
>  	complete(&info->comp);
>  
> -	/* Clear FIFOEVENT and TERMCOUNT STATUS */
> -	irqstatus &= ~(GPMC_IRQ_TERMCOUNT | GPMC_IRQ_FIFOEVENT);
> +	/* Clear IRQ STATUS */
>  	writel(irqstatus, info->reg.gpmc_irqstatus);
>  
>  	/* Disable Interrupt generation */
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
