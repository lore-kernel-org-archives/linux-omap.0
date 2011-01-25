From: David Lambert <dlambert@ti.com>
Subject: [PATCH v3 3/4] OMAP4: DMIC: initializes the DMIC driver
Date: Tue, 25 Jan 2011 16:01:01 -0600
Message-ID: <1295992862-6154-4-git-send-email-dlambert@ti.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59221 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab1AYWBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 17:01:36 -0500
In-Reply-To: <1295992862-6154-1-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, David Lambert <dlambert@ti.com>

This code is used to read the HWMOD database and initialize
the DMIC driver.

Signed-off-by: David Lambert <dlambert@ti.com>
---
 arch/arm/plat-omap/devices.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index fc81912..b347f75 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -72,6 +72,40 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 
 /*-------------------------------------------------------------------------*/
 
+#if defined(CONFIG_SND_OMAP_SOC_DMIC) || \
+	defined(CONFIG_SND_OMAP_SOC_DMIC_MODULE)
+
+static struct omap_device_pm_latency omap_dmic_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static void omap_init_dmic(void)
+{
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+
+	oh = omap_hwmod_lookup("omap-dmic");
+	if (!oh) {
+		printk(KERN_ERR "Could not look up dmic hw_mod\n");
+		return;
+	}
+
+	od = omap_device_build("omap-dmic-dai", -1, oh, NULL, 0,
+				omap_dmic_latency,
+				ARRAY_SIZE(omap_dmic_latency), 0);
+	if (IS_ERR(od))
+		printk(KERN_ERR "Could not build omap_device for omap-dmic-dai\n");
+}
+#else
+static inline void omap_init_dmic(void) {}
+#endif
+
+/*-------------------------------------------------------------------------*/
+
 #if defined(CONFIG_SND_OMAP_SOC_MCPDM) || \
 		defined(CONFIG_SND_OMAP_SOC_MCPDM_MODULE)
 
@@ -328,6 +362,7 @@ static int __init omap_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	omap_init_dmic();
 	omap_init_rng();
 	omap_init_mcpdm();
 	omap_init_uwire();
-- 
1.7.0.4

