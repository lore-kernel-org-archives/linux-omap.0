From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/17] ARM: OMAP2: Change 24xx to use new register access
Date: Wed,  9 Apr 2008 14:03:11 -0700
Message-ID: <1207775003-7429-6-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-04-09-210318
 <1207775003-7429-1-git-send-email-tony@atomide.com>
 <1207775003-7429-2-git-send-email-tony@atomide.com>
 <1207775003-7429-3-git-send-email-tony@atomide.com>
 <1207775003-7429-4-git-send-email-tony@atomide.com>
 <1207775003-7429-5-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63707 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484AbYDIVDg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 17:03:36 -0400
In-Reply-To: <1207775003-7429-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

This patch changes 24xx to use new register access, except for clock
framework. Clock framework register access will get updates in the
next patch.

Note that board-*.c files change GPMC (General Purpose Memory Controller)
access to use gpmc_cs_write_reg() instead of accessing the registers
directly. The code also uses gpmc_fck instead of it's parent clock
core_l3_ck for GPMC clock.

The H4 board file also adds h4_init_flash() function, which specify the
flash start and end addresses.

Also note that sleep.S removes some unused registers addresses.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c     |   15 +++--
 arch/arm/mach-omap2/board-apollon.c     |   51 +++++++++++++---
 arch/arm/mach-omap2/board-h4.c          |  104 ++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/gpmc.c              |    8 +-
 arch/arm/mach-omap2/memory.c            |   26 +++++---
 arch/arm/mach-omap2/mux.c               |   10 ++--
 arch/arm/mach-omap2/prcm-regs.h         |   14 ++++
 arch/arm/mach-omap2/prcm.c              |   14 +++-
 arch/arm/mach-omap2/sleep.S             |   23 +------
 arch/arm/mach-omap2/sram-fn.S           |   42 +++++-------
 arch/arm/plat-omap/common.c             |   47 +++++++++++++-
 include/asm-arm/arch-omap/clock.h       |    5 ++
 include/asm-arm/arch-omap/entry-macro.S |    2 +-
 include/asm-arm/arch-omap/io.h          |   70 ++++++++++++++++++++-
 include/asm-arm/arch-omap/omap24xx.h    |   96 +++++++++++++++++++++++-----
 15 files changed, 411 insertions(+), 116 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 64235de..48fc329 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -33,7 +33,6 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
 #include <asm/arch/gpmc.h>
-#include "prcm-regs.h"
 
 #include <asm/io.h>
 
@@ -125,15 +124,17 @@ static inline void __init sdp2430_init_smc91x(void)
 	int eth_cs;
 	unsigned long cs_mem_base;
 	unsigned int rate;
-	struct clk *l3ck;
+	struct clk *gpmc_fck;
 
 	eth_cs = SDP2430_SMC91X_CS;
 
-	l3ck = clk_get(NULL, "core_l3_ck");
-	if (IS_ERR(l3ck))
-		rate = 100000000;
-	else
-		rate = clk_get_rate(l3ck);
+	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
+	if (IS_ERR(gpmc_fck)) {
+		WARN_ON(1);
+		return;
+	}
+
+	rate = clk_get_rate(gpmc_fck);
 
 	/* Make sure CS1 timings are correct, for 2430 always muxed */
 	gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG1, 0x00011200);
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 7846551..2694dc4 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -26,6 +26,8 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/leds.h>
+#include <linux/err.h>
+#include <linux/clk.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -39,7 +41,7 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
 #include <asm/arch/gpmc.h>
-#include "prcm-regs.h"
+#include <asm/arch/control.h>
 
 /* LED & Switch macros */
 #define LED0_GPIO13		13
