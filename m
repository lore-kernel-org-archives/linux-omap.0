From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/5] omap: OMAP_DSP is not in mainline, remove it
Date: Sun, 16 May 2010 18:46:57 +0300
Message-ID: <1274024821-21178-2-git-send-email-felipe.contreras@gmail.com>
References: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52160 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab0EPPrJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:47:09 -0400
Received: by fxm6 with SMTP id 6so2978236fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:47:08 -0700 (PDT)
In-Reply-To: <1274024821-21178-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Tony Lindgren <tony@atomide.com>

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/devices.c |   62 ------------------------------------------
 1 files changed, 0 insertions(+), 62 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index dc2e631..b552976 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -30,67 +30,6 @@
 #include <plat/mcbsp.h>
 #include <plat/dsp_common.h>
 
-#if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
-
-static struct dsp_platform_data dsp_pdata = {
-	.kdev_list = LIST_HEAD_INIT(dsp_pdata.kdev_list),
-};
-
-static struct resource omap_dsp_resources[] = {
-	{
-		.name	= "dsp_mmu",
-		.start	= -1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device omap_dsp_device = {
-	.name		= "dsp",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(omap_dsp_resources),
-	.resource	= omap_dsp_resources,
-	.dev = {
-		.platform_data = &dsp_pdata,
-	},
-};
-
-static inline void omap_init_dsp(void)
-{
-	struct resource *res;
-	int irq;
-
-	if (cpu_is_omap15xx())
-		irq = INT_1510_DSP_MMU;
-	else if (cpu_is_omap16xx())
-		irq = INT_1610_DSP_MMU;
-	else if (cpu_is_omap24xx())
-		irq = INT_24XX_DSP_MMU;
-
-	res = platform_get_resource_byname(&omap_dsp_device,
-					   IORESOURCE_IRQ, "dsp_mmu");
-	res->start = irq;
-
-	platform_device_register(&omap_dsp_device);
-}
-
-int dsp_kfunc_device_register(struct dsp_kfunc_device *kdev)
-{
-	static DEFINE_MUTEX(dsp_pdata_lock);
-
-	spin_lock_init(&kdev->lock);
-
-	mutex_lock(&dsp_pdata_lock);
-	list_add_tail(&kdev->entry, &dsp_pdata.kdev_list);
-	mutex_unlock(&dsp_pdata_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL(dsp_kfunc_device_register);
-
-#else
-static inline void omap_init_dsp(void) { }
-#endif	/* CONFIG_OMAP_DSP */
-
 #if defined(CONFIG_MPU_BRIDGE) ||  defined(CONFIG_MPU_BRIDGE_MODULE)
 
 static unsigned long dspbridge_phys_mempool_base;
@@ -410,7 +349,6 @@ static int __init omap_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_init_dsp();
 	omap_init_kp();
 	omap_init_rng();
 	omap_init_uwire();
-- 
1.7.1

