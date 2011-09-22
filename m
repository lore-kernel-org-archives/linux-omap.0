From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v16 08/12] OMAP: dmtimer: do remaining initialization
 in probe
Date: Wed, 21 Sep 2011 18:00:05 -0700
Message-ID: <20110922010005.GO2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
 <1316518227-28116-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16390 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751098Ab1IVBAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 21:00:07 -0400
Content-Disposition: inline
In-Reply-To: <1316518227-28116-9-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
> @@ -514,10 +514,23 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
>  	timer->irq = irq->start;
>  	timer->pdev = pdev;
>  
> -	/* Skip pm_runtime_enable for OMAP1 */
> -	if (!pdata->needs_manual_reset) {
> -		pm_runtime_enable(&pdev->dev);
> -		pm_runtime_irq_safe(&pdev->dev);
> +/*
> + * sys_timer_reserved is not defined for OMAP1.
> + * Use the macro to avoid compilation error on OMAP1.
> + */
> +#if defined(CONFIG_ARCH_OMAP2PLUS)
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_irq_safe(&pdev->dev);
> +	/* Mark clocksource and clockevent timers as reserved */
> +	if ((sys_timer_reserved >> (pdev->id - 1)) & 0x1)
> +		timer->reserved = 1;
> +#endif
> +
> +	if (!timer->reserved) {
> +		pm_runtime_get_sync(&pdev->dev);
> +		__omap_dm_timer_init_regs(timer);
> +		timer->tidr = __raw_readl(timer->io_base);
> +		pm_runtime_put(&pdev->dev);
>  	}
>  
>  	/* add the timer element to the list */

This all should not be necessary. We can pass the reserved flag
in pdata. Let's replace this one with the patch below.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 21 Sep 2011 16:38:51 -0700
Subject: [PATCH] ARM: OMAP: dmtimer: skip reserved timers

Pass the reserved flag in pdata and use it. We can
now make sys_timer_reserved static to mach-omap2/timer.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 9c2f588..f1e3ec1 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -69,7 +69,7 @@
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
 
-u32 sys_timer_reserved;
+static u32 sys_timer_reserved;
 
 /* Clockevent code */
 
@@ -463,6 +463,10 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	pdata->set_timer_src = omap2_dm_timer_set_src;
 	pdata->timer_ip_version = oh->class->rev;
 
+	/* Mark clocksource and clockevent timers as reserved */
+	if ((sys_timer_reserved >> (id - 1)) & 0x1)
+		pdata->reserved = 1;
+
 	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
 			omap2_dmtimer_latency,
 			ARRAY_SIZE(omap2_dmtimer_latency),
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index ac904c2..c8df3c3 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -509,6 +509,7 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 
 	timer->id = pdev->id;
 	timer->irq = irq->start;
+	timer->reserved = pdata->reserved;
 	timer->pdev = pdev;
 
 	/* Skip pm_runtime_enable for OMAP1 */
@@ -517,6 +518,12 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		pm_runtime_irq_safe(&pdev->dev);
 	}
 
+	if (!timer->reserved) {
+		pm_runtime_get_sync(&pdev->dev);
+		__omap_dm_timer_init_regs(timer);
+		pm_runtime_put(&pdev->dev);
+	}
+
 	/* add the timer element to the list */
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_add_tail(&timer->node, &omap_timer_list);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 4e3a326..29764c3 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -77,6 +77,7 @@ struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	int timer_ip_version;
 	u32 needs_manual_reset:1;
+	bool reserved;
 };
 
 struct omap_dm_timer *omap_dm_timer_request(void);
@@ -248,7 +249,6 @@ struct omap_dm_timer {
 	struct list_head node;
 };
 
-extern u32 sys_timer_reserved;
 int omap_dm_timer_prepare(struct omap_dm_timer *timer);
 
 static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