@@ -187,13 +189,42 @@ static inline void __init apollon_init_smc91x(void)
 {
 	unsigned long base;
 
+	unsigned int rate;
+	struct clk *gpmc_fck;
+	int eth_cs;
+
+	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
+	if (IS_ERR(gpmc_fck)) {
+		WARN_ON(1);
+		return;
+	}
+
+	rate = clk_get_rate(gpmc_fck);
+
+	eth_cs = APOLLON_ETH_CS;
+
 	/* Make sure CS1 timings are correct */
-	GPMC_CONFIG1_1 = 0x00011203;
-	GPMC_CONFIG2_1 = 0x001f1f01;
-	GPMC_CONFIG3_1 = 0x00080803;
-	GPMC_CONFIG4_1 = 0x1c091c09;
-	GPMC_CONFIG5_1 = 0x041f1f1f;
-	GPMC_CONFIG6_1 = 0x000004c4;
+	gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG1, 0x00011200);
+
+	if (rate >= 160000000) {
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f01);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080803);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1c0b1c0a);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
+	} else if (rate >= 130000000) {
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
+	} else {/* rate = 100000000 */
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x031A1F1F);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000003C2);
+	}
 
 	if (gpmc_cs_request(APOLLON_ETH_CS, SZ_16M, &base) < 0) {
 		printk(KERN_ERR "Failed to request GPMC CS for smc91x\n");
@@ -330,6 +361,8 @@ static void __init apollon_usb_init(void)
 
 static void __init omap_apollon_init(void)
 {
+	u32 v;
+
 	apollon_led_init();
 	apollon_sw_init();
 	apollon_flash_init();
@@ -339,7 +372,9 @@ static void __init omap_apollon_init(void)
 	omap_cfg_reg(W19_24XX_SYS_NIRQ);
 
 	/* Use Interal loop-back in MMC/SDIO Module Input Clock selection */
-	CONTROL_DEVCONF |= (1 << 24);
+	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	v |= (1 << 24);
+	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
 
 	/*
  	 * Make sure the serial ports are muxed on at this point.
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index f125f43..6bfe241 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -19,6 +19,8 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/input.h>
+#include <linux/err.h>
+#include <linux/clk.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -26,6 +28,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
+#include <asm/arch/control.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/gpioexpander.h>
 #include <asm/arch/mux.h>
@@ -36,10 +39,13 @@
 #include <asm/arch/keypad.h>
 #include <asm/arch/menelaus.h>
 #include <asm/arch/dma.h>
-#include "prcm-regs.h"
+#include <asm/arch/gpmc.h>
 
 #include <asm/io.h>
 
+#define H4_FLASH_CS	0
+#define H4_SMC91X_CS	1
+
 static unsigned int row_gpios[6] = { 88, 89, 124, 11, 6, 96 };
 static unsigned int col_gpios[7] = { 90, 91, 100, 36, 12, 97, 98 };
 
@@ -116,8 +122,6 @@ static struct flash_platform_data h4_flash_data = {
 };
 
 static struct resource h4_flash_resource = {
-	.start		= H4_CS0_BASE,
-	.end		= H4_CS0_BASE + SZ_64M - 1,
 	.flags		= IORESOURCE_MEM,
 };
 
@@ -253,16 +257,83 @@ static struct platform_device *h4_devices[] __initdata = {
 	&h4_lcd_device,
 };
 
+/* 2420 Sysboot setup (2430 is different) */
+static u32 get_sysboot_value(void)
+{
+	return (omap_ctrl_readl(OMAP24XX_CONTROL_STATUS) &
+		(OMAP2_SYSBOOT_5_MASK | OMAP2_SYSBOOT_4_MASK |
+		 OMAP2_SYSBOOT_3_MASK | OMAP2_SYSBOOT_2_MASK |
+		 OMAP2_SYSBOOT_1_MASK | OMAP2_SYSBOOT_0_MASK));
+}
+
+/* H4-2420's always used muxed mode, H4-2422's always use non-muxed
+ *
+ * Note: OMAP-GIT doesn't correctly do is_cpu_omap2422 and is_cpu_omap2423
+ *  correctly.  The macro needs to look at production_id not just hawkeye.
+ */
+static u32 is_gpmc_muxed(void)
+{
+	u32 mux;
+	mux = get_sysboot_value();
+	if ((mux & 0xF) == 0xd)
+		return 1;	/* NAND config (could be either) */
+	if (mux & 0x2)		/* if mux'ed */
+		return 1;
+	else
+		return 0;
+}
+
 static inline void __init h4_init_debug(void)
 {
+	int eth_cs;
+	unsigned long cs_mem_base;
+	unsigned int muxed, rate;
+	struct clk *gpmc_fck;
+
+	eth_cs	= H4_SMC91X_CS;
+
+	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
+	if (IS_ERR(gpmc_fck)) {
+		WARN_ON(1);
+		return;
+	}
+
+	rate = clk_get_rate(gpmc_fck);
+
+	if (is_gpmc_muxed())
+		muxed = 0x200;
+	else
+		muxed = 0;
+
 	/* Make sure CS1 timings are correct */
-	GPMC_CONFIG1_1 = 0x00011200;
-	GPMC_CONFIG2_1 = 0x001f1f01;
-	GPMC_CONFIG3_1 = 0x00080803;
-	GPMC_CONFIG4_1 = 0x1c091c09;
-	GPMC_CONFIG5_1 = 0x041f1f1f;
-	GPMC_CONFIG6_1 = 0x000004c4;
-	GPMC_CONFIG7_1 = 0x00000f40 | (0x08000000 >> 24);
+	gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG1,
+			  0x00011000 | muxed);
+
+	if (rate >= 160000000) {
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f01);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080803);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1c0b1c0a);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
+	} else if (rate >= 130000000) {
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
+	} else {/* rate = 100000000 */
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x031A1F1F);
+		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000003C2);
+	}
+
+	if (gpmc_cs_request(eth_cs, SZ_16M, &cs_mem_base) < 0) {
+		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
+		return;
+	}
+
 	udelay(100);
 
 	omap_cfg_reg(M15_24XX_GPIO92);
@@ -270,11 +341,24 @@ static inline void __init h4_init_debug(void)
 		gpmc_cs_free(eth_cs);
 }
 
