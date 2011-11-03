From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: OMAP2+: devices: Fixes for McPDM
Date: Thu,  3 Nov 2011 10:41:22 +0200
Message-ID: <1320309682-30513-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57041 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754788Ab1KCIly (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 04:41:54 -0400
Received: by mail-fx0-f54.google.com with SMTP id r19so2563325faa.27
        for <linux-omap@vger.kernel.org>; Thu, 03 Nov 2011 01:41:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Clean up the omap-mcpdm init function since this part comes via sound
tree, and there has been changes regarding to hwmod/omap_device_build.

Missed patches:
The ARM: OMAP2+: devices: Remove all omap_device_pm_latency structures
OMAP: omap_device: when building return platform_device instead of
omap_device

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Benoit Cousson <b-cousson@ti.com>
CC: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/devices.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 68ec031..c15cfad 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -318,18 +318,10 @@ static inline void omap_init_audio(void) {}
 #if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
 		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
 
-static struct omap_device_pm_latency omap_mcpdm_latency[] = {
-	{
-		.deactivate_func = omap_device_idle_hwmods,
-		.activate_func = omap_device_enable_hwmods,
-		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static void omap_init_mcpdm(void)
 {
 	struct omap_hwmod *oh;
-	struct omap_device *od;
+	struct platform_device *pdev;
 
 	oh = omap_hwmod_lookup("mcpdm");
 	if (!oh) {
@@ -337,11 +329,8 @@ static void omap_init_mcpdm(void)
 		return;
 	}
 
-	od = omap_device_build("omap-mcpdm", -1, oh, NULL, 0,
-				omap_mcpdm_latency,
-				ARRAY_SIZE(omap_mcpdm_latency), 0);
-	if (IS_ERR(od))
-		printk(KERN_ERR "Could not build omap_device for omap-mcpdm-dai\n");
+	pdev = omap_device_build("omap-mcpdm", -1, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(pdev), "Can't build omap_device for omap-mcpdm.\n");
 }
 #else
 static inline void omap_init_mcpdm(void) {}
-- 
1.7.7.1

