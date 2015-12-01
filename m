From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/10] ARM: OMAP2+: Add DPPLS clock manager for dm814x
Date: Tue,  1 Dec 2015 15:38:16 -0800
Message-ID: <1449013103-23238-4-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449013103-23238-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On dm814x we have some clocks at DPLLS and some at PRCM. Let's add a new
omap_prcm_init_data entry for the DPLLS so we can initalize timer clocks
early.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prm_common.c | 6 ++++++
 include/linux/clk/ti.h           | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 3fc2cbe..55acc76 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -662,6 +662,11 @@ static struct omap_prcm_init_data am3_prm_data __initdata = {
 	.index = TI_CLKM_PRM,
 	.init = am33xx_prm_init,
 };
+
+static struct omap_prcm_init_data dm814_pllss_data __initdata = {
+	.index = TI_CLKM_PLLSS,
+	.init = am33xx_prm_init,
+};
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -715,6 +720,7 @@ static const struct of_device_id const omap_prcm_dt_match_table[] __initconst =
 #endif
 #ifdef CONFIG_SOC_TI81XX
 	{ .compatible = "ti,dm814-prcm", .data = &am3_prm_data },
+	{ .compatible = "ti,dm814-pllss", .data = &dm814_pllss_data },
 	{ .compatible = "ti,dm816-prcm", .data = &am3_prm_data },
 #endif
 #ifdef CONFIG_ARCH_OMAP2
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 223be69..57663c1 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -195,6 +195,7 @@ enum {
 	TI_CLKM_PRM,
 	TI_CLKM_SCRM,
 	TI_CLKM_CTRL,
+	TI_CLKM_PLLSS,
 	CLK_MAX_MEMMAPS
 };
 
-- 
2.6.2
