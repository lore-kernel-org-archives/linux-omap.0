From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v5 9/12] OMAP: dmtimer: platform driver
Date: Tue, 7 Dec 2010 00:40:18 +0530
Message-ID: <20101206191018.GF4924@manju-desktop>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
 <1291679059-13419-10-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45929 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750774Ab0LFTK2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 14:10:28 -0500
Received: by mail-gw0-f49.google.com with SMTP id 20so8185014gwj.22
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 11:10:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291679059-13419-10-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

On Tue, Dec 07, 2010 at 05:14:16AM +0530, Tarun Kanti DebBarma wrote:
> From: Thara Gopinath <thara@ti.com>
> 
> Add dmtimer platform driver functions which include:
> (1) platform driver initialization
> (2) driver probe function
> (3) driver remove function
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
> Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> ---
>  arch/arm/plat-omap/dmtimer.c |  156 +++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 154 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 9bf6ac8..ddc875b 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -43,6 +43,8 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
>  #include <mach/hardware.h>
not required. You can cleanup
>  #include <plat/dmtimer.h>
>  #include <mach/irqs.h>
not required. You can cleanup
> @@ -167,6 +169,7 @@ struct omap_dm_timer {
>  	unsigned enabled:1;
>  	unsigned posted:1;
>  	struct platform_device *pdev;
> +	struct list_head node;
>  };
>  
>  static int dm_timer_count;
> @@ -270,7 +273,8 @@ static struct omap_dm_timer *dm_timers;
>  static const char **dm_source_names;
>  static struct clk **dm_source_clocks;
>  
> -static spinlock_t dm_timer_lock;
> +static LIST_HEAD(omap_timer_list);
> +static DEFINE_SPINLOCK(dm_timer_lock);
>  
>  /*
>   * Reads timer registers in posted and non-posted mode. The posted mode bit
> @@ -702,6 +706,155 @@ int omap_dm_timers_active(void)
>  }
>  EXPORT_SYMBOL_GPL(omap_dm_timers_active);
>  
> +/**
> + * omap_dm_timer_probe - probe function called for every registered device
> + * @pdev:	pointer to current timer platform device
> + *
> + * Called by driver framework at the end of device registration for all
> + * timer devices.
> + */
> +static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	unsigned long flags;
> +	struct omap_dm_timer *timer;
> +	struct resource *mem, *irq, *ioarea;
> +	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
> +
> +	dev_dbg(&pdev->dev, "%s: +\n", __func__);
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "%s: no platform data\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	spin_lock_irqsave(&dm_timer_lock, flags);
> +	list_for_each_entry(timer, &omap_timer_list, node)
> +		if (timer->pdev->id == pdev->id) {
> +			timer->pdev = pdev;
> +			spin_unlock_irqrestore(&dm_timer_lock, flags);
> +			return 0;
> +		}
> +	spin_unlock_irqrestore(&dm_timer_lock, flags);
> +
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (unlikely(!irq)) {
> +		dev_err(&pdev->dev, "%s: no IRQ resource\n", __func__);
> +		ret = -ENODEV;
> +		goto err_free_pdev;
> +	}
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(!mem)) {
> +		dev_err(&pdev->dev, "%s: no memory resource\n", __func__);
> +		ret = -ENODEV;
> +		goto err_free_pdev;
> +	}
> +
> +	ioarea = request_mem_region(mem->start, resource_size(mem),
> +			pdev->name);
> +	if (!ioarea) {
> +		dev_err(&pdev->dev, "%s: region already claimed\n", __func__);
> +		ret = -EBUSY;
> +		goto err_free_pdev;
> +	}
> +
> +	timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
> +	if (!timer) {
> +		dev_err(&pdev->dev, "%s: no memory for omap_dm_timer\n",
> +			__func__);
> +		ret = -ENOMEM;
> +		goto err_release_ioregion;
> +	}
> +
> +	timer->io_base = ioremap(mem->start, resource_size(mem));
> +	if (!timer->io_base) {
> +		dev_err(&pdev->dev, "%s: ioremap failed\n", __func__);
> +		ret = -ENOMEM;
> +		goto err_free_mem;
> +	}
> +
> +	timer->irq = irq->start;
> +	timer->pdev = pdev;
> +	timer->reserved = 0;
> +
> +	/* add the timer element to the list */
> +	spin_lock_irqsave(&dm_timer_lock, flags);
> +	list_add_tail(&timer->node, &omap_timer_list);
> +	spin_unlock_irqrestore(&dm_timer_lock, flags);
> +
> +	dev_dbg(&pdev->dev, " bound to its driver\n");
> +
> +	return 0;
> +
> +err_free_mem:
> +	kfree(timer);
> +
> +err_release_ioregion:
> +	release_mem_region(mem->start, resource_size(mem));
> +
> +err_free_pdev:
You can also free pdata?
> +	platform_device_del(pdev);
> +
> +	return ret;
> +}
> +
> +/**
> + * omap_dm_timer_remove - cleanup a registered timer device
> + * @pdev:	pointer to current timer platform device
> + *
> + * Called by driver framework whenever a timer device is unregistered.
> + * In addition to freeing platform resources it also deletes the timer
> + * entry from the local list.
> + */
> +static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
> +{
> +	struct omap_dm_timer *timer, *tmp;
> +	unsigned long flags;
> +	int ret = -EINVAL;
> +
> +	spin_lock_irqsave(&dm_timer_lock, flags);
> +	list_for_each_entry_safe(timer, tmp, &omap_timer_list, node) {
> +		if (timer->pdev->id == pdev->id) {
> +			platform_device_del(timer->pdev);
> +			list_del(&timer->node);
> +			kfree(timer);
kfree(pdev->dev.platform_data);

-Manjunath
