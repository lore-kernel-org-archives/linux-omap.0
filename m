From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v2 1/2] ARM: OMAP2+: Use pdata-quirks for wkup_m3 deassert_hardreset
Date: Wed, 4 Mar 2015 22:12:21 -0600
Message-ID: <1425528742-3087-2-git-send-email-d-gerlach@ti.com>
References: <1425528742-3087-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425528742-3087-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Use pdata-quirks to provide platform data required for reset
of the wkup_m3 during boot.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
This patch requires the pdata introduced in this patch:
https://www.mail-archive.com/linux-omap@vger.kernel.org/msg114622.html

 arch/arm/mach-omap2/pdata-quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 190fa43..7a09513 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -18,6 +18,7 @@
 
 #include <linux/platform_data/pinctrl-single.h>
 #include <linux/platform_data/iommu-omap.h>
+#include <linux/platform_data/wkup_m3.h>
 
 #include "common.h"
 #include "common-board-devices.h"
@@ -287,6 +288,14 @@ static void __init omap3_tao3530_legacy_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
+#ifdef CONFIG_SOC_AM33XX
+static struct wkup_m3_platform_data wkup_m3_data = {
+	.reset_name = "wkup_m3",
+	.assert_reset = omap_device_assert_hardreset,
+	.deassert_reset = omap_device_deassert_hardreset,
+};
+#endif
+
 #ifdef CONFIG_ARCH_OMAP4
 static void __init omap4_sdp_legacy_init(void)
 {
@@ -382,6 +391,10 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
 		       &am35xx_emac_pdata),
 #endif
+#ifdef CONFIG_SOC_AM33XX
+	OF_DEV_AUXDATA("ti,am3353-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
+		       &wkup_m3_data),
+#endif
 #ifdef CONFIG_ARCH_OMAP4
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a100040, "4a100040.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap4-padconf", 0x4a31e040, "4a31e040.pinmux", &pcs_pdata),
-- 
2.3.0
