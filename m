From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] rtc: make rtc-omap driver ioremap its register space
Date: Tue, 22 Sep 2009 15:00:56 -0700
Message-ID: <20090922220056.GG4919@atomide.com>
References: <20090917000458.GA6119@mag.az.mvista.com> <87d45ievqa.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61427 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbZIVWBA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 18:01:00 -0400
Content-Disposition: inline
In-Reply-To: <87d45ievqa.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Mark A. Greer" <mgreer@mvista.com>, rtc-linux@googlegroups.com, David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Davinci-linux-open-source@linux.davincidsp.com

* Kevin Hilman <khilman@deeprootsystems.com> [090922 10:27]:
> "Mark A. Greer" <mgreer@mvista.com> writes:
> 
> > From: Mark A. Greer <mgreer@mvista.com>
> >
> > The rtc-omap driver currently assumes that the rtc's
> > registers are at a fixed address and already mapped
> > into virtual memory space.  Remove those assumptions
> > so the same driver can be used for similar devices
> > that reside at different physical addresses (e.g.,
> > TI's DA8xx/OMAP-L13x SoC's).
> >
> > Also allow the possibility for the timer and alarm
> > interrupts to use the same IRQ.
> >
> > Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> > CC: David Brownell <david-b@pacbell.net>
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> for relevance to davinci platforms.

Acked-by: Tony Lindgren <tony@atomide.com>



> 
> Kevin
> 
> 
> > ---
> > Sorry for the cross-posting but this is relevant to the different lists.
> >
> > This patch was tested on a da830 and a da850.  It was only compiled
> > for an omap1 platform (don't have the hardware) but it should be low
> > risk.  Note that the platform_device data is already set up in
> > arch/arm/mach-omap1/devices.c so it those platforms should
> > "Just Work(tm)".
> >
> >  drivers/rtc/Kconfig    |    7 ++++---
> >  drivers/rtc/rtc-omap.c |   47 ++++++++++++++++++++++++++---------------------
> >  2 files changed, 30 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 81adbdb..f06e885 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -539,10 +539,11 @@ comment "on-CPU RTC drivers"
> >  
> >  config RTC_DRV_OMAP
> >  	tristate "TI OMAP1"
> > -	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730
> > +	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX
> >  	help
> > -	  Say "yes" here to support the real time clock on TI OMAP1 chips.
> > -	  This driver can also be built as a module called rtc-omap.
> > +	  Say "yes" here to support the real time clock on TI OMAP1 and
> > +	  DA8xx/OMAP-L13x chips.  This driver can also be built as a
> > +	  module called rtc-omap.
> >  
> >  config RTC_DRV_S3C
> >  	tristate "Samsung S3C series SoC RTC"
> > diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> > index bd1ce8e..aa418d5 100644
> > --- a/drivers/rtc/rtc-omap.c
> > +++ b/drivers/rtc/rtc-omap.c
> > @@ -87,9 +87,10 @@
> >  #define OMAP_RTC_INTERRUPTS_IT_ALARM    (1<<3)
> >  #define OMAP_RTC_INTERRUPTS_IT_TIMER    (1<<2)
> >  
> > +static void __iomem	*rtc_base;
> >  
> > -#define rtc_read(addr)		omap_readb(OMAP_RTC_BASE + (addr))
> > -#define rtc_write(val, addr)	omap_writeb(val, OMAP_RTC_BASE + (addr))
> > +#define rtc_read(addr)		__raw_readb(rtc_base + (addr))
> > +#define rtc_write(val, addr)	__raw_writeb(val, rtc_base + (addr))
> >  
> >  
> >  /* we rely on the rtc framework to handle locking (rtc->ops_lock),
> > @@ -330,32 +331,31 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
> >  		return -ENOENT;
> >  	}
> >  
> > -	/* NOTE:  using static mapping for RTC registers */
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	if (res && res->start != OMAP_RTC_BASE) {
> > -		pr_debug("%s: RTC registers at %08x, expected %08x\n",
> > -			pdev->name, (unsigned) res->start, OMAP_RTC_BASE);
> > +	if (!res) {
> > +		pr_debug("%s: RTC resource data missing\n", pdev->name);
> >  		return -ENOENT;
> >  	}
> >  
> > -	if (res)
> > -		mem = request_mem_region(res->start,
> > -				res->end - res->start + 1,
> > -				pdev->name);
> > -	else
> > -		mem = NULL;
> > +	mem = request_mem_region(res->start, resource_size(res), pdev->name);
> >  	if (!mem) {
> >  		pr_debug("%s: RTC registers at %08x are not free\n",
> > -			pdev->name, OMAP_RTC_BASE);
> > +			pdev->name, res->start);
> >  		return -EBUSY;
> >  	}
> >  
> > +	rtc_base = ioremap(res->start, resource_size(res));
> > +	if (!rtc_base) {
> > +		pr_debug("%s: RTC registers can't be mapped\n", pdev->name);
> > +		goto fail;
> > +	}
> > +
> >  	rtc = rtc_device_register(pdev->name, &pdev->dev,
> >  			&omap_rtc_ops, THIS_MODULE);
> >  	if (IS_ERR(rtc)) {
> >  		pr_debug("%s: can't register RTC device, err %ld\n",
> >  			pdev->name, PTR_ERR(rtc));
> > -		goto fail;
> > +		goto fail0;
> >  	}
> >  	platform_set_drvdata(pdev, rtc);
> >  	dev_set_drvdata(&rtc->dev, mem);
> > @@ -380,13 +380,14 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
> >  			dev_name(&rtc->dev), rtc)) {
> >  		pr_debug("%s: RTC timer interrupt IRQ%d already claimed\n",
> >  			pdev->name, omap_rtc_timer);
> > -		goto fail0;
> > +		goto fail1;
> >  	}
> > -	if (request_irq(omap_rtc_alarm, rtc_irq, IRQF_DISABLED,
> > -			dev_name(&rtc->dev), rtc)) {
> > +	if ((omap_rtc_timer != omap_rtc_alarm) &&
> > +		(request_irq(omap_rtc_alarm, rtc_irq, IRQF_DISABLED,
> > +			dev_name(&rtc->dev), rtc))) {
> >  		pr_debug("%s: RTC alarm interrupt IRQ%d already claimed\n",
> >  			pdev->name, omap_rtc_alarm);
> > -		goto fail1;
> > +		goto fail2;
> >  	}
> >  
> >  	/* On boards with split power, RTC_ON_NOFF won't reset the RTC */
> > @@ -419,10 +420,12 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
> >  
> >  	return 0;
> >  
> > -fail1:
> > +fail2:
> >  	free_irq(omap_rtc_timer, NULL);
> > -fail0:
> > +fail1:
> >  	rtc_device_unregister(rtc);
> > +fail0:
> > +	iounmap(rtc_base);
> >  fail:
> >  	release_resource(mem);
> >  	return -EIO;
> > @@ -438,7 +441,9 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
> >  	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> >  
> >  	free_irq(omap_rtc_timer, rtc);
> > -	free_irq(omap_rtc_alarm, rtc);
> > +
> > +	if (omap_rtc_timer != omap_rtc_alarm)
> > +		free_irq(omap_rtc_alarm, rtc);
> >  
> >  	release_resource(dev_get_drvdata(&rtc->dev));
> >  	rtc_device_unregister(rtc);
> > -- 
> > 1.6.2.5.182.ga808d
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
