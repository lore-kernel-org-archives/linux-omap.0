From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/9] omap: mux: Add 36xx CBP package support
Date: Wed, 02 Dec 2009 16:22:58 -0800
Message-ID: <20091203002258.2769.60497.stgit@localhost>
References: <20091203001601.2769.20621.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60201 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbZLCAWx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Dec 2009 19:22:53 -0500
In-Reply-To: <20091203001601.2769.20621.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Add 36xx CBP package support

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig         |    5 
 arch/arm/mach-omap2/board-3630sdp.c |    9 +
 arch/arm/mach-omap2/board-zoom3.c   |   10 +
 arch/arm/mach-omap2/mux.h           |    1 
 arch/arm/mach-omap2/mux34xx.c       |  520 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux34xx.h       |   42 +++
 6 files changed, 587 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index c10789c..5a61b74 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -33,6 +33,9 @@ config OMAP_PACKAGE_CBB
 config OMAP_PACKAGE_CUS
        bool
 
+config OMAP_PACKAGE_CBP
+       bool
+
 comment "OMAP Board Type"
 	depends on ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
 
@@ -121,6 +124,7 @@ config MACH_OMAP_ZOOM2
 config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select OMAP_PACKAGE_CBP
 
 config MACH_CM_T35
 	bool "CompuLab CM-T35 module"
@@ -135,6 +139,7 @@ config MACH_IGEP0020
 config MACH_OMAP_3630SDP
 	bool "OMAP3630 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+	select OMAP_PACKAGE_CBP
 
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index e6cbc27..7390596 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -85,8 +85,17 @@ static void __init omap_sdp_init_irq(void)
 	omap_gpio_init();
 }
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap_sdp_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 	zoom_peripherals_init();
 	board_smc91x_init();
 	enable_board_wakeup_source();
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 8d965a6..a9fe918 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -21,6 +21,7 @@
 #include <plat/common.h>
 #include <plat/board.h>
 
+#include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
 
 static void __init omap_zoom_map_io(void)
@@ -42,8 +43,17 @@ static void __init omap_zoom_init_irq(void)
 	omap_gpio_init();
 }
 
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define board_mux	NULL
+#endif
+
 static void __init omap_zoom_init(void)
 {
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 	zoom_peripherals_init();
 	zoom_debugboard_init();
 }
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index a6bd58f..d8b4d5a 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -56,6 +56,7 @@
 
 /* Flags for omap_mux_init */
 #define OMAP_PACKAGE_MASK		0xffff
+#define OMAP_PACKAGE_CBP		4		/* 515-pin 0.40 0.50 */
 #define OMAP_PACKAGE_CUS		3		/* 423-pin 0.65 */
 #define OMAP_PACKAGE_CBB		2		/* 515-pin 0.40 0.50 */
 #define OMAP_PACKAGE_CBC		1		/* 515-pin 0.50 0.65 */
diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 116d5b2..68e0a59 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -1549,6 +1549,522 @@ struct omap_ball __initdata omap3_cbb_ball[] = {
 #define omap3_cbb_ball	 NULL
 #endif
 
+/*
+ * Signals different on 36XX CBP package comapared to 34XX CBC package
+ */
+#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_CBP)
+struct omap_mux __initdata omap36xx_cbp_subset[] = {
+	_OMAP3_MUXENTRY(CAM_D0, 99,
+		"cam_d0", NULL, "csi2_dx2", NULL,
+		"gpio_99", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D1, 100,
+		"cam_d1", NULL, "csi2_dy2", NULL,
+		"gpio_100", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D10, 109,
+		"cam_d10", "ssi2_wake", NULL, NULL,
+		"gpio_109", "hw_dbg8", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D2, 101,
+		"cam_d2", "ssi2_rdy_tx", NULL, NULL,
+		"gpio_101", "hw_dbg4", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D3, 102,
+		"cam_d3", "ssi2_dat_rx", NULL, NULL,
+		"gpio_102", "hw_dbg5", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D4, 103,
+		"cam_d4", "ssi2_flag_rx", NULL, NULL,
+		"gpio_103", "hw_dbg6", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D5, 104,
+		"cam_d5", "ssi2_rdy_rx", NULL, NULL,
+		"gpio_104", "hw_dbg7", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_HS, 94,
+		"cam_hs", "ssi2_dat_tx", NULL, NULL,
+		"gpio_94", "hw_dbg0", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_VS, 95,
+		"cam_vs", "ssi2_flag_tx", NULL, NULL,
+		"gpio_95", "hw_dbg1", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA0, 70,
+		"dss_data0", "dsi_dx0", "uart1_cts", NULL,
+		"gpio_70", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA1, 71,
+		"dss_data1", "dsi_dy0", "uart1_rts", NULL,
+		"gpio_71", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA2, 72,
+		"dss_data2", "dsi_dx1", NULL, NULL,
+		"gpio_72", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA3, 73,
+		"dss_data3", "dsi_dy1", NULL, NULL,
+		"gpio_73", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA4, 74,
+		"dss_data4", "dsi_dx2", "uart3_rx_irrx", NULL,
+		"gpio_74", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA5, 75,
+		"dss_data5", "dsi_dy2", "uart3_tx_irtx", NULL,
+		"gpio_75", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA6, 76,
+		"dss_data6", NULL, "uart1_tx", "dssvenc656_data6",
+		"gpio_76", "hw_dbg14", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA7, 77,
+		"dss_data7", NULL, "uart1_rx", "dssvenc656_data7",
+		"gpio_77", "hw_dbg15", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA8, 78,
+		"dss_data8", NULL, "uart3_rx_irrx", NULL,
+		"gpio_78", "hw_dbg16", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA9, 79,
+		"dss_data9", NULL, "uart3_tx_irtx", NULL,
+		"gpio_79", "hw_dbg17", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(ETK_D12, 26,
+		"etk_d12", "sys_drm_msecure", NULL, "hsusb2_dir",
+		"gpio_26", NULL, "hsusb2_tll_dir", "hw_dbg14"),
+	_OMAP3_MUXENTRY(GPMC_A11, 0,
+		"gpmc_a11", NULL, NULL, NULL,
+		NULL, NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_WAIT2, 64,
+		"gpmc_wait2", NULL, "uart4_tx", NULL,
+		"gpio_64", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_WAIT3, 65,
+		"gpmc_wait3", "sys_ndmareq1", "uart4_rx", NULL,
+		"gpio_65", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA0, 125,
+		"hsusb0_data0", NULL, "uart3_tx_irtx", NULL,
+		"gpio_125", "uart2_tx", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA1, 130,
+		"hsusb0_data1", NULL, "uart3_rx_irrx", NULL,
+		"gpio_130", "uart2_rx", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA2, 131,
+		"hsusb0_data2", NULL, "uart3_rts_sd", NULL,
+		"gpio_131", "uart2_rts", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA3, 169,
+		"hsusb0_data3", NULL, "uart3_cts_rctx", NULL,
+		"gpio_169", "uart2_cts", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP1_CLKR, 156,
+		"mcbsp1_clkr", "mcspi4_clk", "sim_cd", NULL,
+		"gpio_156", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP1_FSR, 157,
+		"mcbsp1_fsr", "adpllv2d_dithering_en1",
+		"cam_global_reset", NULL,
+		"gpio_157", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_CLKX, 152,
+		"mcbsp4_clkx", "ssi1_dat_rx", NULL, NULL,
+		"gpio_152", "hsusb3_tll_data1", "mm3_txse0", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_DR, 153,
+		"mcbsp4_dr", "ssi1_flag_rx", NULL, NULL,
+		"gpio_153", "hsusb3_tll_data0", "mm3_rxrcv", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_DX, 154,
+		"mcbsp4_dx", "ssi1_rdy_rx", NULL, NULL,
+		"gpio_154", "hsusb3_tll_data2", "mm3_txdat", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_FSX, 155,
+		"mcbsp4_fsx", "ssi1_wake", NULL, NULL,
+		"gpio_155", "hsusb3_tll_data3", "mm3_txen_n", "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI1_CS1, 175,
+		"mcspi1_cs1", "adpllv2d_dithering_en2", NULL, "sdmmc3_cmd",
+		"gpio_175", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SAD2D_MBUSFLAG, 0,
+		"sad2d_mbusflag", "mad2d_sbusflag", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD28, 0,
+		"sad2d_mcad28", "mad2d_mcad28", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD29, 0,
+		"sad2d_mcad29", "mad2d_mcad29", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD32, 0,
+		"sad2d_mcad32", "mad2d_mcad32", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD33, 0,
+		"sad2d_mcad33", "mad2d_mcad33", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD34, 0,
+		"sad2d_mcad34", "mad2d_mcad34", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD35, 0,
+		"sad2d_mcad35", "mad2d_mcad35", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MCAD36, 0,
+		"sad2d_mcad36", "mad2d_mcad36", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MREAD, 0,
+		"sad2d_mread", "mad2d_sread", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_MWRITE, 0,
+		"sad2d_mwrite", "mad2d_swrite", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_SBUSFLAG, 0,
+		"sad2d_sbusflag", "mad2d_mbusflag", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_SREAD, 0,
+		"sad2d_sread", "mad2d_mread", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SAD2D_SWRITE, 0,
+		"sad2d_swrite", "mad2d_mwrite", NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(SDMMC1_CLK, 120,
+		"sdmmc1_clk", "ms_clk", NULL, NULL,
+		"gpio_120", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_CMD, 121,
+		"sdmmc1_cmd", "ms_bs", NULL, NULL,
+		"gpio_121", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT0, 122,
+		"sdmmc1_dat0", "ms_dat0", NULL, NULL,
+		"gpio_122", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT1, 123,
+		"sdmmc1_dat1", "ms_dat1", NULL, NULL,
+		"gpio_123", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT2, 124,
+		"sdmmc1_dat2", "ms_dat2", NULL, NULL,
+		"gpio_124", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT3, 125,
+		"sdmmc1_dat3", "ms_dat3", NULL, NULL,
+		"gpio_125", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDRC_CKE0, 0,
+		"sdrc_cke0", NULL, NULL, NULL,
+		NULL, NULL, NULL, "safe_mode_out1"),
+	_OMAP3_MUXENTRY(SDRC_CKE1, 0,
+		"sdrc_cke1", NULL, NULL, NULL,
+		NULL, NULL, NULL, "safe_mode_out1"),
+	_OMAP3_MUXENTRY(SIM_IO, 126,
+		"sim_io", "sim_io_low_impedance", NULL, NULL,
+		"gpio_126", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SIM_CLK, 127,
+		"sim_clk", NULL, NULL, NULL,
+		"gpio_127", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SIM_PWRCTRL, 128,
+		"sim_pwrctrl", NULL, NULL, NULL,
+		"gpio_128", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SIM_RST, 129,
+		"sim_rst", NULL, NULL, NULL,
+		"gpio_129", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT0, 2,
+		"sys_boot0", NULL, NULL, "dss_data18",
+		"gpio_2", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT1, 3,
+		"sys_boot1", NULL, NULL, "dss_data19",
+		"gpio_3", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT3, 5,
+		"sys_boot3", NULL, NULL, "dss_data20",
+		"gpio_5", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT4, 6,
+		"sys_boot4", "sdmmc2_dir_dat2", NULL, "dss_data21",
+		"gpio_6", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT5, 7,
+		"sys_boot5", "sdmmc2_dir_dat3", NULL, "dss_data22",
+		"gpio_7", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT6, 8,
+		"sys_boot6", NULL, NULL, "dss_data23",
+		"gpio_8", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART1_CTS, 150,
+		"uart1_cts", "ssi1_rdy_tx", NULL, NULL,
+		"gpio_150", "hsusb3_tll_clk", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART1_RTS, 149,
+		"uart1_rts", "ssi1_flag_tx", NULL, NULL,
+		"gpio_149", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART1_TX, 148,
+		"uart1_tx", "ssi1_dat_tx", NULL, NULL,
+		"gpio_148", NULL, NULL, "safe_mode"),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define omap36xx_cbp_subset	NULL
+#endif
+
+/*
+ * Balls for 36XX CBP package
+ * 515-pin s-PBGA Package, 0.50mm Ball Pitch (Top), 0.40mm Ball Pitch (Bottom)
+ */
+#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)		\
+		&& defined (CONFIG_OMAP_PACKAGE_CBP)
+struct omap_ball __initdata omap36xx_cbp_ball[] = {
+	_OMAP3_BALLENTRY(CAM_D0, "ag17", NULL),
+	_OMAP3_BALLENTRY(CAM_D1, "ah17", NULL),
+	_OMAP3_BALLENTRY(CAM_D10, "b25", NULL),
+	_OMAP3_BALLENTRY(CAM_D11, "c26", NULL),
+	_OMAP3_BALLENTRY(CAM_D2, "b24", NULL),
+	_OMAP3_BALLENTRY(CAM_D3, "c24", NULL),
+	_OMAP3_BALLENTRY(CAM_D4, "d24", NULL),
+	_OMAP3_BALLENTRY(CAM_D5, "a25", NULL),
+	_OMAP3_BALLENTRY(CAM_D6, "k28", NULL),
+	_OMAP3_BALLENTRY(CAM_D7, "l28", NULL),
+	_OMAP3_BALLENTRY(CAM_D8, "k27", NULL),
+	_OMAP3_BALLENTRY(CAM_D9, "l27", NULL),
+	_OMAP3_BALLENTRY(CAM_FLD, "c23", NULL),
+	_OMAP3_BALLENTRY(CAM_HS, "a24", NULL),
+	_OMAP3_BALLENTRY(CAM_PCLK, "c27", NULL),
+	_OMAP3_BALLENTRY(CAM_STROBE, "d25", NULL),
+	_OMAP3_BALLENTRY(CAM_VS, "a23", NULL),
+	_OMAP3_BALLENTRY(CAM_WEN, "b23", NULL),
+	_OMAP3_BALLENTRY(CAM_XCLKA, "c25", NULL),
+	_OMAP3_BALLENTRY(CAM_XCLKB, "b26", NULL),
+	_OMAP3_BALLENTRY(CSI2_DX0, "ag19", NULL),
+	_OMAP3_BALLENTRY(CSI2_DX1, "ag18", NULL),
+	_OMAP3_BALLENTRY(CSI2_DY0, "ah19", NULL),
+	_OMAP3_BALLENTRY(CSI2_DY1, "ah18", NULL),
+	_OMAP3_BALLENTRY(DSS_ACBIAS, "e27", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA0, "ag22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA1, "ah22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA10, "ad28", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA11, "ad27", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA12, "ab28", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA13, "ab27", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA14, "aa28", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA15, "aa27", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA16, "g25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA17, "h27", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA18, "h26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA19, "h25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA2, "ag23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA20, "e28", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA21, "j26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA22, "ac27", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA23, "ac28", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA3, "ah23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA4, "ag24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA5, "ah24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA6, "e26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA7, "f28", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA8, "f27", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA9, "g26", NULL),
+	_OMAP3_BALLENTRY(DSS_HSYNC, "d26", NULL),
+	_OMAP3_BALLENTRY(DSS_PCLK, "d28", NULL),
+	_OMAP3_BALLENTRY(DSS_VSYNC, "d27", NULL),
+	_OMAP3_BALLENTRY(ETK_CLK, "af10", NULL),
+	_OMAP3_BALLENTRY(ETK_CTL, "ae10", NULL),
+	_OMAP3_BALLENTRY(ETK_D0, "af11", NULL),
+	_OMAP3_BALLENTRY(ETK_D1, "ag12", NULL),
+	_OMAP3_BALLENTRY(ETK_D10, "ae7", NULL),
+	_OMAP3_BALLENTRY(ETK_D11, "af7", NULL),
+	_OMAP3_BALLENTRY(ETK_D12, "ag7", NULL),
+	_OMAP3_BALLENTRY(ETK_D13, "ah7", NULL),
+	_OMAP3_BALLENTRY(ETK_D14, "ag8", NULL),
+	_OMAP3_BALLENTRY(ETK_D15, "ah8", NULL),
+	_OMAP3_BALLENTRY(ETK_D2, "ah12", NULL),
+	_OMAP3_BALLENTRY(ETK_D3, "ae13", NULL),
+	_OMAP3_BALLENTRY(ETK_D4, "ae11", NULL),
+	_OMAP3_BALLENTRY(ETK_D5, "ah9", NULL),
+	_OMAP3_BALLENTRY(ETK_D6, "af13", NULL),
+	_OMAP3_BALLENTRY(ETK_D7, "ah14", NULL),
+	_OMAP3_BALLENTRY(ETK_D8, "af9", NULL),
+	_OMAP3_BALLENTRY(ETK_D9, "ag9", NULL),
+	_OMAP3_BALLENTRY(GPMC_A1, "n4", "ac15"),
+	_OMAP3_BALLENTRY(GPMC_A10, "k3", "ab19"),
+	_OMAP3_BALLENTRY(GPMC_A11, NULL, "ac20"),
+	_OMAP3_BALLENTRY(GPMC_A2, "m4", "ab15"),
+	_OMAP3_BALLENTRY(GPMC_A3, "l4", "ac16"),
+	_OMAP3_BALLENTRY(GPMC_A4, "k4", "ab16"),
+	_OMAP3_BALLENTRY(GPMC_A5, "t3", "ac17"),
+	_OMAP3_BALLENTRY(GPMC_A6, "r3", "ab17"),
+	_OMAP3_BALLENTRY(GPMC_A7, "n3", "ac18"),
+	_OMAP3_BALLENTRY(GPMC_A8, "m3", "ab18"),
+	_OMAP3_BALLENTRY(GPMC_A9, "l3", "ac19"),
+	_OMAP3_BALLENTRY(GPMC_CLK, "t4", "w2"),
+	_OMAP3_BALLENTRY(GPMC_D0, "k1", "m2"),
+	_OMAP3_BALLENTRY(GPMC_D1, "l1", "m1"),
+	_OMAP3_BALLENTRY(GPMC_D10, "p1", "ab4"),
+	_OMAP3_BALLENTRY(GPMC_D11, "r1", "ac4"),
+	_OMAP3_BALLENTRY(GPMC_D12, "r2", "ab6"),
+	_OMAP3_BALLENTRY(GPMC_D13, "t2", "ac6"),
+	_OMAP3_BALLENTRY(GPMC_D14, "w1", "ab7"),
+	_OMAP3_BALLENTRY(GPMC_D15, "y1", "ac7"),
+	_OMAP3_BALLENTRY(GPMC_D2, "l2", "n2"),
+	_OMAP3_BALLENTRY(GPMC_D3, "p2", "n1"),
+	_OMAP3_BALLENTRY(GPMC_D4, "t1", "r2"),
+	_OMAP3_BALLENTRY(GPMC_D5, "v1", "r1"),
+	_OMAP3_BALLENTRY(GPMC_D6, "v2", "t2"),
+	_OMAP3_BALLENTRY(GPMC_D7, "w2", "t1"),
+	_OMAP3_BALLENTRY(GPMC_D8, "h2", "ab3"),
+	_OMAP3_BALLENTRY(GPMC_D9, "k2", "ac3"),
+	_OMAP3_BALLENTRY(GPMC_NADV_ALE, "f3", "w1"),
+	_OMAP3_BALLENTRY(GPMC_NBE0_CLE, "g3", "ac12"),
+	_OMAP3_BALLENTRY(GPMC_NBE1, "u3", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS0, "g4", "y2"),
+	_OMAP3_BALLENTRY(GPMC_NCS1, "h3", "y1"),
+	_OMAP3_BALLENTRY(GPMC_NCS2, "v8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS3, "u8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS4, "t8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS5, "r8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS6, "p8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS7, "n8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NOE, "g2", "v2"),
+	_OMAP3_BALLENTRY(GPMC_NWE, "f4", "v1"),
+	_OMAP3_BALLENTRY(GPMC_NWP, "h1", "ab10"),
+	_OMAP3_BALLENTRY(GPMC_WAIT0, "m8", "ab12"),
+	_OMAP3_BALLENTRY(GPMC_WAIT1, "l8", "ac10"),
+	_OMAP3_BALLENTRY(GPMC_WAIT2, "k8", NULL),
+	_OMAP3_BALLENTRY(GPMC_WAIT3, "j8", NULL),
+	_OMAP3_BALLENTRY(HDQ_SIO, "j25", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_CLK, "t28", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA0, "t27", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA1, "u28", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA2, "u27", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA3, "u26", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA4, "u25", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA5, "v28", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA6, "v27", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA7, "v26", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DIR, "r28", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_NXT, "t26", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_STP, "t25", NULL),
+	_OMAP3_BALLENTRY(I2C1_SCL, "k21", NULL),
+	_OMAP3_BALLENTRY(I2C1_SDA, "j21", NULL),
+	_OMAP3_BALLENTRY(I2C2_SCL, "af15", NULL),
+	_OMAP3_BALLENTRY(I2C2_SDA, "ae15", NULL),
+	_OMAP3_BALLENTRY(I2C3_SCL, "af14", NULL),
+	_OMAP3_BALLENTRY(I2C3_SDA, "ag14", NULL),
+	_OMAP3_BALLENTRY(I2C4_SCL, "ad26", NULL),
+	_OMAP3_BALLENTRY(I2C4_SDA, "ae26", NULL),
+	_OMAP3_BALLENTRY(JTAG_EMU0, "aa11", NULL),
+	_OMAP3_BALLENTRY(JTAG_EMU1, "aa10", NULL),
+	_OMAP3_BALLENTRY(JTAG_RTCK, "aa12", NULL),
+	_OMAP3_BALLENTRY(JTAG_TCK, "aa13", NULL),
+	_OMAP3_BALLENTRY(JTAG_TDI, "aa20", NULL),
+	_OMAP3_BALLENTRY(JTAG_TDO, "aa19", NULL),
+	_OMAP3_BALLENTRY(JTAG_TMS_TMSC, "aa18", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_CLKR, "y21", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_CLKX, "w21", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_DR, "u21", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_DX, "v21", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_FSR, "aa21", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_FSX, "k26", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_CLKX, "n21", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_DR, "r21", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_DX, "m21", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_FSX, "p21", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_CLKX, "af5", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_DR, "ae6", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_DX, "af6", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_FSX, "ae5", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_CLKX, "ae1", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_DR, "ad1", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_DX, "ad2", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_FSX, "ac1", NULL),
+	_OMAP3_BALLENTRY(MCBSP_CLKS, "t21", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CLK, "ab3", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS0, "ac2", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS1, "ac3", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS2, "ab1", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS3, "ab2", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_SIMO, "ab4", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_SOMI, "aa4", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CLK, "aa3", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CS0, "y4", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CS1, "v3", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_SIMO, "y2", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_SOMI, "y3", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_CLK, "n28", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_CMD, "m27", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT0, "n27", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT1, "n26", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT2, "n25", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT3, "p28", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_CLK, "ae2", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_CMD, "ag5", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT0, "ah5", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT1, "ah4", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT2, "ag4", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT3, "af4", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT4, "ae4", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT5, "ah3", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT6, "af3", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT7, "ae3", NULL),
+	_OMAP3_BALLENTRY(SDRC_A0, NULL, "n22"),
+	_OMAP3_BALLENTRY(SDRC_A1, NULL, "n23"),
+	_OMAP3_BALLENTRY(SDRC_A10, NULL, "v22"),
+	_OMAP3_BALLENTRY(SDRC_A11, NULL, "v23"),
+	_OMAP3_BALLENTRY(SDRC_A12, NULL, "w22"),
+	_OMAP3_BALLENTRY(SDRC_A13, NULL, "w23"),
+	_OMAP3_BALLENTRY(SDRC_A14, NULL, "y22"),
+	_OMAP3_BALLENTRY(SDRC_A2, NULL, "p22"),
+	_OMAP3_BALLENTRY(SDRC_A3, NULL, "p23"),
+	_OMAP3_BALLENTRY(SDRC_A4, NULL, "r22"),
+	_OMAP3_BALLENTRY(SDRC_A5, NULL, "r23"),
+	_OMAP3_BALLENTRY(SDRC_A6, NULL, "t22"),
+	_OMAP3_BALLENTRY(SDRC_A7, NULL, "t23"),
+	_OMAP3_BALLENTRY(SDRC_A8, NULL, "u22"),
+	_OMAP3_BALLENTRY(SDRC_A9, NULL, "u23"),
+	_OMAP3_BALLENTRY(SDRC_BA0, "h9", "ab21"),
+	_OMAP3_BALLENTRY(SDRC_BA1, "h10", "ac21"),
+	_OMAP3_BALLENTRY(SDRC_CKE0, "h16", "j22"),
+	_OMAP3_BALLENTRY(SDRC_CKE1, "h17", "j23"),
+	_OMAP3_BALLENTRY(SDRC_CLK, "a13", "a11"),
+	_OMAP3_BALLENTRY(SDRC_D0, NULL, "j2"),
+	_OMAP3_BALLENTRY(SDRC_D1, NULL, "j1"),
+	_OMAP3_BALLENTRY(SDRC_D10, "c15", "b14"),
+	_OMAP3_BALLENTRY(SDRC_D11, "b16", "a14"),
+	_OMAP3_BALLENTRY(SDRC_D12, "d17", "b16"),
+	_OMAP3_BALLENTRY(SDRC_D13, "c17", "a16"),
+	_OMAP3_BALLENTRY(SDRC_D14, "b17", "b19"),
+	_OMAP3_BALLENTRY(SDRC_D15, "d18", "a19"),
+	_OMAP3_BALLENTRY(SDRC_D16, NULL, "b3"),
+	_OMAP3_BALLENTRY(SDRC_D17, NULL, "a3"),
+	_OMAP3_BALLENTRY(SDRC_D18, NULL, "b5"),
+	_OMAP3_BALLENTRY(SDRC_D19, NULL, "a5"),
+	_OMAP3_BALLENTRY(SDRC_D2, NULL, "g2"),
+	_OMAP3_BALLENTRY(SDRC_D20, NULL, "b8"),
+	_OMAP3_BALLENTRY(SDRC_D21, NULL, "a8"),
+	_OMAP3_BALLENTRY(SDRC_D22, NULL, "b9"),
+	_OMAP3_BALLENTRY(SDRC_D23, NULL, "a9"),
+	_OMAP3_BALLENTRY(SDRC_D24, NULL, "b21"),
+	_OMAP3_BALLENTRY(SDRC_D25, NULL, "a21"),
+	_OMAP3_BALLENTRY(SDRC_D26, NULL, "d22"),
+	_OMAP3_BALLENTRY(SDRC_D27, NULL, "d23"),
+	_OMAP3_BALLENTRY(SDRC_D28, NULL, "e22"),
+	_OMAP3_BALLENTRY(SDRC_D29, NULL, "e23"),
+	_OMAP3_BALLENTRY(SDRC_D3, NULL, "g1"),
+	_OMAP3_BALLENTRY(SDRC_D30, NULL, "g22"),
+	_OMAP3_BALLENTRY(SDRC_D31, NULL, "g23"),
+	_OMAP3_BALLENTRY(SDRC_D4, NULL, "f2"),
+	_OMAP3_BALLENTRY(SDRC_D5, NULL, "f1"),
+	_OMAP3_BALLENTRY(SDRC_D6, NULL, "d2"),
+	_OMAP3_BALLENTRY(SDRC_D7, NULL, "d1"),
+	_OMAP3_BALLENTRY(SDRC_D8, "c14", "b13"),
+	_OMAP3_BALLENTRY(SDRC_D9, "b14", "a13"),
+	_OMAP3_BALLENTRY(SDRC_DM0, NULL, "c1"),
+	_OMAP3_BALLENTRY(SDRC_DM1, "a16", "a17"),
+	_OMAP3_BALLENTRY(SDRC_DM2, NULL, "a6"),
+	_OMAP3_BALLENTRY(SDRC_DM3, NULL, "a20"),
+	_OMAP3_BALLENTRY(SDRC_DQS0, NULL, "c2"),
+	_OMAP3_BALLENTRY(SDRC_DQS1, "a17", "b17"),
+	_OMAP3_BALLENTRY(SDRC_DQS2, NULL, "b6"),
+	_OMAP3_BALLENTRY(SDRC_DQS3, NULL, "b20"),
+	_OMAP3_BALLENTRY(SDRC_NCAS, "h13", "l22"),
+	_OMAP3_BALLENTRY(SDRC_NCLK, "a14", "b11"),
+	_OMAP3_BALLENTRY(SDRC_NCS0, "h11", "m22"),
+	_OMAP3_BALLENTRY(SDRC_NCS1, "h12", "m23"),
+	_OMAP3_BALLENTRY(SDRC_NRAS, "h14", "l23"),
+	_OMAP3_BALLENTRY(SDRC_NWE, "h15", "k23"),
+	_OMAP3_BALLENTRY(SIM_CLK, "p26", NULL),
+	_OMAP3_BALLENTRY(SIM_IO, "p27", NULL),
+	_OMAP3_BALLENTRY(SIM_PWRCTRL, "r27", NULL),
+	_OMAP3_BALLENTRY(SIM_RST, "r25", NULL),
+	_OMAP3_BALLENTRY(SYS_32K, "ae25", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT0, "ah26", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT1, "ag26", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT2, "ae14", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT3, "af18", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT4, "af19", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT5, "ae21", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT6, "af21", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKOUT1, "ag25", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKOUT2, "ae22", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKREQ, "af25", NULL),
+	_OMAP3_BALLENTRY(SYS_NIRQ, "af26", NULL),
+	_OMAP3_BALLENTRY(SYS_NRESWARM, "af24", NULL),
+	_OMAP3_BALLENTRY(SYS_OFF_MODE, "af22", NULL),
+	_OMAP3_BALLENTRY(UART1_CTS, "w8", NULL),
+	_OMAP3_BALLENTRY(UART1_RTS, "aa9", NULL),
+	_OMAP3_BALLENTRY(UART1_RX, "y8", NULL),
+	_OMAP3_BALLENTRY(UART1_TX, "aa8", NULL),
+	_OMAP3_BALLENTRY(UART2_CTS, "ab26", NULL),
+	_OMAP3_BALLENTRY(UART2_RTS, "ab25", NULL),
+	_OMAP3_BALLENTRY(UART2_RX, "ad25", NULL),
+	_OMAP3_BALLENTRY(UART2_TX, "aa25", NULL),
+	_OMAP3_BALLENTRY(UART3_CTS_RCTX, "h18", NULL),
+	_OMAP3_BALLENTRY(UART3_RTS_SD, "h19", NULL),
+	_OMAP3_BALLENTRY(UART3_RX_IRRX, "h20", NULL),
+	_OMAP3_BALLENTRY(UART3_TX_IRTX, "h21", NULL),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define omap36xx_cbp_ball	 NULL
+#endif
+
 int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
 {
 	struct omap_mux *package_subset;
@@ -1567,6 +2083,10 @@ int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
 		package_subset = omap3_cus_subset;
 		package_balls = omap3_cus_ball;
 		break;
+	case (OMAP_PACKAGE_CBP):
+		package_subset = omap36xx_cbp_subset;
+		package_balls = omap36xx_cbp_ball;
+		break;
 	default:
 		printk(KERN_ERR "mux: Unknown omap package, mux disabled\n");
 		return -EINVAL;
diff --git a/arch/arm/mach-omap2/mux34xx.h b/arch/arm/mach-omap2/mux34xx.h
index a7cc871..6543ebf 100644
--- a/arch/arm/mach-omap2/mux34xx.h
+++ b/arch/arm/mach-omap2/mux34xx.h
@@ -170,10 +170,13 @@
 #define OMAP3_CONTROL_PADCONF_SDMMC1_DAT1_OFFSET		0x11a
 #define OMAP3_CONTROL_PADCONF_SDMMC1_DAT2_OFFSET		0x11c
 #define OMAP3_CONTROL_PADCONF_SDMMC1_DAT3_OFFSET		0x11e
+
+/* SDMMC1_DAT4 - DAT7 are SIM_IO SIM_CLK SIM_PWRCTRL and SIM_RST on 36xx */
 #define OMAP3_CONTROL_PADCONF_SDMMC1_DAT4_OFFSET		0x120
 #define OMAP3_CONTROL_PADCONF_SDMMC1_DAT5_OFFSET		0x122
 #define OMAP3_CONTROL_PADCONF_SDMMC1_DAT6_OFFSET		0x124
 #define OMAP3_CONTROL_PADCONF_SDMMC1_DAT7_OFFSET		0x126
+
 #define OMAP3_CONTROL_PADCONF_SDMMC2_CLK_OFFSET			0x128
 #define OMAP3_CONTROL_PADCONF_SDMMC2_CMD_OFFSET			0x12a
 #define OMAP3_CONTROL_PADCONF_SDMMC2_DAT0_OFFSET		0x12c
@@ -281,6 +284,7 @@
 #define OMAP3_CONTROL_PADCONF_SAD2D_MCAD34_OFFSET		0x1f8
 #define OMAP3_CONTROL_PADCONF_SAD2D_MCAD35_OFFSET		0x1fa
 #define OMAP3_CONTROL_PADCONF_SAD2D_MCAD36_OFFSET		0x1fc
+
 /* Note that 34xx TRM has SAD2D instead of CHASSIS for these */
 #define OMAP3_CONTROL_PADCONF_CHASSIS_CLK26MI_OFFSET		0x1fe
 #define OMAP3_CONTROL_PADCONF_CHASSIS_NRESPWRON_OFFSET		0x200
@@ -302,6 +306,7 @@
 #define OMAP3_CONTROL_PADCONF_CHASSIS_MSTDBY_OFFSET		0x220
 #define OMAP3_CONTROL_PADCONF_CHASSIS_IDLEREQ_OFFSET		0x222
 #define OMAP3_CONTROL_PADCONF_CHASSIS_IDLEACK_OFFSET		0x224
+
 #define OMAP3_CONTROL_PADCONF_SAD2D_MWRITE_OFFSET		0x226
 #define OMAP3_CONTROL_PADCONF_SAD2D_SWRITE_OFFSET		0x228
 #define OMAP3_CONTROL_PADCONF_SAD2D_MREAD_OFFSET		0x22a
@@ -310,6 +315,43 @@
 #define OMAP3_CONTROL_PADCONF_SAD2D_SBUSFLAG_OFFSET		0x230
 #define OMAP3_CONTROL_PADCONF_SDRC_CKE0_OFFSET			0x232
 #define OMAP3_CONTROL_PADCONF_SDRC_CKE1_OFFSET			0x234
+
+/* 36xx only */
+#define OMAP3_CONTROL_PADCONF_GPMC_A11_OFFSET			0x236
+#define OMAP3_CONTROL_PADCONF_SDRC_BA0_OFFSET			0x570
+#define OMAP3_CONTROL_PADCONF_SDRC_BA1_OFFSET			0x572
+#define OMAP3_CONTROL_PADCONF_SDRC_A0_OFFSET			0x574
+#define OMAP3_CONTROL_PADCONF_SDRC_A1_OFFSET			0x576
+#define OMAP3_CONTROL_PADCONF_SDRC_A2_OFFSET			0x578
+#define OMAP3_CONTROL_PADCONF_SDRC_A3_OFFSET			0x57a
+#define OMAP3_CONTROL_PADCONF_SDRC_A4_OFFSET			0x57c
+#define OMAP3_CONTROL_PADCONF_SDRC_A5_OFFSET			0x57e
+#define OMAP3_CONTROL_PADCONF_SDRC_A6_OFFSET			0x580
+#define OMAP3_CONTROL_PADCONF_SDRC_A7_OFFSET			0x582
+#define OMAP3_CONTROL_PADCONF_SDRC_A8_OFFSET			0x584
+#define OMAP3_CONTROL_PADCONF_SDRC_A9_OFFSET			0x586
+#define OMAP3_CONTROL_PADCONF_SDRC_A10_OFFSET			0x588
+#define OMAP3_CONTROL_PADCONF_SDRC_A11_OFFSET			0x58a
+#define OMAP3_CONTROL_PADCONF_SDRC_A12_OFFSET			0x58c
+#define OMAP3_CONTROL_PADCONF_SDRC_A13_OFFSET			0x58e
+#define OMAP3_CONTROL_PADCONF_SDRC_A14_OFFSET			0x590
+#define OMAP3_CONTROL_PADCONF_SDRC_NCS0_OFFSET			0x592
+#define OMAP3_CONTROL_PADCONF_SDRC_NCS1_OFFSET			0x594
+#define OMAP3_CONTROL_PADCONF_SDRC_NCLK_OFFSET			0x596
+#define OMAP3_CONTROL_PADCONF_SDRC_NRAS_OFFSET			0x598
+#define OMAP3_CONTROL_PADCONF_SDRC_NCAS_OFFSET			0x59a
+#define OMAP3_CONTROL_PADCONF_SDRC_NWE_OFFSET			0x59c
+#define OMAP3_CONTROL_PADCONF_SDRC_DM0_OFFSET			0x59e
+#define OMAP3_CONTROL_PADCONF_SDRC_DM1_OFFSET			0x5a0
+#define OMAP3_CONTROL_PADCONF_SDRC_DM2_OFFSET			0x5a2
+#define OMAP3_CONTROL_PADCONF_SDRC_DM3_OFFSET			0x5a4
+
+/* 36xx only, these are SDMMC1_DAT4 - DAT7 on 34xx */
+#define OMAP3_CONTROL_PADCONF_SIM_IO_OFFSET			0x120
+#define OMAP3_CONTROL_PADCONF_SIM_CLK_OFFSET			0x122
+#define OMAP3_CONTROL_PADCONF_SIM_PWRCTRL_OFFSET		0x124
+#define OMAP3_CONTROL_PADCONF_SIM_RST_OFFSET			0x126
+
 #define OMAP3_CONTROL_PADCONF_ETK_CLK_OFFSET			0x5a8
 #define OMAP3_CONTROL_PADCONF_ETK_CTL_OFFSET			0x5aa
 #define OMAP3_CONTROL_PADCONF_ETK_D0_OFFSET			0x5ac

