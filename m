From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] omap: mux: Add new style pin multiplexing data for 34xx
Date: Thu, 29 Oct 2009 13:36:31 -0700
Message-ID: <20091029203631.11843.1364.stgit@localhost>
References: <20091029203124.11843.89983.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62916 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbZJ2Ug2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 16:36:28 -0400
In-Reply-To: <20091029203124.11843.89983.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mike.rapoport@gmail.com

Add new style mux data for 34xx. This should also
work with 3630 easily by adding the processor subset
and ball data.

Note that this data is __initdata, and gets optimized
out if CONFIG_OMAP_MUX is not set. Also, the debug data
gets optimized out if CONFIG_DEBUG_FS is not set.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile  |    4 
 arch/arm/mach-omap2/mux.h     |    2 
 arch/arm/mach-omap2/mux34xx.c | 1552 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux34xx.h |  352 +++++++++
 4 files changed, 1910 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mux34xx.c
 create mode 100644 arch/arm/mach-omap2/mux34xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 03cb4fc..4b6d7b9 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -23,6 +23,10 @@ obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
 obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 
+ifeq ($(CONFIG_OMAP_MUX),y)
+obj-$(CONFIG_ARCH_OMAP3)		+= mux34xx.o
+endif
+
 # SMS/SDRC
 obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 # obj-$(CONFIG_ARCH_OMAP3)		+= sdrc3xxx.o
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index a8453f5..0d52318 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -7,6 +7,8 @@
  * published by the Free Software Foundation.
  */
 
+#include "mux34xx.h"
+
 #define OMAP_MUX_TERMINATOR	0xffff
 
 /* 34xx mux mode options for each pin. See TRM for options */
diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
new file mode 100644
index 0000000..62c2b6a
--- /dev/null
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -0,0 +1,1552 @@
+/*
+ * Copyright (C) 2009 Nokia
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include "mux.h"
+
+#ifdef CONFIG_DEBUG_FS
+
+#define _OMAP3_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
+{									\
+	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
+	.gpio		= (g),						\
+	.muxnames	= { m0, m1, m2, m3, m4, m5, m6, m7 },		\
+}
+
+#else
+
+#define _OMAP3_MUXENTRY(M0, g, m0, m1, m2, m3, m4, m5, m6, m7)		\
+{									\
+	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
+	.gpio		= (g),						\
+}
+
+#endif
+
+#define _OMAP3_BALLENTRY(M0, bb, bt)					\
+{									\
+	.reg_offset	= (OMAP3_CONTROL_PADCONF_##M0##_OFFSET),	\
+	.balls		= { bb, bt },					\
+}
+
+/*
+ * Superset of all mux modes, same as the CBC package
+ */
+static struct omap_mux __initdata omap3_muxmodes[] = {
+	_OMAP3_MUXENTRY(CAM_D0, 99,
+		"cam_d0", NULL, NULL, NULL,
+		"gpio_99", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D10, 109,
+		"cam_d10", NULL, NULL, NULL,
+		"gpio_109", "hw_dbg8", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D11, 110,
+		"cam_d11", NULL, NULL, NULL,
+		"gpio_110", "hw_dbg9", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D1, 100,
+		"cam_d1", NULL, NULL, NULL,
+		"gpio_100", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D2, 101,
+		"cam_d2", NULL, NULL, NULL,
+		"gpio_101", "hw_dbg4", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D3, 102,
+		"cam_d3", NULL, NULL, NULL,
+		"gpio_102", "hw_dbg5", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D4, 103,
+		"cam_d4", NULL, NULL, NULL,
+		"gpio_103", "hw_dbg6", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D5, 104,
+		"cam_d5", NULL, NULL, NULL,
+		"gpio_104", "hw_dbg7", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D6, 105,
+		"cam_d6", NULL, NULL, NULL,
+		"gpio_105", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D7, 106,
+		"cam_d7", NULL, NULL, NULL,
+		"gpio_106", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D8, 107,
+		"cam_d8", NULL, NULL, NULL,
+		"gpio_107", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D9, 108,
+		"cam_d9", NULL, NULL, NULL,
+		"gpio_108", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_FLD, 98,
+		"cam_fld", NULL, "cam_global_reset", NULL,
+		"gpio_98", "hw_dbg3", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_HS, 94,
+		"cam_hs", NULL, NULL, NULL,
+		"gpio_94", "hw_dbg0", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_PCLK, 97,
+		"cam_pclk", NULL, NULL, NULL,
+		"gpio_97", "hw_dbg2", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_STROBE, 126,
+		"cam_strobe", NULL, NULL, NULL,
+		"gpio_126", "hw_dbg11", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_VS, 95,
+		"cam_vs", NULL, NULL, NULL,
+		"gpio_95", "hw_dbg1", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_WEN, 167,
+		"cam_wen", NULL, "cam_shutter", NULL,
+		"gpio_167", "hw_dbg10", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_XCLKA, 96,
+		"cam_xclka", NULL, NULL, NULL,
+		"gpio_96", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_XCLKB, 111,
+		"cam_xclkb", NULL, NULL, NULL,
+		"gpio_111", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CSI2_DX0, 112,
+		"csi2_dx0", NULL, NULL, NULL,
+		"gpio_112", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CSI2_DX1, 114,
+		"csi2_dx1", NULL, NULL, NULL,
+		"gpio_114", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CSI2_DY0, 113,
+		"csi2_dy0", NULL, NULL, NULL,
+		"gpio_113", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CSI2_DY1, 115,
+		"csi2_dy1", NULL, NULL, NULL,
+		"gpio_115", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_ACBIAS, 69,
+		"dss_acbias", NULL, NULL, NULL,
+		"gpio_69", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA0, 70,
+		"dss_data0", NULL, "uart1_cts", NULL,
+		"gpio_70", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA10, 80,
+		"dss_data10", NULL, NULL, NULL,
+		"gpio_80", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA11, 81,
+		"dss_data11", NULL, NULL, NULL,
+		"gpio_81", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA12, 82,
+		"dss_data12", NULL, NULL, NULL,
+		"gpio_82", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA13, 83,
+		"dss_data13", NULL, NULL, NULL,
+		"gpio_83", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA14, 84,
+		"dss_data14", NULL, NULL, NULL,
+		"gpio_84", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA15, 85,
+		"dss_data15", NULL, NULL, NULL,
+		"gpio_85", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA16, 86,
+		"dss_data16", NULL, NULL, NULL,
+		"gpio_86", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA17, 87,
+		"dss_data17", NULL, NULL, NULL,
+		"gpio_87", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA18, 88,
+		"dss_data18", NULL, "mcspi3_clk", "dss_data0",
+		"gpio_88", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA19, 89,
+		"dss_data19", NULL, "mcspi3_simo", "dss_data1",
+		"gpio_89", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA1, 71,
+		"dss_data1", NULL, "uart1_rts", NULL,
+		"gpio_71", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA20, 90,
+		"dss_data20", NULL, "mcspi3_somi", "dss_data2",
+		"gpio_90", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA21, 91,
+		"dss_data21", NULL, "mcspi3_cs0", "dss_data3",
+		"gpio_91", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA22, 92,
+		"dss_data22", NULL, "mcspi3_cs1", "dss_data4",
+		"gpio_92", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA23, 93,
+		"dss_data23", NULL, NULL, "dss_data5",
+		"gpio_93", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA2, 72,
+		"dss_data2", NULL, NULL, NULL,
+		"gpio_72", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA3, 73,
+		"dss_data3", NULL, NULL, NULL,
+		"gpio_73", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA4, 74,
+		"dss_data4", NULL, "uart3_rx_irrx", NULL,
+		"gpio_74", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA5, 75,
+		"dss_data5", NULL, "uart3_tx_irtx", NULL,
+		"gpio_75", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA6, 76,
+		"dss_data6", NULL, "uart1_tx", NULL,
+		"gpio_76", "hw_dbg14", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA7, 77,
+		"dss_data7", NULL, "uart1_rx", NULL,
+		"gpio_77", "hw_dbg15", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA8, 78,
+		"dss_data8", NULL, NULL, NULL,
+		"gpio_78", "hw_dbg16", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA9, 79,
+		"dss_data9", NULL, NULL, NULL,
+		"gpio_79", "hw_dbg17", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_HSYNC, 67,
+		"dss_hsync", NULL, NULL, NULL,
+		"gpio_67", "hw_dbg13", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_PCLK, 66,
+		"dss_pclk", NULL, NULL, NULL,
+		"gpio_66", "hw_dbg12", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_VSYNC, 68,
+		"dss_vsync", NULL, NULL, NULL,
+		"gpio_68", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(ETK_CLK, 12,
+		"etk_clk", "mcbsp5_clkx", "mmc3_clk", "hsusb1_stp",
+		"gpio_12", "mm1_rxdp", "hsusb1_tll_stp", "hw_dbg0"),
+	_OMAP3_MUXENTRY(ETK_CTL, 13,
+		"etk_ctl", NULL, "mmc3_cmd", "hsusb1_clk",
+		"gpio_13", NULL, "hsusb1_tll_clk", "hw_dbg1"),
+	_OMAP3_MUXENTRY(ETK_D0, 14,
+		"etk_d0", "mcspi3_simo", "mmc3_dat4", "hsusb1_data0",
+		"gpio_14", "mm1_rxrcv", "hsusb1_tll_data0", "hw_dbg2"),
+	_OMAP3_MUXENTRY(ETK_D10, 24,
+		"etk_d10", NULL, "uart1_rx", "hsusb2_clk",
+		"gpio_24", NULL, "hsusb2_tll_clk", "hw_dbg12"),
+	_OMAP3_MUXENTRY(ETK_D11, 25,
+		"etk_d11", NULL, NULL, "hsusb2_stp",
+		"gpio_25", "mm2_rxdp", "hsusb2_tll_stp", "hw_dbg13"),
+	_OMAP3_MUXENTRY(ETK_D12, 26,
+		"etk_d12", NULL, NULL, "hsusb2_dir",
+		"gpio_26", NULL, "hsusb2_tll_dir", "hw_dbg14"),
+	_OMAP3_MUXENTRY(ETK_D13, 27,
+		"etk_d13", NULL, NULL, "hsusb2_nxt",
+		"gpio_27", "mm2_rxdm", "hsusb2_tll_nxt", "hw_dbg15"),
+	_OMAP3_MUXENTRY(ETK_D14, 28,
+		"etk_d14", NULL, NULL, "hsusb2_data0",
+		"gpio_28", "mm2_rxrcv", "hsusb2_tll_data0", "hw_dbg16"),
+	_OMAP3_MUXENTRY(ETK_D15, 29,
+		"etk_d15", NULL, NULL, "hsusb2_data1",
+		"gpio_29", "mm2_txse0", "hsusb2_tll_data1", "hw_dbg17"),
+	_OMAP3_MUXENTRY(ETK_D1, 15,
+		"etk_d1", "mcspi3_somi", NULL, "hsusb1_data1",
+		"gpio_15", "mm1_txse0", "hsusb1_tll_data1", "hw_dbg3"),
+	_OMAP3_MUXENTRY(ETK_D2, 16,
+		"etk_d2", "mcspi3_cs0", NULL, "hsusb1_data2",
+		"gpio_16", "mm1_txdat", "hsusb1_tll_data2", "hw_dbg4"),
+	_OMAP3_MUXENTRY(ETK_D3, 17,
+		"etk_d3", "mcspi3_clk", "mmc3_dat3", "hsusb1_data7",
+		"gpio_17", NULL, "hsusb1_tll_data7", "hw_dbg5"),
+	_OMAP3_MUXENTRY(ETK_D4, 18,
+		"etk_d4", "mcbsp5_dr", "mmc3_dat0", "hsusb1_data4",
+		"gpio_18", NULL, "hsusb1_tll_data4", "hw_dbg6"),
+	_OMAP3_MUXENTRY(ETK_D5, 19,
+		"etk_d5", "mcbsp5_fsx", "mmc3_dat1", "hsusb1_data5",
+		"gpio_19", NULL, "hsusb1_tll_data5", "hw_dbg7"),
+	_OMAP3_MUXENTRY(ETK_D6, 20,
+		"etk_d6", "mcbsp5_dx", "mmc3_dat2", "hsusb1_data6",
+		"gpio_20", NULL, "hsusb1_tll_data6", "hw_dbg8"),
+	_OMAP3_MUXENTRY(ETK_D7, 21,
+		"etk_d7", "mcspi3_cs1", "mmc3_dat7", "hsusb1_data3",
+		"gpio_21", "mm1_txen_n", "hsusb1_tll_data3", "hw_dbg9"),
+	_OMAP3_MUXENTRY(ETK_D8, 22,
+		"etk_d8", "sys_drm_msecure", "mmc3_dat6", "hsusb1_dir",
+		"gpio_22", NULL, "hsusb1_tll_dir", "hw_dbg10"),
+	_OMAP3_MUXENTRY(ETK_D9, 23,
+		"etk_d9", "sys_secure_indicator", "mmc3_dat5", "hsusb1_nxt",
+		"gpio_23", "mm1_rxdm", "hsusb1_tll_nxt", "hw_dbg11"),
+	_OMAP3_MUXENTRY(GPMC_A10, 43,
+		"gpmc_a10", "sys_ndmareq3", NULL, NULL,
+		"gpio_43", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_A1, 34,
+		"gpmc_a1", NULL, NULL, NULL,
+		"gpio_34", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_A2, 35,
+		"gpmc_a2", NULL, NULL, NULL,
+		"gpio_35", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_A3, 36,
+		"gpmc_a3", NULL, NULL, NULL,
+		"gpio_36", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_A4, 37,
+		"gpmc_a4", NULL, NULL, NULL,
+		"gpio_37", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_A5, 38,
+		"gpmc_a5", NULL, NULL, NULL,
+		"gpio_38", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_A6, 39,
+		"gpmc_a6", NULL, NULL, NULL,
+		"gpio_39", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_A7, 40,
+		"gpmc_a7", NULL, NULL, NULL,
+		"gpio_40", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_A8, 41,
+		"gpmc_a8", NULL, NULL, NULL,
+		"gpio_41", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_A9, 42,
+		"gpmc_a9", "sys_ndmareq2", NULL, NULL,
+		"gpio_42", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_CLK, 59,
+		"gpmc_clk", NULL, NULL, NULL,
+		"gpio_59", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_D10, 46,
+		"gpmc_d10", NULL, NULL, NULL,
+		"gpio_46", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_D11, 47,
+		"gpmc_d11", NULL, NULL, NULL,
+		"gpio_47", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_D12, 48,
+		"gpmc_d12", NULL, NULL, NULL,
+		"gpio_48", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_D13, 49,
+		"gpmc_d13", NULL, NULL, NULL,
+		"gpio_49", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_D14, 50,
+		"gpmc_d14", NULL, NULL, NULL,
+		"gpio_50", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_D15, 51,
+		"gpmc_d15", NULL, NULL, NULL,
+		"gpio_51", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_D8, 44,
+		"gpmc_d8", NULL, NULL, NULL,
+		"gpio_44", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_D9, 45,
+		"gpmc_d9", NULL, NULL, NULL,
+		"gpio_45", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NBE0_CLE, 60,
+		"gpmc_nbe0_cle", NULL, NULL, NULL,
+		"gpio_60", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NBE1, 61,
+		"gpmc_nbe1", NULL, NULL, NULL,
+		"gpio_61", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS1, 52,
+		"gpmc_ncs1", NULL, NULL, NULL,
+		"gpio_52", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS2, 53,
+		"gpmc_ncs2", NULL, NULL, NULL,
+		"gpio_53", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS3, 54,
+		"gpmc_ncs3", "sys_ndmareq0", NULL, NULL,
+		"gpio_54", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS4, 55,
+		"gpmc_ncs4", "sys_ndmareq1", "mcbsp4_clkx", "gpt9_pwm_evt",
+		"gpio_55", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS5, 56,
+		"gpmc_ncs5", "sys_ndmareq2", "mcbsp4_dr", "gpt10_pwm_evt",
+		"gpio_56", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS6, 57,
+		"gpmc_ncs6", "sys_ndmareq3", "mcbsp4_dx", "gpt11_pwm_evt",
+		"gpio_57", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NCS7, 58,
+		"gpmc_ncs7", "gpmc_io_dir", "mcbsp4_fsx", "gpt8_pwm_evt",
+		"gpio_58", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_NWP, 62,
+		"gpmc_nwp", NULL, NULL, NULL,
+		"gpio_62", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_WAIT1, 63,
+		"gpmc_wait1", NULL, NULL, NULL,
+		"gpio_63", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_WAIT2, 64,
+		"gpmc_wait2", NULL, NULL, NULL,
+		"gpio_64", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(GPMC_WAIT3, 65,
+		"gpmc_wait3", "sys_ndmareq1", NULL, NULL,
+		"gpio_65", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HDQ_SIO, 170,
+		"hdq_sio", "sys_altclk", "i2c2_sccbe", "i2c3_sccbe",
+		"gpio_170", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_CLK, 120,
+		"hsusb0_clk", NULL, NULL, NULL,
+		"gpio_120", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA0, 125,
+		"hsusb0_data0", NULL, "uart3_tx_irtx", NULL,
+		"gpio_125", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA1, 130,
+		"hsusb0_data1", NULL, "uart3_rx_irrx", NULL,
+		"gpio_130", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA2, 131,
+		"hsusb0_data2", NULL, "uart3_rts_sd", NULL,
+		"gpio_131", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA3, 169,
+		"hsusb0_data3", NULL, "uart3_cts_rctx", NULL,
+		"gpio_169", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA4, 188,
+		"hsusb0_data4", NULL, NULL, NULL,
+		"gpio_188", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA5, 189,
+		"hsusb0_data5", NULL, NULL, NULL,
+		"gpio_189", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA6, 190,
+		"hsusb0_data6", NULL, NULL, NULL,
+		"gpio_190", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DATA7, 191,
+		"hsusb0_data7", NULL, NULL, NULL,
+		"gpio_191", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_DIR, 122,
+		"hsusb0_dir", NULL, NULL, NULL,
+		"gpio_122", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_NXT, 124,
+		"hsusb0_nxt", NULL, NULL, NULL,
+		"gpio_124", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(HSUSB0_STP, 121,
+		"hsusb0_stp", NULL, NULL, NULL,
+		"gpio_121", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(I2C2_SCL, 168,
+		"i2c2_scl", NULL, NULL, NULL,
+		"gpio_168", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(I2C2_SDA, 183,
+		"i2c2_sda", NULL, NULL, NULL,
+		"gpio_183", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(I2C3_SCL, 184,
+		"i2c3_scl", NULL, NULL, NULL,
+		"gpio_184", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(I2C3_SDA, 185,
+		"i2c3_sda", NULL, NULL, NULL,
+		"gpio_185", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(I2C4_SCL, 0,
+		"i2c4_scl", "sys_nvmode1", NULL, NULL,
+		NULL, NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(I2C4_SDA, 0,
+		"i2c4_sda", "sys_nvmode2", NULL, NULL,
+		NULL, NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(JTAG_EMU0, 11,
+		"jtag_emu0", NULL, NULL, NULL,
+		"gpio_11", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(JTAG_EMU1, 31,
+		"jtag_emu1", NULL, NULL, NULL,
+		"gpio_31", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP1_CLKR, 156,
+		"mcbsp1_clkr", "mcspi4_clk", NULL, NULL,
+		"gpio_156", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP1_CLKX, 162,
+		"mcbsp1_clkx", NULL, "mcbsp3_clkx", NULL,
+		"gpio_162", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP1_DR, 159,
+		"mcbsp1_dr", "mcspi4_somi", "mcbsp3_dr", NULL,
+		"gpio_159", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP1_DX, 158,
+		"mcbsp1_dx", "mcspi4_simo", "mcbsp3_dx", NULL,
+		"gpio_158", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP1_FSR, 157,
+		"mcbsp1_fsr", NULL, "cam_global_reset", NULL,
+		"gpio_157", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP1_FSX, 161,
+		"mcbsp1_fsx", "mcspi4_cs0", "mcbsp3_fsx", NULL,
+		"gpio_161", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP2_CLKX, 117,
+		"mcbsp2_clkx", NULL, NULL, NULL,
+		"gpio_117", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP2_DR, 118,
+		"mcbsp2_dr", NULL, NULL, NULL,
+		"gpio_118", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP2_DX, 119,
+		"mcbsp2_dx", NULL, NULL, NULL,
+		"gpio_119", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP2_FSX, 116,
+		"mcbsp2_fsx", NULL, NULL, NULL,
+		"gpio_116", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_CLKX, 142,
+		"mcbsp3_clkx", "uart2_tx", NULL, NULL,
+		"gpio_142", "hsusb3_tll_data6", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_DR, 141,
+		"mcbsp3_dr", "uart2_rts", NULL, NULL,
+		"gpio_141", "hsusb3_tll_data5", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_DX, 140,
+		"mcbsp3_dx", "uart2_cts", NULL, NULL,
+		"gpio_140", "hsusb3_tll_data4", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_FSX, 143,
+		"mcbsp3_fsx", "uart2_rx", NULL, NULL,
+		"gpio_143", "hsusb3_tll_data7", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_CLKX, 152,
+		"mcbsp4_clkx", NULL, NULL, NULL,
+		"gpio_152", "hsusb3_tll_data1", "mm3_txse0", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_DR, 153,
+		"mcbsp4_dr", NULL, NULL, NULL,
+		"gpio_153", "hsusb3_tll_data0", "mm3_rxrcv", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_DX, 154,
+		"mcbsp4_dx", NULL, NULL, NULL,
+		"gpio_154", "hsusb3_tll_data2", "mm3_txdat", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP4_FSX, 155,
+		"mcbsp4_fsx", NULL, NULL, NULL,
+		"gpio_155", "hsusb3_tll_data3", "mm3_txen_n", "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP_CLKS, 160,
+		"mcbsp_clks", NULL, "cam_shutter", NULL,
+		"gpio_160", "uart1_cts", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI1_CLK, 171,
+		"mcspi1_clk", "mmc2_dat4", NULL, NULL,
+		"gpio_171", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI1_CS0, 174,
+		"mcspi1_cs0", "mmc2_dat7", NULL, NULL,
+		"gpio_174", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI1_CS1, 175,
+		"mcspi1_cs1", NULL, NULL, "mmc3_cmd",
+		"gpio_175", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI1_CS2, 176,
+		"mcspi1_cs2", NULL, NULL, "mmc3_clk",
+		"gpio_176", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI1_CS3, 177,
+		"mcspi1_cs3", NULL, "hsusb2_tll_data2", "hsusb2_data2",
+		"gpio_177", "mm2_txdat", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI1_SIMO, 172,
+		"mcspi1_simo", "mmc2_dat5", NULL, NULL,
+		"gpio_172", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI1_SOMI, 173,
+		"mcspi1_somi", "mmc2_dat6", NULL, NULL,
+		"gpio_173", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI2_CLK, 178,
+		"mcspi2_clk", NULL, "hsusb2_tll_data7", "hsusb2_data7",
+		"gpio_178", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI2_CS0, 181,
+		"mcspi2_cs0", "gpt11_pwm_evt", "hsusb2_tll_data6", "hsusb2_data6",
+		"gpio_181", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI2_CS1, 182,
+		"mcspi2_cs1", "gpt8_pwm_evt", "hsusb2_tll_data3", "hsusb2_data3",
+		"gpio_182", "mm2_txen_n", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI2_SIMO, 179,
+		"mcspi2_simo", "gpt9_pwm_evt", "hsusb2_tll_data4", "hsusb2_data4",
+		"gpio_179", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCSPI2_SOMI, 180,
+		"mcspi2_somi", "gpt10_pwm_evt", "hsusb2_tll_data5", "hsusb2_data5",
+		"gpio_180", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC1_CLK, 120,
+		"mmc1_clk", NULL, NULL, NULL,
+		"gpio_120", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC1_CMD, 121,
+		"mmc1_cmd", NULL, NULL, NULL,
+		"gpio_121", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC1_DAT0, 122,
+		"mmc1_dat0", NULL, NULL, NULL,
+		"gpio_122", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC1_DAT1, 123,
+		"mmc1_dat1", NULL, NULL, NULL,
+		"gpio_123", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC1_DAT2, 124,
+		"mmc1_dat2", NULL, NULL, NULL,
+		"gpio_124", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC1_DAT3, 125,
+		"mmc1_dat3", NULL, NULL, NULL,
+		"gpio_125", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC1_DAT4, 126,
+		"mmc1_dat4", NULL, NULL, NULL,
+		"gpio_126", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC1_DAT5, 127,
+		"mmc1_dat5", NULL, NULL, NULL,
+		"gpio_127", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC1_DAT6, 128,
+		"mmc1_dat6", NULL, NULL, NULL,
+		"gpio_128", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC1_DAT7, 129,
+		"mmc1_dat7", NULL, NULL, NULL,
+		"gpio_129", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_CLK, 130,
+		"mmc2_clk", "mcspi3_clk", NULL, NULL,
+		"gpio_130", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_CMD, 131,
+		"mmc2_cmd", "mcspi3_simo", NULL, NULL,
+		"gpio_131", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT0, 132,
+		"mmc2_dat0", "mcspi3_somi", NULL, NULL,
+		"gpio_132", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT1, 133,
+		"mmc2_dat1", NULL, NULL, NULL,
+		"gpio_133", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT2, 134,
+		"mmc2_dat2", "mcspi3_cs1", NULL, NULL,
+		"gpio_134", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT3, 135,
+		"mmc2_dat3", "mcspi3_cs0", NULL, NULL,
+		"gpio_135", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT4, 136,
+		"mmc2_dat4", "mmc2_dir_dat0", NULL, "mmc3_dat0",
+		"gpio_136", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT5, 137,
+		"mmc2_dat5", "mmc2_dir_dat1", "cam_global_reset", "mmc3_dat1",
+		"gpio_137", "hsusb3_tll_stp", "mm3_rxdp", "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT6, 138,
+		"mmc2_dat6", "mmc2_dir_cmd", "cam_shutter", "mmc3_dat2",
+		"gpio_138", "hsusb3_tll_dir", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT7, 139,
+		"mmc2_dat7", "mmc2_clkin", NULL, "mmc3_dat3",
+		"gpio_139", "hsusb3_tll_nxt", "mm3_rxdm", "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT0, 2,
+		"sys_boot0", NULL, NULL, NULL,
+		"gpio_2", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT1, 3,
+		"sys_boot1", NULL, NULL, NULL,
+		"gpio_3", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT2, 4,
+		"sys_boot2", NULL, NULL, NULL,
+		"gpio_4", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT3, 5,
+		"sys_boot3", NULL, NULL, NULL,
+		"gpio_5", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT4, 6,
+		"sys_boot4", "mmc2_dir_dat2", NULL, NULL,
+		"gpio_6", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT5, 7,
+		"sys_boot5", "mmc2_dir_dat3", NULL, NULL,
+		"gpio_7", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_BOOT6, 8,
+		"sys_boot6", NULL, NULL, NULL,
+		"gpio_8", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_CLKOUT1, 10,
+		"sys_clkout1", NULL, NULL, NULL,
+		"gpio_10", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_CLKOUT2, 186,
+		"sys_clkout2", NULL, NULL, NULL,
+		"gpio_186", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_CLKREQ, 1,
+		"sys_clkreq", NULL, NULL, NULL,
+		"gpio_1", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_NIRQ, 0,
+		"sys_nirq", NULL, NULL, NULL,
+		"gpio_0", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_NRESWARM, 30,
+		"sys_nreswarm", NULL, NULL, NULL,
+		"gpio_30", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(SYS_OFF_MODE, 9,
+		"sys_off_mode", NULL, NULL, NULL,
+		"gpio_9", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART1_CTS, 150,
+		"uart1_cts", NULL, NULL, NULL,
+		"gpio_150", "hsusb3_tll_clk", NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART1_RTS, 149,
+		"uart1_rts", NULL, NULL, NULL,
+		"gpio_149", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART1_RX, 151,
+		"uart1_rx", NULL, "mcbsp1_clkr", "mcspi4_clk",
+		"gpio_151", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART1_TX, 148,
+		"uart1_tx", NULL, NULL, NULL,
+		"gpio_148", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART2_CTS, 144,
+		"uart2_cts", "mcbsp3_dx", "gpt9_pwm_evt", NULL,
+		"gpio_144", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART2_RTS, 145,
+		"uart2_rts", "mcbsp3_dr", "gpt10_pwm_evt", NULL,
+		"gpio_145", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART2_RX, 147,
+		"uart2_rx", "mcbsp3_fsx", "gpt8_pwm_evt", NULL,
+		"gpio_147", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART2_TX, 146,
+		"uart2_tx", "mcbsp3_clkx", "gpt11_pwm_evt", NULL,
+		"gpio_146", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART3_CTS_RCTX, 163,
+		"uart3_cts_rctx", NULL, NULL, NULL,
+		"gpio_163", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART3_RTS_SD, 164,
+		"uart3_rts_sd", NULL, NULL, NULL,
+		"gpio_164", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART3_RX_IRRX, 165,
+		"uart3_rx_irrx", NULL, NULL, NULL,
+		"gpio_165", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART3_TX_IRTX, 166,
+		"uart3_tx_irtx", NULL, NULL, NULL,
+		"gpio_166", NULL, NULL, "safe_mode"),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+/*
+ * Pins different on CBC package comapared to CBC package
+ */
+struct omap_mux __initdata omap3_cbc_subset[] = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+/*
+ * Balls for CBC package
+ * 515-pin s-PBGA Package, 0.65mm Ball Pitch (Top), 0.50mm Ball Pitch (Bottom)
+ *
+ * FIXME: What's up with the outdated TI documentation? See:
+ *
+ * http://wiki.davincidsp.com/index.php/Datasheet_Errata_for_OMAP35x_CBC_Package
+ * http://community.ti.com/forums/t/10982.aspx
+ */
+#ifdef CONFIG_DEBUG_FS
+struct omap_ball __initdata omap3_cbc_ball[] = {
+	_OMAP3_BALLENTRY(CAM_D0, "ae16", NULL),
+	_OMAP3_BALLENTRY(CAM_D1, "ae15", NULL),
+	_OMAP3_BALLENTRY(CAM_D10, "d25", NULL),
+	_OMAP3_BALLENTRY(CAM_D11, "e26", NULL),
+	_OMAP3_BALLENTRY(CAM_D2, "a24", NULL),
+	_OMAP3_BALLENTRY(CAM_D3, "b24", NULL),
+	_OMAP3_BALLENTRY(CAM_D4, "d24", NULL),
+	_OMAP3_BALLENTRY(CAM_D5, "c24", NULL),
+	_OMAP3_BALLENTRY(CAM_D6, "p25", NULL),
+	_OMAP3_BALLENTRY(CAM_D7, "p26", NULL),
+	_OMAP3_BALLENTRY(CAM_D8, "n25", NULL),
+	_OMAP3_BALLENTRY(CAM_D9, "n26", NULL),
+	_OMAP3_BALLENTRY(CAM_FLD, "b23", NULL),
+	_OMAP3_BALLENTRY(CAM_HS, "c23", NULL),
+	_OMAP3_BALLENTRY(CAM_PCLK, "c26", NULL),
+	_OMAP3_BALLENTRY(CAM_STROBE, "d26", NULL),
+	_OMAP3_BALLENTRY(CAM_VS, "d23", NULL),
+	_OMAP3_BALLENTRY(CAM_WEN, "a23", NULL),
+	_OMAP3_BALLENTRY(CAM_XCLKA, "c25", NULL),
+	_OMAP3_BALLENTRY(CAM_XCLKB, "e25", NULL),
+	_OMAP3_BALLENTRY(CSI2_DX0, "ad17", NULL),
+	_OMAP3_BALLENTRY(CSI2_DX1, "ae18", NULL),
+	_OMAP3_BALLENTRY(CSI2_DY0, "ad16", NULL),
+	_OMAP3_BALLENTRY(CSI2_DY1, "ae17", NULL),
+	_OMAP3_BALLENTRY(DSS_ACBIAS, "f26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA0, "ae21", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA1, "ae22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA10, "ac26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA11, "ad26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA12, "aa25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA13, "y25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA14, "aa26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA15, "ab26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA16, "l25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA17, "l26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA18, "m24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA19, "m26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA2, "ae23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA20, "f25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA21, "n24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA22, "ac25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA23, "ab25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA3, "ae24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA4, "ad23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA5, "ad24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA6, "g26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA7, "h25", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA8, "h26", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA9, "j26", NULL),
+	_OMAP3_BALLENTRY(DSS_HSYNC, "k24", NULL),
+	_OMAP3_BALLENTRY(DSS_PCLK, "g25", NULL),
+	_OMAP3_BALLENTRY(DSS_VSYNC, "m25", NULL),
+	_OMAP3_BALLENTRY(ETK_CLK, "ab2", NULL),
+	_OMAP3_BALLENTRY(ETK_CTL, "ab3", NULL),
+	_OMAP3_BALLENTRY(ETK_D0, "ac3", NULL),
+	_OMAP3_BALLENTRY(ETK_D1, "ad4", NULL),
+	_OMAP3_BALLENTRY(ETK_D10, "ae4", NULL),
+	_OMAP3_BALLENTRY(ETK_D11, "af6", NULL),
+	_OMAP3_BALLENTRY(ETK_D12, "ae6", NULL),
+	_OMAP3_BALLENTRY(ETK_D13, "af7", NULL),
+	_OMAP3_BALLENTRY(ETK_D14, "af9", NULL),
+	_OMAP3_BALLENTRY(ETK_D15, "ae9", NULL),
+	_OMAP3_BALLENTRY(ETK_D2, "ad3", NULL),
+	_OMAP3_BALLENTRY(ETK_D3, "aa3", NULL),
+	_OMAP3_BALLENTRY(ETK_D4, "y3", NULL),
+	_OMAP3_BALLENTRY(ETK_D5, "ab1", NULL),
+	_OMAP3_BALLENTRY(ETK_D6, "ae3", NULL),
+	_OMAP3_BALLENTRY(ETK_D7, "ad2", NULL),
+	_OMAP3_BALLENTRY(ETK_D8, "aa4", NULL),
+	_OMAP3_BALLENTRY(ETK_D9, "v2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A1, "j2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A10, "d2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A2, "h1", NULL),
+	_OMAP3_BALLENTRY(GPMC_A3, "h2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A4, "g2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A5, "f1", NULL),
+	_OMAP3_BALLENTRY(GPMC_A6, "f2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A7, "e1", NULL),
+	_OMAP3_BALLENTRY(GPMC_A8, "e2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A9, "d1", NULL),
+	_OMAP3_BALLENTRY(GPMC_CLK, "n1", "l1"),
+	_OMAP3_BALLENTRY(GPMC_D10, "t1", "n1"),
+	_OMAP3_BALLENTRY(GPMC_D11, "u2", "p2"),
+	_OMAP3_BALLENTRY(GPMC_D12, "u1", "p1"),
+	_OMAP3_BALLENTRY(GPMC_D13, "p1", "m1"),
+	_OMAP3_BALLENTRY(GPMC_D14, "l2", "j2"),
+	_OMAP3_BALLENTRY(GPMC_D15, "m2", "k2"),
+	_OMAP3_BALLENTRY(GPMC_D8, "v1", "r1"),
+	_OMAP3_BALLENTRY(GPMC_D9, "y1", "t1"),
+	_OMAP3_BALLENTRY(GPMC_NBE0_CLE, "k2", NULL),
+	_OMAP3_BALLENTRY(GPMC_NBE1, "j1", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS1, "ad1", "w1"),
+	_OMAP3_BALLENTRY(GPMC_NCS2, "a3", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS3, "b6", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS4, "b4", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS5, "c4", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS6, "b5", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS7, "c5", NULL),
+	_OMAP3_BALLENTRY(GPMC_NWP, "ac6", "y5"),
+	_OMAP3_BALLENTRY(GPMC_WAIT1, "ac8", "y8"),
+	_OMAP3_BALLENTRY(GPMC_WAIT2, "b3", NULL),
+	_OMAP3_BALLENTRY(GPMC_WAIT3, "c6", NULL),
+	_OMAP3_BALLENTRY(HDQ_SIO, "j23", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_CLK, "w19", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA0, "v20", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA1, "y20", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA2, "v18", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA3, "w20", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA4, "w17", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA5, "y18", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA6, "y19", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA7, "y17", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DIR, "v19", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_NXT, "w18", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_STP, "u20", NULL),
+	_OMAP3_BALLENTRY(I2C2_SCL, "c2", NULL),
+	_OMAP3_BALLENTRY(I2C2_SDA, "c1", NULL),
+	_OMAP3_BALLENTRY(I2C3_SCL, "ab4", NULL),
+	_OMAP3_BALLENTRY(I2C3_SDA, "ac4", NULL),
+	_OMAP3_BALLENTRY(I2C4_SCL, "ad15", NULL),
+	_OMAP3_BALLENTRY(I2C4_SDA, "w16", NULL),
+	_OMAP3_BALLENTRY(JTAG_EMU0, "y15", NULL),
+	_OMAP3_BALLENTRY(JTAG_EMU1, "y14", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_CLKR, "u19", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_CLKX, "t17", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_DR, "t20", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_DX, "u17", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_FSR, "v17", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_FSX, "p20", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_CLKX, "r18", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_DR, "t18", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_DX, "r19", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_FSX, "u18", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_CLKX, "u3", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_DR, "n3", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_DX, "p3", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_FSX, "w3", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_CLKX, "v3", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_DR, "u4", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_DX, "r3", NULL),
+	_OMAP3_BALLENTRY(MCBSP4_FSX, "t3", NULL),
+	_OMAP3_BALLENTRY(MCBSP_CLKS, "t19", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CLK, "p9", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS0, "r7", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS1, "r8", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS2, "r9", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS3, "t8", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_SIMO, "p8", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_SOMI, "p7", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CLK, "w7", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CS0, "v8", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CS1, "v9", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_SIMO, "w8", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_SOMI, "u8", NULL),
+	_OMAP3_BALLENTRY(MMC1_CLK, "n19", NULL),
+	_OMAP3_BALLENTRY(MMC1_CMD, "l18", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT0, "m19", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT1, "m18", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT2, "k18", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT3, "n20", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT4, "m20", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT5, "p17", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT6, "p18", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT7, "p19", NULL),
+	_OMAP3_BALLENTRY(MMC2_CLK, "w10", NULL),
+	_OMAP3_BALLENTRY(MMC2_CMD, "r10", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT0, "t10", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT1, "t9", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT2, "u10", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT3, "u9", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT4, "v10", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT5, "m3", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT6, "l3", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT7, "k3", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT0, "f3", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT1, "d3", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT2, "c3", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT3, "e3", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT4, "e4", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT5, "g3", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT6, "d4", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKOUT1, "ae14", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKOUT2, "w11", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKREQ, "w15", NULL),
+	_OMAP3_BALLENTRY(SYS_NIRQ, "v16", NULL),
+	_OMAP3_BALLENTRY(SYS_NRESWARM, "ad7", "aa5"),
+	_OMAP3_BALLENTRY(SYS_OFF_MODE, "v12", NULL),
+	_OMAP3_BALLENTRY(UART1_CTS, "w2", NULL),
+	_OMAP3_BALLENTRY(UART1_RTS, "r2", NULL),
+	_OMAP3_BALLENTRY(UART1_RX, "h3", NULL),
+	_OMAP3_BALLENTRY(UART1_TX, "l4", NULL),
+	_OMAP3_BALLENTRY(UART2_CTS, "y24", NULL),
+	_OMAP3_BALLENTRY(UART2_RTS, "aa24", NULL),
+	_OMAP3_BALLENTRY(UART2_RX, "ad21", NULL),
+	_OMAP3_BALLENTRY(UART2_TX, "ad22", NULL),
+	_OMAP3_BALLENTRY(UART3_CTS_RCTX, "f23", NULL),
+	_OMAP3_BALLENTRY(UART3_RTS_SD, "f24", NULL),
+	_OMAP3_BALLENTRY(UART3_RX_IRRX, "h24", NULL),
+	_OMAP3_BALLENTRY(UART3_TX_IRTX, "g24", NULL),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define omap3_cbc_ball	 NULL
+#endif
+
+/*
+ * Pins different on CUS package comapared to CBC package
+ */
+struct omap_mux __initdata omap3_cus_subset[] = {
+	_OMAP3_MUXENTRY(CAM_D10, 109,
+		"cam_d10", NULL, NULL, NULL,
+		"gpio_109", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D11, 110,
+		"cam_d11", NULL, NULL, NULL,
+		"gpio_110", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D2, 101,
+		"cam_d2", NULL, NULL, NULL,
+		"gpio_101", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D3, 102,
+		"cam_d3", NULL, NULL, NULL,
+		"gpio_102", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D4, 103,
+		"cam_d4", NULL, NULL, NULL,
+		"gpio_103", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D5, 104,
+		"cam_d5", NULL, NULL, NULL,
+		"gpio_104", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_FLD, 98,
+		"cam_fld", NULL, "cam_global_reset", NULL,
+		"gpio_98", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_HS, 94,
+		"cam_hs", NULL, NULL, NULL,
+		"gpio_94", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_PCLK, 97,
+		"cam_pclk", NULL, NULL, NULL,
+		"gpio_97", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_STROBE, 126,
+		"cam_strobe", NULL, NULL, NULL,
+		"gpio_126", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_VS, 95,
+		"cam_vs", NULL, NULL, NULL,
+		"gpio_95", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_WEN, 167,
+		"cam_wen", NULL, "cam_shutter", NULL,
+		"gpio_167", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA6, 76,
+		"dss_data6", NULL, "uart1_tx", NULL,
+		"gpio_76", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA7, 77,
+		"dss_data7", NULL, "uart1_rx", NULL,
+		"gpio_77", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA8, 78,
+		"dss_data8", NULL, NULL, NULL,
+		"gpio_78", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA9, 79,
+		"dss_data9", NULL, NULL, NULL,
+		"gpio_79", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_HSYNC, 67,
+		"dss_hsync", NULL, NULL, NULL,
+		"gpio_67", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_PCLK, 66,
+		"dss_pclk", NULL, NULL, NULL,
+		"gpio_66", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(ETK_CLK, 12,
+		"etk_clk", "mcbsp5_clkx", "mmc3_clk", "hsusb1_stp",
+		"gpio_12", "mm1_rxdp", "hsusb1_tll_stp", NULL),
+	_OMAP3_MUXENTRY(ETK_CTL, 13,
+		"etk_ctl", NULL, "mmc3_cmd", "hsusb1_clk",
+		"gpio_13", NULL, "hsusb1_tll_clk", NULL),
+	_OMAP3_MUXENTRY(ETK_D0, 14,
+		"etk_d0", "mcspi3_simo", "mmc3_dat4", "hsusb1_data0",
+		"gpio_14", "mm1_rxrcv", "hsusb1_tll_data0", NULL),
+	_OMAP3_MUXENTRY(ETK_D1, 15,
+		"etk_d1", "mcspi3_somi", NULL, "hsusb1_data1",
+		"gpio_15", "mm1_txse0", "hsusb1_tll_data1", NULL),
+	_OMAP3_MUXENTRY(ETK_D10, 24,
+		"etk_d10", NULL, "uart1_rx", "hsusb2_clk",
+		"gpio_24", NULL, "hsusb2_tll_clk", NULL),
+	_OMAP3_MUXENTRY(ETK_D11, 25,
+		"etk_d11", NULL, NULL, "hsusb2_stp",
+		"gpio_25", "mm2_rxdp", "hsusb2_tll_stp", NULL),
+	_OMAP3_MUXENTRY(ETK_D12, 26,
+		"etk_d12", NULL, NULL, "hsusb2_dir",
+		"gpio_26", NULL, "hsusb2_tll_dir", NULL),
+	_OMAP3_MUXENTRY(ETK_D13, 27,
+		"etk_d13", NULL, NULL, "hsusb2_nxt",
+		"gpio_27", "mm2_rxdm", "hsusb2_tll_nxt", NULL),
+	_OMAP3_MUXENTRY(ETK_D14, 28,
+		"etk_d14", NULL, NULL, "hsusb2_data0",
+		"gpio_28", "mm2_rxrcv", "hsusb2_tll_data0", NULL),
+	_OMAP3_MUXENTRY(ETK_D15, 29,
+		"etk_d15", NULL, NULL, "hsusb2_data1",
+		"gpio_29", "mm2_txse0", "hsusb2_tll_data1", NULL),
+	_OMAP3_MUXENTRY(ETK_D2, 16,
+		"etk_d2", "mcspi3_cs0", NULL, "hsusb1_data2",
+		"gpio_16", "mm1_txdat", "hsusb1_tll_data2", NULL),
+	_OMAP3_MUXENTRY(ETK_D3, 17,
+		"etk_d3", "mcspi3_clk", "mmc3_dat3", "hsusb1_data7",
+		"gpio_17", NULL, "hsusb1_tll_data7", NULL),
+	_OMAP3_MUXENTRY(ETK_D4, 18,
+		"etk_d4", "mcbsp5_dr", "mmc3_dat0", "hsusb1_data4",
+		"gpio_18", NULL, "hsusb1_tll_data4", NULL),
+	_OMAP3_MUXENTRY(ETK_D5, 19,
+		"etk_d5", "mcbsp5_fsx", "mmc3_dat1", "hsusb1_data5",
+		"gpio_19", NULL, "hsusb1_tll_data5", NULL),
+	_OMAP3_MUXENTRY(ETK_D6, 20,
+		"etk_d6", "mcbsp5_dx", "mmc3_dat2", "hsusb1_data6",
+		"gpio_20", NULL, "hsusb1_tll_data6", NULL),
+	_OMAP3_MUXENTRY(ETK_D7, 21,
+		"etk_d7", "mcspi3_cs1", "mmc3_dat7", "hsusb1_data3",
+		"gpio_21", "mm1_txen_n", "hsusb1_tll_data3", NULL),
+	_OMAP3_MUXENTRY(ETK_D8, 22,
+		"etk_d8", "sys_drm_msecure", "mmc3_dat6", "hsusb1_dir",
+		"gpio_22", NULL, "hsusb1_tll_dir", NULL),
+	_OMAP3_MUXENTRY(ETK_D9, 23,
+		"etk_d9", "sys_secure_indicator", "mmc3_dat5", "hsusb1_nxt",
+		"gpio_23", "mm1_rxdm", "hsusb1_tll_nxt", NULL),
+	_OMAP3_MUXENTRY(MCBSP3_CLKX, 142,
+		"mcbsp3_clkx", "uart2_tx", NULL, NULL,
+		"gpio_142", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_DR, 141,
+		"mcbsp3_dr", "uart2_rts", NULL, NULL,
+		"gpio_141", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_DX, 140,
+		"mcbsp3_dx", "uart2_cts", NULL, NULL,
+		"gpio_140", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MCBSP3_FSX, 143,
+		"mcbsp3_fsx", "uart2_rx", NULL, NULL,
+		"gpio_143", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT5, 137,
+		"mmc2_dat5", "mmc2_dir_dat1", "cam_global_reset", "mmc3_dat1",
+		"gpio_137", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT6, 138,
+		"mmc2_dat6", "mmc2_dir_cmd", "cam_shutter", "mmc3_dat2",
+		"gpio_138", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(MMC2_DAT7, 139,
+		"mmc2_dat7", "mmc2_clkin", NULL, "mmc3_dat3",
+		"gpio_139", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(UART1_CTS, 150,
+		"uart1_cts", NULL, NULL, NULL,
+		"gpio_150", NULL, NULL, "safe_mode"),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+/*
+ * Balls for CUS package
+ * 423-pin s-PBGA Package, 0.65mm Ball Pitch (Bottom)
+ */
+#ifdef CONFIG_DEBUG_FS
+struct omap_ball __initdata omap3_cus_ball[] = {
+	_OMAP3_BALLENTRY(CAM_D0, "ab18", NULL),
+	_OMAP3_BALLENTRY(CAM_D1, "ac18", NULL),
+	_OMAP3_BALLENTRY(CAM_D10, "f21", NULL),
+	_OMAP3_BALLENTRY(CAM_D11, "g21", NULL),
+	_OMAP3_BALLENTRY(CAM_D2, "g19", NULL),
+	_OMAP3_BALLENTRY(CAM_D3, "f19", NULL),
+	_OMAP3_BALLENTRY(CAM_D4, "g20", NULL),
+	_OMAP3_BALLENTRY(CAM_D5, "b21", NULL),
+	_OMAP3_BALLENTRY(CAM_D6, "l24", NULL),
+	_OMAP3_BALLENTRY(CAM_D7, "k24", NULL),
+	_OMAP3_BALLENTRY(CAM_D8, "j23", NULL),
+	_OMAP3_BALLENTRY(CAM_D9, "k23", NULL),
+	_OMAP3_BALLENTRY(CAM_FLD, "h24", NULL),
+	_OMAP3_BALLENTRY(CAM_HS, "a22", NULL),
+	_OMAP3_BALLENTRY(CAM_PCLK, "j19", NULL),
+	_OMAP3_BALLENTRY(CAM_STROBE, "j20", NULL),
+	_OMAP3_BALLENTRY(CAM_VS, "e18", NULL),
+	_OMAP3_BALLENTRY(CAM_WEN, "f18", NULL),
+	_OMAP3_BALLENTRY(CAM_XCLKA, "b22", NULL),
+	_OMAP3_BALLENTRY(CAM_XCLKB, "c22", NULL),
+	_OMAP3_BALLENTRY(DSS_ACBIAS, "j21", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA0, "ac19", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA1, "ab19", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA10, "ac22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA11, "ac23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA12, "ab22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA13, "y22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA14, "w22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA15, "v22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA16, "j22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA17, "g23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA18, "g24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA19, "h23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA2, "ad20", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA20, "d23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA21, "k22", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA22, "v21", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA23, "w21", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA3, "ac20", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA4, "ad21", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA5, "ac21", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA6, "d24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA7, "e23", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA8, "e24", NULL),
+	_OMAP3_BALLENTRY(DSS_DATA9, "f23", NULL),
+	_OMAP3_BALLENTRY(DSS_HSYNC, "e22", NULL),
+	_OMAP3_BALLENTRY(DSS_PCLK, "g22", NULL),
+	_OMAP3_BALLENTRY(DSS_VSYNC, "f22", NULL),
+	_OMAP3_BALLENTRY(ETK_CLK, "ac1", NULL),
+	_OMAP3_BALLENTRY(ETK_CTL, "ad3", NULL),
+	_OMAP3_BALLENTRY(ETK_D0, "ad6", NULL),
+	_OMAP3_BALLENTRY(ETK_D1, "ac6", NULL),
+	_OMAP3_BALLENTRY(ETK_D10, "ac3", NULL),
+	_OMAP3_BALLENTRY(ETK_D11, "ac9", NULL),
+	_OMAP3_BALLENTRY(ETK_D12, "ac10", NULL),
+	_OMAP3_BALLENTRY(ETK_D13, "ad11", NULL),
+	_OMAP3_BALLENTRY(ETK_D14, "ac11", NULL),
+	_OMAP3_BALLENTRY(ETK_D15, "ad12", NULL),
+	_OMAP3_BALLENTRY(ETK_D2, "ac7", NULL),
+	_OMAP3_BALLENTRY(ETK_D3, "ad8", NULL),
+	_OMAP3_BALLENTRY(ETK_D4, "ac5", NULL),
+	_OMAP3_BALLENTRY(ETK_D5, "ad2", NULL),
+	_OMAP3_BALLENTRY(ETK_D6, "ac8", NULL),
+	_OMAP3_BALLENTRY(ETK_D7, "ad9", NULL),
+	_OMAP3_BALLENTRY(ETK_D8, "ac4", NULL),
+	_OMAP3_BALLENTRY(ETK_D9, "ad5", NULL),
+	_OMAP3_BALLENTRY(GPMC_A1, "k4", NULL),
+	_OMAP3_BALLENTRY(GPMC_A10, "g2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A2, "k3", NULL),
+	_OMAP3_BALLENTRY(GPMC_A3, "k2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A4, "j4", NULL),
+	_OMAP3_BALLENTRY(GPMC_A5, "j3", NULL),
+	_OMAP3_BALLENTRY(GPMC_A6, "j2", NULL),
+	_OMAP3_BALLENTRY(GPMC_A7, "j1", NULL),
+	_OMAP3_BALLENTRY(GPMC_A8, "h1", NULL),
+	_OMAP3_BALLENTRY(GPMC_A9, "h2", NULL),
+	_OMAP3_BALLENTRY(GPMC_CLK, "w2", NULL),
+	_OMAP3_BALLENTRY(GPMC_D10, "u1", NULL),
+	_OMAP3_BALLENTRY(GPMC_D11, "r3", NULL),
+	_OMAP3_BALLENTRY(GPMC_D12, "t3", NULL),
+	_OMAP3_BALLENTRY(GPMC_D13, "u2", NULL),
+	_OMAP3_BALLENTRY(GPMC_D14, "v1", NULL),
+	_OMAP3_BALLENTRY(GPMC_D15, "v2", NULL),
+	_OMAP3_BALLENTRY(GPMC_D8, "r2", NULL),
+	_OMAP3_BALLENTRY(GPMC_D9, "t2", NULL),
+	_OMAP3_BALLENTRY(GPMC_NBE0_CLE, "k5", NULL),
+	_OMAP3_BALLENTRY(GPMC_NBE1, "l1", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS3, "d2", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS4, "f4", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS5, "g5", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS6, "f3", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS7, "g4", NULL),
+	_OMAP3_BALLENTRY(GPMC_NWP, "e1", NULL),
+	_OMAP3_BALLENTRY(GPMC_WAIT3, "c2", NULL),
+	_OMAP3_BALLENTRY(HDQ_SIO, "a24", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_CLK, "r21", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA0, "t24", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA1, "t23", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA2, "u24", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA3, "u23", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA4, "w24", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA5, "v23", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA6, "w23", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DATA7, "t22", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_DIR, "p23", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_NXT, "r22", NULL),
+	_OMAP3_BALLENTRY(HSUSB0_STP, "r23", NULL),
+	_OMAP3_BALLENTRY(I2C2_SCL, "ac15", NULL),
+	_OMAP3_BALLENTRY(I2C2_SDA, "ac14", NULL),
+	_OMAP3_BALLENTRY(I2C3_SCL, "ac13", NULL),
+	_OMAP3_BALLENTRY(I2C3_SDA, "ac12", NULL),
+	_OMAP3_BALLENTRY(I2C4_SCL, "y16", NULL),
+	_OMAP3_BALLENTRY(I2C4_SDA, "y15", NULL),
+	_OMAP3_BALLENTRY(JTAG_EMU0, "ac24", NULL),
+	_OMAP3_BALLENTRY(JTAG_EMU1, "ad24", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_CLKR, "w19", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_CLKX, "v18", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_DR, "y18", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_DX, "w18", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_FSR, "ab20", NULL),
+	_OMAP3_BALLENTRY(MCBSP1_FSX, "aa19", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_CLKX, "t21", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_DR, "v19", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_DX, "r20", NULL),
+	_OMAP3_BALLENTRY(MCBSP2_FSX, "v20", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_CLKX, "w4", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_DR, "v5", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_DX, "v6", NULL),
+	_OMAP3_BALLENTRY(MCBSP3_FSX, "v4", NULL),
+	_OMAP3_BALLENTRY(MCBSP_CLKS, "aa18", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CLK, "t5", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS0, "t6", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_CS3, "r5", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_SIMO, "r4", NULL),
+	_OMAP3_BALLENTRY(MCSPI1_SOMI, "t4", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CLK, "n5", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CS0, "m5", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_CS1, "m4", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_SIMO, "n4", NULL),
+	_OMAP3_BALLENTRY(MCSPI2_SOMI, "n3", NULL),
+	_OMAP3_BALLENTRY(MMC1_CLK, "m23", NULL),
+	_OMAP3_BALLENTRY(MMC1_CMD, "l23", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT0, "m22", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT1, "m21", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT2, "m20", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT3, "n23", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT4, "n22", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT5, "n21", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT6, "n20", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT7, "p24", NULL),
+	_OMAP3_BALLENTRY(MMC2_CLK, "y1", NULL),
+	_OMAP3_BALLENTRY(MMC2_CMD, "ab5", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT0, "ab3", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT1, "y3", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT2, "w3", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT3, "v3", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT4, "ab2", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT5, "aa2", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT6, "y2", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT7, "aa1", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT0, "ab12", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT1, "ac16", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT2, "ad17", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT3, "ad18", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT4, "ac17", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT5, "ab16", NULL),
+	_OMAP3_BALLENTRY(SYS_BOOT6, "aa15", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKOUT1, "y7", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKOUT2, "aa6", NULL),
+	_OMAP3_BALLENTRY(SYS_CLKREQ, "y13", NULL),
+	_OMAP3_BALLENTRY(SYS_NIRQ, "w16", NULL),
+	_OMAP3_BALLENTRY(SYS_NRESWARM, "y10", NULL),
+	_OMAP3_BALLENTRY(SYS_OFF_MODE, "ad23", NULL),
+	_OMAP3_BALLENTRY(UART1_CTS, "ac2", NULL),
+	_OMAP3_BALLENTRY(UART1_RTS, "w6", NULL),
+	_OMAP3_BALLENTRY(UART1_RX, "v7", NULL),
+	_OMAP3_BALLENTRY(UART1_TX, "w7", NULL),
+	_OMAP3_BALLENTRY(UART3_CTS_RCTX, "a23", NULL),
+	_OMAP3_BALLENTRY(UART3_RTS_SD, "b23", NULL),
+	_OMAP3_BALLENTRY(UART3_RX_IRRX, "b24", NULL),
+	_OMAP3_BALLENTRY(UART3_TX_IRTX, "c23", NULL),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#else
+#define omap3_cus_ball	 NULL
+#endif
+
+/*
+ * Pins different on CBB package comapared to CBC package
+ */
+struct omap_mux __initdata omap3_cbb_subset[] = {
+	_OMAP3_MUXENTRY(CAM_D10, 109,
+		"cam_d10", NULL, NULL, NULL,
+		"gpio_109", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D11, 110,
+		"cam_d11", NULL, NULL, NULL,
+		"gpio_110", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D2, 101,
+		"cam_d2", NULL, NULL, NULL,
+		"gpio_101", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D3, 102,
+		"cam_d3", NULL, NULL, NULL,
+		"gpio_102", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D4, 103,
+		"cam_d4", NULL, NULL, NULL,
+		"gpio_103", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_D5, 104,
+		"cam_d5", NULL, NULL, NULL,
+		"gpio_104", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_FLD, 98,
+		"cam_fld", NULL, "cam_global_reset", NULL,
+		"gpio_98", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_HS, 94,
+		"cam_hs", NULL, NULL, NULL,
+		"gpio_94", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_PCLK, 97,
+		"cam_pclk", NULL, NULL, NULL,
+		"gpio_97", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_STROBE, 126,
+		"cam_strobe", NULL, NULL, NULL,
+		"gpio_126", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_VS, 95,
+		"cam_vs", NULL, NULL, NULL,
+		"gpio_95", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(CAM_WEN, 167,
+		"cam_wen", NULL, "cam_shutter", NULL,
+		"gpio_167", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA6, 76,
+		"dss_data6", NULL, "uart1_tx", NULL,
+		"gpio_76", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA7, 77,
+		"dss_data7", NULL, "uart1_rx", NULL,
+		"gpio_77", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA8, 78,
+		"dss_data8", NULL, NULL, NULL,
+		"gpio_78", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_DATA9, 79,
+		"dss_data9", NULL, NULL, NULL,
+		"gpio_79", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_HSYNC, 67,
+		"dss_hsync", NULL, NULL, NULL,
+		"gpio_67", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(DSS_PCLK, 66,
+		"dss_pclk", NULL, NULL, NULL,
+		"gpio_66", NULL, NULL, "safe_mode"),
+	_OMAP3_MUXENTRY(ETK_CLK, 12,
+		"etk_clk", "mcbsp5_clkx", "mmc3_clk", "hsusb1_stp",
+		"gpio_12", "mm1_rxdp", "hsusb1_tll_stp", NULL),
+	_OMAP3_MUXENTRY(ETK_CTL, 13,
+		"etk_ctl", NULL, "mmc3_cmd", "hsusb1_clk",
+		"gpio_13", NULL, "hsusb1_tll_clk", NULL),
+	_OMAP3_MUXENTRY(ETK_D0, 14,
+		"etk_d0", "mcspi3_simo", "mmc3_dat4", "hsusb1_data0",
+		"gpio_14", "mm1_rxrcv", "hsusb1_tll_data0", NULL),
+	_OMAP3_MUXENTRY(ETK_D1, 15,
+		"etk_d1", "mcspi3_somi", NULL, "hsusb1_data1",
+		"gpio_15", "mm1_txse0", "hsusb1_tll_data1", NULL),
+	_OMAP3_MUXENTRY(ETK_D10, 24,
+		"etk_d10", NULL, "uart1_rx", "hsusb2_clk",
+		"gpio_24", NULL, "hsusb2_tll_clk", NULL),
+	_OMAP3_MUXENTRY(ETK_D11, 25,
+		"etk_d11", NULL, NULL, "hsusb2_stp",
+		"gpio_25", "mm2_rxdp", "hsusb2_tll_stp", NULL),
+	_OMAP3_MUXENTRY(ETK_D12, 26,
+		"etk_d12", NULL, NULL, "hsusb2_dir",
+		"gpio_26", NULL, "hsusb2_tll_dir", NULL),
+	_OMAP3_MUXENTRY(ETK_D13, 27,
+		"etk_d13", NULL, NULL, "hsusb2_nxt",
+		"gpio_27", "mm2_rxdm", "hsusb2_tll_nxt", NULL),
+	_OMAP3_MUXENTRY(ETK_D14, 28,
+		"etk_d14", NULL, NULL, "hsusb2_data0",
+		"gpio_28", "mm2_rxrcv", "hsusb2_tll_data0", NULL),
+	_OMAP3_MUXENTRY(ETK_D15, 29,
+		"etk_d15", NULL, NULL, "hsusb2_data1",
+		"gpio_29", "mm2_txse0", "hsusb2_tll_data1", NULL),
+	_OMAP3_MUXENTRY(ETK_D2, 16,
+		"etk_d2", "mcspi3_cs0", NULL, "hsusb1_data2",
+		"gpio_16", "mm1_txdat", "hsusb1_tll_data2", NULL),
+	_OMAP3_MUXENTRY(ETK_D3, 17,
+		"etk_d3", "mcspi3_clk", "mmc3_dat3", "hsusb1_data7",
+		"gpio_17", NULL, "hsusb1_tll_data7", NULL),
+	_OMAP3_MUXENTRY(ETK_D4, 18,
+		"etk_d4", "mcbsp5_dr", "mmc3_dat0", "hsusb1_data4",
+		"gpio_18", NULL, "hsusb1_tll_data4", NULL),
+	_OMAP3_MUXENTRY(ETK_D5, 19,
+		"etk_d5", "mcbsp5_fsx", "mmc3_dat1", "hsusb1_data5",
+		"gpio_19", NULL, "hsusb1_tll_data5", NULL),
+	_OMAP3_MUXENTRY(ETK_D6, 20,
+		"etk_d6", "mcbsp5_dx", "mmc3_dat2", "hsusb1_data6",
+		"gpio_20", NULL, "hsusb1_tll_data6", NULL),
+	_OMAP3_MUXENTRY(ETK_D7, 21,
+		"etk_d7", "mcspi3_cs1", "mmc3_dat7", "hsusb1_data3",
+		"gpio_21", "mm1_txen_n", "hsusb1_tll_data3", NULL),
+	_OMAP3_MUXENTRY(ETK_D8, 22,
+		"etk_d8", "sys_drm_msecure", "mmc3_dat6", "hsusb1_dir",
+		"gpio_22", NULL, "hsusb1_tll_dir", NULL),
+	_OMAP3_MUXENTRY(ETK_D9, 23,
+		"etk_d9", "sys_secure_indicator", "mmc3_dat5", "hsusb1_nxt",
+		"gpio_23", "mm1_rxdm", "hsusb1_tll_nxt", NULL),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+/*
+ * Balls for CBB package
+ * 515-pin s-PBGA Package, 0.50mm Ball Pitch (Top), 0.40mm Ball Pitch (Bottom)
+ */
+#ifdef CONFIG_DEBUG_FS
+struct omap_ball __initdata omap3_cbb_ball[] = {
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
+	_OMAP3_BALLENTRY(GPMC_A2, "m4", "ab15"),
+	_OMAP3_BALLENTRY(GPMC_A3, "l4", "ac16"),
+	_OMAP3_BALLENTRY(GPMC_A4, "k4", "ab16"),
+	_OMAP3_BALLENTRY(GPMC_A5, "t3", "ac17"),
+	_OMAP3_BALLENTRY(GPMC_A6, "r3", "ab17"),
+	_OMAP3_BALLENTRY(GPMC_A7, "n3", "ac18"),
+	_OMAP3_BALLENTRY(GPMC_A8, "m3", "ab18"),
+	_OMAP3_BALLENTRY(GPMC_A9, "l3", "ac19"),
+	_OMAP3_BALLENTRY(GPMC_CLK, "t4", "w2"),
+	_OMAP3_BALLENTRY(GPMC_D10, "p1", "ab4"),
+	_OMAP3_BALLENTRY(GPMC_D11, "r1", "ac4"),
+	_OMAP3_BALLENTRY(GPMC_D12, "r2", "ab6"),
+	_OMAP3_BALLENTRY(GPMC_D13, "t2", "ac6"),
+	_OMAP3_BALLENTRY(GPMC_D14, "w1", "ab7"),
+	_OMAP3_BALLENTRY(GPMC_D15, "y1", "ac7"),
+	_OMAP3_BALLENTRY(GPMC_D8, "h2", "ab3"),
+	_OMAP3_BALLENTRY(GPMC_D9, "k2", "ac3"),
+	_OMAP3_BALLENTRY(GPMC_NBE0_CLE, "g3", "ac12"),
+	_OMAP3_BALLENTRY(GPMC_NBE1, "u3", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS1, "h3", "y1"),
+	_OMAP3_BALLENTRY(GPMC_NCS2, "v8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS3, "u8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS4, "t8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS5, "r8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS6, "p8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NCS7, "n8", NULL),
+	_OMAP3_BALLENTRY(GPMC_NWP, "h1", "ab10"),
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
+	_OMAP3_BALLENTRY(I2C2_SCL, "af15", NULL),
+	_OMAP3_BALLENTRY(I2C2_SDA, "ae15", NULL),
+	_OMAP3_BALLENTRY(I2C3_SCL, "af14", NULL),
+	_OMAP3_BALLENTRY(I2C3_SDA, "ag14", NULL),
+	_OMAP3_BALLENTRY(I2C4_SCL, "ad26", NULL),
+	_OMAP3_BALLENTRY(I2C4_SDA, "ae26", NULL),
+	_OMAP3_BALLENTRY(JTAG_EMU0, "aa11", NULL),
+	_OMAP3_BALLENTRY(JTAG_EMU1, "aa10", NULL),
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
+	_OMAP3_BALLENTRY(MMC1_CLK, "n28", NULL),
+	_OMAP3_BALLENTRY(MMC1_CMD, "m27", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT0, "n27", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT1, "n26", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT2, "n25", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT3, "p28", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT4, "p27", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT5, "p26", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT6, "r27", NULL),
+	_OMAP3_BALLENTRY(MMC1_DAT7, "r25", NULL),
+	_OMAP3_BALLENTRY(MMC2_CLK, "ae2", NULL),
+	_OMAP3_BALLENTRY(MMC2_CMD, "ag5", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT0, "ah5", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT1, "ah4", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT2, "ag4", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT3, "af4", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT4, "ae4", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT5, "ah3", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT6, "af3", NULL),
+	_OMAP3_BALLENTRY(MMC2_DAT7, "ae3", NULL),
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
+#define omap3_cbb_ball	 NULL
+#endif
+
+int __init omap3_mux_init(struct omap_board_mux *board_subset, int flags)
+{
+	struct omap_mux *package_subset;
+	struct omap_ball *package_balls;
+
+	switch (flags & OMAP_PACKAGE_MASK) {
+	case (OMAP_PACKAGE_CBC):
+		package_subset = omap3_cbc_subset;
+		package_balls = omap3_cbc_ball;
+		break;
+	case (OMAP_PACKAGE_CBB):
+		package_subset = omap3_cbb_subset;
+		package_balls = omap3_cbb_ball;
+		break;
+	case (OMAP_PACKAGE_CUS):
+		package_subset = omap3_cus_subset;
+		package_balls = omap3_cus_ball;
+		break;
+	default:
+		printk(KERN_ERR "mux: Unknown omap package, mux disabled\n");
+		return -EINVAL;
+	}
+
+	return omap_mux_init(OMAP3_CONTROL_PADCONF_MUX_PBASE,
+			     OMAP3_CONTROL_PADCONF_MUX_SIZE,
+				omap3_muxmodes, package_subset, board_subset,
+				package_balls, flags);
+}
diff --git a/arch/arm/mach-omap2/mux34xx.h b/arch/arm/mach-omap2/mux34xx.h
new file mode 100644
index 0000000..8c5f261
--- /dev/null
+++ b/arch/arm/mach-omap2/mux34xx.h
@@ -0,0 +1,352 @@
+/*
+ * Copyright (C) 2009 Nokia
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define OMAP3_CONTROL_PADCONF_MUX_PBASE				0x48002030LU
+
+#define OMAP3_MUX(mode0, mux_value, mux_flags)				\
+{									\
+	.reg_offset	= (OMAP3_CONTROL_PADCONF_##mode0##_OFFSET),	\
+	.value		= (mux_value),					\
+	.flags		= (mux_flags),					\
+}
+
+/* 
+ * OMAP3 CONTROL_PADCONF* register offsets for pin-muxing
+ *
+ * Extracted from the TRM.  Add 0x48002030 to these values to get the
+ * absolute addresses.  The name in the macro is the mode-0 name of
+ * the pin.  NOTE: These registers are 16-bits wide.
+ */ 
+#define OMAP3_CONTROL_PADCONF_SDRC_D0_OFFSET			0x000
+#define OMAP3_CONTROL_PADCONF_SDRC_D1_OFFSET			0x002
+#define OMAP3_CONTROL_PADCONF_SDRC_D2_OFFSET			0x004
+#define OMAP3_CONTROL_PADCONF_SDRC_D3_OFFSET			0x006
+#define OMAP3_CONTROL_PADCONF_SDRC_D4_OFFSET			0x008
+#define OMAP3_CONTROL_PADCONF_SDRC_D5_OFFSET			0x00a
+#define OMAP3_CONTROL_PADCONF_SDRC_D6_OFFSET			0x00c
+#define OMAP3_CONTROL_PADCONF_SDRC_D7_OFFSET			0x00e
+#define OMAP3_CONTROL_PADCONF_SDRC_D8_OFFSET			0x010
+#define OMAP3_CONTROL_PADCONF_SDRC_D9_OFFSET			0x012
+#define OMAP3_CONTROL_PADCONF_SDRC_D10_OFFSET			0x014
+#define OMAP3_CONTROL_PADCONF_SDRC_D11_OFFSET			0x016
+#define OMAP3_CONTROL_PADCONF_SDRC_D12_OFFSET			0x018
+#define OMAP3_CONTROL_PADCONF_SDRC_D13_OFFSET			0x01a
+#define OMAP3_CONTROL_PADCONF_SDRC_D14_OFFSET			0x01c
+#define OMAP3_CONTROL_PADCONF_SDRC_D15_OFFSET			0x01e
+#define OMAP3_CONTROL_PADCONF_SDRC_D16_OFFSET			0x020
+#define OMAP3_CONTROL_PADCONF_SDRC_D17_OFFSET			0x022
+#define OMAP3_CONTROL_PADCONF_SDRC_D18_OFFSET			0x024
+#define OMAP3_CONTROL_PADCONF_SDRC_D19_OFFSET			0x026
+#define OMAP3_CONTROL_PADCONF_SDRC_D20_OFFSET			0x028
+#define OMAP3_CONTROL_PADCONF_SDRC_D21_OFFSET			0x02a
+#define OMAP3_CONTROL_PADCONF_SDRC_D22_OFFSET			0x02c
+#define OMAP3_CONTROL_PADCONF_SDRC_D23_OFFSET			0x02e
+#define OMAP3_CONTROL_PADCONF_SDRC_D24_OFFSET			0x030
+#define OMAP3_CONTROL_PADCONF_SDRC_D25_OFFSET			0x032
+#define OMAP3_CONTROL_PADCONF_SDRC_D26_OFFSET			0x034
+#define OMAP3_CONTROL_PADCONF_SDRC_D27_OFFSET			0x036
+#define OMAP3_CONTROL_PADCONF_SDRC_D28_OFFSET			0x038
+#define OMAP3_CONTROL_PADCONF_SDRC_D29_OFFSET			0x03a
+#define OMAP3_CONTROL_PADCONF_SDRC_D30_OFFSET			0x03c
+#define OMAP3_CONTROL_PADCONF_SDRC_D31_OFFSET			0x03e
+#define OMAP3_CONTROL_PADCONF_SDRC_CLK_OFFSET			0x040
+#define OMAP3_CONTROL_PADCONF_SDRC_DQS0_OFFSET			0x042
+#define OMAP3_CONTROL_PADCONF_SDRC_CKE0_OFFSET			0x232
+#define OMAP3_CONTROL_PADCONF_SDRC_CKE1_OFFSET			0x234
+#define OMAP3_CONTROL_PADCONF_SDRC_DQS1_OFFSET			0x044
+#define OMAP3_CONTROL_PADCONF_SDRC_DQS2_OFFSET			0x046
+#define OMAP3_CONTROL_PADCONF_SDRC_DQS3_OFFSET			0x048
+#define OMAP3_CONTROL_PADCONF_GPMC_A1_OFFSET			0x04a
+#define OMAP3_CONTROL_PADCONF_GPMC_A2_OFFSET			0x04c
+#define OMAP3_CONTROL_PADCONF_GPMC_A3_OFFSET			0x04e
+#define OMAP3_CONTROL_PADCONF_GPMC_A4_OFFSET			0x050
+#define OMAP3_CONTROL_PADCONF_GPMC_A5_OFFSET			0x052
+#define OMAP3_CONTROL_PADCONF_GPMC_A6_OFFSET			0x054
+#define OMAP3_CONTROL_PADCONF_GPMC_A7_OFFSET			0x056
+#define OMAP3_CONTROL_PADCONF_GPMC_A8_OFFSET			0x058
+#define OMAP3_CONTROL_PADCONF_GPMC_A9_OFFSET			0x05a
+#define OMAP3_CONTROL_PADCONF_GPMC_A10_OFFSET			0x05c
+#define OMAP3_CONTROL_PADCONF_GPMC_D0_OFFSET			0x05e
+#define OMAP3_CONTROL_PADCONF_GPMC_D1_OFFSET			0x060
+#define OMAP3_CONTROL_PADCONF_GPMC_D2_OFFSET			0x062
+#define OMAP3_CONTROL_PADCONF_GPMC_D3_OFFSET			0x064
+#define OMAP3_CONTROL_PADCONF_GPMC_D4_OFFSET			0x066
+#define OMAP3_CONTROL_PADCONF_GPMC_D5_OFFSET			0x068
+#define OMAP3_CONTROL_PADCONF_GPMC_D6_OFFSET			0x06a
+#define OMAP3_CONTROL_PADCONF_GPMC_D7_OFFSET			0x06c
+#define OMAP3_CONTROL_PADCONF_GPMC_D8_OFFSET			0x06e
+#define OMAP3_CONTROL_PADCONF_GPMC_D9_OFFSET			0x070
+#define OMAP3_CONTROL_PADCONF_GPMC_D10_OFFSET			0x072
+#define OMAP3_CONTROL_PADCONF_GPMC_D11_OFFSET			0x074
+#define OMAP3_CONTROL_PADCONF_GPMC_D12_OFFSET			0x076
+#define OMAP3_CONTROL_PADCONF_GPMC_D13_OFFSET			0x078
+#define OMAP3_CONTROL_PADCONF_GPMC_D14_OFFSET			0x07a
+#define OMAP3_CONTROL_PADCONF_GPMC_D15_OFFSET			0x07c
+#define OMAP3_CONTROL_PADCONF_GPMC_NCS0_OFFSET			0x07e
+#define OMAP3_CONTROL_PADCONF_GPMC_NCS1_OFFSET			0x080
+#define OMAP3_CONTROL_PADCONF_GPMC_NCS2_OFFSET			0x082
+#define OMAP3_CONTROL_PADCONF_GPMC_NCS3_OFFSET			0x084
+#define OMAP3_CONTROL_PADCONF_GPMC_NCS4_OFFSET			0x086
+#define OMAP3_CONTROL_PADCONF_GPMC_NCS5_OFFSET			0x088
+#define OMAP3_CONTROL_PADCONF_GPMC_NCS6_OFFSET			0x08a
+#define OMAP3_CONTROL_PADCONF_GPMC_NCS7_OFFSET			0x08c
+#define OMAP3_CONTROL_PADCONF_GPMC_CLK_OFFSET			0x08e
+#define OMAP3_CONTROL_PADCONF_GPMC_NADV_ALE_OFFSET		0x090
+#define OMAP3_CONTROL_PADCONF_GPMC_NOE_OFFSET			0x092
+#define OMAP3_CONTROL_PADCONF_GPMC_NWE_OFFSET			0x094
+#define OMAP3_CONTROL_PADCONF_GPMC_NBE0_CLE_OFFSET		0x096
+#define OMAP3_CONTROL_PADCONF_GPMC_NBE1_OFFSET			0x098
+#define OMAP3_CONTROL_PADCONF_GPMC_NWP_OFFSET			0x09a
+#define OMAP3_CONTROL_PADCONF_GPMC_WAIT0_OFFSET			0x09c
+#define OMAP3_CONTROL_PADCONF_GPMC_WAIT1_OFFSET			0x09e
+#define OMAP3_CONTROL_PADCONF_GPMC_WAIT2_OFFSET			0x0a0
+#define OMAP3_CONTROL_PADCONF_GPMC_WAIT3_OFFSET			0x0a2
+#define OMAP3_CONTROL_PADCONF_DSS_PCLK_OFFSET			0x0a4
+#define OMAP3_CONTROL_PADCONF_DSS_HSYNC_OFFSET			0x0a6
+#define OMAP3_CONTROL_PADCONF_DSS_VSYNC_OFFSET			0x0a8
+#define OMAP3_CONTROL_PADCONF_DSS_ACBIAS_OFFSET			0x0aa
+#define OMAP3_CONTROL_PADCONF_DSS_DATA0_OFFSET			0x0ac
+#define OMAP3_CONTROL_PADCONF_DSS_DATA1_OFFSET			0x0ae
+#define OMAP3_CONTROL_PADCONF_DSS_DATA2_OFFSET			0x0b0
+#define OMAP3_CONTROL_PADCONF_DSS_DATA3_OFFSET			0x0b2
+#define OMAP3_CONTROL_PADCONF_DSS_DATA4_OFFSET			0x0b4
+#define OMAP3_CONTROL_PADCONF_DSS_DATA5_OFFSET			0x0b6
+#define OMAP3_CONTROL_PADCONF_DSS_DATA6_OFFSET			0x0b8
+#define OMAP3_CONTROL_PADCONF_DSS_DATA7_OFFSET			0x0ba
+#define OMAP3_CONTROL_PADCONF_DSS_DATA8_OFFSET			0x0bc
+#define OMAP3_CONTROL_PADCONF_DSS_DATA9_OFFSET			0x0be
+#define OMAP3_CONTROL_PADCONF_DSS_DATA10_OFFSET			0x0c0
+#define OMAP3_CONTROL_PADCONF_DSS_DATA11_OFFSET			0x0c2
+#define OMAP3_CONTROL_PADCONF_DSS_DATA12_OFFSET			0x0c4
+#define OMAP3_CONTROL_PADCONF_DSS_DATA13_OFFSET			0x0c6
+#define OMAP3_CONTROL_PADCONF_DSS_DATA14_OFFSET			0x0c8
+#define OMAP3_CONTROL_PADCONF_DSS_DATA15_OFFSET			0x0ca
+#define OMAP3_CONTROL_PADCONF_DSS_DATA16_OFFSET			0x0cc
+#define OMAP3_CONTROL_PADCONF_DSS_DATA17_OFFSET			0x0ce
+#define OMAP3_CONTROL_PADCONF_DSS_DATA18_OFFSET			0x0d0
+#define OMAP3_CONTROL_PADCONF_DSS_DATA19_OFFSET			0x0d2
+#define OMAP3_CONTROL_PADCONF_DSS_DATA20_OFFSET			0x0d4
+#define OMAP3_CONTROL_PADCONF_DSS_DATA21_OFFSET			0x0d6
+#define OMAP3_CONTROL_PADCONF_DSS_DATA22_OFFSET			0x0d8
+#define OMAP3_CONTROL_PADCONF_DSS_DATA23_OFFSET			0x0da
+#define OMAP3_CONTROL_PADCONF_CAM_HS_OFFSET			0x0dc
+#define OMAP3_CONTROL_PADCONF_CAM_VS_OFFSET			0x0de
+#define OMAP3_CONTROL_PADCONF_CAM_XCLKA_OFFSET			0x0e0
+#define OMAP3_CONTROL_PADCONF_CAM_PCLK_OFFSET			0x0e2
+#define OMAP3_CONTROL_PADCONF_CAM_FLD_OFFSET			0x0e4
+#define OMAP3_CONTROL_PADCONF_CAM_D0_OFFSET			0x0e6
+#define OMAP3_CONTROL_PADCONF_CAM_D1_OFFSET			0x0e8
+#define OMAP3_CONTROL_PADCONF_CAM_D2_OFFSET			0x0ea
+#define OMAP3_CONTROL_PADCONF_CAM_D3_OFFSET			0x0ec
+#define OMAP3_CONTROL_PADCONF_CAM_D4_OFFSET			0x0ee
+#define OMAP3_CONTROL_PADCONF_CAM_D5_OFFSET			0x0f0
+#define OMAP3_CONTROL_PADCONF_CAM_D6_OFFSET			0x0f2
+#define OMAP3_CONTROL_PADCONF_CAM_D7_OFFSET			0x0f4
+#define OMAP3_CONTROL_PADCONF_CAM_D8_OFFSET			0x0f6
+#define OMAP3_CONTROL_PADCONF_CAM_D9_OFFSET			0x0f8
+#define OMAP3_CONTROL_PADCONF_CAM_D10_OFFSET			0x0fa
+#define OMAP3_CONTROL_PADCONF_CAM_D11_OFFSET			0x0fc
+#define OMAP3_CONTROL_PADCONF_CAM_XCLKB_OFFSET			0x0fe
+#define OMAP3_CONTROL_PADCONF_CAM_WEN_OFFSET			0x100
+#define OMAP3_CONTROL_PADCONF_CAM_STROBE_OFFSET			0x102
+#define OMAP3_CONTROL_PADCONF_CSI2_DX0_OFFSET			0x104
+#define OMAP3_CONTROL_PADCONF_CSI2_DY0_OFFSET			0x106
+#define OMAP3_CONTROL_PADCONF_CSI2_DX1_OFFSET			0x108
+#define OMAP3_CONTROL_PADCONF_CSI2_DY1_OFFSET			0x10a
+#define OMAP3_CONTROL_PADCONF_MCBSP2_FSX_OFFSET			0x10c
+#define OMAP3_CONTROL_PADCONF_MCBSP2_CLKX_OFFSET		0x10e
+#define OMAP3_CONTROL_PADCONF_MCBSP2_DR_OFFSET			0x110
+#define OMAP3_CONTROL_PADCONF_MCBSP2_DX_OFFSET			0x112
+#define OMAP3_CONTROL_PADCONF_MMC1_CLK_OFFSET			0x114
+#define OMAP3_CONTROL_PADCONF_MMC1_CMD_OFFSET			0x116
+#define OMAP3_CONTROL_PADCONF_MMC1_DAT0_OFFSET			0x118
+#define OMAP3_CONTROL_PADCONF_MMC1_DAT1_OFFSET			0x11a
+#define OMAP3_CONTROL_PADCONF_MMC1_DAT2_OFFSET			0x11c
+#define OMAP3_CONTROL_PADCONF_MMC1_DAT3_OFFSET			0x11e
+#define OMAP3_CONTROL_PADCONF_MMC1_DAT4_OFFSET			0x120
+#define OMAP3_CONTROL_PADCONF_MMC1_DAT5_OFFSET			0x122
+#define OMAP3_CONTROL_PADCONF_MMC1_DAT6_OFFSET			0x124
+#define OMAP3_CONTROL_PADCONF_MMC1_DAT7_OFFSET			0x126
+#define OMAP3_CONTROL_PADCONF_MMC2_CLK_OFFSET			0x128
+#define OMAP3_CONTROL_PADCONF_MMC2_CMD_OFFSET			0x12a
+#define OMAP3_CONTROL_PADCONF_MMC2_DAT0_OFFSET			0x12c
+#define OMAP3_CONTROL_PADCONF_MMC2_DAT1_OFFSET			0x12e
+#define OMAP3_CONTROL_PADCONF_MMC2_DAT2_OFFSET			0x130
+#define OMAP3_CONTROL_PADCONF_MMC2_DAT3_OFFSET			0x132
+#define OMAP3_CONTROL_PADCONF_MMC2_DAT4_OFFSET			0x134
+#define OMAP3_CONTROL_PADCONF_MMC2_DAT5_OFFSET			0x136
+#define OMAP3_CONTROL_PADCONF_MMC2_DAT6_OFFSET			0x138
+#define OMAP3_CONTROL_PADCONF_MMC2_DAT7_OFFSET			0x13a
+#define OMAP3_CONTROL_PADCONF_MCBSP3_DX_OFFSET			0x13c
+#define OMAP3_CONTROL_PADCONF_MCBSP3_DR_OFFSET			0x13e
+#define OMAP3_CONTROL_PADCONF_MCBSP3_CLKX_OFFSET		0x140
+#define OMAP3_CONTROL_PADCONF_MCBSP3_FSX_OFFSET			0x142
+#define OMAP3_CONTROL_PADCONF_UART2_CTS_OFFSET			0x144
+#define OMAP3_CONTROL_PADCONF_UART2_RTS_OFFSET			0x146
+#define OMAP3_CONTROL_PADCONF_UART2_TX_OFFSET			0x148
+#define OMAP3_CONTROL_PADCONF_UART2_RX_OFFSET			0x14a
+#define OMAP3_CONTROL_PADCONF_UART1_TX_OFFSET			0x14c
+#define OMAP3_CONTROL_PADCONF_UART1_RTS_OFFSET			0x14e
+#define OMAP3_CONTROL_PADCONF_UART1_CTS_OFFSET			0x150
+#define OMAP3_CONTROL_PADCONF_UART1_RX_OFFSET			0x152
+#define OMAP3_CONTROL_PADCONF_MCBSP4_CLKX_OFFSET		0x154
+#define OMAP3_CONTROL_PADCONF_MCBSP4_DR_OFFSET			0x156
+#define OMAP3_CONTROL_PADCONF_MCBSP4_DX_OFFSET			0x158
+#define OMAP3_CONTROL_PADCONF_MCBSP4_FSX_OFFSET			0x15a
+#define OMAP3_CONTROL_PADCONF_MCBSP1_CLKR_OFFSET		0x15c
+#define OMAP3_CONTROL_PADCONF_MCBSP1_FSR_OFFSET			0x15e
+#define OMAP3_CONTROL_PADCONF_MCBSP1_DX_OFFSET			0x160
+#define OMAP3_CONTROL_PADCONF_MCBSP1_DR_OFFSET			0x162
+#define OMAP3_CONTROL_PADCONF_MCBSP_CLKS_OFFSET			0x164
+#define OMAP3_CONTROL_PADCONF_MCBSP1_FSX_OFFSET			0x166
+#define OMAP3_CONTROL_PADCONF_MCBSP1_CLKX_OFFSET		0x168
+#define OMAP3_CONTROL_PADCONF_UART3_CTS_RCTX_OFFSET		0x16a
+#define OMAP3_CONTROL_PADCONF_UART3_RTS_SD_OFFSET		0x16c
+#define OMAP3_CONTROL_PADCONF_UART3_RX_IRRX_OFFSET		0x16e
+#define OMAP3_CONTROL_PADCONF_UART3_TX_IRTX_OFFSET		0x170
+#define OMAP3_CONTROL_PADCONF_HSUSB0_CLK_OFFSET			0x172
+#define OMAP3_CONTROL_PADCONF_HSUSB0_STP_OFFSET			0x174
+#define OMAP3_CONTROL_PADCONF_HSUSB0_DIR_OFFSET			0x176
+#define OMAP3_CONTROL_PADCONF_HSUSB0_NXT_OFFSET			0x178
+#define OMAP3_CONTROL_PADCONF_HSUSB0_DATA0_OFFSET		0x17a
+#define OMAP3_CONTROL_PADCONF_HSUSB0_DATA1_OFFSET		0x17c
+#define OMAP3_CONTROL_PADCONF_HSUSB0_DATA2_OFFSET		0x17e
+#define OMAP3_CONTROL_PADCONF_HSUSB0_DATA3_OFFSET		0x180
+#define OMAP3_CONTROL_PADCONF_HSUSB0_DATA4_OFFSET		0x182
+#define OMAP3_CONTROL_PADCONF_HSUSB0_DATA5_OFFSET		0x184
+#define OMAP3_CONTROL_PADCONF_HSUSB0_DATA6_OFFSET		0x186
+#define OMAP3_CONTROL_PADCONF_HSUSB0_DATA7_OFFSET		0x188
+#define OMAP3_CONTROL_PADCONF_I2C1_SCL_OFFSET			0x18a
+#define OMAP3_CONTROL_PADCONF_I2C1_SDA_OFFSET			0x18c
+#define OMAP3_CONTROL_PADCONF_I2C2_SCL_OFFSET			0x18e
+#define OMAP3_CONTROL_PADCONF_I2C2_SDA_OFFSET			0x190
+#define OMAP3_CONTROL_PADCONF_I2C3_SCL_OFFSET			0x192
+#define OMAP3_CONTROL_PADCONF_I2C3_SDA_OFFSET			0x194
+#define OMAP3_CONTROL_PADCONF_HDQ_SIO_OFFSET			0x196
+#define OMAP3_CONTROL_PADCONF_MCSPI1_CLK_OFFSET			0x198
+#define OMAP3_CONTROL_PADCONF_MCSPI1_SIMO_OFFSET		0x19a
+#define OMAP3_CONTROL_PADCONF_MCSPI1_SOMI_OFFSET		0x19c
+#define OMAP3_CONTROL_PADCONF_MCSPI1_CS0_OFFSET			0x19e
+#define OMAP3_CONTROL_PADCONF_MCSPI1_CS1_OFFSET			0x1a0
+#define OMAP3_CONTROL_PADCONF_MCSPI1_CS2_OFFSET			0x1a2
+#define OMAP3_CONTROL_PADCONF_MCSPI1_CS3_OFFSET			0x1a4
+#define OMAP3_CONTROL_PADCONF_MCSPI2_CLK_OFFSET			0x1a6
+#define OMAP3_CONTROL_PADCONF_MCSPI2_SIMO_OFFSET		0x1a8
+#define OMAP3_CONTROL_PADCONF_MCSPI2_SOMI_OFFSET		0x1aa
+#define OMAP3_CONTROL_PADCONF_MCSPI2_CS0_OFFSET			0x1ac
+#define OMAP3_CONTROL_PADCONF_MCSPI2_CS1_OFFSET			0x1ae
+#define OMAP3_CONTROL_PADCONF_SYS_NIRQ_OFFSET			0x1b0
+#define OMAP3_CONTROL_PADCONF_SYS_CLKOUT2_OFFSET		0x1b2
+#define OMAP3_CONTROL_PADCONF_ETK_CLK_OFFSET			0x5a8
+#define OMAP3_CONTROL_PADCONF_ETK_CTL_OFFSET			0x5aa
+#define OMAP3_CONTROL_PADCONF_ETK_D0_OFFSET			0x5ac
+#define OMAP3_CONTROL_PADCONF_ETK_D1_OFFSET			0x5ae
+#define OMAP3_CONTROL_PADCONF_ETK_D2_OFFSET			0x5b0
+#define OMAP3_CONTROL_PADCONF_ETK_D3_OFFSET			0x5b2
+#define OMAP3_CONTROL_PADCONF_ETK_D4_OFFSET			0x5b4
+#define OMAP3_CONTROL_PADCONF_ETK_D5_OFFSET			0x5b6
+#define OMAP3_CONTROL_PADCONF_ETK_D6_OFFSET			0x5b8
+#define OMAP3_CONTROL_PADCONF_ETK_D7_OFFSET			0x5ba
+#define OMAP3_CONTROL_PADCONF_ETK_D8_OFFSET			0x5bc
+#define OMAP3_CONTROL_PADCONF_ETK_D9_OFFSET			0x5be
+#define OMAP3_CONTROL_PADCONF_ETK_D10_OFFSET			0x5c0
+#define OMAP3_CONTROL_PADCONF_ETK_D11_OFFSET			0x5c2
+#define OMAP3_CONTROL_PADCONF_ETK_D12_OFFSET			0x5c4
+#define OMAP3_CONTROL_PADCONF_ETK_D13_OFFSET			0x5c6
+#define OMAP3_CONTROL_PADCONF_ETK_D14_OFFSET			0x5c8
+#define OMAP3_CONTROL_PADCONF_ETK_D15_OFFSET			0x5ca
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD0_OFFSET		0x1b4
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD1_OFFSET		0x1b6
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD2_OFFSET		0x1b8
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD3_OFFSET		0x1ba
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD4_OFFSET		0x1bc
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD5_OFFSET		0x1be
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD6_OFFSET		0x1c0
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD7_OFFSET		0x1c2
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD8_OFFSET		0x1c4
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD9_OFFSET		0x1c6
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD10_OFFSET		0x1c8
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD11_OFFSET		0x1ca
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD12_OFFSET		0x1cc
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD13_OFFSET		0x1ce
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD14_OFFSET		0x1d0
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD15_OFFSET		0x1d2
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD16_OFFSET		0x1d4
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD17_OFFSET		0x1d6
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD18_OFFSET		0x1d8
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD19_OFFSET		0x1da
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD20_OFFSET		0x1dc
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD21_OFFSET		0x1de
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD22_OFFSET		0x1e0
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD23_OFFSET		0x1e2
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD24_OFFSET		0x1e4
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD25_OFFSET		0x1e6
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD26_OFFSET		0x1e8
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD27_OFFSET		0x1ea
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD28_OFFSET		0x1ec
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD29_OFFSET		0x1ee
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD30_OFFSET		0x1f0
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD31_OFFSET		0x1f2
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD32_OFFSET		0x1f4
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD33_OFFSET		0x1f6
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD34_OFFSET		0x1f8
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD35_OFFSET		0x1fa
+#define OMAP3_CONTROL_PADCONF_SAD2D_MCAD36_OFFSET		0x1fc
+#define OMAP3_CONTROL_PADCONF_SAD2D_CLK26MI_OFFSET		0x1fe
+#define OMAP3_CONTROL_PADCONF_SAD2D_NRESPWRON_OFFSET		0x200
+#define OMAP3_CONTROL_PADCONF_SAD2D_NRESWARM_OFFSET		0x202
+#define OMAP3_CONTROL_PADCONF_SAD2D_ARMNIRQ_OFFSET		0x204
+#define OMAP3_CONTROL_PADCONF_SAD2D_UMAFIQ_OFFSET		0x206
+#define OMAP3_CONTROL_PADCONF_SAD2D_SPINT_OFFSET		0x208
+#define OMAP3_CONTROL_PADCONF_SAD2D_FRINT_OFFSET		0x20a
+#define OMAP3_CONTROL_PADCONF_SAD2D_DMAREQ0_OFFSET		0x20c
+#define OMAP3_CONTROL_PADCONF_SAD2D_DMAREQ1_OFFSET		0x20e
+#define OMAP3_CONTROL_PADCONF_SAD2D_DMAREQ2_OFFSET		0x210
+#define OMAP3_CONTROL_PADCONF_SAD2D_DMAREQ3_OFFSET		0x212
+#define OMAP3_CONTROL_PADCONF_SAD2D_NTRST_OFFSET		0x214
+#define OMAP3_CONTROL_PADCONF_SAD2D_TDI_OFFSET			0x216
+#define OMAP3_CONTROL_PADCONF_SAD2D_TDO_OFFSET			0x218
+#define OMAP3_CONTROL_PADCONF_SAD2D_TMS_OFFSET			0x21a
+#define OMAP3_CONTROL_PADCONF_SAD2D_TCK_OFFSET			0x21c
+#define OMAP3_CONTROL_PADCONF_SAD2D_RTCK_OFFSET			0x21e
+#define OMAP3_CONTROL_PADCONF_SAD2D_MSTDBY_OFFSET		0x220
+#define OMAP3_CONTROL_PADCONF_SAD2D_IDLEREQ_OFFSET		0x222
+#define OMAP3_CONTROL_PADCONF_SAD2D_IDLEACK_OFFSET		0x224
+#define OMAP3_CONTROL_PADCONF_SAD2D_MWRITE_OFFSET		0x226
+#define OMAP3_CONTROL_PADCONF_SAD2D_SWRITE_OFFSET		0x228
+#define OMAP3_CONTROL_PADCONF_SAD2D_MREAD_OFFSET		0x22a
+#define OMAP3_CONTROL_PADCONF_SAD2D_SREAD_OFFSET		0x22c
+#define OMAP3_CONTROL_PADCONF_SAD2D_MBUSFLAG_OFFSET		0x22e
+#define OMAP3_CONTROL_PADCONF_SAD2D_SBUSFLAG_OFFSET		0x230
+#define OMAP3_CONTROL_PADCONF_I2C4_SCL_OFFSET			0x9d0
+#define OMAP3_CONTROL_PADCONF_I2C4_SDA_OFFSET			0x9d2
+#define OMAP3_CONTROL_PADCONF_SYS_32K_OFFSET			0x9d4
+#define OMAP3_CONTROL_PADCONF_SYS_CLKREQ_OFFSET			0x9d6
+#define OMAP3_CONTROL_PADCONF_SYS_NRESWARM_OFFSET		0x9d8
+#define OMAP3_CONTROL_PADCONF_SYS_BOOT0_OFFSET			0x9da
+#define OMAP3_CONTROL_PADCONF_SYS_BOOT1_OFFSET			0x9dc
+#define OMAP3_CONTROL_PADCONF_SYS_BOOT2_OFFSET			0x9de
+#define OMAP3_CONTROL_PADCONF_SYS_BOOT3_OFFSET			0x9e0
+#define OMAP3_CONTROL_PADCONF_SYS_BOOT4_OFFSET			0x9e2
+#define OMAP3_CONTROL_PADCONF_SYS_BOOT5_OFFSET			0x9e4
+#define OMAP3_CONTROL_PADCONF_SYS_BOOT6_OFFSET			0x9e6
+#define OMAP3_CONTROL_PADCONF_SYS_OFF_MODE_OFFSET		0x9e8
+#define OMAP3_CONTROL_PADCONF_SYS_CLKOUT1_OFFSET		0x9ea
+#define OMAP3_CONTROL_PADCONF_JTAG_NTRST_OFFSET			0x9ec
+#define OMAP3_CONTROL_PADCONF_JTAG_TCK_OFFSET			0x9ee
+#define OMAP3_CONTROL_PADCONF_JTAG_TMS_TMSC_OFFSET		0x9f0
+#define OMAP3_CONTROL_PADCONF_JTAG_TDI_OFFSET			0x9f2
+#define OMAP3_CONTROL_PADCONF_JTAG_EMU0_OFFSET			0x9f4
+#define OMAP3_CONTROL_PADCONF_JTAG_EMU1_OFFSET			0x9f6
+#define OMAP3_CONTROL_PADCONF_SAD2D_SWAKEUP_OFFSET		0xa1c
+#define OMAP3_CONTROL_PADCONF_JTAG_RTCK_OFFSET			0xa1e
+#define OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET			0xa20
+
+#define OMAP3_CONTROL_PADCONF_MUX_SIZE				\
+		(OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET + 0x2)

