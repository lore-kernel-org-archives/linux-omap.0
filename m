From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] arm: omap3: am35x: Disable hlt when using Davinci
 EMAC
Date: Wed, 18 Jul 2012 17:25:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207181723120.19048@utopia.booyaka.com>
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com> <1336770778-23044-3-git-send-email-mgreer@animalcreek.com> <alpine.DEB.2.00.1207171814100.28834@utopia.booyaka.com> <20120718213246.GD27904@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58084 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab2GRXZR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 19:25:17 -0400
In-Reply-To: <20120718213246.GD27904@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, 18 Jul 2012, Mark A. Greer wrote:

> On Tue, Jul 17, 2012 at 09:54:53PM -0600, Paul Walmsley wrote:
> 
> > Want to try something like this?  It's your patch but modified to not use 
> > disable/enable_hlt().  If it doesn't work in your test case, maybe 
> > try uncommenting that second set of deny_idle / allow_idle ...
> 
> I tested the modified patch (to get it to compile) below.

Doh, sorry about that. 

> It did not work with or without the core_dpll_ck deny_idle/allow_idle
> commented out.

Here's a version with some of the CPUIdle states restricted.  Maybe try 
this one if you're using CPUIdle?

If it happens to work, it would also be interesting to know if it works 
with the CORE DPLL part commented out.


- Paul

---
 arch/arm/mach-omap2/am35xx-emac.c     |   56 ++++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/am35xx-emac.h     |   13 ++++++--
 arch/arm/mach-omap2/board-am3517evm.c |    3 +-
 arch/arm/mach-omap2/board-cm-t3517.c  |    3 +-
 arch/arm/mach-omap2/cpuidle34xx.c     |    5 +++
 5 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index 2c90ac6..6b0edcd 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -16,13 +16,50 @@
  */
 
 #include <linux/err.h>
+#include <linux/clk.h>
 #include <linux/davinci_emac.h>
 #include <asm/system.h>
+#include <plat/clock.h>
 #include <plat/omap_device.h>
 #include <mach/am35xx.h>
 #include "control.h"
 #include "am35xx-emac.h"
 
+static struct clk *mpu_dpll_ck, *core_dpll_ck;
+
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
+	mpu_dpll_ck->ops->deny_idle(mpu_dpll_ck);
+	core_dpll_ck->ops->deny_idle(core_dpll_ck);
+	return omap_device_idle_hwmods(od);
+}
+
+static int am35xx_emac_activate_func(struct omap_device *od)
+{
+	mpu_dpll_ck->ops->allow_idle(mpu_dpll_ck);
+	core_dpll_ck->ops->allow_idle(core_dpll_ck);
+	return omap_device_enable_hwmods(od);
+}
+
+struct omap_device_pm_latency am35xx_emac_pm_lats[] = {
+	{
+		.deactivate_func	= am35xx_emac_deactivate_func,
+		.activate_func		= am35xx_emac_activate_func,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+int am35xx_emac_pm_lats_size = ARRAY_SIZE(am35xx_emac_pm_lats);
+
 static void am35xx_enable_emac_int(void)
 {
 	u32 v;
@@ -58,12 +95,14 @@ static struct emac_platform_data am35xx_emac_pdata = {
 static struct mdio_platform_data am35xx_mdio_pdata;
 
 static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
-		void *pdata, int pdata_len)
+					     void *pdata, int pdata_len,
+					     struct omap_device_pm_latency *pm_lats,
+					     int pm_lats_size)
 {
 	struct platform_device *pdev;
 
 	pdev = omap_device_build(oh->class->name, 0, oh, pdata, pdata_len,
-				 NULL, 0, false);
+				 pm_lats, pm_lats_size, false);
 	if (IS_ERR(pdev)) {
 		WARN(1, "Can't build omap_device for %s:%s.\n",
 		     oh->class->name, oh->name);
@@ -73,7 +112,8 @@ static int __init omap_davinci_emac_dev_init(struct omap_hwmod *oh,
 	return 0;
 }
 
-void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
+void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en,
+		struct omap_device_pm_latency *pm_lats, int pm_lats_size)
 {
 	struct omap_hwmod *oh;
 	u32 v;
@@ -88,7 +128,7 @@ void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
 	am35xx_mdio_pdata.bus_freq = mdio_bus_freq;
 
 	ret = omap_davinci_emac_dev_init(oh, &am35xx_mdio_pdata,
-					 sizeof(am35xx_mdio_pdata));
+					 sizeof(am35xx_mdio_pdata), NULL, 0);
 	if (ret) {
 		pr_err("Could not build davinci_mdio hwmod device\n");
 		return;
@@ -103,12 +143,18 @@ void __init am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en)
 	am35xx_emac_pdata.rmii_en = rmii_en;
 
 	ret = omap_davinci_emac_dev_init(oh, &am35xx_emac_pdata,
-					 sizeof(am35xx_emac_pdata));
+					 sizeof(am35xx_emac_pdata),
+					 pm_lats, pm_lats_size);
 	if (ret) {
 		pr_err("Could not build davinci_emac hwmod device\n");
 		return;
 	}
 
+	mpu_dpll_ck = clk_get(NULL, "dpll1_ck");
+	WARN(!mpu_dpll_ck, "Can't get dpll1_ck\n");
+	core_dpll_ck = clk_get(NULL, "dpll3_ck");
+	WARN(!core_dpll_ck, "Can't get dpll3_ck\n");
+
 	v = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
 	v &= ~AM35XX_CPGMACSS_SW_RST;
 	omap_ctrl_writel(v, AM35XX_CONTROL_IP_SW_RESET);
diff --git a/arch/arm/mach-omap2/am35xx-emac.h b/arch/arm/mach-omap2/am35xx-emac.h
index 15c6f9c..446a429 100644
--- a/arch/arm/mach-omap2/am35xx-emac.h
+++ b/arch/arm/mach-omap2/am35xx-emac.h
@@ -5,11 +5,20 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <plat/omap_device.h>
 
 #define AM35XX_DEFAULT_MDIO_FREQUENCY	1000000
 
 #if defined(CONFIG_TI_DAVINCI_EMAC) || defined(CONFIG_TI_DAVINCI_EMAC_MODULE)
-void am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en);
+extern struct omap_device_pm_latency am35xx_emac_pm_lats[];
+extern int am35xx_emac_pm_lats_size;
+
+void am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en,
+		struct omap_device_pm_latency *pm_lats, int pm_lats_size);
 #else