+static void __init h4_init_flash(void)
+{
+	unsigned long base;
+
+	if (gpmc_cs_request(H4_FLASH_CS, SZ_64M, &base) < 0) {
+		printk("Can't request GPMC CS for flash\n");
+		return;
+	}
+	h4_flash_resource.start	= base;
+	h4_flash_resource.end	= base + SZ_64M - 1;
+}
+
 static void __init omap_h4_init_irq(void)
 {
 	omap2_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
+	h4_init_flash();
 }
 
 static struct omap_uart_config h4_uart_config __initdata = {
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5a4cc20..b0bc526 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -69,7 +69,7 @@ static void __iomem *gpmc_base =
 static void __iomem *gpmc_cs_base =
 	(void __iomem *) IO_ADDRESS(GPMC_BASE) + GPMC_CS0;
 
-static struct clk *gpmc_l3_clk;
+static struct clk *gpmc_fck;
 
 static void gpmc_write_reg(int idx, u32 val)
 {
@@ -98,7 +98,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
 unsigned long gpmc_get_fclk_period(void)
 {
 	/* In picoseconds */
-	return 1000000000 / ((clk_get_rate(gpmc_l3_clk)) / 1000);
+	return 1000000000 / ((clk_get_rate(gpmc_fck)) / 1000);
 }
 
 unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
@@ -398,8 +398,8 @@ void __init gpmc_init(void)
 {
 	u32 l;
 
-	gpmc_l3_clk = clk_get(NULL, "core_l3_ck");
-	BUG_ON(IS_ERR(gpmc_l3_clk));
+	gpmc_fck = clk_get(NULL, "gpmc_fck"); /* Always on ENABLE_ON_INIT */
+	WARN_ON(IS_ERR(gpmc_fck));
 
 	l = gpmc_read_reg(GPMC_REVISION);
 	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
diff --git a/arch/arm/mach-omap2/memory.c b/arch/arm/mach-omap2/memory.c
index 3e5d8cd..b56c1a0 100644
--- a/arch/arm/mach-omap2/memory.c
+++ b/arch/arm/mach-omap2/memory.c
@@ -27,11 +27,16 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
 
-#include "prcm-regs.h"
+#include "prm.h"
+
 #include "memory.h"
+#include "sdrc.h"
 
+unsigned long omap2_sdrc_base;
+unsigned long omap2_sms_base;
 
 static struct memory_timings mem_timings;
+static u32 curr_perf_level = CORE_CLK_SRC_DPLL_X2;
 
 u32 omap2_memory_get_slow_dll_ctrl(void)
 {
@@ -53,7 +58,7 @@ void omap2_init_memory_params(u32 force_lock_to_unlock_mode)
 	unsigned long dll_cnt;
 	u32 fast_dll = 0;
 
-	mem_timings.m_type = !((SDRC_MR_0 & 0x3) == 0x1); /* DDR = 1, SDR = 0 */
+	mem_timings.m_type = !((sdrc_read_reg(SDRC_MR_0) & 0x3) == 0x1); /* DDR = 1, SDR = 0 */
 
 	/* 2422 es2.05 and beyond has a single SIP DDR instead of 2 like others.
 	 * In the case of 2422, its ok to use CS1 instead of CS0.
@@ -73,11 +78,11 @@ void omap2_init_memory_params(u32 force_lock_to_unlock_mode)
 		mem_timings.dll_mode = M_LOCK;
 
 	if (mem_timings.base_cs == 0) {
-		fast_dll = SDRC_DLLA_CTRL;
-		dll_cnt = SDRC_DLLA_STATUS & 0xff00;
+		fast_dll = sdrc_read_reg(SDRC_DLLA_CTRL);
+		dll_cnt = sdrc_read_reg(SDRC_DLLA_STATUS) & 0xff00;
 	} else {
-		fast_dll = SDRC_DLLB_CTRL;
-		dll_cnt = SDRC_DLLB_STATUS & 0xff00;
+		fast_dll = sdrc_read_reg(SDRC_DLLB_CTRL);
+		dll_cnt = sdrc_read_reg(SDRC_DLLB_STATUS) & 0xff00;
 	}
 	if (force_lock_to_unlock_mode) {
 		fast_dll &= ~0xff00;
@@ -106,14 +111,13 @@ void __init omap2_init_memory(void)
 {
 	u32 l;
 
-	l = SMS_SYSCONFIG;
+	l = sms_read_reg(SMS_SYSCONFIG);
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
-	SMS_SYSCONFIG = l;
+	sms_write_reg(l, SMS_SYSCONFIG);
 
-	l = SDRC_SYSCONFIG;
+	l = sdrc_read_reg(SDRC_SYSCONFIG);
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
-	SDRC_SYSCONFIG = l;
-
+	sdrc_write_reg(l, SDRC_SYSCONFIG);
 }
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 0cf7562..9307700 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -29,6 +29,7 @@
 #include <asm/io.h>
 #include <linux/spinlock.h>
 
+#include <asm/arch/control.h>
 #include <asm/arch/mux.h>
 
 #ifdef CONFIG_OMAP_MUX
@@ -218,18 +219,16 @@ MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)
 #define OMAP24XX_PINS_SZ	0
 #endif	/* CONFIG_ARCH_OMAP24XX */
 
-#define OMAP24XX_L4_BASE	0x48000000
 #define OMAP24XX_PULL_ENA	(1 << 3)
 #define OMAP24XX_PULL_UP	(1 << 4)
 
-/* REVISIT: Convert this code to use ctrl_{read,write}_reg */
 #if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
 void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u8 reg)
 {
 	u16 orig;
 	u8 warn = 0, debug = 0;
 
-	orig = omap_readb(OMAP24XX_L4_BASE + cfg->mux_reg);
+	orig = omap_ctrl_readb(cfg->mux_reg);
 
 #ifdef	CONFIG_OMAP_MUX_DEBUG
 	debug = cfg->debug;
@@ -238,7 +237,8 @@ void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u8 reg)
 	if (debug || warn)
 		printk(KERN_WARNING
 			"MUX: setup %s (0x%08x): 0x%02x -> 0x%02x\n",
-			cfg->name, omap_readb(OMAP24XX_L4_BASE + cfg->mux_reg));
+			cfg->name, omap_ctrl_base_get() + cfg->mux_reg,
+			orig, reg);
 }
 #else
 #define omap2_cfg_debug(x, y)	do {} while (0)
@@ -258,7 +258,7 @@ int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 	if (cfg->pu_pd_val)
 		reg |= OMAP24XX_PULL_UP;
 	omap2_cfg_debug(cfg, reg);
-	omap_writeb(reg, OMAP24XX_L4_BASE + cfg->mux_reg);
+	omap_ctrl_writeb(reg, cfg->mux_reg);
 	spin_unlock_irqrestore(&mux_spin_lock, flags);
 
 	return 0;
diff --git a/arch/arm/mach-omap2/prcm-regs.h b/arch/arm/mach-omap2/prcm-regs.h
index 5e1c4b5..c7f6cfa 100644
--- a/arch/arm/mach-omap2/prcm-regs.h
+++ b/arch/arm/mach-omap2/prcm-regs.h
@@ -23,6 +23,20 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRCM_H
 #define __ARCH_ARM_MACH_OMAP2_PRCM_H
 
+#ifdef CONFIG_ARCH_OMAP2420
+#define OMAP24XX_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
+#define OMAP24XX_PRCM_BASE	(L4_24XX_BASE + 0x8000)
+#define OMAP24XX_SDRC_BASE	(L3_24XX_BASE + 0x9000)
+#define OMAP242X_CONTROL_STATUS	(L4_24XX_BASE + 0x2f8)
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+#define OMAP24XX_32KSYNCT_BASE (L4_WK_243X_BASE + 0x20000)
+#define OMAP24XX_PRCM_BASE     (L4_WK_243X_BASE + 0x6000)
+#define OMAP24XX_SDRC_BASE     (0x6D000000)
+#define OMAP242X_CONTROL_STATUS        (L4_24XX_BASE + 0x2f8)
+#endif
+
 /* SET_PERFORMANCE_LEVEL PARAMETERS */
 #define PRCM_HALF_SPEED 1
 #define PRCM_FULL_SPEED 2
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 90f5305..b12f423 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -17,19 +17,27 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 
-#include "prcm-regs.h"
+#include <asm/io.h>
+
+#include "prm.h"
+#include "prm-regbits-24xx.h"
 
 extern void omap2_clk_prepare_for_reboot(void);
 
 u32 omap_prcm_get_reset_sources(void)
 {
-	return RM_RSTST_WKUP & 0x7f;
+	return prm_read_mod_reg(WKUP_MOD, RM_RSTST) & 0x7f;
 }
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 
 /* Resets clock rates and reboots the system. Only called from system.h */
 void omap_prcm_arch_reset(char mode)
 {
+	u32 wkup;
 	omap2_clk_prepare_for_reboot();
-	RM_RSTCTRL_WKUP |= 2;
+
+	if (cpu_is_omap24xx()) {
+		wkup = prm_read_mod_reg(WKUP_MOD, RM_RSTCTRL) | OMAP_RST_DPLL3;
+		prm_write_mod_reg(wkup, WKUP_MOD, RM_RSTCTRL);
+	}
 }
diff --git a/arch/arm/mach-omap2/sleep.S b/arch/arm/mach-omap2/sleep.S
index 16247d5..46ccb9b 100644
--- a/arch/arm/mach-omap2/sleep.S
+++ b/arch/arm/mach-omap2/sleep.S
@@ -26,19 +26,10 @@
 #include <asm/arch/io.h>
 #include <asm/arch/pm.h>
 
-#define A_32KSYNC_CR_V		IO_ADDRESS(OMAP_TIMER32K_BASE+0x10)
-#define A_PRCM_VOLTCTRL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x50)
-#define A_PRCM_CLKCFG_CTRL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x80)
-#define A_CM_CLKEN_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x500)
-#define A_CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x520)
-#define A_CM_CLKSEL1_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x540)
-#define A_CM_CLKSEL2_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE+0x544)
+#include "sdrc.h"
 
-#define A_SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP24XX_SDRC_BASE+0x60)
-#define	A_SDRC_POWER_V		IO_ADDRESS(OMAP24XX_SDRC_BASE+0x70)
-#define A_SDRC_RFR_CTRL_V	IO_ADDRESS(OMAP24XX_SDRC_BASE+0xA4)
+/* First address of reserved address space?  apparently valid for OMAP2 & 3 */
 #define A_SDRC0_V		(0xC0000000)
-#define A_SDRC_MANUAL_V		IO_ADDRESS(OMAP24XX_SDRC_BASE+0xA8)
 
 	.text
 
@@ -126,17 +117,11 @@ loop2:
 	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
 
 A_SDRC_POWER:
-	.word A_SDRC_POWER_V
+	.word OMAP242X_SDRC_REGADDR(SDRC_POWER)
 A_SDRC0:
 	.word A_SDRC0_V
-A_CM_CLKSEL2_PLL_S:
-	.word A_CM_CLKSEL2_PLL_V
-A_CM_CLKEN_PLL:
-	.word A_CM_CLKEN_PLL_V
 A_SDRC_DLLA_CTRL_S:
-	.word A_SDRC_DLLA_CTRL_V
-A_SDRC_MANUAL_S:
-	.word A_SDRC_MANUAL_V
+	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
 
 ENTRY(omap24xx_cpu_suspend_sz)
 	.word	. - omap24xx_cpu_suspend
diff --git a/arch/arm/mach-omap2/sram-fn.S b/arch/arm/mach-omap2/sram-fn.S
index b275766..4a9e491 100644
--- a/arch/arm/mach-omap2/sram-fn.S
+++ b/arch/arm/mach-omap2/sram-fn.S
@@ -27,19 +27,11 @@
 #include <asm/arch/io.h>
 #include <asm/hardware.h>
 
-#include "prcm-regs.h"
+#include "sdrc.h"
+#include "prm.h"
+#include "cm.h"
 
-#define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP24XX_32KSYNCT_BASE + 0x010)
-
-#define CM_CLKSEL2_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x544)
-#define PRCM_VOLTCTRL_V		IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x050)
-#define PRCM_CLKCFG_CTRL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x080)
-#define CM_CLKEN_PLL_V		IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x500)
-#define CM_IDLEST_CKGEN_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x520)
-#define CM_CLKSEL1_PLL_V	IO_ADDRESS(OMAP24XX_PRCM_BASE + 0x540)
-
-#define SDRC_DLLA_CTRL_V	IO_ADDRESS(OMAP24XX_SDRC_BASE + 0x060)
-#define SDRC_RFR_CTRL_V		IO_ADDRESS(OMAP24XX_SDRC_BASE + 0x0a4)
+#define TIMER_32KSYNCT_CR_V	IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
 
 	.text
 
@@ -131,11 +123,11 @@ volt_delay:
 
 /* relative load constants */
 cm_clksel2_pll:
-	.word CM_CLKSEL2_PLL_V
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
 sdrc_dlla_ctrl:
-	.word SDRC_DLLA_CTRL_V
+	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
 prcm_voltctrl:
-	.word PRCM_VOLTCTRL_V
+	.word OMAP2420_PRM_REGADDR(OCP_MOD, 0x50)
 prcm_mask_val:
 	.word 0xFFFF3FFC
 timer_32ksynct_cr:
@@ -225,13 +217,13 @@ volt_delay_c:
 	mov	pc, lr			@ back to caller
 
 ddr_cm_clksel2_pll:
-	.word CM_CLKSEL2_PLL_V
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL2)
 ddr_sdrc_dlla_ctrl:
