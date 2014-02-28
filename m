From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv3 11/13] ARM: OMAP2+: use pdata quirks for iommu reset lines
Date: Fri, 28 Feb 2014 14:42:42 -0600
Message-ID: <1393620164-14633-12-git-send-email-s-anna@ti.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57103 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbaB1UpB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 15:45:01 -0500
In-Reply-To: <1393620164-14633-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The OMAP iommu driver performs the reset management for the
iommu instances in processor sub-systems using the omap_device
API which are currently supplied as platform data ops. Use pdata
quirks to maintain the functionality as the OMAP iommu driver
gets converted to use DT nodes, until the reset portions are
decoupled from omap_hwmod/omap_device into a separate reset
driver.

This patch adds the pdata quirks for the reset management of
iommus within the DSP (OMAP3 & OMAP4) and IPU subsystems (OMAP4).

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 3d5b24d..74e094a 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -16,12 +16,14 @@
 #include <linux/wl12xx.h>
 
 #include <linux/platform_data/pinctrl-single.h>
+#include <linux/platform_data/iommu-omap.h>
 
 #include "am35xx.h"
 #include "common.h"
 #include "common-board-devices.h"
 #include "dss-common.h"
 #include "control.h"
+#include "omap_device.h"
 
 struct pdata_init {
 	const char *compatible;
@@ -92,6 +94,12 @@ static void __init hsmmc2_internal_input_clk(void)
 	omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
 }
 
+static struct iommu_platform_data omap3_iommu_pdata = {
+	.reset_name = "mmu",
+	.assert_reset = omap_device_assert_hardreset,
+	.deassert_reset = omap_device_deassert_hardreset,
+};
+
 static int omap3_sbc_t3730_twl_callback(struct device *dev,
 					   unsigned gpio,
 					   unsigned ngpio)
@@ -185,6 +193,12 @@ static void __init omap4_panda_legacy_init(void)
 	legacy_init_ehci_clk("auxclk3_ck");
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 53);
 }
+
+static struct iommu_platform_data omap4_iommu_pdata = {
+	.reset_name = "mmu_cache",
+	.assert_reset = omap_device_assert_hardreset,
+	.deassert_reset = omap_device_deassert_hardreset,
+};
 #endif
 
 #ifdef CONFIG_SOC_OMAP5
@@ -240,6 +254,8 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002030, "48002030.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002a00, "48002a00.pinmux", &pcs_pdata),
+	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
+		       &omap3_iommu_pdata),
 	/* Only on am3517 */
 	OF_DEV_AUXDATA("ti,davinci_mdio", 0x5c030000, "davinci_mdio.0", NULL),
 	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
@@ -248,6 +264,10 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP4
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a100040, "4a100040.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a31e040, "4a31e040.pinmux", &pcs_pdata),
+	OF_DEV_AUXDATA("ti,omap4-iommu", 0x4a066000, "4a066000.mmu",
+		       &omap4_iommu_pdata),
+	OF_DEV_AUXDATA("ti,omap4-iommu", 0x55082000, "55082000.mmu",
+		       &omap4_iommu_pdata),
 #endif
 	{ /* sentinel */ },
 };
-- 
1.9.0

