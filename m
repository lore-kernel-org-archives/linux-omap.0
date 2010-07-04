From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/5] omap: OMAP_DSP is not in mainline, remove it
Date: Sun,  4 Jul 2010 16:36:22 +0300
Message-ID: <1278250586-17062-2-git-send-email-felipe.contreras@gmail.com>
References: <1278250586-17062-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65451 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757840Ab0GDNgb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:36:31 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so2295721bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:36:31 -0700 (PDT)
In-Reply-To: <1278250586-17062-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>, Tony Lindgren <tony@atomide.com>

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/plat-omap/devices.c |   62 ------------------------------------------
 1 files changed, 0 insertions(+), 62 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 95677d1..a3997ec 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -31,67 +31,6 @@
 #include <plat/dsp_common.h>
 #include <plat/omap44xx.h>
 
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
 /*-------------------------------------------------------------------------*/
 #if	defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
 
@@ -419,7 +358,6 @@ static int __init omap_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_init_dsp();
 	omap_init_kp();
 	omap_init_rng();
 	omap_init_mcpdm();
-- 
1.7.1