-	.word SDRC_DLLA_CTRL_V
+	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
 ddr_sdrc_rfr_ctrl:
-	.word SDRC_RFR_CTRL_V
+	.word OMAP242X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
 ddr_prcm_voltctrl:
-	.word PRCM_VOLTCTRL_V
+	.word OMAP2420_PRM_REGADDR(OCP_MOD, 0x50)
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 ddr_timer_32ksynct:
@@ -316,17 +308,17 @@ wait_dll_lock:
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
 set_config:
-	.word PRCM_CLKCFG_CTRL_V
+	.word OMAP2420_PRM_REGADDR(OCP_MOD, 0x80)
 pll_ctl:
-	.word CM_CLKEN_PLL_V
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_FCLKEN1)
 pll_stat:
-	.word CM_IDLEST_CKGEN_V
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_IDLEST1)
 pll_div:
-	.word CM_CLKSEL1_PLL_V
+	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKSEL)
 sdrc_rfr:
-	.word SDRC_RFR_CTRL_V
+	.word OMAP242X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
 dlla_ctrl:
-	.word SDRC_DLLA_CTRL_V
+	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
 
 ENTRY(sram_set_prcm_sz)
 	.word	. - sram_set_prcm
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 7f1cae1..bd1cef2 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -27,11 +27,16 @@
 #include <asm/setup.h>
 
 #include <asm/arch/board.h>
