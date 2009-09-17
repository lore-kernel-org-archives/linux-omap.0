From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2] rtc: make rtc-omap driver ioremap its register space
Date: Wed, 16 Sep 2009 21:02:28 -0700
Message-ID: <200909162102.28367.david-b@pacbell.net>
References: <20090917000458.GA6119@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20090917000458.GA6119-S3yzRvi4kHRa+ipTMWa7OQC/G2K4zDHf@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 16 September 2009, Mark A. Greer wrote:
> From: Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> 
> The rtc-omap driver currently assumes that the rtc's
> registers are at a fixed address and already mapped
> into virtual memory space.  Remove those assumptions
> so the same driver can be used for similar devices
> that reside at different physical addresses (e.g.,
> TI's DA8xx/OMAP-L13x SoC's).
> 
> Also allow the possibility for the timer and alarm
> interrupts to use the same IRQ.
> 
> Signed-off-by: Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> CC: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

... but not tested on OMAP1 (e.g. OSK5912, H2).

> ---
> Sorry for the cross-posting but this is relevant to the different lists.
> 
> This patch was tested on a da830 and a da850.  It was only compiled
> for an omap1 platform (don't have the hardware) but it should be low
> risk.  Note that the platform_device data is already set up in
> arch/arm/mach-omap1/devices.c so it those platforms should
> "Just Work(tm)".
> 
>  drivers/rtc/Kconfig    |    7 ++++---
>  drivers/rtc/rtc-omap.c |   47 ++++++++++++++++++++++++++---------------------
>  2 files changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 81adbdb..f06e885 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -539,10 +539,11 @@ comment "on-CPU RTC drivers"
>  
>  config RTC_DRV_OMAP
>  	tristate "TI OMAP1"
> -	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730
> +	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX
>  	help
> -	  Say "yes" here to support the real time clock on TI OMAP1 chips.
> -	  This driver can also be built as a module called rtc-omap.
> +	  Say "yes" here to support the real time clock on TI OMAP1 and
> +	  DA8xx/OMAP-L13x chips.  This driver can also be built as a
> +	  module called rtc-omap.
>  
>  config RTC_DRV_S3C
>  	tristate "Samsung S3C series SoC RTC"
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index bd1ce8e..aa418d5 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -87,9 +87,10 @@
>  #define OMAP_RTC_INTERRUPTS_IT_ALARM    (1<<3)
>  #define OMAP_RTC_INTERRUPTS_IT_TIMER    (1<<2)
>  
> +static void __iomem	*rtc_base;
>  
> -#define rtc_read(addr)		omap_readb(OMAP_RTC_BASE + (addr))
> -#define rtc_write(val, addr)	omap_writeb(val, OMAP_RTC_BASE + (addr))
> +#define rtc_read(addr)		__raw_readb(rtc_base + (addr))
> +#define rtc_write(val, addr)	__raw_writeb(val, rtc_base + (addr))
>  
>  
>  /* we rely on the rtc framework to handle locking (rtc->ops_lock),
> @@ -330,32 +331,31 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	/* NOTE:  using static mapping for RTC registers */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res && res->start != OMAP_RTC_BASE) {
> -		pr_debug("%s: RTC registers at %08x, expected %08x\n",
> -			pdev->name, (unsigned) res->start, OMAP_RTC_BASE);
> +	if (!res) {
> +		pr_debug("%s: RTC resource data missing\n", pdev->name);
>  		return -ENOENT;
>  	}
>  
> -	if (res)
> -		mem = request_mem_region(res->start,
> -				res->end - res->start + 1,
> -				pdev->name);
> -	else
> -		mem = NULL;
> +	mem = request_mem_region(res->start, resource_size(res), pdev->name);
>  	if (!mem) {
>  		pr_debug("%s: RTC registers at %08x are not free\n",
> -			pdev->name, OMAP_RTC_BASE);
> +			pdev->name, res->start);
>  		return -EBUSY;
>  	}
>  
> +	rtc_base = ioremap(res->start, resource_size(res));
> +	if (!rtc_base) {
> +		pr_debug("%s: RTC registers can't be mapped\n", pdev->name);
> +		goto fail;
> +	}
> +
>  	rtc = rtc_device_register(pdev->name, &pdev->dev,
>  			&omap_rtc_ops, THIS_MODULE);
>  	if (IS_ERR(rtc)) {
>  		pr_debug("%s: can't register RTC device, err %ld\n",
>  			pdev->name, PTR_ERR(rtc));
> -		goto fail;
> +		goto fail0;
>  	}
>  	platform_set_drvdata(pdev, rtc);
>  	dev_set_drvdata(&rtc->dev, mem);
> @@ -380,13 +380,14 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  			dev_name(&rtc->dev), rtc)) {
>  		pr_debug("%s: RTC timer interrupt IRQ%d already claimed\n",
>  			pdev->name, omap_rtc_timer);
> -		goto fail0;
> +		goto fail1;
>  	}
> -	if (request_irq(omap_rtc_alarm, rtc_irq, IRQF_DISABLED,
> -			dev_name(&rtc->dev), rtc)) {
> +	if ((omap_rtc_timer != omap_rtc_alarm) &&
> +		(request_irq(omap_rtc_alarm, rtc_irq, IRQF_DISABLED,
> +			dev_name(&rtc->dev), rtc))) {
>  		pr_debug("%s: RTC alarm interrupt IRQ%d already claimed\n",
>  			pdev->name, omap_rtc_alarm);
> -		goto fail1;
> +		goto fail2;
>  	}
>  
>  	/* On boards with split power, RTC_ON_NOFF won't reset the RTC */
> @@ -419,10 +420,12 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -fail1:
> +fail2:
>  	free_irq(omap_rtc_timer, NULL);
> -fail0:
> +fail1:
>  	rtc_device_unregister(rtc);
> +fail0:
> +	iounmap(rtc_base);
>  fail:
>  	release_resource(mem);
>  	return -EIO;
> @@ -438,7 +441,9 @@ static int __exit omap_rtc_remove(struct platform_device *pdev)
>  	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
>  
>  	free_irq(omap_rtc_timer, rtc);
> -	free_irq(omap_rtc_alarm, rtc);
> +
> +	if (omap_rtc_timer != omap_rtc_alarm)
> +		free_irq(omap_rtc_alarm, rtc);
>  
>  	release_resource(dev_get_drvdata(&rtc->dev));
>  	rtc_device_unregister(rtc);
> -- 
> 1.6.2.5.182.ga808d
> 
> 
