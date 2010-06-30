From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/16] omap: mux: Remove old mux code
Date: Wed, 30 Jun 2010 15:07:31 +0300
Message-ID: <20100630120731.2637.92183.stgit@baageli.muru.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58189 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab0F3MHT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:07:19 -0400
In-Reply-To: <20100630120226.2637.31198.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

All mach-omap2 omaps should now use the new mux code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3630sdp.c          |    1 
 arch/arm/mach-omap2/board-generic.c          |    1 
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 
 arch/arm/mach-omap2/board-rx51-video.c       |    1 
 arch/arm/mach-omap2/io.c                     |    2 
 arch/arm/mach-omap2/mux.c                    |  298 --------------------------
 arch/arm/mach-omap2/pm24xx.c                 |    1 
 arch/arm/mach-omap2/usb-ehci.c               |    1 
 arch/arm/mach-omap2/usb-musb.c               |    1 
 arch/arm/plat-omap/include/plat/mux.h        |  220 -------------------
 arch/arm/plat-omap/mux.c                     |    2 
 11 files changed, 1 insertions(+), 528 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 504d2bd..f267dc0 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -18,7 +18,6 @@
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/gpmc-smc91x.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 
 #include <mach/board-zoom.h>
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 16cc068..9a7f790 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -26,7 +26,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/gpio.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index abdf321..5ddf156 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -25,7 +25,6 @@
 #include <linux/mmc/host.h>
 
 #include <plat/mcspi.h>
-#include <plat/mux.h>
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/dma.h>
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index b743a4f..5a1005b 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -16,7 +16,6 @@
 #include <linux/mm.h>
 
 #include <asm/mach-types.h>
-#include <plat/mux.h>
 #include <plat/display.h>
 #include <plat/vram.h>
 #include <plat/mcspi.h>
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3cfb425..b12d715 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -28,7 +28,6 @@
 
 #include <asm/mach/map.h>
 
-#include <plat/mux.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
 #include <plat/gpmc.h>
@@ -324,7 +323,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		omap2430_hwmod_init();
 	else if (cpu_is_omap34xx())
 		omap3xxx_hwmod_init();
-	omap2_mux_init();
 	/* The OPP tables have to be registered before a clk init */
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 197e295..be52fab 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -37,7 +37,6 @@
 #include <asm/system.h>
 
 #include <plat/control.h>
-#include <plat/mux.h>
 
 #include "mux.h"
 
@@ -78,301 +77,6 @@ void omap_mux_write_array(struct omap_board_mux *board_mux)
 	}
 }
 
