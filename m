From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH v2 2/2] arm: omap3: am35x: Disable hlt when using Davinci EMAC
Date: Tue, 15 May 2012 11:14:02 -0700
Message-ID: <1337105642-22711-3-git-send-email-mgreer@animalcreek.com>
References: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:37861 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965105Ab2EOSPQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 14:15:16 -0400
In-Reply-To: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

The am35x family of SoCs has a Davinci EMAC ethernet
controller on-chip.  Unfortunately, the EMAC is unable
to wake the PRCM when there is network activity which
leads to a hung or extremely slow system when the MPU
has executed a 'wfi' instruction (because of pm_idle
or CPUidle).  To prevent this, add hooks to the EMAC
pm_runtime suspend/resume calls so that hlt is disabled
whenever the EMAC is in use.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/am35xx-emac.c |   40 +++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index 3bb5cb3..887a057 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -23,6 +23,35 @@
 #include "control.h"
 #include "am35xx-emac.h"
 
+/*
+ * Default pm_lats for the am35x.
+ * The net effect of using am35xx_emac_pm_lats[] is that
+ * pm_idle or CPUidle won't be called while the emac
+ * interface is open.  This is required because the
+ * EMAC can't wake up PRCM so if the MPU is executing
+ * a 'wfi' instruction (e.g., from pm_idle or CPUidle),
+ * it won't break out of it due to emac activity.
+ */
+static int am35xx_emac_deactivate_func(struct omap_device *od)
+{
+	enable_hlt();
+	return omap_device_idle_hwmods(od);
+}
+
+static int am35xx_emac_activate_func(struct omap_device *od)
+{
+	disable_hlt();
+	return omap_device_enable_hwmods(od);
+}
+
+static struct omap_device_pm_latency am35xx_emac_pm_lats[] = {
+	{
+		.deactivate_func	= am35xx_emac_deactivate_func,
+		.activate_func		= am35xx_emac_activate_func,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
 static void am35xx_enable_emac_int(void)
 {
 	u32 regval;
@@ -61,12 +90,13 @@ static struct emac_platform_data am35xx_emac_pdata = {
 static struct mdio_platform_data am35xx_mdio_pdata;
 
 static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
-		void *pdata, int pdata_len)
+		void *pdata, int pdata_len,
+		struct omap_device_pm_latency *pm_lats, int pm_lats_size)
 {
 	struct platform_device *pdev;
 
 	pdev = omap_device_build(oh->class->name, 0, oh, pdata, pdata_len,
-			NULL, 0, false);
+			pm_lats, pm_lats_size, false);
 	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n",
 					oh->class->name, oh->name);
@@ -91,7 +121,7 @@ void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
 	am35xx_mdio_pdata.bus_freq = mdio_bus_freq;
 
 	ret = omap_davinci_emac_dev_init(oh, &am35xx_mdio_pdata,
-					 sizeof(am35xx_mdio_pdata));
+					 sizeof(am35xx_mdio_pdata), NULL, 0);
 	if (ret) {
 		pr_err("Could not build davinci_mdio hwmod device\n");
 		return;
@@ -106,7 +136,9 @@ void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
 	am35xx_emac_pdata.rmii_en = rmii_en;
 
 	ret = omap_davinci_emac_dev_init(oh, &am35xx_emac_pdata,
-					 sizeof(am35xx_emac_pdata));
+					 sizeof(am35xx_emac_pdata),
+					 am35xx_emac_pm_lats,
+					 ARRAY_SIZE(am35xx_emac_pm_lats));
 	if (ret) {
 		pr_err("Could not build davinci_emac hwmod device\n");
 		return;
-- 
1.7.9.4