+#include <asm/arch/control.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/fpga.h>
 
 #include <asm/arch/clock.h>
 
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+# include "../mach-omap2/sdrc.h"
+#endif
+
 #define NO_LENGTH_CHECK 0xffffffff
 
 unsigned char omap_bootloader_tag[512];
@@ -171,8 +176,8 @@ console_initcall(omap_add_serial_console);
 
 #if defined(CONFIG_ARCH_OMAP16XX)
 #define TIMER_32K_SYNCHRONIZED		0xfffbc410
-#elif defined(CONFIG_ARCH_OMAP24XX)
-#define TIMER_32K_SYNCHRONIZED		(OMAP24XX_32KSYNCT_BASE + 0x10)
+#elif defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#define TIMER_32K_SYNCHRONIZED		(OMAP2_32KSYNCT_BASE + 0x10)
 #endif
 
 #ifdef	TIMER_32K_SYNCHRONIZED
@@ -215,7 +220,13 @@ static int __init omap_init_clocksource_32k(void)
 	static char err[] __initdata = KERN_ERR
 			"%s: can't register clocksource!\n";
 
-	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
+		struct clk *sync_32k_ick;
+
+		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
+		if (sync_32k_ick)
+			clk_enable(sync_32k_ick);
+
 		clocksource_32k.mult = clocksource_hz2mult(32768,
 					    clocksource_32k.shift);
 
