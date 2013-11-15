From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/11] ARM: OMAP2+: Add quirks support for n8x0
Date: Thu, 14 Nov 2013 16:09:53 -0800
Message-ID: <1384474198-20756-7-git-send-email-tony@atomide.com>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42261 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab3KOAKH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 19:10:07 -0500
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

This allows us to keep things working when booted with
device tree. Note that we still need to initialize most
things with platform data as the drivers are lacking
support for device tree.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c           | 21 ++++++++++++++++++++-
 arch/arm/mach-omap2/common-board-devices.h |  1 +
 arch/arm/mach-omap2/pdata-quirks.c         | 14 ++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index c9eef2b..da0d494 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -529,7 +529,7 @@ static void n8x0_mmc_cleanup(struct device *dev)
  * MMC controller2 is not in use.
  */
 static struct omap_mmc_platform_data mmc1_data = {
-	.nr_slots			= 2,
+	.nr_slots			= 0,
 	.switch_slot			= n8x0_mmc_switch_slot,
 	.init				= n8x0_mmc_late_init,
 	.cleanup			= n8x0_mmc_cleanup,
@@ -596,6 +596,7 @@ static void __init n8x0_mmc_init(void)
 		}
 	}
 
+	mmc1_data.nr_slots = 2;
 	mmc_data[0] = &mmc1_data;
 	if (!of_have_populated_dt())
 		omap242x_init_mmc(mmc_data);
@@ -746,6 +747,24 @@ static int __init n8x0_late_initcall(void)
 }
 omap_late_initcall(n8x0_late_initcall);
 
+/*
+ * Legacy init pdata init for n8x0. Note that we want to follow the
+ * I2C bus numbering starting at 0 for device tree like other omaps.
+ */
+void * __init n8x0_legacy_init(void)
+{
+	board_check_revision();
+	spi_register_board_info(n800_spi_board_info,
+				ARRAY_SIZE(n800_spi_board_info));
+	i2c_register_board_info(0, n8x0_i2c_board_info_1,
+				ARRAY_SIZE(n8x0_i2c_board_info_1));
+	if (board_is_n810())
+		i2c_register_board_info(1, n810_i2c_board_info_2,
+					ARRAY_SIZE(n810_i2c_board_info_2));
+
+	return &mmc1_data;
+}
+
 static void __init n8x0_init_machine(void)
 {
 	board_check_revision();
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
index 72bb41b..f338177 100644
--- a/arch/arm/mach-omap2/common-board-devices.h
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -10,5 +10,6 @@ struct ads7846_platform_data;
 
 void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
 		       struct ads7846_platform_data *board_pdata);
+void *n8x0_legacy_init(void);
 
 #endif /* __OMAP_COMMON_BOARD_DEVICES__ */
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index cb2863d..7f0ff2a 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -26,6 +26,8 @@ struct pdata_init {
 	void (*fn)(void);
 };
 
+struct of_dev_auxdata omap_auxdata_lookup[];
+
 /*
  * Create alias for USB host PHY clock.
  * Remove this when clock phandle can be provided via DT
@@ -68,6 +70,13 @@ static inline void legacy_init_wl12xx(unsigned ref_clock,
 }
 #endif
 
+#ifdef CONFIG_SOC_OMAP2420
+static void __init omap2420_n8x0_legacy_init(void)
+{
+	omap_auxdata_lookup[0].platform_data = n8x0_legacy_init();
+}
+#endif
+
 #ifdef CONFIG_ARCH_OMAP3
 static void __init hsmmc2_internal_input_clk(void)
 {
@@ -130,6 +139,11 @@ void omap_pcs_legacy_init(int irq, void (*rearm)(void))
  * the dev entries in of_platform_populate().
  */
 static struct pdata_init auxdata_quirks[] __initdata = {
+#ifdef CONFIG_SOC_OMAP2420
+	{ "nokia,n800", omap2420_n8x0_legacy_init, },
+	{ "nokia,n810", omap2420_n8x0_legacy_init, },
+	{ "nokia,n810-wimax", omap2420_n8x0_legacy_init, },
+#endif
 	{ /* sentinel */ },
 };
 
-- 
1.8.1.1

