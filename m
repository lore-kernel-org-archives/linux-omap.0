From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: omap1: make some functions static
Date: Thu, 18 Nov 2010 19:59:47 +0200
Message-ID: <1290103191-360-3-git-send-email-aaro.koskinen@nokia.com>
References: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:44728 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759938Ab0KRR7u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 12:59:50 -0500
In-Reply-To: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Make some functions static to get rid of the following sparse warnings:

	arch/arm/mach-omap1/mcbsp.c:177:12: warning: symbol 'omap1_mcbsp_init' was not declared. Should it be static?
	arch/arm/mach-omap1/mux.c:346:22: warning: symbol 'omap1_cfg_reg' was not declared. Should it be static?
	arch/arm/plat-omap/dma.c:177:5: warning: symbol 'omap_dma_in_1510_mode' was not declared. Should it be static?
	arch/arm/plat-omap/sram.c:273:12: warning: symbol 'omap1_sram_init' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap1/mcbsp.c |    2 +-
 arch/arm/mach-omap1/mux.c   |    2 +-
 arch/arm/plat-omap/dma.c    |    2 +-
 arch/arm/plat-omap/sram.c   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/mcbsp.c b/arch/arm/mach-omap1/mcbsp.c
index b3a796a..372ea71 100644
--- a/arch/arm/mach-omap1/mcbsp.c
+++ b/arch/arm/mach-omap1/mcbsp.c
@@ -174,7 +174,7 @@ static struct omap_mcbsp_platform_data omap16xx_mcbsp_pdata[] = {
 #define OMAP16XX_MCBSP_REG_NUM		0
 #endif
 
-int __init omap1_mcbsp_init(void)
+static int __init omap1_mcbsp_init(void)
 {
 	if (cpu_is_omap7xx()) {
 		omap_mcbsp_count = OMAP7XX_MCBSP_PDATA_SZ;
diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 7835add..5fdef7a 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -343,7 +343,7 @@ MUX_CFG("Y14_1610_CCP_DATAM",	 9,   21,    6,   2,   3,   1,    2,     0,  0)
 #define OMAP1XXX_PINS_SZ	0
 #endif	/* CONFIG_ARCH_OMAP15XX || CONFIG_ARCH_OMAP16XX */
 
-int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
+static int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
 {
 	static DEFINE_SPINLOCK(mux_spin_lock);
 	unsigned long flags;
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2c28265..a863f55 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -174,7 +174,7 @@ static inline void omap_enable_channel_irq(int lch);
 
 #ifdef CONFIG_ARCH_OMAP15XX
 /* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 otherwise */
-int omap_dma_in_1510_mode(void)
+static int omap_dma_in_1510_mode(void)
 {
 	return enable_1510_mode;
 }
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index e2c8eeb..93641df 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -270,7 +270,7 @@ void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl)
 	_omap_sram_reprogram_clock(dpllctl, ckctl);
 }
 
-int __init omap1_sram_init(void)
+static int __init omap1_sram_init(void)
 {
 	_omap_sram_reprogram_clock =
 			omap_sram_push(omap1_sram_reprogram_clock,
-- 
1.5.6.5

