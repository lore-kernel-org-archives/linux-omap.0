From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH v2] omap3: cm-t35: add mux initialization
Date: Wed,  9 Dec 2009 08:49:07 +0200
Message-ID: <1260341347-10204-1-git-send-email-mike@compulab.co.il>
References: <20091207174446.GY24013@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:56465 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755590AbZLIGtK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 01:49:10 -0500
In-Reply-To: <20091207174446.GY24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: gadiyar@ti.com, linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

CM-T35 can be assembled with different set of peripherals thus making
certain interfaces available to user as GPIOs or dedicated pins. Because
of it CM-T35 bootloader sets up mux configuration only for pins
necessary to boot the system and the rest of the mux configuration is
done by the kernel. Besides, having mux configuration in the kernel
allows to minimize dependancy on bootloader.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/Kconfig        |    1 +
 arch/arm/mach-omap2/board-cm-t35.c |   95 +++++++++++++++++++++++++++++++++--
 2 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 034d990..96e7e3f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -108,6 +108,7 @@ config MACH_OMAP_ZOOM3
 config MACH_CM_T35
 	bool "CompuLab CM-T35 module"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select OMAP_MUX
 
 config MACH_IGEP0020
 	bool "IGEP0020"
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index e5f3039..c28afd6 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -482,13 +482,98 @@ static void __init cm_t35_map_io(void)
 	omap2_map_common_io();
 }
 
-#ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	/* nCS and IRQ for CM-T35 ethernet */
+	OMAP3_MUX(GPMC_NCS5, OMAP_MUX_MODE0),
+	OMAP3_MUX(UART3_CTS_RCTX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+
+	/* nCS and IRQ for SB-T35 ethernet */
+	OMAP3_MUX(GPMC_NCS4, OMAP_MUX_MODE0),
+	OMAP3_MUX(GPMC_WAIT3, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+
+	/* PENDOWN GPIO */
+	OMAP3_MUX(GPMC_NCS6, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+
+	/* mUSB */
+	OMAP3_MUX(HSUSB0_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_STP, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(HSUSB0_DIR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_NXT, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA4, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA5, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(HSUSB0_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+
+	/* MMC 2 */
+	OMAP3_MUX(MMC2_DAT4, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(MMC2_DAT5, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(MMC2_DAT6, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(MMC2_DAT7, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+
+	/* McSPI 1 */
+	OMAP3_MUX(MCSPI1_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCSPI1_SIMO, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCSPI1_SOMI, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCSPI1_CS0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+
+	/* McSPI 4 */
+	OMAP3_MUX(MCBSP1_CLKR, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE1 | OMAP_PIN_INPUT_PULLUP),
+
+	/* McBSP 2 */
+	OMAP3_MUX(MCBSP2_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP2_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP2_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(MCBSP2_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+
+	/* serial ports */
+	OMAP3_MUX(MCBSP3_CLKX, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(MCBSP3_FSX, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
+	OMAP3_MUX(UART1_TX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(UART1_RX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+
+	/* DSS */
+	OMAP3_MUX(DSS_PCLK, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_HSYNC, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_VSYNC, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_ACBIAS, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA0, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA1, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA2, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA3, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA4, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA5, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA8, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA9, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA10, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA11, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA12, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA13, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA14, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA15, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA16, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA17, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA18, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA19, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA20, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA21, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA22, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP3_MUX(DSS_DATA23, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+
+	/* TPS IRQ */
+	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_WAKEUP_EN | \
+		  OMAP_PIN_INPUT_PULLUP),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-#else
-#define board_mux	NULL
-#endif
 
 static void __init cm_t35_init(void)
 {
@@ -501,8 +586,6 @@ static void __init cm_t35_init(void)
 	cm_t35_init_led();
 
 	usb_musb_init();
-
-	omap_mux_init_signal("sys_nirq", OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
 }
 
 MACHINE_START(CM_T35, "Compulab CM-T35")
-- 
1.6.4.4

