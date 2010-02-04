From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 3/3] OMAP3: PM: Wakeup from TWL4030 keypad with OFF mode
Date: Thu,  4 Feb 2010 21:37:03 +0530
Message-ID: <1265299623-30124-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40741 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758266Ab0BDQHH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 11:07:07 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o14G747D023511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 4 Feb 2010 10:07:06 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch allows wakeup from TWL4030 keypad when
OFF mode is hit during suspend.

Tested on OMAP3EVM.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   86 ++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 00bfe9b..b89fa29 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -40,12 +40,15 @@
 #include <plat/board.h>
 #include <plat/usb.h>
 #include <plat/common.h>
+#include <plat/control.h>
 #include <plat/mcspi.h>
 
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
+#include "prm-regbits-34xx.h"
+
 #define OMAP3_EVM_TS_GPIO	175
 #define OMAP3_EVM_EHCI_VBUS	22
 #define OMAP3_EVM_EHCI_SELECT	61
@@ -218,6 +221,84 @@ static struct platform_device leds_gpio = {
 	},
 };
 
+#ifdef CONFIG_PM
+/*
+ * Save the state of keypad
+ *
+ * TODO: This definition should ideally be in a header file, but
+ *       matrix_keypad.h is not the right one. Also, plat/keypad.h
+ *       is no longer used.
+ */
+struct omap_keypad_pm_state {
+	void __iomem *wk_st;
+	void __iomem *wk_en;
+	u32 wk_mask;
+	u32 padconf;
+};
+
+/*
+ * Board specific hook for keypad suspend
+ */
+void omap3_evm_kp_suspend(void *ptr)
+{
+	struct omap_keypad_pm_state *pstate =
+			(struct omap_keypad_pm_state *)ptr;
+
+	if (pstate) {
+		/*
+		 * Set wake-enable bit
+		 */
+		if (pstate->wk_en && pstate->wk_mask) {
+			u32 v = __raw_readl(pstate->wk_en);
+			v |= pstate->wk_mask;
+			__raw_writel(v, pstate->wk_en);
+		}
+		/*
+		 * Set corresponding IOPAD wakeup-enable
+		 */
+		if (cpu_is_omap34xx() && pstate->padconf) {
+			u16 v = omap_ctrl_readw(pstate->padconf);
+			v |= OMAP3_PADCONF_WAKEUPENABLE0;
+			omap_ctrl_writew(v, pstate->padconf);
+		}
+	}
+}
+
+/*
+ * Board specific hook for keypad resume
+ */
+void omap3_evm_kp_resume(void *ptr)
+{
+	struct omap_keypad_pm_state *pstate =
+			(struct omap_keypad_pm_state *)ptr;
+
+	if (pstate) {
+		/*
+		 * Clear wake-enable bit
+		 */
+		if (pstate->wk_en && pstate->wk_mask) {
+			u32 v = __raw_readl(pstate->wk_en);
+			v &= ~pstate->wk_mask;
+			__raw_writel(v, pstate->wk_en);
+		}
+		/*
+		 * Clear corresponding IOPAD wakeup-enable
+		 */
+		if (cpu_is_omap34xx() && pstate->padconf) {
+			u16 v = omap_ctrl_readw(pstate->padconf);
+			v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
+			omap_ctrl_writew(v, pstate->padconf);
+		}
+	}
+}
+
+static struct omap_keypad_pm_state omap3evm_kp_pm_state = {
+	.wk_st		= OMAP34XX_PRM_REGADDR(WKUP_MOD, PM_WKEN1),
+	.wk_en		= OMAP34XX_PRM_REGADDR(WKUP_MOD, PM_WKST1),
+	.wk_mask	= OMAP3430_EN_GPIO1,
+	.padconf	= 0x1e0,
+};
+#endif	/* CONFIG_PM */
 
 static int omap3evm_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
@@ -288,6 +369,11 @@ static struct twl4030_keypad_data omap3evm_kp_data = {
 	.rows		= 4,
 	.cols		= 4,
 	.rep		= 1,
+#ifdef CONFIG_PM
+	.pm_state	= (void *)&omap3evm_kp_pm_state,
+	.on_suspend	= omap3_evm_kp_suspend,
+	.on_resume	= omap3_evm_kp_resume,
+#endif	/* CONFIG_PM */
 };
 
 static struct twl4030_madc_platform_data omap3evm_madc_data = {
-- 
1.6.2.2