-static inline void am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en) {}
+#define am35xx_emac_pm_lats		NULL
+#define am35xx_emac_pm_lats_size	0
+
+static inline am35xx_emac_init(unsigned long mdio_bus_freq, u8 rmii_en,
+		struct omap_device_pm_latency *pm_lats, int pm_lats_size) {}
 #endif
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 18f6010..5348d0d 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -368,7 +368,8 @@ static void __init am3517_evm_init(void)
 	i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
 				ARRAY_SIZE(am3517evm_i2c1_boardinfo));
 	/*Ethernet*/
-	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
+	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1,
+			 am35xx_emac_pm_lats, am35xx_emac_pm_lats_size);
 
 	/* MUSB */
 	am3517_evm_musb_init();
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index a33ad46..8258057 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -292,7 +292,8 @@ static void __init cm_t3517_init(void)
 	cm_t3517_init_rtc();
 	cm_t3517_init_usbh();
 	cm_t3517_init_hecc();
-	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
+	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1,
+			 am35xx_emac_pm_lats, am35xx_emac_pm_lats_size);
 }
 
 MACHINE_START(CM_T3517, "Compulab CM-T3517")
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f2a49a4..d95dd8c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -291,6 +291,7 @@ struct cpuidle_driver omap3_idle_driver = {
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C3",
 			.desc		  = "MPU RET + CORE ON",
+			.disable	  = 1,
 		},
 		{
 			.enter		  = omap3_enter_idle_bm,
@@ -299,6 +300,7 @@ struct cpuidle_driver omap3_idle_driver = {
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C4",
 			.desc		  = "MPU OFF + CORE ON",
+			.disable	  = 1,
 		},
 		{
 			.enter		  = omap3_enter_idle_bm,
@@ -307,6 +309,7 @@ struct cpuidle_driver omap3_idle_driver = {
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C5",
 			.desc		  = "MPU RET + CORE RET",
+			.disable	  = 1,
 		},
 		{
 			.enter		  = omap3_enter_idle_bm,
@@ -315,6 +318,7 @@ struct cpuidle_driver omap3_idle_driver = {
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C6",
 			.desc		  = "MPU OFF + CORE RET",
+			.disable	  = 1,
 		},
 		{
 			.enter		  = omap3_enter_idle_bm,
@@ -323,6 +327,7 @@ struct cpuidle_driver omap3_idle_driver = {
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
 			.name		  = "C7",
 			.desc		  = "MPU OFF + CORE OFF",
+			.disable	  = 1,
 		},
 	},
 	.state_count = ARRAY_SIZE(omap3_idle_data),
-- 
1.7.10.4

