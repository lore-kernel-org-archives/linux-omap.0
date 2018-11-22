From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 14/17] ARM: OMAP2+: use pdata quirks for PRUSS reset lines on AM335x
Date: Thu, 22 Nov 2018 13:39:10 +0200
Message-ID: <1542886753-17625-15-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The omap_device API is needed to perform the reset management for
any IP instances with PRCM RSTCTRL registers (hard reset lines).
This API is limited to the mach-omap2 layer, and cannot be exposed
to drivers layer directly. So use platform data ops and pdata quirks
for the PRUSS IP in AM335x SoCs to plumb the required omap_device
API. The PRUSS SoC bus driver can then use these pdata ops to
achieve the required reset functionality.

This is being implemented this way as there is no separate reset
driver at the moment.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 9fec5f8..97fc5a2 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -26,6 +26,7 @@
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/ti-sysc.h>
+#include <linux/platform_data/ti-pruss.h>
 #include <linux/platform_data/wkup_m3.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
@@ -438,6 +439,14 @@ static struct wkup_m3_platform_data wkup_m3_data = {
 };
 #endif
 
+#ifdef CONFIG_SOC_AM33XX
+static struct pruss_platform_data pruss_pdata = {
+	.reset_name = "pruss",
+	.assert_reset = omap_device_assert_hardreset,
+	.deassert_reset = omap_device_deassert_hardreset,
+};
+#endif
+
 #ifdef CONFIG_SOC_OMAP5
 static void __init omap5_uevm_legacy_init(void)
 {
@@ -580,6 +589,8 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 #ifdef CONFIG_SOC_AM33XX
 	OF_DEV_AUXDATA("ti,am3352-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
 		       &wkup_m3_data),
+	OF_DEV_AUXDATA("ti,am3356-pruss-soc-bus", 0x4a326004,
+		       "4a326004.pruss-soc-bus", &pruss_pdata),
 #endif
 #ifdef CONFIG_SOC_AM43XX
 	OF_DEV_AUXDATA("ti,am4372-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
