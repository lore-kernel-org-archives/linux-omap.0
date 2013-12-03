From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] ARM: OMAP2+: Use pdata quirks for emac on am3517
Date: Tue,  3 Dec 2013 15:23:17 -0800
Message-ID: <1386112999-17271-4-git-send-email-tony@atomide.com>
References: <1386112999-17271-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51171 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab3LCXXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 18:23:24 -0500
In-Reply-To: <1386112999-17271-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

As the emac uses the system control module registers for
reset and interrupts, we need to pass those in the platform
data until we have a separate system control module driver.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index ecdba9f..ec83c20 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/clk.h>
+#include <linux/davinci_emac.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -16,6 +17,7 @@
 
 #include <linux/platform_data/pinctrl-single.h>
 
+#include "am35xx.h"
 #include "common.h"
 #include "common-board-devices.h"
 #include "dss-common.h"
@@ -118,6 +120,42 @@ static void __init omap3_zoom_legacy_init(void)
 {
 	legacy_init_wl12xx(WL12XX_REFCLOCK_26, 0, 162);
 }
+
+static void am35xx_enable_emac_int(void)
+{
+	u32 v;
+
+	v = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
+	v |= (AM35XX_CPGMAC_C0_RX_PULSE_CLR | AM35XX_CPGMAC_C0_TX_PULSE_CLR |
+	      AM35XX_CPGMAC_C0_MISC_PULSE_CLR | AM35XX_CPGMAC_C0_RX_THRESH_CLR);
+	omap_ctrl_writel(v, AM35XX_CONTROL_LVL_INTR_CLEAR);
+	omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR); /* OCP barrier */
+}
+
+static void am35xx_disable_emac_int(void)
+{
+	u32 v;
+
+	v = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
+	v |= (AM35XX_CPGMAC_C0_RX_PULSE_CLR | AM35XX_CPGMAC_C0_TX_PULSE_CLR);
+	omap_ctrl_writel(v, AM35XX_CONTROL_LVL_INTR_CLEAR);
+	omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR); /* OCP barrier */
+}
+
+static struct emac_platform_data am35xx_emac_pdata = {
+	.interrupt_enable	= am35xx_enable_emac_int,
+	.interrupt_disable	= am35xx_disable_emac_int,
+};
+
+static void __init am3517_evm_legacy_init(void)
+{
+	u32 v;
+
+	v = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
+	v &= ~AM35XX_CPGMACSS_SW_RST;
+	omap_ctrl_writel(v, AM35XX_CONTROL_IP_SW_RESET);
+	omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET); /* OCP barrier */
+}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -186,6 +224,10 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002030, "48002030.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002a00, "48002a00.pinmux", &pcs_pdata),
+	/* Only on am3517 */
+	OF_DEV_AUXDATA("ti,davinci_mdio", 0x5c030000, "davinci_mdio.0", NULL),
+	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
+		       &am35xx_emac_pdata),
 #endif
 #ifdef CONFIG_ARCH_OMAP4
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a100040, "4a100040.pinmux", &pcs_pdata),
@@ -207,6 +249,7 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
 	{ "ti,omap3-ldp", omap3_ldp_legacy_init, },
 	{ "ti,omap3-zoom3", omap3_zoom_legacy_init, },
+	{ "ti,am3517-evm", am3517_evm_legacy_init, },
 #endif
 #ifdef CONFIG_ARCH_OMAP4
 	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
-- 
1.8.1.1