@@ -227,3 +238,33 @@ static int __init omap_init_clocksource_32k(void)
 arch_initcall(omap_init_clocksource_32k);
 
 #endif	/* TIMER_32K_SYNCHRONIZED */
+
+/* Global address base setup code */
+
+#if defined(CONFIG_ARCH_OMAP2420)
+void __init omap2_set_globals_242x(void)
+{
+	omap2_sdrc_base = OMAP2420_SDRC_BASE;
+	omap2_sms_base = OMAP2420_SMS_BASE;
+	omap_ctrl_base_set(OMAP2420_CTRL_BASE);
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2430)
+void __init omap2_set_globals_243x(void)
+{
+	omap2_sdrc_base = OMAP243X_SDRC_BASE;
+	omap2_sms_base = OMAP243X_SMS_BASE;
+	omap_ctrl_base_set(OMAP243X_CTRL_BASE);
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP3430)
+void __init omap2_set_globals_343x(void)
+{
+	omap2_sdrc_base = OMAP343X_SDRC_BASE;
+	omap2_sms_base = OMAP343X_SMS_BASE;
+	omap_ctrl_base_set(OMAP343X_CTRL_BASE);
+}
+#endif
+
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index fa68810..fc7b806 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -88,4 +88,9 @@ extern int clk_get_usecount(struct clk *clk);
 #define CLOCK_IN_OMAP242X	(1 << 25)
 #define CLOCK_IN_OMAP243X	(1 << 26)
 
+/* CM_CLKSEL2_PLL.CORE_CLK_SRC options (24XX) */
+#define CORE_CLK_SRC_32K		0
+#define CORE_CLK_SRC_DPLL		1
+#define CORE_CLK_SRC_DPLL_X2		2
+
 #endif
diff --git a/include/asm-arm/arch-omap/entry-macro.S b/include/asm-arm/arch-omap/entry-macro.S
index f6967c8..74cd572 100644
--- a/include/asm-arm/arch-omap/entry-macro.S
+++ b/include/asm-arm/arch-omap/entry-macro.S
@@ -68,7 +68,7 @@
 		.endm
 
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =VA_IC_BASE
+		ldr	\base, =OMAP2_VA_IC_BASE
 		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
 		cmp	\irqnr, #0x0
 		bne	2222f
diff --git a/include/asm-arm/arch-omap/io.h b/include/asm-arm/arch-omap/io.h
index 289082d..160578e 100644
--- a/include/asm-arm/arch-omap/io.h
+++ b/include/asm-arm/arch-omap/io.h
@@ -80,6 +80,13 @@
 #define OMAP243X_GPMC_PHYS	OMAP243X_GPMC_BASE	/* 0x49000000 */
 #define OMAP243X_GPMC_VIRT	0xFE000000
 #define OMAP243X_GPMC_SIZE	SZ_1M
+#define OMAP243X_SDRC_PHYS	OMAP243X_SDRC_BASE
+#define OMAP243X_SDRC_VIRT	0xFD000000
+#define OMAP243X_SDRC_SIZE	SZ_1M
+#define OMAP243X_SMS_PHYS	OMAP243X_SMS_BASE
+#define OMAP243X_SMS_VIRT	0xFC000000
+#define OMAP243X_SMS_SIZE	SZ_1M
+
 #endif
 
 #define IO_OFFSET	0x90000000
@@ -88,16 +95,73 @@
 #define io_v2p(va)	((va) - IO_OFFSET)	/* Works for L3 and L4 */
 
 /* DSP */
-#define DSP_MEM_24XX_PHYS	OMAP24XX_DSP_MEM_BASE	/* 0x58000000 */
+#define DSP_MEM_24XX_PHYS	OMAP2420_DSP_MEM_BASE	/* 0x58000000 */
 #define DSP_MEM_24XX_VIRT	0xe0000000
 #define DSP_MEM_24XX_SIZE	0x28000