-#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_OMAP_MUX)
-
-static struct omap_mux_cfg arch_mux_cfg;
-
-/* NOTE: See mux.h for the enumeration */
-
-static struct pin_config __initdata_or_module omap24xx_pins[] = {
-/*
- *	description			mux	mux	pull	pull	debug
- *					offset	mode	ena	type
- */
-
-/* 24xx I2C */
-MUX_CFG_24XX("M19_24XX_I2C1_SCL",	0x111,	0,	0,	0,	1)
-MUX_CFG_24XX("L15_24XX_I2C1_SDA",	0x112,	0,	0,	0,	1)
-MUX_CFG_24XX("J15_24XX_I2C2_SCL",	0x113,	0,	0,	1,	1)
-MUX_CFG_24XX("H19_24XX_I2C2_SDA",	0x114,	0,	0,	0,	1)
-
-/* Menelaus interrupt */
-MUX_CFG_24XX("W19_24XX_SYS_NIRQ",	0x12c,	0,	1,	1,	1)
-
-/* 24xx clocks */
-MUX_CFG_24XX("W14_24XX_SYS_CLKOUT",	0x137,	0,	1,	1,	1)
-
-/* 24xx GPMC chipselects, wait pin monitoring */
-MUX_CFG_24XX("E2_GPMC_NCS2",		0x08e,	0,	1,	1,	1)
-MUX_CFG_24XX("L2_GPMC_NCS7",		0x093,	0,	1,	1,	1)
-MUX_CFG_24XX("L3_GPMC_WAIT0",		0x09a,	0,	1,	1,	1)
-MUX_CFG_24XX("N7_GPMC_WAIT1",		0x09b,	0,	1,	1,	1)
-MUX_CFG_24XX("M1_GPMC_WAIT2",		0x09c,	0,	1,	1,	1)
-MUX_CFG_24XX("P1_GPMC_WAIT3",		0x09d,	0,	1,	1,	1)
-
-/* 24xx McBSP */
-MUX_CFG_24XX("Y15_24XX_MCBSP2_CLKX",	0x124,	1,	1,	0,	1)
-MUX_CFG_24XX("R14_24XX_MCBSP2_FSX",	0x125,	1,	1,	0,	1)
-MUX_CFG_24XX("W15_24XX_MCBSP2_DR",	0x126,	1,	1,	0,	1)
-MUX_CFG_24XX("V15_24XX_MCBSP2_DX",	0x127,	1,	1,	0,	1)
-
-/* 24xx GPIO */
-MUX_CFG_24XX("M21_242X_GPIO11",		0x0c9,	3,	1,	1,	1)
-MUX_CFG_24XX("P21_242X_GPIO12",		0x0ca,	3,	0,	0,	1)
-MUX_CFG_24XX("AA10_242X_GPIO13",	0x0e5,	3,	0,	0,	1)
-MUX_CFG_24XX("AA6_242X_GPIO14",		0x0e6,	3,	0,	0,	1)
-MUX_CFG_24XX("AA4_242X_GPIO15",		0x0e7,	3,	0,	0,	1)
-MUX_CFG_24XX("Y11_242X_GPIO16",		0x0e8,	3,	0,	0,	1)
-MUX_CFG_24XX("AA12_242X_GPIO17",	0x0e9,	3,	0,	0,	1)
-MUX_CFG_24XX("AA8_242X_GPIO58",		0x0ea,	3,	0,	0,	1)
-MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,	1)
-MUX_CFG_24XX("W4__24XX_GPIO74",		0x0f2,	3,	0,	0,	1)
-MUX_CFG_24XX("N15_24XX_GPIO85",		0x103,	3,	0,	0,	1)
-MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,	1)
-MUX_CFG_24XX("P20_24XX_GPIO93",		0x10b,	3,	0,	0,	1)
-MUX_CFG_24XX("P18_24XX_GPIO95",		0x10d,	3,	0,	0,	1)
-MUX_CFG_24XX("M18_24XX_GPIO96",		0x10e,	3,	0,	0,	1)
-MUX_CFG_24XX("L14_24XX_GPIO97",		0x10f,	3,	0,	0,	1)
-MUX_CFG_24XX("J15_24XX_GPIO99",		0x113,	3,	1,	1,	1)
-MUX_CFG_24XX("V14_24XX_GPIO117",	0x128,	3,	1,	0,	1)
-MUX_CFG_24XX("P14_24XX_GPIO125",	0x140,	3,	1,	1,	1)
-
-/* 242x DBG GPIO */
-MUX_CFG_24XX("V4_242X_GPIO49",		0xd3,	3,	0,	0,	1)
-MUX_CFG_24XX("W2_242X_GPIO50",		0xd4,	3,	0,	0,	1)
-MUX_CFG_24XX("U4_242X_GPIO51",		0xd5,	3,	0,	0,	1)
-MUX_CFG_24XX("V3_242X_GPIO52",		0xd6,	3,	0,	0,	1)
-MUX_CFG_24XX("V2_242X_GPIO53",		0xd7,	3,	0,	0,	1)
-MUX_CFG_24XX("V6_242X_GPIO53",		0xcf,	3,	0,	0,	1)
-MUX_CFG_24XX("T4_242X_GPIO54",		0xd8,	3,	0,	0,	1)
-MUX_CFG_24XX("Y4_242X_GPIO54",		0xd0,	3,	0,	0,	1)
-MUX_CFG_24XX("T3_242X_GPIO55",		0xd9,	3,	0,	0,	1)
-MUX_CFG_24XX("U2_242X_GPIO56",		0xda,	3,	0,	0,	1)
-
-/* 24xx external DMA requests */
-MUX_CFG_24XX("AA10_242X_DMAREQ0",	0x0e5,	2,	0,	0,	1)
-MUX_CFG_24XX("AA6_242X_DMAREQ1",	0x0e6,	2,	0,	0,	1)
-MUX_CFG_24XX("E4_242X_DMAREQ2",		0x074,	2,	0,	0,	1)
-MUX_CFG_24XX("G4_242X_DMAREQ3",		0x073,	2,	0,	0,	1)
-MUX_CFG_24XX("D3_242X_DMAREQ4",		0x072,	2,	0,	0,	1)
-MUX_CFG_24XX("E3_242X_DMAREQ5",		0x071,	2,	0,	0,	1)
-
-/* UART3 */
-MUX_CFG_24XX("K15_24XX_UART3_TX",	0x118,	0,	0,	0,	1)
-MUX_CFG_24XX("K14_24XX_UART3_RX",	0x119,	0,	0,	0,	1)
-
-/* MMC/SDIO */
-MUX_CFG_24XX("G19_24XX_MMC_CLKO",	0x0f3,	0,	0,	0,	1)
-MUX_CFG_24XX("H18_24XX_MMC_CMD",	0x0f4,	0,	0,	0,	1)
-MUX_CFG_24XX("F20_24XX_MMC_DAT0",	0x0f5,	0,	0,	0,	1)
-MUX_CFG_24XX("H14_24XX_MMC_DAT1",	0x0f6,	0,	0,	0,	1)
-MUX_CFG_24XX("E19_24XX_MMC_DAT2",	0x0f7,	0,	0,	0,	1)
-MUX_CFG_24XX("D19_24XX_MMC_DAT3",	0x0f8,	0,	0,	0,	1)
-MUX_CFG_24XX("F19_24XX_MMC_DAT_DIR0",	0x0f9,	0,	0,	0,	1)
-MUX_CFG_24XX("E20_24XX_MMC_DAT_DIR1",	0x0fa,	0,	0,	0,	1)
-MUX_CFG_24XX("F18_24XX_MMC_DAT_DIR2",	0x0fb,	0,	0,	0,	1)
-MUX_CFG_24XX("E18_24XX_MMC_DAT_DIR3",	0x0fc,	0,	0,	0,	1)
-MUX_CFG_24XX("G18_24XX_MMC_CMD_DIR",	0x0fd,	0,	0,	0,	1)
-MUX_CFG_24XX("H15_24XX_MMC_CLKI",	0x0fe,	0,	0,	0,	1)
-
-/* Full speed USB */
-MUX_CFG_24XX("J20_24XX_USB0_PUEN",	0x11d,	0,	0,	0,	1)
-MUX_CFG_24XX("J19_24XX_USB0_VP",	0x11e,	0,	0,	0,	1)
-MUX_CFG_24XX("K20_24XX_USB0_VM",	0x11f,	0,	0,	0,	1)
-MUX_CFG_24XX("J18_24XX_USB0_RCV",	0x120,	0,	0,	0,	1)
-MUX_CFG_24XX("K19_24XX_USB0_TXEN",	0x121,	0,	0,	0,	1)
-MUX_CFG_24XX("J14_24XX_USB0_SE0",	0x122,	0,	0,	0,	1)
-MUX_CFG_24XX("K18_24XX_USB0_DAT",	0x123,	0,	0,	0,	1)
-
-MUX_CFG_24XX("N14_24XX_USB1_SE0",	0x0ed,	2,	0,	0,	1)
-MUX_CFG_24XX("W12_24XX_USB1_SE0",	0x0dd,	3,	0,	0,	1)
-MUX_CFG_24XX("P15_24XX_USB1_DAT",	0x0ee,	2,	0,	0,	1)
-MUX_CFG_24XX("R13_24XX_USB1_DAT",	0x0e0,	3,	0,	0,	1)
-MUX_CFG_24XX("W20_24XX_USB1_TXEN",	0x0ec,	2,	0,	0,	1)
-MUX_CFG_24XX("P13_24XX_USB1_TXEN",	0x0df,	3,	0,	0,	1)
-MUX_CFG_24XX("V19_24XX_USB1_RCV",	0x0eb,	2,	0,	0,	1)
-MUX_CFG_24XX("V12_24XX_USB1_RCV",	0x0de,	3,	0,	0,	1)
-
-MUX_CFG_24XX("AA10_24XX_USB2_SE0",	0x0e5,	2,	0,	0,	1)
-MUX_CFG_24XX("Y11_24XX_USB2_DAT",	0x0e8,	2,	0,	0,	1)
-MUX_CFG_24XX("AA12_24XX_USB2_TXEN",	0x0e9,	2,	0,	0,	1)
-MUX_CFG_24XX("AA6_24XX_USB2_RCV",	0x0e6,	2,	0,	0,	1)
-MUX_CFG_24XX("AA4_24XX_USB2_TLLSE0",	0x0e7,	2,	0,	0,	1)
-
-/* Keypad GPIO*/
-MUX_CFG_24XX("T19_24XX_KBR0",		0x106,	3,	1,	1,	1)
-MUX_CFG_24XX("R19_24XX_KBR1",		0x107,	3,	1,	1,	1)
-MUX_CFG_24XX("V18_24XX_KBR2",		0x139,	3,	1,	1,	1)
-MUX_CFG_24XX("M21_24XX_KBR3",		0xc9,	3,	1,	1,	1)
-MUX_CFG_24XX("E5__24XX_KBR4",		0x138,	3,	1,	1,	1)
-MUX_CFG_24XX("M18_24XX_KBR5",		0x10e,	3,	1,	1,	1)
-MUX_CFG_24XX("R20_24XX_KBC0",		0x108,	3,	0,	0,	1)
-MUX_CFG_24XX("M14_24XX_KBC1",		0x109,	3,	0,	0,	1)
-MUX_CFG_24XX("H19_24XX_KBC2",		0x114,	3,	0,	0,	1)
-MUX_CFG_24XX("V17_24XX_KBC3",		0x135,	3,	0,	0,	1)
-MUX_CFG_24XX("P21_24XX_KBC4",		0xca,	3,	0,	0,	1)
-MUX_CFG_24XX("L14_24XX_KBC5",		0x10f,	3,	0,	0,	1)
-MUX_CFG_24XX("N19_24XX_KBC6",		0x110,	3,	0,	0,	1)
-
-/* 24xx Menelaus Keypad GPIO */
-MUX_CFG_24XX("B3__24XX_KBR5",		0x30,	3,	1,	1,	1)
-MUX_CFG_24XX("AA4_24XX_KBC2",		0xe7,	3,	0,	0,	1)
-MUX_CFG_24XX("B13_24XX_KBC6",		0x110,	3,	0,	0,	1)
-
-/* 2430 USB */
-MUX_CFG_24XX("AD9_2430_USB0_PUEN",	0x133,	4,	0,	0,	1)
-MUX_CFG_24XX("Y11_2430_USB0_VP",	0x134,	4,	0,	0,	1)
-MUX_CFG_24XX("AD7_2430_USB0_VM",	0x135,	4,	0,	0,	1)
-MUX_CFG_24XX("AE7_2430_USB0_RCV",	0x136,	4,	0,	0,	1)
-MUX_CFG_24XX("AD4_2430_USB0_TXEN",	0x137,	4,	0,	0,	1)
-MUX_CFG_24XX("AF9_2430_USB0_SE0",	0x138,	4,	0,	0,	1)
-MUX_CFG_24XX("AE6_2430_USB0_DAT",	0x139,	4,	0,	0,	1)
-MUX_CFG_24XX("AD24_2430_USB1_SE0",	0x107,	2,	0,	0,	1)
-MUX_CFG_24XX("AB24_2430_USB1_RCV",	0x108,	2,	0,	0,	1)
-MUX_CFG_24XX("Y25_2430_USB1_TXEN",	0x109,	2,	0,	0,	1)
-MUX_CFG_24XX("AA26_2430_USB1_DAT",	0x10A,	2,	0,	0,	1)
-
-/* 2430 HS-USB */
-MUX_CFG_24XX("AD9_2430_USB0HS_DATA3",	0x133,	0,	0,	0,	1)
-MUX_CFG_24XX("Y11_2430_USB0HS_DATA4",	0x134,	0,	0,	0,	1)
-MUX_CFG_24XX("AD7_2430_USB0HS_DATA5",	0x135,	0,	0,	0,	1)
-MUX_CFG_24XX("AE7_2430_USB0HS_DATA6",	0x136,	0,	0,	0,	1)
-MUX_CFG_24XX("AD4_2430_USB0HS_DATA2",	0x137,	0,	0,	0,	1)
-MUX_CFG_24XX("AF9_2430_USB0HS_DATA0",	0x138,	0,	0,	0,	1)
-MUX_CFG_24XX("AE6_2430_USB0HS_DATA1",	0x139,	0,	0,	0,	1)
-MUX_CFG_24XX("AE8_2430_USB0HS_CLK",	0x13A,	0,	0,	0,	1)
-MUX_CFG_24XX("AD8_2430_USB0HS_DIR",	0x13B,	0,	0,	0,	1)
-MUX_CFG_24XX("AE5_2430_USB0HS_STP",	0x13c,	0,	1,	1,	1)
-MUX_CFG_24XX("AE9_2430_USB0HS_NXT",	0x13D,	0,	0,	0,	1)
-MUX_CFG_24XX("AC7_2430_USB0HS_DATA7",	0x13E,	0,	0,	0,	1)
-
-/* 2430 McBSP */
-MUX_CFG_24XX("AD6_2430_MCBSP_CLKS",	0x011E,	0,	0,	0,	1)
-
-MUX_CFG_24XX("AB2_2430_MCBSP1_CLKR",	0x011A,	0,	0,	0,	1)
-MUX_CFG_24XX("AD5_2430_MCBSP1_FSR",	0x011B,	0,	0,	0,	1)
-MUX_CFG_24XX("AA1_2430_MCBSP1_DX",	0x011C,	0,	0,	0,	1)
-MUX_CFG_24XX("AF3_2430_MCBSP1_DR",	0x011D,	0,	0,	0,	1)
-MUX_CFG_24XX("AB3_2430_MCBSP1_FSX",	0x011F,	0,	0,	0,	1)
-MUX_CFG_24XX("Y9_2430_MCBSP1_CLKX",	0x0120,	0,	0,	0,	1)
-
-MUX_CFG_24XX("AC10_2430_MCBSP2_FSX",	0x012E,	1,	0,	0,	1)
-MUX_CFG_24XX("AD16_2430_MCBSP2_CLX",	0x012F,	1,	0,	0,	1)
-MUX_CFG_24XX("AE13_2430_MCBSP2_DX",	0x0130,	1,	0,	0,	1)
-MUX_CFG_24XX("AD13_2430_MCBSP2_DR",	0x0131,	1,	0,	0,	1)
-MUX_CFG_24XX("AC10_2430_MCBSP2_FSX_OFF",0x012E,	0,	0,	0,	1)
-MUX_CFG_24XX("AD16_2430_MCBSP2_CLX_OFF",0x012F,	0,	0,	0,	1)
-MUX_CFG_24XX("AE13_2430_MCBSP2_DX_OFF",	0x0130,	0,	0,	0,	1)
-MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)
-
-MUX_CFG_24XX("AC9_2430_MCBSP3_CLKX",	0x0103,	0,	0,	0,	1)
-MUX_CFG_24XX("AE4_2430_MCBSP3_FSX",	0x0104,	0,	0,	0,	1)
-MUX_CFG_24XX("AE2_2430_MCBSP3_DR",	0x0105,	0,	0,	0,	1)
-MUX_CFG_24XX("AF4_2430_MCBSP3_DX",	0x0106,	0,	0,	0,	1)
-
-MUX_CFG_24XX("N3_2430_MCBSP4_CLKX",	0x010B,	1,	0,	0,	1)
-MUX_CFG_24XX("AD23_2430_MCBSP4_DR",	0x010C,	1,	0,	0,	1)
-MUX_CFG_24XX("AB25_2430_MCBSP4_DX",	0x010D,	1,	0,	0,	1)
-MUX_CFG_24XX("AC25_2430_MCBSP4_FSX",	0x010E,	1,	0,	0,	1)
-
-MUX_CFG_24XX("AE16_2430_MCBSP5_CLKX",	0x00ED,	1,	0,	0,	1)
-MUX_CFG_24XX("AF12_2430_MCBSP5_FSX",	0x00ED,	1,	0,	0,	1)
-MUX_CFG_24XX("K7_2430_MCBSP5_DX",	0x00EF,	1,	0,	0,	1)
-MUX_CFG_24XX("M1_2430_MCBSP5_DR",	0x00F0,	1,	0,	0,	1)
-
-/* 2430 MCSPI1 */
-MUX_CFG_24XX("Y18_2430_MCSPI1_CLK",	0x010F,	0,	0,	0,	1)
-MUX_CFG_24XX("AD15_2430_MCSPI1_SIMO",	0x0110,	0,	0,	0,	1)
-MUX_CFG_24XX("AE17_2430_MCSPI1_SOMI",	0x0111,	0,	0,	0,	1)
-MUX_CFG_24XX("U1_2430_MCSPI1_CS0",	0x0112,	0,	0,	0,	1)
-
-/* Touchscreen GPIO */
-MUX_CFG_24XX("AF19_2430_GPIO_85",	0x0113,	3,	0,	0,	1)
-
-};
-
-#define OMAP24XX_PINS_SZ	ARRAY_SIZE(omap24xx_pins)
-
-#if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
-
-static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 reg)
-{
-	u16 orig;
-	u8 warn = 0, debug = 0;
-
-	orig = omap_mux_read(cfg->mux_reg - OMAP_MUX_BASE_OFFSET);
-
-#ifdef	CONFIG_OMAP_MUX_DEBUG
-	debug = cfg->debug;
-#endif
-	warn = (orig != reg);
-	if (debug || warn)
-		printk(KERN_WARNING
-			"MUX: setup %s (0x%p): 0x%04x -> 0x%04x\n",
-			cfg->name, omap_ctrl_base_get() + cfg->mux_reg,
-			orig, reg);
-}
-#else
-#define omap2_cfg_debug(x, y)	do {} while (0)
-#endif
-
-static int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
-{
-	static DEFINE_SPINLOCK(mux_spin_lock);
-	unsigned long flags;
-	u8 reg = 0;
-
-	spin_lock_irqsave(&mux_spin_lock, flags);
-	reg |= cfg->mask & 0x7;
-	if (cfg->pull_val)
-		reg |= OMAP2_PULL_ENA;
-	if (cfg->pu_pd_val)
-		reg |= OMAP2_PULL_UP;
-	omap2_cfg_debug(cfg, reg);
-	omap_mux_write(reg, cfg->mux_reg - OMAP_MUX_BASE_OFFSET);
-	spin_unlock_irqrestore(&mux_spin_lock, flags);
-
-	return 0;
-}
-
-int __init omap2_mux_init(void)
-{
-	u32 mux_pbase;
-
-	if (cpu_is_omap2420())
-		mux_pbase = OMAP2420_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
-	else if (cpu_is_omap2430())
-		mux_pbase = OMAP243X_CTRL_BASE + OMAP_MUX_BASE_OFFSET;
-	else
-		return -ENODEV;
-
-	mux_base = ioremap(mux_pbase, OMAP_MUX_BASE_SZ);
-	if (!mux_base) {
-		printk(KERN_ERR "mux: Could not ioremap\n");
-		return -ENODEV;
-	}
-
-	if (cpu_is_omap24xx()) {
-		arch_mux_cfg.pins	= omap24xx_pins;
-		arch_mux_cfg.size	= OMAP24XX_PINS_SZ;
-		arch_mux_cfg.cfg_reg	= omap24xx_cfg_reg;
-
-		return omap_mux_register(&arch_mux_cfg);
-	}
-
-	return 0;
-}
-
-#else
-int __init omap2_mux_init(void)
-{
-	return 0;
-}
-#endif	/* CONFIG_OMAP_MUX */
-
-/*----------------------------------------------------------------------------*/
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
 static LIST_HEAD(muxmodes);
 static DEFINE_MUTEX(muxmode_mutex);
 
