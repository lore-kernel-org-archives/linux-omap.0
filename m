From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/11] omap3: Remove non-muxable ball entries for 3630
Date: Fri, 30 Apr 2010 13:33:54 -0700
Message-ID: <20100430203354.25812.67516.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60960 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933091Ab0D3Ud4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 16:33:56 -0400
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

These are currently non-muxable, so let's save some memory
and remove them. Otherwise we get the following warnings:

mux: Unknown ball offset 0x5e
mux: Unknown ball offset 0x60
 mux: Unknown ball offset 0x62
...

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux34xx.c |   86 -----------------------------------------
 1 files changed, 0 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index 07aa7b3..2ff4dce 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -1901,26 +1901,15 @@ struct omap_ball __initdata omap36xx_cbp_ball[] = {
 	_OMAP3_BALLENTRY(GPMC_A8, "m3", "ab18"),
 	_OMAP3_BALLENTRY(GPMC_A9, "l3", "ac19"),
 	_OMAP3_BALLENTRY(GPMC_CLK, "t4", "w2"),
-	_OMAP3_BALLENTRY(GPMC_D0, "k1", "m2"),
-	_OMAP3_BALLENTRY(GPMC_D1, "l1", "m1"),
 	_OMAP3_BALLENTRY(GPMC_D10, "p1", "ab4"),
 	_OMAP3_BALLENTRY(GPMC_D11, "r1", "ac4"),
 	_OMAP3_BALLENTRY(GPMC_D12, "r2", "ab6"),
 	_OMAP3_BALLENTRY(GPMC_D13, "t2", "ac6"),
 	_OMAP3_BALLENTRY(GPMC_D14, "w1", "ab7"),
 	_OMAP3_BALLENTRY(GPMC_D15, "y1", "ac7"),
-	_OMAP3_BALLENTRY(GPMC_D2, "l2", "n2"),
-	_OMAP3_BALLENTRY(GPMC_D3, "p2", "n1"),
-	_OMAP3_BALLENTRY(GPMC_D4, "t1", "r2"),
-	_OMAP3_BALLENTRY(GPMC_D5, "v1", "r1"),
-	_OMAP3_BALLENTRY(GPMC_D6, "v2", "t2"),
-	_OMAP3_BALLENTRY(GPMC_D7, "w2", "t1"),
-	_OMAP3_BALLENTRY(GPMC_D8, "h2", "ab3"),
 	_OMAP3_BALLENTRY(GPMC_D9, "k2", "ac3"),
-	_OMAP3_BALLENTRY(GPMC_NADV_ALE, "f3", "w1"),
 	_OMAP3_BALLENTRY(GPMC_NBE0_CLE, "g3", "ac12"),
 	_OMAP3_BALLENTRY(GPMC_NBE1, "u3", NULL),
-	_OMAP3_BALLENTRY(GPMC_NCS0, "g4", "y2"),
 	_OMAP3_BALLENTRY(GPMC_NCS1, "h3", "y1"),
 	_OMAP3_BALLENTRY(GPMC_NCS2, "v8", NULL),
 	_OMAP3_BALLENTRY(GPMC_NCS3, "u8", NULL),
@@ -1928,10 +1917,7 @@ struct omap_ball __initdata omap36xx_cbp_ball[] = {
 	_OMAP3_BALLENTRY(GPMC_NCS5, "r8", NULL),
 	_OMAP3_BALLENTRY(GPMC_NCS6, "p8", NULL),
 	_OMAP3_BALLENTRY(GPMC_NCS7, "n8", NULL),
-	_OMAP3_BALLENTRY(GPMC_NOE, "g2", "v2"),
-	_OMAP3_BALLENTRY(GPMC_NWE, "f4", "v1"),
 	_OMAP3_BALLENTRY(GPMC_NWP, "h1", "ab10"),
-	_OMAP3_BALLENTRY(GPMC_WAIT0, "m8", "ab12"),
 	_OMAP3_BALLENTRY(GPMC_WAIT1, "l8", "ac10"),
 	_OMAP3_BALLENTRY(GPMC_WAIT2, "k8", NULL),
 	_OMAP3_BALLENTRY(GPMC_WAIT3, "j8", NULL),
@@ -1948,8 +1934,6 @@ struct omap_ball __initdata omap36xx_cbp_ball[] = {
 	_OMAP3_BALLENTRY(HSUSB0_DIR, "r28", NULL),
 	_OMAP3_BALLENTRY(HSUSB0_NXT, "t26", NULL),
 	_OMAP3_BALLENTRY(HSUSB0_STP, "t25", NULL),
-	_OMAP3_BALLENTRY(I2C1_SCL, "k21", NULL),
-	_OMAP3_BALLENTRY(I2C1_SDA, "j21", NULL),
 	_OMAP3_BALLENTRY(I2C2_SCL, "af15", NULL),
 	_OMAP3_BALLENTRY(I2C2_SDA, "ae15", NULL),
 	_OMAP3_BALLENTRY(I2C3_SCL, "af14", NULL),
@@ -1958,11 +1942,6 @@ struct omap_ball __initdata omap36xx_cbp_ball[] = {
 	_OMAP3_BALLENTRY(I2C4_SDA, "ae26", NULL),
 	_OMAP3_BALLENTRY(JTAG_EMU0, "aa11", NULL),
 	_OMAP3_BALLENTRY(JTAG_EMU1, "aa10", NULL),
-	_OMAP3_BALLENTRY(JTAG_RTCK, "aa12", NULL),
-	_OMAP3_BALLENTRY(JTAG_TCK, "aa13", NULL),
-	_OMAP3_BALLENTRY(JTAG_TDI, "aa20", NULL),
-	_OMAP3_BALLENTRY(JTAG_TDO, "aa19", NULL),
-	_OMAP3_BALLENTRY(JTAG_TMS_TMSC, "aa18", NULL),
 	_OMAP3_BALLENTRY(MCBSP1_CLKR, "y21", NULL),
 	_OMAP3_BALLENTRY(MCBSP1_CLKX, "w21", NULL),
 	_OMAP3_BALLENTRY(MCBSP1_DR, "u21", NULL),
@@ -2010,77 +1989,12 @@ struct omap_ball __initdata omap36xx_cbp_ball[] = {
 	_OMAP3_BALLENTRY(SDMMC2_DAT5, "ah3", NULL),
 	_OMAP3_BALLENTRY(SDMMC2_DAT6, "af3", NULL),
 	_OMAP3_BALLENTRY(SDMMC2_DAT7, "ae3", NULL),
-	_OMAP3_BALLENTRY(SDRC_A0, NULL, "n22"),
-	_OMAP3_BALLENTRY(SDRC_A1, NULL, "n23"),
-	_OMAP3_BALLENTRY(SDRC_A10, NULL, "v22"),
-	_OMAP3_BALLENTRY(SDRC_A11, NULL, "v23"),
-	_OMAP3_BALLENTRY(SDRC_A12, NULL, "w22"),
-	_OMAP3_BALLENTRY(SDRC_A13, NULL, "w23"),
-	_OMAP3_BALLENTRY(SDRC_A14, NULL, "y22"),
-	_OMAP3_BALLENTRY(SDRC_A2, NULL, "p22"),
-	_OMAP3_BALLENTRY(SDRC_A3, NULL, "p23"),
-	_OMAP3_BALLENTRY(SDRC_A4, NULL, "r22"),
-	_OMAP3_BALLENTRY(SDRC_A5, NULL, "r23"),
-	_OMAP3_BALLENTRY(SDRC_A6, NULL, "t22"),
-	_OMAP3_BALLENTRY(SDRC_A7, NULL, "t23"),
-	_OMAP3_BALLENTRY(SDRC_A8, NULL, "u22"),
-	_OMAP3_BALLENTRY(SDRC_A9, NULL, "u23"),
-	_OMAP3_BALLENTRY(SDRC_BA0, "h9", "ab21"),
-	_OMAP3_BALLENTRY(SDRC_BA1, "h10", "ac21"),
 	_OMAP3_BALLENTRY(SDRC_CKE0, "h16", "j22"),
 	_OMAP3_BALLENTRY(SDRC_CKE1, "h17", "j23"),
-	_OMAP3_BALLENTRY(SDRC_CLK, "a13", "a11"),
-	_OMAP3_BALLENTRY(SDRC_D0, NULL, "j2"),
-	_OMAP3_BALLENTRY(SDRC_D1, NULL, "j1"),
-	_OMAP3_BALLENTRY(SDRC_D10, "c15", "b14"),
-	_OMAP3_BALLENTRY(SDRC_D11, "b16", "a14"),
-	_OMAP3_BALLENTRY(SDRC_D12, "d17", "b16"),
-	_OMAP3_BALLENTRY(SDRC_D13, "c17", "a16"),
-	_OMAP3_BALLENTRY(SDRC_D14, "b17", "b19"),
-	_OMAP3_BALLENTRY(SDRC_D15, "d18", "a19"),
-	_OMAP3_BALLENTRY(SDRC_D16, NULL, "b3"),
-	_OMAP3_BALLENTRY(SDRC_D17, NULL, "a3"),
-	_OMAP3_BALLENTRY(SDRC_D18, NULL, "b5"),
-	_OMAP3_BALLENTRY(SDRC_D19, NULL, "a5"),
-	_OMAP3_BALLENTRY(SDRC_D2, NULL, "g2"),
-	_OMAP3_BALLENTRY(SDRC_D20, NULL, "b8"),
-	_OMAP3_BALLENTRY(SDRC_D21, NULL, "a8"),
-	_OMAP3_BALLENTRY(SDRC_D22, NULL, "b9"),
-	_OMAP3_BALLENTRY(SDRC_D23, NULL, "a9"),
-	_OMAP3_BALLENTRY(SDRC_D24, NULL, "b21"),
-	_OMAP3_BALLENTRY(SDRC_D25, NULL, "a21"),
-	_OMAP3_BALLENTRY(SDRC_D26, NULL, "d22"),
-	_OMAP3_BALLENTRY(SDRC_D27, NULL, "d23"),
-	_OMAP3_BALLENTRY(SDRC_D28, NULL, "e22"),
-	_OMAP3_BALLENTRY(SDRC_D29, NULL, "e23"),
-	_OMAP3_BALLENTRY(SDRC_D3, NULL, "g1"),
-	_OMAP3_BALLENTRY(SDRC_D30, NULL, "g22"),
-	_OMAP3_BALLENTRY(SDRC_D31, NULL, "g23"),
-	_OMAP3_BALLENTRY(SDRC_D4, NULL, "f2"),
-	_OMAP3_BALLENTRY(SDRC_D5, NULL, "f1"),
-	_OMAP3_BALLENTRY(SDRC_D6, NULL, "d2"),
-	_OMAP3_BALLENTRY(SDRC_D7, NULL, "d1"),
-	_OMAP3_BALLENTRY(SDRC_D8, "c14", "b13"),
-	_OMAP3_BALLENTRY(SDRC_D9, "b14", "a13"),
-	_OMAP3_BALLENTRY(SDRC_DM0, NULL, "c1"),
-	_OMAP3_BALLENTRY(SDRC_DM1, "a16", "a17"),
-	_OMAP3_BALLENTRY(SDRC_DM2, NULL, "a6"),
-	_OMAP3_BALLENTRY(SDRC_DM3, NULL, "a20"),
-	_OMAP3_BALLENTRY(SDRC_DQS0, NULL, "c2"),
-	_OMAP3_BALLENTRY(SDRC_DQS1, "a17", "b17"),
-	_OMAP3_BALLENTRY(SDRC_DQS2, NULL, "b6"),
-	_OMAP3_BALLENTRY(SDRC_DQS3, NULL, "b20"),
-	_OMAP3_BALLENTRY(SDRC_NCAS, "h13", "l22"),
-	_OMAP3_BALLENTRY(SDRC_NCLK, "a14", "b11"),
-	_OMAP3_BALLENTRY(SDRC_NCS0, "h11", "m22"),
-	_OMAP3_BALLENTRY(SDRC_NCS1, "h12", "m23"),
-	_OMAP3_BALLENTRY(SDRC_NRAS, "h14", "l23"),
-	_OMAP3_BALLENTRY(SDRC_NWE, "h15", "k23"),
 	_OMAP3_BALLENTRY(SIM_CLK, "p26", NULL),
 	_OMAP3_BALLENTRY(SIM_IO, "p27", NULL),
 	_OMAP3_BALLENTRY(SIM_PWRCTRL, "r27", NULL),
 	_OMAP3_BALLENTRY(SIM_RST, "r25", NULL),
-	_OMAP3_BALLENTRY(SYS_32K, "ae25", NULL),
 	_OMAP3_BALLENTRY(SYS_BOOT0, "ah26", NULL),
 	_OMAP3_BALLENTRY(SYS_BOOT1, "ag26", NULL),
 	_OMAP3_BALLENTRY(SYS_BOOT2, "ae14", NULL),

