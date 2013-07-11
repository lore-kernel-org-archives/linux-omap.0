From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: OMAP2+: Remove legacy device creation for McPDM and DMIC
Date: Thu, 11 Jul 2013 16:04:48 +0200
Message-ID: <1373551488-3816-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56453 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755025Ab3GKOFb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 10:05:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

McPDM and DMIC only available on OMAP4/5 which no longer boots in legacy
mode.
The code to create the devices in legacy mode can be removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/devices.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index aef96e4..dbcadcc 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -328,44 +328,6 @@ static void omap_init_audio(void)
 static inline void omap_init_audio(void) {}
 #endif
 
-#if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
-		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
-
-static void __init omap_init_mcpdm(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-
-	oh = omap_hwmod_lookup("mcpdm");
-	if (!oh)
-		return;
-
-	pdev = omap_device_build("omap-mcpdm", -1, oh, NULL, 0);
-	WARN(IS_ERR(pdev), "Can't build omap_device for omap-mcpdm.\n");
-}
-#else
-static inline void omap_init_mcpdm(void) {}
-#endif
-
-#if defined(CONFIG_SND_OMAP_SOC_DMIC) || \
-		defined(CONFIG_SND_OMAP_SOC_DMIC_MODULE)
-
-static void __init omap_init_dmic(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-
-	oh = omap_hwmod_lookup("dmic");
-	if (!oh)
-		return;
-
-	pdev = omap_device_build("omap-dmic", -1, oh, NULL, 0);
-	WARN(IS_ERR(pdev), "Can't build omap_device for omap-dmic.\n");
-}
-#else
-static inline void omap_init_dmic(void) {}
-#endif
-
 #if defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI) || \
 		defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI_MODULE)
 
@@ -566,8 +528,6 @@ static int __init omap2_init_devices(void)
 	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
-		omap_init_dmic();
-		omap_init_mcpdm();
 		omap_init_mcspi();
 		omap_init_sham();
 		omap_init_aes();
-- 
1.8.2.1