@@ -1047,5 +751,3 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 	return 0;
 }
 
-#endif	/* CONFIG_ARCH_OMAP3 */
-
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index e321281..6aeedea 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -39,7 +39,6 @@
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/control.h>
-#include <plat/mux.h>
 #include <plat/dma.h>
 #include <plat/board.h>
 
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index d72d1ac..b11bf38 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -23,7 +23,6 @@
 #include <linux/dma-mapping.h>
 
 #include <asm/io.h>
-#include <plat/mux.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 96f6787..33a5cde 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -28,7 +28,6 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <plat/mux.h>
 #include <plat/usb.h>
 
 #ifdef CONFIG_USB_MUSB_SOC
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index c7472a2..e1da7b1 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -114,28 +114,11 @@
 	PU_PD_REG(NA, 0)		\
 },
 
-#define MUX_CFG_24XX(desc, reg_offset, mode,			\
-				pull_en, pull_mode, dbg)	\
-{								\
-	.name		= desc,					\
-	.debug		= dbg,					\
-	.mux_reg	= reg_offset,				\
-	.mask		= mode,					\
-	.pull_val	= pull_en,				\
-	.pu_pd_val	= pull_mode,				\
-},
-
-/* 24xx/34xx mux bit defines */
-#define OMAP2_PULL_ENA		(1 << 3)
-#define OMAP2_PULL_UP		(1 << 4)
-#define OMAP2_ALTELECTRICALSEL	(1 << 5)
-
 struct pin_config {
 	char 			*name;
 	const unsigned int 	mux_reg;
 	unsigned char		debug;
 
-#if	defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2)
 	const unsigned char mask_offset;
 	const unsigned char mask;
 
@@ -147,7 +130,6 @@ struct pin_config {
 	const char *pu_pd_name;
 	const unsigned int pu_pd_reg;
 	const unsigned char pu_pd_val;
-#endif
 
 #if	defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
 	const char *mux_reg_name;
@@ -446,208 +428,6 @@ enum omap1xxx_index {
 
 };
 
-enum omap24xx_index {
-	/* 24xx I2C */
-	M19_24XX_I2C1_SCL,
-	L15_24XX_I2C1_SDA,
-	J15_24XX_I2C2_SCL,
-	H19_24XX_I2C2_SDA,
-
-	/* 24xx Menelaus interrupt */
-	W19_24XX_SYS_NIRQ,
-
-	/* 24xx clock */
-	W14_24XX_SYS_CLKOUT,
-
-	/* 24xx GPMC chipselects, wait pin monitoring */
-	E2_GPMC_NCS2,
-	L2_GPMC_NCS7,
-	L3_GPMC_WAIT0,
-	N7_GPMC_WAIT1,
-	M1_GPMC_WAIT2,
-	P1_GPMC_WAIT3,
-
-	/* 242X McBSP */
-	Y15_24XX_MCBSP2_CLKX,
-	R14_24XX_MCBSP2_FSX,
-	W15_24XX_MCBSP2_DR,
-	V15_24XX_MCBSP2_DX,
-
-	/* 24xx GPIO */
-	M21_242X_GPIO11,
-	P21_242X_GPIO12,
-	AA10_242X_GPIO13,
-	AA6_242X_GPIO14,
-	AA4_242X_GPIO15,
-	Y11_242X_GPIO16,
-	AA12_242X_GPIO17,
-	AA8_242X_GPIO58,
-	Y20_24XX_GPIO60,
-	W4__24XX_GPIO74,
-	N15_24XX_GPIO85,
-	M15_24XX_GPIO92,
-	P20_24XX_GPIO93,
-	P18_24XX_GPIO95,
-	M18_24XX_GPIO96,
-	L14_24XX_GPIO97,
-	J15_24XX_GPIO99,
-	V14_24XX_GPIO117,
-	P14_24XX_GPIO125,
-
-	/* 242x DBG GPIO */
-	V4_242X_GPIO49,
-	W2_242X_GPIO50,
-	U4_242X_GPIO51,
-	V3_242X_GPIO52,
-	V2_242X_GPIO53,
-	V6_242X_GPIO53,
-	T4_242X_GPIO54,
-	Y4_242X_GPIO54,
-	T3_242X_GPIO55,
-	U2_242X_GPIO56,
-
-	/* 24xx external DMA requests */
-	AA10_242X_DMAREQ0,
-	AA6_242X_DMAREQ1,
-	E4_242X_DMAREQ2,
-	G4_242X_DMAREQ3,
-	D3_242X_DMAREQ4,
-	E3_242X_DMAREQ5,
-
-	/* UART3 */
-	K15_24XX_UART3_TX,
-	K14_24XX_UART3_RX,
-
-	/* MMC/SDIO */
-	G19_24XX_MMC_CLKO,
-	H18_24XX_MMC_CMD,
-	F20_24XX_MMC_DAT0,
-	H14_24XX_MMC_DAT1,
-	E19_24XX_MMC_DAT2,
-	D19_24XX_MMC_DAT3,
-	F19_24XX_MMC_DAT_DIR0,
-	E20_24XX_MMC_DAT_DIR1,
-	F18_24XX_MMC_DAT_DIR2,
-	E18_24XX_MMC_DAT_DIR3,
-	G18_24XX_MMC_CMD_DIR,
-	H15_24XX_MMC_CLKI,
-
-	/* Full speed USB */
-	J20_24XX_USB0_PUEN,
-	J19_24XX_USB0_VP,
-	K20_24XX_USB0_VM,
-	J18_24XX_USB0_RCV,
-	K19_24XX_USB0_TXEN,
-	J14_24XX_USB0_SE0,
-	K18_24XX_USB0_DAT,
-
-	N14_24XX_USB1_SE0,
-	W12_24XX_USB1_SE0,
-	P15_24XX_USB1_DAT,
-	R13_24XX_USB1_DAT,
-	W20_24XX_USB1_TXEN,
-	P13_24XX_USB1_TXEN,
-	V19_24XX_USB1_RCV,
-	V12_24XX_USB1_RCV,
-
-	AA10_24XX_USB2_SE0,
-	Y11_24XX_USB2_DAT,
-	AA12_24XX_USB2_TXEN,
-	AA6_24XX_USB2_RCV,
-	AA4_24XX_USB2_TLLSE0,
-
-	/* Keypad GPIO*/
-	T19_24XX_KBR0,
-	R19_24XX_KBR1,
-	V18_24XX_KBR2,
-	M21_24XX_KBR3,
-	E5__24XX_KBR4,
-	M18_24XX_KBR5,
-	R20_24XX_KBC0,
-	M14_24XX_KBC1,
-	H19_24XX_KBC2,
-	V17_24XX_KBC3,
-	P21_24XX_KBC4,
-	L14_24XX_KBC5,
-	N19_24XX_KBC6,
-
-	/* 24xx Menelaus Keypad GPIO */
-	B3__24XX_KBR5,
-	AA4_24XX_KBC2,
-	B13_24XX_KBC6,
-
-	/* 2430 USB */
-	AD9_2430_USB0_PUEN,
-	Y11_2430_USB0_VP,
-	AD7_2430_USB0_VM,
-	AE7_2430_USB0_RCV,
-	AD4_2430_USB0_TXEN,
-	AF9_2430_USB0_SE0,
-	AE6_2430_USB0_DAT,
-	AD24_2430_USB1_SE0,
-	AB24_2430_USB1_RCV,
-	Y25_2430_USB1_TXEN,
-	AA26_2430_USB1_DAT,
-
-	/* 2430 HS-USB */
-	AD9_2430_USB0HS_DATA3,
-	Y11_2430_USB0HS_DATA4,
-	AD7_2430_USB0HS_DATA5,
-	AE7_2430_USB0HS_DATA6,
-	AD4_2430_USB0HS_DATA2,
-	AF9_2430_USB0HS_DATA0,
-	AE6_2430_USB0HS_DATA1,
-	AE8_2430_USB0HS_CLK,
-	AD8_2430_USB0HS_DIR,
-	AE5_2430_USB0HS_STP,
-	AE9_2430_USB0HS_NXT,
-	AC7_2430_USB0HS_DATA7,
-
-	/* 2430 McBSP */
-	AD6_2430_MCBSP_CLKS,
-
-	AB2_2430_MCBSP1_CLKR,
-	AD5_2430_MCBSP1_FSR,
-	AA1_2430_MCBSP1_DX,
-	AF3_2430_MCBSP1_DR,
-	AB3_2430_MCBSP1_FSX,
-	Y9_2430_MCBSP1_CLKX,
-
-	AC10_2430_MCBSP2_FSX,
-	AD16_2430_MCBSP2_CLX,
-	AE13_2430_MCBSP2_DX,
-	AD13_2430_MCBSP2_DR,
-	AC10_2430_MCBSP2_FSX_OFF,
-	AD16_2430_MCBSP2_CLX_OFF,
-	AE13_2430_MCBSP2_DX_OFF,
-	AD13_2430_MCBSP2_DR_OFF,
-
-	AC9_2430_MCBSP3_CLKX,
-	AE4_2430_MCBSP3_FSX,
-	AE2_2430_MCBSP3_DR,
-	AF4_2430_MCBSP3_DX,
-
-	N3_2430_MCBSP4_CLKX,
-	AD23_2430_MCBSP4_DR,
-	AB25_2430_MCBSP4_DX,
-	AC25_2430_MCBSP4_FSX,
-
-	AE16_2430_MCBSP5_CLKX,
-	AF12_2430_MCBSP5_FSX,
-	K7_2430_MCBSP5_DX,
-	M1_2430_MCBSP5_DR,
-
-	/* 2430 McSPI*/
-	Y18_2430_MCSPI1_CLK,
-	AD15_2430_MCSPI1_SIMO,
-	AE17_2430_MCSPI1_SOMI,
-	U1_2430_MCSPI1_CS0,
-
-	/* Touchscreen GPIO */
-	AF19_2430_GPIO_85,
-
-};
-
 struct omap_mux_cfg {
 	struct pin_config	*pins;
 	unsigned long		size;
diff --git a/arch/arm/plat-omap/mux.c b/arch/arm/plat-omap/mux.c
index 0670363..0d4aa0d 100644
--- a/arch/arm/plat-omap/mux.c
+++ b/arch/arm/plat-omap/mux.c
@@ -54,7 +54,7 @@ int __init_or_module omap_cfg_reg(const unsigned long index)
 {
 	struct pin_config *reg;
 
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (!cpu_class_is_omap1()) {
 		printk(KERN_ERR "mux: Broken omap_cfg_reg(%lu) entry\n",
 				index);
 		WARN_ON(1);

