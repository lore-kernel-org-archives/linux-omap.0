From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/11] ARM: OMAP: Move omap-pm-noop.c local to
 mach-omap2
Date: Wed, 31 Oct 2012 13:58:50 -0700
Message-ID: <20121031205850.GO12739@atomide.com>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
 <20121030235255.25936.36727.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46118 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760559Ab2JaU6y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 16:58:54 -0400
Content-Disposition: inline
In-Reply-To: <20121030235255.25936.36727.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@infradead.org>

* Tony Lindgren <tony@atomide.com> [121030 16:55]:
> This code should be private to mach-omap2.
> 
> The only use for it in for omap1 has been in dmtimer.c
> to check for context loss. However, omap1 does not
> lose context during idle, so the code is not needed.
> Further, omap1 timer has OMAP_TIMER_ALWON set, so omap1
> was not hitting omap_pm_get_dev_context_loss_count()
> test.

Noticed one issue with my test compiles in the
omap-for-v3.8/cleanup-headers branch that can be
fixed along with this patch.

--- a/drivers/media/platform/omap3isp/ispvideo.c
+++ b/drivers/media/platform/omap3isp/ispvideo.c
@@ -36,7 +36,6 @@
 #include <media/v4l2-ioctl.h>
 #include <plat/iommu.h>
 #include <plat/iovmm.h>
-#include <plat/omap-pm.h>
 
 #include "ispvideo.h"
 #include "isp.h"

I'll fold that into this patch.

Regards,

Tony

 
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Makefile              |    1 +
>  arch/arm/mach-omap2/omap-pm-noop.c        |    4 ++--
>  arch/arm/mach-omap2/timer.c               |    2 ++
>  arch/arm/plat-omap/Makefile               |    1 -
>  arch/arm/plat-omap/dmtimer.c              |   17 ++++++++++-------
>  arch/arm/plat-omap/include/plat/dmtimer.h |    2 ++
>  6 files changed, 17 insertions(+), 10 deletions(-)
>  rename arch/arm/{plat-omap/omap-pm-noop.c => mach-omap2/omap-pm-noop.c} (99%)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index e3de5d4..b118ed5 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= sleep44xx.o
>  obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o sleep44xx.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
> +obj-$(CONFIG_OMAP_PM_NOOP)		+= omap-pm-noop.o
>  
>  obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
>  obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)	+= smartreflex-class3.o
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/mach-omap2/omap-pm-noop.c
> similarity index 99%
> rename from arch/arm/plat-omap/omap-pm-noop.c
> rename to arch/arm/mach-omap2/omap-pm-noop.c
> index 198685b..6a3be2b 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/mach-omap2/omap-pm-noop.c
> @@ -22,8 +22,8 @@
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  
> -#include "../mach-omap2/omap_device.h"
> -#include "../mach-omap2/omap-pm.h"
> +#include "omap_device.h"
> +#include "omap-pm.h"
>  
>  static bool off_mode_enabled;
>  static int dummy_context_loss_counter;
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 565e575..95e4478 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -559,6 +559,8 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
>  	if (timer_dev_attr)
>  		pdata->timer_capability = timer_dev_attr->timer_capability;
>  
> +	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
> +
>  	pdev = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
>  				 NULL, 0, 0);
>  
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 4bd0ace..50da9bf 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -19,4 +19,3 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
>  # OMAP mailbox framework
>  obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
>  
> -obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index 4a0b30a..9a0bbc4 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -45,8 +45,6 @@
>  
>  #include <mach/hardware.h>
>  
> -#include "../mach-omap2/omap-pm.h"
> -
>  static u32 omap_reserved_systimers;
>  static LIST_HEAD(omap_timer_list);
>  static DEFINE_SPINLOCK(dm_timer_lock);
> @@ -349,7 +347,8 @@ int omap_dm_timer_start(struct omap_dm_timer *timer)
>  	omap_dm_timer_enable(timer);
>  
>  	if (!(timer->capability & OMAP_TIMER_ALWON)) {
> -		if (omap_pm_get_dev_context_loss_count(&timer->pdev->dev) !=
> +		if (timer->get_context_loss_count &&
> +			timer->get_context_loss_count(&timer->pdev->dev) !=
>  				timer->ctx_loss_count)
>  			omap_timer_restore_context(timer);
>  	}
> @@ -378,9 +377,11 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
>  
>  	__omap_dm_timer_stop(timer, timer->posted, rate);
>  
> -	if (!(timer->capability & OMAP_TIMER_ALWON))
> -		timer->ctx_loss_count =
> -			omap_pm_get_dev_context_loss_count(&timer->pdev->dev);
> +	if (!(timer->capability & OMAP_TIMER_ALWON)) {
> +		if (timer->get_context_loss_count)
> +			timer->ctx_loss_count =
> +				timer->get_context_loss_count(&timer->pdev->dev);
> +	}
>  
>  	/*
>  	 * Since the register values are computed and written within
> @@ -496,7 +497,8 @@ int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
>  	omap_dm_timer_enable(timer);
>  
>  	if (!(timer->capability & OMAP_TIMER_ALWON)) {
> -		if (omap_pm_get_dev_context_loss_count(&timer->pdev->dev) !=
> +		if (timer->get_context_loss_count &&
> +			timer->get_context_loss_count(&timer->pdev->dev) !=
>  				timer->ctx_loss_count)
>  			omap_timer_restore_context(timer);
>  	}
> @@ -730,6 +732,7 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
>  	timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
>  	timer->pdev = pdev;
>  	timer->capability = pdata->timer_capability;
> +	timer->get_context_loss_count = pdata->get_context_loss_count;
>  
>  	/* Skip pm_runtime_enable for OMAP1 */
>  	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index 85868e9..3f5b9cf 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -94,6 +94,7 @@ struct dmtimer_platform_data {
>  	/* set_timer_src - Only used for OMAP1 devices */
>  	int (*set_timer_src)(struct platform_device *pdev, int source);
>  	u32 timer_capability;
> +	int (*get_context_loss_count)(struct device *);
>  };
>  
>  int omap_dm_timer_reserve_systimer(int id);
> @@ -263,6 +264,7 @@ struct omap_dm_timer {
>  	unsigned reserved:1;
>  	unsigned posted:1;
>  	struct timer_regs context;
> +	int (*get_context_loss_count)(struct device *);
>  	int ctx_loss_count;
>  	int revision;
>  	u32 capability;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
