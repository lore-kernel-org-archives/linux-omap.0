From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 3/5] OMAP4: devices: Register OMAP4 DMIC platform device
Date: Fri, 25 Nov 2011 14:20:34 +0200
Message-ID: <1322223636-31623-4-git-send-email-peter.ujfalusi@ti.com>
References: <1322223636-31623-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60526 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755132Ab1KYMVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 07:21:16 -0500
Received: by bkbzu5 with SMTP id zu5so4763647bkb.4
        for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 04:21:14 -0800 (PST)
In-Reply-To: <1322223636-31623-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Add platform device registration for OMAP4 DMIC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/devices.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c15cfad..35d5dff 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -336,6 +336,27 @@ static void omap_init_mcpdm(void)
 static inline void omap_init_mcpdm(void) {}
 #endif
 
+#if defined(CONFIG_SND_OMAP_SOC_DMIC) || \
+		defined(CONFIG_SND_OMAP_SOC_DMIC_MODULE)
+
+static void omap_init_dmic(void)
+{
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+
+	oh = omap_hwmod_lookup("dmic");
+	if (!oh) {
+		printk(KERN_ERR "Could not look up mcpdm hw_mod\n");
+		return;
+	}
+
+	pdev = omap_device_build("omap-dmic", -1, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(pdev), "Can't build omap_device for omap-dmic.\n");
+}
+#else
+static inline void omap_init_dmic(void) {}
+#endif
+
 #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
 #include <plat/mcspi.h>
@@ -681,6 +702,7 @@ static int __init omap2_init_devices(void)
 	 */
 	omap_init_audio();
 	omap_init_mcpdm();
+	omap_init_dmic();
 	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
-- 
1.7.8.rc3