-#define DSP_IPI_24XX_PHYS	OMAP24XX_DSP_IPI_BASE	/* 0x59000000 */
+#define DSP_IPI_24XX_PHYS	OMAP2420_DSP_IPI_BASE	/* 0x59000000 */
 #define DSP_IPI_24XX_VIRT	0xe1000000
 #define DSP_IPI_24XX_SIZE	SZ_4K
-#define DSP_MMU_24XX_PHYS	OMAP24XX_DSP_MMU_BASE	/* 0x5a000000 */
+#define DSP_MMU_24XX_PHYS	OMAP2420_DSP_MMU_BASE	/* 0x5a000000 */
 #define DSP_MMU_24XX_VIRT	0xe2000000
 #define DSP_MMU_24XX_SIZE	SZ_4K
 
+#elif defined(CONFIG_ARCH_OMAP3)
+
+/* We map both L3 and L4 on OMAP3 */
+#define L3_34XX_PHYS		L3_34XX_BASE	/* 0x68000000 */
+#define L3_34XX_VIRT		0xf8000000
+#define L3_34XX_SIZE		SZ_1M   /* 44kB of 128MB used, want 1MB sect */
+
+#define L4_34XX_PHYS		L4_34XX_BASE	/* 0x48000000 */
+#define L4_34XX_VIRT		0xd8000000
+#define L4_34XX_SIZE		SZ_4M   /* 1MB of 128MB used, want 1MB sect */
+
+/*
+ * Need to look at the Size 4M for L4.
+ * VPOM3430 was not working for Int controller
+ */
+
+#define L4_WK_34XX_PHYS		L4_WK_34XX_BASE /* 0x48300000 */
+#define L4_WK_34XX_VIRT		0xd8300000
+#define L4_WK_34XX_SIZE		SZ_1M
+
+#define L4_PER_34XX_PHYS	L4_PER_34XX_BASE /* 0x49000000 */
+#define L4_PER_34XX_VIRT	0xd9000000
+#define L4_PER_34XX_SIZE	SZ_1M
+
+#define L4_EMU_34XX_PHYS	L4_EMU_34XX_BASE /* 0x54000000 */
+#define L4_EMU_34XX_VIRT	0xe4000000
+#define L4_EMU_34XX_SIZE	SZ_64M
+
+#define OMAP34XX_GPMC_PHYS	OMAP34XX_GPMC_BASE /* 0x6E000000 */
+#define OMAP34XX_GPMC_VIRT	0xFE000000
+#define OMAP34XX_GPMC_SIZE	SZ_1M
+
+#define OMAP343X_SMS_PHYS	OMAP343X_SMS_BASE /* 0x6C000000 */
+#define OMAP343X_SMS_VIRT	0xFC000000
+#define OMAP343X_SMS_SIZE	SZ_1M
+
+#define OMAP343X_SDRC_PHYS	OMAP343X_SDRC_BASE /* 0x6D000000 */
+#define OMAP343X_SDRC_VIRT	0xFD000000
+#define OMAP343X_SDRC_SIZE	SZ_1M
+
+
+#define IO_OFFSET		0x90000000
+#define IO_ADDRESS(pa)		((pa) + IO_OFFSET)/* Works for L3 and L4 */
+#define io_p2v(pa)		((pa) + IO_OFFSET)/* Works for L3 and L4 */
+#define io_v2p(va)		((va) - IO_OFFSET)/* Works for L3 and L4 */
+
+/* DSP */
+#define DSP_MEM_34XX_PHYS	OMAP34XX_DSP_MEM_BASE	/* 0x58000000 */
+#define DSP_MEM_34XX_VIRT	0xe0000000
+#define DSP_MEM_34XX_SIZE	0x28000
+#define DSP_IPI_34XX_PHYS	OMAP34XX_DSP_IPI_BASE	/* 0x59000000 */
+#define DSP_IPI_34XX_VIRT	0xe1000000
+#define DSP_IPI_34XX_SIZE	SZ_4K
+#define DSP_MMU_34XX_PHYS	OMAP34XX_DSP_MMU_BASE	/* 0x5a000000 */
+#define DSP_MMU_34XX_VIRT	0xe2000000
+#define DSP_MMU_34XX_SIZE	SZ_4K
+
 #endif
 
 #ifndef __ASSEMBLER__
diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
index 14c0f94..b9fcaae 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -1,3 +1,28 @@
+/*
+ * include/asm-arm/arch-omap/omap24xx.h
+ *
+ * This file contains the processor specific definitions
+ * of the TI OMAP24XX.
+ *
+ * Copyright (C) 2007 Texas Instruments.
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
 #ifndef __ASM_ARCH_OMAP24XX_H
 #define __ASM_ARCH_OMAP24XX_H
 
@@ -13,33 +38,70 @@
 
 /* interrupt controller */
 #define OMAP24XX_IC_BASE	(L4_24XX_BASE + 0xfe000)
-#define VA_IC_BASE		IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP24XX_IVA_INTC_BASE	0x40000000
 #define IRQ_SIR_IRQ		0x0040
 
