From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v11 5/8] OMAP: dmtimer: platform driver
Date: Thu, 03 Mar 2011 16:35:03 -0800
Message-ID: <87mxlboh8o.fsf@ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:48132 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758891Ab1CDAfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 19:35:07 -0500
Received: by mail-gw0-f50.google.com with SMTP id a20so890579gwa.9
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 16:35:06 -0800 (PST)
In-Reply-To: <1298546811-27055-6-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 24 Feb 2011 16:56:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Thara Gopinath <thara@ti.com>
>
> Add dmtimer platform driver functions which include:
> (1) platform driver initialization
> (2) driver probe function
> (3) driver remove function
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>

Some locking issues below...

> ---
>  arch/arm/plat-omap/dmtimer.c              |  167 ++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/dmtimer.h |    2 +
>  2 files changed, 168 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 1bfaf09..bfe6fd3 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -43,6 +43,9 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
>  #include <mach/hardware.h>
>  #include <plat/dmtimer.h>
>  #include <mach/irqs.h>
> @@ -257,7 +260,8 @@ static struct omap_dm_timer *dm_timers;
>  static const char **dm_source_names;
>  static struct clk **dm_source_clocks;
>  
> -static spinlock_t dm_timer_lock;
> +static LIST_HEAD(omap_timer_list);
> +static DEFINE_SPINLOCK(dm_timer_lock);

This spinlock is being used as a mutex.  Please use a mutex instead.

>  /*
>   * Reads timer registers in posted and non-posted mode. The posted mode bit
> @@ -689,6 +693,167 @@ int omap_dm_timers_active(void)
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
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "%s: no platform data\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	spin_lock_irqsave(&dm_timer_lock, flags);

Why do you need IRQ versions of the locks?   This lock is never used in
interrupt context.

Kevin
