From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: [PATCH v2] AM3505/3517 ZCN package support
Date: Wed, 06 Jul 2011 12:52:16 -0400
Message-ID: <4E1492C0.8060900@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:51527 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987Ab1GFQwY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jul 2011 12:52:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Premi, Sanjeev" <premi@ti.com>

Fixes according to Sanjeev's comments in previous thread.

---
This patch adds support for the AM35xx ZCN package specific muxmodes.
    
Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4ae6257..bf452eb 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -103,6 +103,9 @@ config OMAP_PACKAGE_CBL
 config OMAP_PACKAGE_CBS
        bool
 
+config OMAP_PACKAGE_ZCN
+       bool
+
 comment "OMAP Board Type"
 	depends on ARCH_OMAP2PLUS
 
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 2132308..f227503 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -62,6 +62,7 @@
 
 /* Flags for omapX_mux_init */
 #define OMAP_PACKAGE_MASK		0xffff
+#define OMAP_PACKAGE_ZCN		9		/* 491-pin 0.65 */
 #define OMAP_PACKAGE_CBS		8		/* 547-pin 0.40 0.40 */
 #define OMAP_PACKAGE_CBL		7		/* 547-pin 0.40 0.40 */
 #define OMAP_PACKAGE_CBP		6		/* 515-pin 0.40 0.50 */
diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 17f80e4..26b703a 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -696,6 +696,86 @@ static struct omap_mux __initdata omap3_muxmodes[] = {
 	_OMAP3_MUXENTRY(SAD2D_MCAD36, 0,
 		NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL),
+
+	/* Only on AM35xx, see am35xx_zcn_subset for the signals */
+	_OMAP3_MUXENTRY(CCDC_PCLK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_FIELD, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_HD, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_VD, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_WEN, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_DATA0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_DATA1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_DATA2, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_DATA3, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_DATA4, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_DATA5, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_DATA6, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(CCDC_DATA7, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(RMII_MDIO_DATA, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(RMII_MDIO_CLK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(RMII_RXD0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(RMII_RXD1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(RMII_CRS_DV, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(RMII_RXER, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(RMII_TXD0, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(RMII_TXD1, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(RMII_TXEN, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(RMII_50MHZ_CLK, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(USB0_DRVVBUS, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(HECC1_TXD, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
+	_OMAP3_MUXENTRY(HECC1_RXD, 0,
+		NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
@@ -2026,6 +2106,489 @@ static struct omap_ball __initdata omap36xx_cbp_ball[] = {
 #define omap36xx_cbp_ball	 NULL
 #endif
 
+/*
+ * Signals different on AM35XX ZCN package comapared to 34XX CBC package
+ */
+#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_ZCN)
+static struct omap_mux __initdata am35xx_zcn_subset[] = {
+	_OMAP3_MUXENTRY(GPMC_NCS2, 53,
+		"gpmc_ncs2", NULL, "gpt9_pwm_evt", NULL,
+		"gpio_53", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS3, 54,
+		"gpmc_ncs3", "sys_ndmareq0", "gpt10_pwm_evt", NULL,
+		"gpio_54", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS4, 55,
+		"gpmc_ncs4", "sys_ndmareq1", NULL, "gpt9_pwm_evt",
+		"gpio_55", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS5, 56,
+		"gpmc_ncs5", "sys_ndmareq2", NULL, "gpt10_pwm_evt",
+		"gpio_56", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS6, 57,
+		"gpmc_ncs6", "sys_ndmareq3", NULL, "gpt11_pwm_evt",
+		"gpio_57", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS7, 58,
+		"gpmc_ncs7", "gpmc_io_dir", NULL, "gpt8_pwm_evt",
+		"gpio_58", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_WAIT1, 63,
+		"gpmc_wait1", "uart4_tx", NULL, NULL,
+		"gpio_63", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_WAIT2, 64,
+		"gpmc_wait2", "uart4_rx", NULL, NULL,
+		"gpio_64", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_WAIT3, 65,
+		"gpmc_wait3", "sys_ndmareq1", "uart3_cts_rctx", NULL,
+		"gpio_65", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA18, 88,
+		"dss_data18", NULL, "mcspi3_clk", "dss_data4",
+		"gpio_88", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA19, 89,
+		"dss_data19", NULL, "mcspi3_simo", "dss_data3",
+		"gpio_89", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA21, 91,
+		"dss_data21", NULL, "mcspi3_cs0", "dss_data1",
+		"gpio_91", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA22, 92,
+		"dss_data22", NULL, "mcspi3_cs1", "dss_data0",
+		"gpio_92", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_PCLK, 94,
+		"ccdc_pclk", NULL, NULL, NULL,
+		"gpio_94", "hw_dbg0", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_FIELD, 95,
+		"ccdc_field", "ccdc_data8", "uart4_tx", "i2c3_scl",
+		"gpio_95", "hw_dbg1", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_HD, 96,
+		"ccdc_hd", NULL, "uart4_rts", NULL,
+		"gpio_96", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_VD, 97,
+		"ccdc_vd", NULL, "uart4_cts", NULL,
+		"gpio_97", "hw_dbg2", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_WEN, 98,
+		"ccdc_wen", "ccdc_data9", "uart4_rx", NULL,
+		"gpio_98", "hw_dbg3", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_DATA0, 99,
+		"ccdc_data0", NULL, NULL, "i2c3_sda",
+		"gpio_99", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_DATA1, 100,
+		"ccdc_data1", NULL, NULL, NULL,
+		"gpio_100", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_DATA2, 101,
+		"ccdc_data2", NULL, NULL, NULL,
+		"gpio_101", "hw_dbg4", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_DATA3, 102,
+		"ccdc_data3", NULL, NULL, NULL,
+		"gpio_102", "hw_dbg5", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_DATA4, 103,
+		"ccdc_data4", NULL, NULL, NULL,
+		"gpio_103", "hw_dbg6", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_DATA5, 104,
+		"ccdc_data5", NULL, NULL, NULL,
+		"gpio_104", "hw_dbg7", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_DATA6, 105,
+		"ccdc_data6", NULL, NULL, NULL,
+		"gpio_105", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CCDC_DATA7, 106,
+		"ccdc_data7", NULL, NULL, NULL,
+		"gpio_106", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(RMII_MDIO_DATA, 107,
+		"rmii_mdio_data", "ccdc_data8", NULL, NULL,
+		"gpio_107", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(RMII_MDIO_CLK, 108,
+		"rmii_mdio_clk", "ccdc_data9", NULL, NULL,
+		"gpio_108", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(RMII_RXD0, 109,
+		"rmii_rxd0", "ccdc_data10", NULL, NULL,
+		"gpio_109", "hw_dbg8", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(RMII_RXD1, 110,
+		"rmii_rxd1", "ccdc_data11", NULL, NULL,
+		"gpio_110", "hw_dbg9", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(RMII_CRS_DV, 111,
+		"rmii_crs_dv", "ccdc_data12", NULL, NULL,
+		"gpio_111", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(RMII_RXER, 167,
+		"rmii_rxer", "ccdc_data13", NULL, NULL,
+		"gpio_167", "hw_dbg10", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(RMII_TXD0, 126,
+		"rmii_txd0", "ccdc_data14", NULL, NULL,
+		"gpio_126", "hw_dbg11", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(RMII_TXD1, 112,
+		"rmii_txd1", "ccdc_data15", NULL, NULL,
+		"gpio_112", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(RMII_TXEN, 113,
+		"rmii_txen", NULL, NULL, NULL,
+		"gpio_113", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(RMII_50MHZ_CLK, 114,
+		"rmii_50mhz_clk", NULL, NULL, NULL,
+		"gpio_114", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT0, 122,
+		"sdmmc1_dat0", "mcspi2_clk", NULL, NULL,
+		"gpio_122", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT1, 123,
+		"sdmmc1_dat1", "mcspi2_simo", NULL, NULL,
+		"gpio_123", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT2, 124,
+		"sdmmc1_dat2", "mcspi2_somi", NULL, NULL,
+		"gpio_124", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT3, 125,
+		"sdmmc1_dat3", "mcspi2_cs0", NULL, NULL,
+		"gpio_125", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT4, 126,
+		"sdmmc1_dat4", NULL, NULL, NULL,
+		"gpio_126", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT5, 127,
+		"sdmmc1_dat5", NULL, NULL, NULL,
+		"gpio_127", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT6, 128,
+		"sdmmc1_dat6", NULL, NULL, NULL,
+		"gpio_128", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC1_DAT7, 129,
+		"sdmmc1_dat7", NULL, NULL, NULL,
+		"gpio_129", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC2_CLK, 130,
+		"sdmmc2_clk", "mcspi3_clk", "uart4_cts", NULL,
+		"gpio_130", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC2_CMD, 131,
+		"sdmmc2_cmd", "mcspi3_simo", "uart4_rts", NULL,
+		"gpio_131", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC2_DAT0, 132,
+		"sdmmc2_dat0", "mcspi3_somi", "uart4_tx", NULL,
+		"gpio_132", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC2_DAT1, 133,
+		"sdmmc2_dat1", NULL, "uart4_rx", NULL,
+		"gpio_133", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC2_DAT5, 137,
+		"sdmmc2_dat5", "sdmmc2_dir_dat1", NULL, "sdmmc3_dat1",
+		"gpio_137", NULL, "mm_fsusb3_rxdp", "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC2_DAT6, 138,
+		"sdmmc2_dat6", "sdmmc2_dir_cmd", NULL, "sdmmc3_dat2",
+		"gpio_138", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SDMMC2_DAT7, 139,
+		"sdmmc2_dat7", "sdmmc2_clkin", NULL, "sdmmc3_dat3",
+		"gpio_139", NULL, "mm_fsusbb3_rxdm", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_DX, 140,
+		"mcbsp3_dx", "uart2_cts", NULL, NULL,
+		"gpio_140", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_DR, 141,
+		"mcbsp3_dr", "uart2_rts", NULL, NULL,
+		"gpio_141", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_CLKX, 142,
+		"mcbsp3_clkx", "uart2_tx", NULL, NULL,
+		"gpio_142", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_FSX, 143,
+		"mcbsp3_fsx", "uart2_rx", NULL, NULL,
+		"gpio_143", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART1_CTS, 150,
+		"uart1_cts", NULL, NULL, NULL,
+		"gpio_150", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_CLKX, 152,
+		"mcbsp4_clkx", NULL, NULL, NULL,
+		"gpio_152", NULL, "mm_fsusb3_rxrcv", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_DR, 153,
+		"mcbsp4_dr", NULL, NULL, NULL,
+		"gpio_153", NULL, "mm_fsusb3_txdat", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_DX, 154,
+		"mcbsp4_dx", NULL, NULL, NULL,
+		"gpio_154", NULL, "mm_fsusb3_txen_n", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_FSX, 155,
+		"mcbsp4_fsx", NULL, NULL, NULL,
+		"gpio_155", NULL, NULL , "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP1_FSR, 157,
+		"mcbsp1_fsr", NULL, NULL, NULL,
+		"gpio_157", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP_CLKS, 160,
+		"mcbsp_clks", NULL, NULL, NULL,
+		"gpio_160", "uart1_cts", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(USB0_DRVVBUS, 125,
+		"usb0_drvvbus", NULL, "uart3_tx_irtx", NULL,
+		"gpio_125", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HECC1_TXD, 130,
+		"hecc1_txd", NULL, "uart3_rx_irrx", NULL,
+		"gpio_130", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HECC1_RXD, 131,
+		"hecc1_rxd", NULL, "uart3_rts_sd", NULL,
+		"gpio_131", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI1_CS3, 177,
+		"mcspi1_cs3", NULL, "hsusb2_tll_data2", "hsusb2_data2",
+		"gpio_177", "mm_fsusb2_txdat", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI2_CLK, 178,
+		"mcspi2_clk", NULL, "hsusb2_tll_data7", "hsusb2_data7",
+		"gpio_178", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI2_SIMO, 179,
+		"mcspi2_simo", "gpt9_pwm_evt",
+		"hsusb2_tll_data4", "hsusb2_data4",
+		"gpio_179", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI2_SOMI, 180,
+		"mcspi2_somi", "gpt10_pwm_evt",
+		"hsusb2_tll_data5", "hsusb2_data5",
+		"gpio_180", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI2_CS0, 181,
+		"mcspi2_cs0", "gpt11_pwm_evt",
+		"hsusb2_tll_data6", "hsusb2_data6",
+		"gpio_181", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI2_CS1, 182,
+		"mcspi2_cs1", "gpt8_pwm_evt",
+		"hsusb2_tll_data3", "hsusb2_data3",
+		"gpio_182", "mm_fsusb2_txen_n", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(ETK_CLK, 12,
+		"etk_clk", "mcbsp5_clkx", "sdmmc3_clk", "hsusb1_stp",
+		"gpio_12", NULL, NULL, "hw_dbg1"),
+	_OMAP3_MUXENTRY(ETK_CTL, 13,
+		"etk_ctl", NULL, "sdmmc3_cmd", "hsusb1_clk",
+		"gpio_13", "mm_fsusb1_rxdp", NULL, "hw_dbg2"),
+	_OMAP3_MUXENTRY(ETK_D0, 14,
+		"etk_d0", "mcspi3_simo", "sdmmc3_dat4", "hsusb1_data0",
+		"gpio_14", "mm_fsusb1_rxrcv", NULL, "hw_dbg3"),
+	_OMAP3_MUXENTRY(ETK_D1, 15,
+		"etk_d1", "mcspi3_somi", NULL, "hsusb1_data1",
+		"gpio_15", "mm_fsusb1_txse0", NULL, "hw_dbg4"),
+	_OMAP3_MUXENTRY(ETK_D2, 16,
+		"etk_d2", "mcspi3_cs0", NULL, "hsusb1_data2",
+		"gpio_16", "mm_fsusb1_txdat", NULL, "hw_dbg5"),
+	_OMAP3_MUXENTRY(ETK_D3, 17,
+		"etk_d3", "mcspi3_clk", "sdmmc3_dat3", "hsusb1_data7",
+		"gpio_17", NULL, NULL, "hw_dbg6"),
+	_OMAP3_MUXENTRY(ETK_D4, 18,
+		"etk_d4", "mcbsp5_dr", "sdmmc3_dat0", "hsusb1_data4",
+		"gpio_18", NULL, NULL, "hw_dbg7"),
+	_OMAP3_MUXENTRY(ETK_D5, 19,
+		"etk_d5", "mcbsp5_fsx", "sdmmc3_dat1", "hsusb1_data5",
+		"gpio_19", NULL, NULL, "hw_dbg8"),
+	_OMAP3_MUXENTRY(ETK_D6, 20,
+		"etk_d6", "mcbsp5_dx", "sdmmc3_dat2", "hsusb1_data6",
+		"gpio_20", NULL, NULL, "hw_dbg9"),
+	_OMAP3_MUXENTRY(ETK_D7, 21,
+		"etk_d7", "mcspi3_cs1", "sdmmc3_dat7", "hsusb1_data3",
+		"gpio_21", "mm_fsusb1_txen_n", NULL, "hw_dbg10"),
+	_OMAP3_MUXENTRY(ETK_D8, 22,
+		"etk_d8", NULL, "sdmmc3_dat6", "hsusb1_dir",
+		"gpio_22", NULL, NULL, "hw_dbg11"),
+	_OMAP3_MUXENTRY(ETK_D9, 23,
+		"etk_d9", NULL, "sdmmc3_dat5", "hsusb1_nxt",
+		"gpio_23", "mm_fsusb1_rxdm", NULL, "hw_dbg12"),
+	_OMAP3_MUXENTRY(ETK_D10, 24,
+		"etk_d10", NULL, "uart1_rx", "hsusb2_clk",
+		"gpio_24", NULL, NULL, "hw_dbg13"),
+	_OMAP3_MUXENTRY(ETK_D11, 25,
+		"etk_d11", "mcspi3_clk", NULL, "hsusb2_stp",
+		"gpio_25", "mm_fsusb2_rxdp", NULL, "hw_dbg14"),
+	_OMAP3_MUXENTRY(ETK_D12, 26,
+		"etk_d12", NULL, NULL, "hsusb2_dir",
+		"gpio_26", NULL, NULL, "hw_dbg15"),
+	_OMAP3_MUXENTRY(ETK_D13, 27,
+		"etk_d13", NULL, NULL, "hsusb2_nxt",
+		"gpio_27", "mm_fsusb2_rxdm", NULL, "hw_dbg15"),
+	_OMAP3_MUXENTRY(ETK_D14, 28,
+		"etk_d14", NULL, NULL, "hsusb2_data0",
+		"gpio_28", "mm_fsusb2_rxrcv", NULL, "hw_dbg16"),
+	_OMAP3_MUXENTRY(ETK_D15, 29,
+		"etk_d15", NULL, NULL, "hsusb2_data1",
+		"gpio_29", "mm_fsusb2_txse0", NULL, "hw_dbg17"),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define am35xx_zcn_subset	NULL
+#endif
+
+/*
+ * Balls for AM35XX ZCN package
+ * 491-pin s-PBGA Package, 0.65mm Ball Pitch
+ */
+#if defined(CONFIG_OMAP_MUX) && defined(CONFIG_DEBUG_FS)		\
+		&& defined (CONFIG_OMAP_PACKAGE_ZCN)
+static struct omap_ball __initdata am35xx_zcn_ball[] = {
+	_OMAP3_BALLENTRY(SDRC_CKE0, "d14", NULL),
+	_OMAP3_BALLENTRY(GPMC_A1, "e3", NULL),
+	_OMAP3_BALLENTRY(GPMC_A2, "e2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A3, "e1", NULL),
+	_OMAP3_BALLENTRY(GPMC_A4, "f7", NULL),
+	_OMAP3_BALLENTRY(GPMC_A5, "f6", NULL),
+	_OMAP3_BALLENTRY(GPMC_A6, "f4", NULL),
+	_OMAP3_BALLENTRY(GPMC_A7, "f3", NULL),
+	_OMAP3_BALLENTRY(GPMC_A8, "f2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A9, "f1", NULL),
+	_OMAP3_BALLENTRY(GPMC_A10, "g6", NULL),
+	_OMAP3_BALLENTRY(GPMC_D8, "j4", NULL),
+	_OMAP3_BALLENTRY(GPMC_D9, "j3", NULL),
+	_OMAP3_BALLENTRY(GPMC_D10, "j2", NULL),
+	_OMAP3_BALLENTRY(GPMC_D11, "j1", NULL),
+	_OMAP3_BALLENTRY(GPMC_D12, "k4", NULL),
+	_OMAP3_BALLENTRY(GPMC_D13, "k3", NULL),
+	_OMAP3_BALLENTRY(GPMC_D14, "k2", NULL),
+	_OMAP3_BALLENTRY(GPMC_D15, "k1", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS1, "l1", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS2, "m4", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS3, "m3", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS4, "m2", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS5, "m1", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS6, "n5", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS7, "n4", NULL),
+	_OMAP3_BALLENTRY(GPMC_CLK, "n1", NULL),
+	_OMAP3_BALLENTRY(GPMC_NBE0_CLE, "r4", NULL),
+	_OMAP3_BALLENTRY(GPMC_NBE1, "t1", NULL),
+	_OMAP3_BALLENTRY(GPMC_NWP, "t2", NULL),
+	_OMAP3_BALLENTRY(GPMC_WAIT1, "t4", NULL),
+	_OMAP3_BALLENTRY(GPMC_WAIT2, "t5", NULL),
+	_OMAP3_BALLENTRY(GPMC_WAIT3, "u1", NULL),
+	_OMAP3_BALLENTRY(DSS_PCLK, "ae23", NULL),
+	_OMAP3_BALLENTRY(DSS_HSYNC, "ad22", NULL),
+	_OMAP3_BALLENTRY(DSS_VSYNC, "ad23", NULL),
+	_OMAP3_BALLENTRY(DSS_ACBIAS, "ae24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA0, "ad24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA1, "ad25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA2, "ac23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA3, "ac24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA4, "ac25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA5, "ab24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA6, "ab25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA7, "aa23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA8, "aa24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA9, "aa25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA10, "y22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA11, "y23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA12, "y24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA13, "y25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA14, "w21", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA15, "w22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA16, "w23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA17, "w24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA18, "w25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA19, "v24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA20, "v25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA21, "u21", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA22, "u22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA23, "u23", NULL),
+	_OMAP3_BALLENTRY(CCDC_PCLK, "ad2", NULL),
+	_OMAP3_BALLENTRY(CCDC_FIELD, "ad1", NULL),
+	_OMAP3_BALLENTRY(CCDC_HD, "ae2", NULL),
+	_OMAP3_BALLENTRY(CCDC_VD, "ad3", NULL),
+	_OMAP3_BALLENTRY(CCDC_WEN, "ae3", NULL),
+	_OMAP3_BALLENTRY(CCDC_DATA0, "ad4", NULL),
+	_OMAP3_BALLENTRY(CCDC_DATA1, "ae4", NULL),
+	_OMAP3_BALLENTRY(CCDC_DATA2, "ac5", NULL),
+	_OMAP3_BALLENTRY(CCDC_DATA3, "ad5", NULL),
+	_OMAP3_BALLENTRY(CCDC_DATA4, "ae5", NULL),
+	_OMAP3_BALLENTRY(CCDC_DATA5, "y6", NULL),
+	_OMAP3_BALLENTRY(CCDC_DATA6, "ab6", NULL),
+	_OMAP3_BALLENTRY(CCDC_DATA7, "ac6", NULL),
+	_OMAP3_BALLENTRY(RMII_MDIO_DATA, "ae6", NULL),
+	_OMAP3_BALLENTRY(RMII_MDIO_CLK, "ad6", NULL),
+	_OMAP3_BALLENTRY(RMII_RXD0, "y7", NULL),
+	_OMAP3_BALLENTRY(RMII_RXD1, "aa7", NULL),
+	_OMAP3_BALLENTRY(RMII_CRS_DV, "ab7", NULL),
+	_OMAP3_BALLENTRY(RMII_RXER, "ac7", NULL),
+	_OMAP3_BALLENTRY(RMII_TXD0, "ad7", NULL),
+	_OMAP3_BALLENTRY(RMII_TXD1, "ae7", NULL),
+	_OMAP3_BALLENTRY(RMII_TXEN, "ad8", NULL),
+	_OMAP3_BALLENTRY(RMII_50MHZ_CLK, "ae8", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_FSX, "d25", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_CLKX, "c25", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_DR, "b25", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_DX, "d24", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_CLK, "aa9", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_CMD, "ab9", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT0, "ac9", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT1, "ad9", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT2, "ae9", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT3, "aa10", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT4, "ab10", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT5, "ac10", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT6, "ad10", NULL),
+	_OMAP3_BALLENTRY(SDMMC1_DAT7, "ae10", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_CLK, "ad11", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_CMD, "ae11", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT0, "ab12", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT1, "ac12", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT2, "ad12", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT3, "ae12", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT4, "ab13", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT5, "ac13", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT6, "ad13", NULL),
+	_OMAP3_BALLENTRY(SDMMC2_DAT7, "ae13", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_DX, "b24", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_DR, "c24", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_CLKX, "a24", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_FSX, "c23", NULL),
+	_OMAP3_BALLENTRY(UART2_CTS, "f20", NULL),
+	_OMAP3_BALLENTRY(UART2_RTS, "f19", NULL),
+	_OMAP3_BALLENTRY(UART2_TX, "e24", NULL),
+	_OMAP3_BALLENTRY(UART2_RX, "e23", NULL),
+	_OMAP3_BALLENTRY(UART1_TX, "aa19", NULL),
+	_OMAP3_BALLENTRY(UART1_RTS, "y19", NULL),
+	_OMAP3_BALLENTRY(UART1_CTS, "y20", NULL),
+	_OMAP3_BALLENTRY(UART1_RX, "w20", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_CLKX, "b23", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_DR, "a23", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_DX, "b22", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_FSX, "a22", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_CLKR, "r25", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_FSR, "p21", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_DX, "p22", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_DR, "p23", NULL),
+	_OMAP3_BALLENTRY(MCBSP_CLKS, "p25", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_FSX, "p24", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_CLKX, "n24", NULL),
+	_OMAP3_BALLENTRY(UART3_CTS_RCTX, "n2", NULL),
+	_OMAP3_BALLENTRY(UART3_RTS_SD, "n3", NULL),
+	_OMAP3_BALLENTRY(UART3_RX_IRRX, "p1", NULL),
+	_OMAP3_BALLENTRY(UART3_TX_IRTX, "p2", NULL),
+	_OMAP3_BALLENTRY(USB0_DRVVBUS, "e25", NULL),
+	_OMAP3_BALLENTRY(HECC1_TXD, "v2", NULL),
+	_OMAP3_BALLENTRY(HECC1_RXD, "v3", NULL),
+	_OMAP3_BALLENTRY(I2C2_SCL, "w1", NULL),
+	_OMAP3_BALLENTRY(I2C2_SDA, "w2", NULL),
+	_OMAP3_BALLENTRY(I2C3_SCL, "w4", NULL),
+	_OMAP3_BALLENTRY(I2C3_SDA, "w5", NULL),
+	_OMAP3_BALLENTRY(HDQ_SIO, "l25", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CLK, "ae14", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_SIMO, "ad15", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_SOMI, "ac15", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS0, "ab15", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS1, "ad14", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS2, "ae15", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS3, "ae16", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CLK, "ad16", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_SIMO, "ac16", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_SOMI, "ab16", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CS0, "aa16", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CS1, "ae17", NULL),
+	_OMAP3_BALLENTRY(SYS_NIRQ, "y1", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKOUT2, "m25", NULL),
+	_OMAP3_BALLENTRY(ETK_CLK, "ad17", NULL),
+	_OMAP3_BALLENTRY(ETK_CTL, "ae18", NULL),
+	_OMAP3_BALLENTRY(ETK_D0, "ad18", NULL),
+	_OMAP3_BALLENTRY(ETK_D1, "ac18", NULL),
+	_OMAP3_BALLENTRY(ETK_D10, "ac20", NULL),
+	_OMAP3_BALLENTRY(ETK_D11, "ab20", NULL),
+	_OMAP3_BALLENTRY(ETK_D12, "ae21", NULL),
+	_OMAP3_BALLENTRY(ETK_D13, "ad21", NULL),
+	_OMAP3_BALLENTRY(ETK_D14, "ac21", NULL),
+	_OMAP3_BALLENTRY(ETK_D15, "ae22", NULL),
+	_OMAP3_BALLENTRY(ETK_D2, "ab18", NULL),
+	_OMAP3_BALLENTRY(ETK_D3, "aa18", NULL),
+	_OMAP3_BALLENTRY(ETK_D4, "y18", NULL),
+	_OMAP3_BALLENTRY(ETK_D5, "ae19", NULL),
+	_OMAP3_BALLENTRY(ETK_D6, "ad19", NULL),
+	_OMAP3_BALLENTRY(ETK_D7, "ab19", NULL),
+	_OMAP3_BALLENTRY(ETK_D8, "ae20", NULL),
+	_OMAP3_BALLENTRY(ETK_D9, "d20", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKREQ, "m24", NULL),
+	_OMAP3_BALLENTRY(SYS_NRESWARM, "y3", "aa5"),
+	_OMAP3_BALLENTRY(SYS_BOOT0, "y4", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT1, "aa1", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT2, "aa2", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT3, "aa3", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT4, "ab1", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT5, "ab2", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT6, "ac1", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKOUT1, "n25", NULL),
+	_OMAP3_BALLENTRY(JTAG_EMU0, "t25", NULL),
+	_OMAP3_BALLENTRY(JTAG_EMU1, "r24", NULL),
+
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define am35xx_zcn_ball	 NULL
+#endif
+
 int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
 {
 	struct omap_mux *package_subset;
@@ -2048,6 +2611,10 @@ int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
 		package_subset = omap36xx_cbp_subset;
 		package_balls = omap36xx_cbp_ball;
 		break;
+	case OMAP_PACKAGE_ZCN:
+		package_subset = am35xx_zcn_subset;
+		package_balls = am35xx_zcn_ball;
+		break;
 	default:
 		pr_err("%s Unknown omap package, mux disabled\n", __func__);
 		return -EINVAL;
diff --git a/arch/arm/mach-omap2/mux34xx.h b/arch/arm/mach-omap2/mux34xx.h
index 6543ebf..5626544 100644
--- a/arch/arm/mach-omap2/mux34xx.h
+++ b/arch/arm/mach-omap2/mux34xx.h
@@ -316,6 +316,42 @@
 #define OMAP3_CONTROL_PADCONF_SDRC_CKE0_OFFSET			0x232
 #define OMAP3_CONTROL_PADCONF_SDRC_CKE1_OFFSET			0x234
 
+/* AM3505/3517 only */
+#define OMAP3_CONTROL_PADCONF_CCDC_PCLK_OFFSET			0x1b4
+#define OMAP3_CONTROL_PADCONF_CCDC_FIELD_OFFSET			0x1b6
+#define OMAP3_CONTROL_PADCONF_CCDC_HD_OFFSET			0x1b8
+#define OMAP3_CONTROL_PADCONF_CCDC_VD_OFFSET			0x1ba
+#define OMAP3_CONTROL_PADCONF_CCDC_WEN_OFFSET			0x1bc
+#define OMAP3_CONTROL_PADCONF_CCDC_DATA0_OFFSET			0x1be
+#define OMAP3_CONTROL_PADCONF_CCDC_DATA1_OFFSET			0x1c0
+#define OMAP3_CONTROL_PADCONF_CCDC_DATA2_OFFSET			0x1c2
+#define OMAP3_CONTROL_PADCONF_CCDC_DATA3_OFFSET			0x1c4
+#define OMAP3_CONTROL_PADCONF_CCDC_DATA4_OFFSET			0x1c6
+#define OMAP3_CONTROL_PADCONF_CCDC_DATA5_OFFSET			0x1c8
+#define OMAP3_CONTROL_PADCONF_CCDC_DATA6_OFFSET			0x1ca
+#define OMAP3_CONTROL_PADCONF_CCDC_DATA7_OFFSET			0x1cc
+#define OMAP3_CONTROL_PADCONF_RMII_MDIO_DATA_OFFSET		0x1ce
+#define OMAP3_CONTROL_PADCONF_RMII_MDIO_CLK_OFFSET		0x1d0
+#define OMAP3_CONTROL_PADCONF_RMII_RXD0_OFFSET			0x1d2
+#define OMAP3_CONTROL_PADCONF_RMII_RXD1_OFFSET			0x1d4
+#define OMAP3_CONTROL_PADCONF_RMII_CRS_DV_OFFSET		0x1d6
+#define OMAP3_CONTROL_PADCONF_RMII_RXER_OFFSET			0x1d8
+#define OMAP3_CONTROL_PADCONF_RMII_TXD0_OFFSET			0x1da
+#define OMAP3_CONTROL_PADCONF_RMII_TXD1_OFFSET			0x1dc
+#define OMAP3_CONTROL_PADCONF_RMII_TXEN_OFFSET			0x1de
+#define OMAP3_CONTROL_PADCONF_RMII_50MHZ_CLK_OFFSET		0x1e0
+#define OMAP3_CONTROL_PADCONF_USB0_DRVVBUS_OFFSET		0x1e2
+#define OMAP3_CONTROL_PADCONF_HECC1_TXD_OFFSET			0x1e4
+#define OMAP3_CONTROL_PADCONF_HECC1_RXD_OFFSET			0x1e6
+#define OMAP3_CONTROL_PADCONF_SYS_BOOT7_OFFSET			0x1e8
+#define OMAP3_CONTROL_PADCONF_SDRC_DQS0N_OFFSET			0x1ea
+#define OMAP3_CONTROL_PADCONF_SDRC_DQS1N_OFFSET			0x1ec
+#define OMAP3_CONTROL_PADCONF_SDRC_DQS2N_OFFSET			0x1ee
+#define OMAP3_CONTROL_PADCONF_SDRC_DQS3N_OFFSET			0x1f0
+#define OMAP3_CONTROL_PADCONF_SDRC_STRBEN_DLY0_OFFSET		0x1f2
+#define OMAP3_CONTROL_PADCONF_SDRC_STRBEN_DLY1_OFFSET		0x1f4
+#define OMAP3_CONTROL_PADCONF_SYS_BOOT8_OFFSET			0x1f6
+
 /* 36xx only */
 #define OMAP3_CONTROL_PADCONF_GPMC_A11_OFFSET			0x236
 #define OMAP3_CONTROL_PADCONF_SDRC_BA0_OFFSET			0x570