-#ifdef CONFIG_ARCH_OMAP2420
-#define OMAP24XX_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
-#define OMAP24XX_PRCM_BASE	(L4_24XX_BASE + 0x8000)
-#define OMAP24XX_SDRC_BASE	(L3_24XX_BASE + 0x9000)
-#define OMAP242X_CONTROL_STATUS	(L4_24XX_BASE + 0x2f8)
-#endif
+#define OMAP2420_CTRL_BASE	L4_24XX_BASE
+#define OMAP2420_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
+#define OMAP2420_PRCM_BASE	(L4_24XX_BASE + 0x8000)
+#define OMAP2420_CM_BASE	(L4_24XX_BASE + 0x8000)
+#define OMAP2420_PRM_BASE	OMAP2420_CM_BASE
+#define OMAP2420_SDRC_BASE	(L3_24XX_BASE + 0x9000)
+#define OMAP2420_SMS_BASE	0x68008000
 
-#ifdef CONFIG_ARCH_OMAP2430
-#define OMAP24XX_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
-#define OMAP24XX_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
-#define OMAP24XX_SDRC_BASE	(0x6D000000)
-#define OMAP242X_CONTROL_STATUS	(L4_24XX_BASE + 0x2f8)
+#define OMAP2430_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
+#define OMAP2430_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
+#define OMAP2430_CM_BASE	(L4_WK_243X_BASE + 0x6000)
+#define OMAP2430_PRM_BASE	OMAP2430_CM_BASE
+
+#define OMAP243X_SMS_BASE	0x6C000000
+#define OMAP243X_SDRC_BASE	0x6D000000
 #define OMAP243X_GPMC_BASE	0x6E000000
-#endif
+#define OMAP243X_SCM_BASE	(L4_WK_243X_BASE + 0x2000)
+#define OMAP243X_CTRL_BASE	OMAP243X_SCM_BASE
+#define OMAP243X_HS_BASE	(L4_24XX_BASE + 0x000ac000)
 
 /* DSP SS */
-#define OMAP24XX_DSP_BASE	0x58000000
-#define OMAP24XX_DSP_MEM_BASE	(OMAP24XX_DSP_BASE + 0x0)
-#define OMAP24XX_DSP_IPI_BASE	(OMAP24XX_DSP_BASE + 0x1000000)
-#define OMAP24XX_DSP_MMU_BASE	(OMAP24XX_DSP_BASE + 0x2000000)
+#define OMAP2420_DSP_BASE	0x58000000
+#define OMAP2420_DSP_MEM_BASE	(OMAP2420_DSP_BASE + 0x0)
+#define OMAP2420_DSP_IPI_BASE	(OMAP2420_DSP_BASE + 0x1000000)
+#define OMAP2420_DSP_MMU_BASE	(OMAP2420_DSP_BASE + 0x2000000)
+
+#define OMAP243X_DSP_BASE	0x5C000000
+#define OMAP243X_DSP_MEM_BASE	(OMAP243X_DSP_BASE + 0x0)
+#define OMAP243X_DSP_MMU_BASE	(OMAP243X_DSP_BASE + 0x1000000)
 
 /* Mailbox */
 #define OMAP24XX_MAILBOX_BASE	(L4_24XX_BASE + 0x94000)
 
+/* Camera */
+#define OMAP24XX_CAMERA_BASE	(L4_24XX_BASE + 0x52000)
+
+/* Security */
+#define OMAP24XX_SEC_BASE	(L4_24XX_BASE + 0xA0000)
+#define OMAP24XX_SEC_RNG_BASE	(OMAP24XX_SEC_BASE + 0x0000)
+#define OMAP24XX_SEC_DES_BASE	(OMAP24XX_SEC_BASE + 0x2000)
+#define OMAP24XX_SEC_SHA1MD5_BASE (OMAP24XX_SEC_BASE + 0x4000)
+#define OMAP24XX_SEC_AES_BASE	(OMAP24XX_SEC_BASE + 0x6000)
+#define OMAP24XX_SEC_PKA_BASE	(OMAP24XX_SEC_BASE + 0x8000)
+
+#if defined(CONFIG_ARCH_OMAP2420)
+
+#define OMAP2_32KSYNCT_BASE	OMAP2420_32KSYNCT_BASE
+#define OMAP2_PRCM_BASE		OMAP2420_PRCM_BASE
+#define OMAP2_CM_BASE		OMAP2420_CM_BASE
+#define OMAP2_PRM_BASE		OMAP2420_PRM_BASE
+#define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
+
+#elif defined(CONFIG_ARCH_OMAP2430)
+
+#define OMAP2_32KSYNCT_BASE	OMAP2430_32KSYNCT_BASE
+#define OMAP2_PRCM_BASE		OMAP2430_PRCM_BASE
+#define OMAP2_CM_BASE		OMAP2430_CM_BASE
+#define OMAP2_PRM_BASE		OMAP2430_PRM_BASE
+#define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
+
+#endif
+
 #endif /* __ASM_ARCH_OMAP24XX_H */
 
-- 
1.5.3.6

