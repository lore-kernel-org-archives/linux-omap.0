From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] arm: omap: dra7xx: Set OPT_CLKS_IN_RESET flag for gpio1
Date: Wed, 6 Sep 2017 16:03:58 +0530
Message-ID: <1504694038-32159-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: t-kristo@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

gpio1 soft reset fails in the kexec path as the optional clock
is not enabled hence enable the HWMOD_CONTROL_OPT_CLKS_IN_RESET
flag for gpio1 hwmod.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 7cc3247..6ae729a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1037,6 +1037,7 @@ struct omap_hwmod dra7xx_sha0_hwmod = {
 	.name		= "gpio1",
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.main_clk	= "wkupaon_iclk_mux",
 	.prcm = {
 		.omap4 = {
-- 
1.9.1
