From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 1/3] ARM: OMAP2+: Use pdata-quirks for wkup_m3 reset management
Date: Wed, 1 Apr 2015 14:47:08 -0500
Message-ID: <1427917630-43961-2-git-send-email-d-gerlach@ti.com>
References: <1427917630-43961-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58213 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbbDATrl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2015 15:47:41 -0400
In-Reply-To: <1427917630-43961-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>

Use pdata-quirks to provide platform data required for reset
management during boot and shutdown of the wkup_m3 processor
on both the AM33xx and AM43xx SoCs. The WkupM3 remote processor
is used to implement and achieve low-power functionality on
the AM33xx & AM43xx SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index e642b07..7b4a4c1 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -18,6 +18,7 @@
 
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/iommu-omap.h>
+#include <linux/platform_data/wkup_m3.h>
 
 #include "common.h"
 #include "common-board-devices.h"
@@ -314,6 +315,14 @@ static struct iommu_platform_data omap4_iommu_pdata = {
 };
 #endif
 
+#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
+static struct wkup_m3_platform_data wkup_m3_data = {
+	.reset_name = "wkup_m3",
+	.assert_reset = omap_device_assert_hardreset,
+	.deassert_reset = omap_device_deassert_hardreset,
+};
+#endif
+
 #ifdef CONFIG_SOC_AM33XX
 static void __init am335x_evmsk_legacy_init(void)
 {
@@ -383,6 +392,10 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
 		       &am35xx_emac_pdata),
 #endif
+#ifdef CONFIG_SOC_AM33XX
+	OF_DEV_AUXDATA("ti,am3352-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
+		       &wkup_m3_data),
+#endif
 #ifdef CONFIG_ARCH_OMAP4
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a100040, "4a100040.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a31e040, "4a31e040.pinmux", &pcs_pdata),
@@ -396,6 +409,8 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #endif
 #ifdef CONFIG_SOC_AM43XX
 	OF_DEV_AUXDATA("ti,am437-padconf", 0x44e10800, "44e10800.pinmux", &pcs_pdata),
+	OF_DEV_AUXDATA("ti,am4372-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
+		       &wkup_m3_data),
 #endif
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 	OF_DEV_AUXDATA("ti,omap4-iommu", 0x4a066000, "4a066000.mmu",
-- 
2.3.0

