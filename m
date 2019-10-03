From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 3/4] ARM: OMAP2+: pdata-quirks: drop TI_ST/KIM support
Date: Thu,  3 Oct 2019 15:41:46 +0200
Message-ID: <20191003134147.9458-4-sre@kernel.org>
References: <20191003134147.9458-1-sre@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191003134147.9458-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>
Cc: Adam Ford <aford173@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

All TI_ST users have been migrated to the new serdev based HCILL
bluetooth driver. That driver is initialized from DT and does not
need any platform quirks.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 52 ------------------------------
 1 file changed, 52 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index d942a3357090..02abeb44cab2 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
-#include <linux/ti_wilink_st.h>
 #include <linux/wl12xx.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -139,53 +138,6 @@ static void __init omap3_sbc_t3530_legacy_init(void)
 	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
 }
 
-static struct ti_st_plat_data wilink_pdata = {
-	.nshutdown_gpio = 137,
-	.dev_name = "/dev/ttyO1",
-	.flow_cntrl = 1,
-	.baud_rate = 300000,
-};
-
-static struct platform_device wl18xx_device = {
-	.name	= "kim",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &wilink_pdata,
-	}
-};
-
-static struct ti_st_plat_data wilink7_pdata = {
-	.nshutdown_gpio = 162,
-	.dev_name = "/dev/ttyO1",
-	.flow_cntrl = 1,
-	.baud_rate = 3000000,
-};
-
-static struct platform_device wl128x_device = {
-	.name	= "kim",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &wilink7_pdata,
-	}
-};
-
-static struct platform_device btwilink_device = {
-	.name	= "btwilink",
-	.id	= -1,
-};
-
-static void __init omap3_igep0020_rev_f_legacy_init(void)
-{
-	platform_device_register(&wl18xx_device);
-	platform_device_register(&btwilink_device);
-}
-
-static void __init omap3_igep0030_rev_g_legacy_init(void)
-{
-	platform_device_register(&wl18xx_device);
-	platform_device_register(&btwilink_device);
-}
-
 static void __init omap3_evm_legacy_init(void)
 {
 	hsmmc2_internal_input_clk();
@@ -299,8 +251,6 @@ static void __init omap3_tao3530_legacy_init(void)
 static void __init omap3_logicpd_torpedo_init(void)
 {
 	omap3_gpio126_127_129();
-	platform_device_register(&wl128x_device);
-	platform_device_register(&btwilink_device);
 }
 
 /* omap3pandora legacy devices */
@@ -679,8 +629,6 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "nokia,omap3-n900", nokia_n900_legacy_init, },
 	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
-	{ "isee,omap3-igep0020-rev-f", omap3_igep0020_rev_f_legacy_init, },
-	{ "isee,omap3-igep0030-rev-g", omap3_igep0030_rev_g_legacy_init, },
 	{ "logicpd,dm3730-torpedo-devkit", omap3_logicpd_torpedo_init, },
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
-- 
2.23.0
