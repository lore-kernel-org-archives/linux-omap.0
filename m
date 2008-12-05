From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] ARM: OMAP3: Pin multiplexing updates for 24xx and 34xx
Date: Fri, 05 Dec 2008 12:07:44 -0800
Message-ID: <20081205200744.31125.1666.stgit@localhost>
References: <20081205195846.31125.21080.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54912 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbYLEUHr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 15:07:47 -0500
In-Reply-To: <20081205195846.31125.21080.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Arun KS <arunks@mistralsolutions.com>

From: Arun KS <arunks@mistralsolutions.com>

This patch adds some new pin multiplexing options
for McBSP and McSPI from Arun KS. Also add two more
GPIOs from David Brownell.

Also mark omap24xx_cfg_reg() static.

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c             |   44 ++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/mux.h |   41 +++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index b139367..dacb41f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -203,6 +203,15 @@ MUX_CFG_24XX("AE9_2430_USB0HS_NXT",	0x13D,	0,	0,	0,	1)
 MUX_CFG_24XX("AC7_2430_USB0HS_DATA7",	0x13E,	0,	0,	0,	1)
 
 /* 2430 McBSP */
+MUX_CFG_24XX("AD6_2430_MCBSP_CLKS",	0x011E,	0,	0,	0,	1)
+
+MUX_CFG_24XX("AB2_2430_MCBSP1_CLKR",	0x011A,	0,	0,	0,	1)
+MUX_CFG_24XX("AD5_2430_MCBSP1_FSR",	0x011B,	0,	0,	0,	1)
+MUX_CFG_24XX("AA1_2430_MCBSP1_DX",	0x011C,	0,	0,	0,	1)
+MUX_CFG_24XX("AF3_2430_MCBSP1_DR",	0x011D,	0,	0,	0,	1)
+MUX_CFG_24XX("AB3_2430_MCBSP1_FSX",	0x011F,	0,	0,	0,	1)
+MUX_CFG_24XX("Y9_2430_MCBSP1_CLKX",	0x0120,	0,	0,	0,	1)
+
 MUX_CFG_24XX("AC10_2430_MCBSP2_FSX",	0x012E,	1,	0,	0,	1)
 MUX_CFG_24XX("AD16_2430_MCBSP2_CLX",	0x012F,	1,	0,	0,	1)
 MUX_CFG_24XX("AE13_2430_MCBSP2_DX",	0x0130,	1,	0,	0,	1)
@@ -211,6 +220,31 @@ MUX_CFG_24XX("AC10_2430_MCBSP2_FSX_OFF",0x012E,	0,	0,	0,	1)
 MUX_CFG_24XX("AD16_2430_MCBSP2_CLX_OFF",0x012F,	0,	0,	0,	1)
 MUX_CFG_24XX("AE13_2430_MCBSP2_DX_OFF",	0x0130,	0,	0,	0,	1)
 MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)
+
+MUX_CFG_24XX("AC9_2430_MCBSP3_CLKX",	0x0103,	0,	0,	0,	1)
+MUX_CFG_24XX("AE4_2430_MCBSP3_FSX",	0x0104,	0,	0,	0,	1)
+MUX_CFG_24XX("AE2_2430_MCBSP3_DR",	0x0105,	0,	0,	0,	1)
+MUX_CFG_24XX("AF4_2430_MCBSP3_DX",	0x0106,	0,	0,	0,	1)
+
+MUX_CFG_24XX("N3_2430_MCBSP4_CLKX",	0x010B,	1,	0,	0,	1)
+MUX_CFG_24XX("AD23_2430_MCBSP4_DR",	0x010C,	1,	0,	0,	1)
+MUX_CFG_24XX("AB25_2430_MCBSP4_DX",	0x010D,	1,	0,	0,	1)
+MUX_CFG_24XX("AC25_2430_MCBSP4_FSX",	0x010E,	1,	0,	0,	1)
+
+MUX_CFG_24XX("AE16_2430_MCBSP5_CLKX",	0x00ED,	1,	0,	0,	1)
+MUX_CFG_24XX("AF12_2430_MCBSP5_FSX",	0x00ED,	1,	0,	0,	1)
+MUX_CFG_24XX("K7_2430_MCBSP5_DX",	0x00EF,	1,	0,	0,	1)
+MUX_CFG_24XX("M1_2430_MCBSP5_DR",	0x00F0,	1,	0,	0,	1)
+
+/* 2430 MCSPI1 */
+MUX_CFG_24XX("Y18_2430_MCSPI1_CLK",	0x010F,	0,	0,	0,	1)
+MUX_CFG_24XX("AD15_2430_MCSPI1_SIMO",	0x0110,	0,	0,	0,	1)
+MUX_CFG_24XX("AE17_2430_MCSPI1_SOMI",	0x0111,	0,	0,	0,	1)
+MUX_CFG_24XX("U1_2430_MCSPI1_CS0",	0x0112,	0,	0,	0,	1)
+
+/* Touchscreen GPIO */
+MUX_CFG_24XX("AF19_2430_GPIO_85",	0x0113,	3,	0,	0,	1)
+
 };
 
 #define OMAP24XX_PINS_SZ	ARRAY_SIZE(omap24xx_pins)
@@ -417,6 +451,14 @@ MUX_CFG_34XX("AD2_3430_USB3FS_PHY_MM3_TXDAT", 0x188,
 MUX_CFG_34XX("AC1_3430_USB3FS_PHY_MM3_TXEN_N", 0x18a,
 		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
 
+
+/* 34XX GPIO - bidirectional, unless the name has an "_OUT" suffix.
+ * No internal pullup/pulldown without "_UP" or "_DOWN" suffix.
+ */
+MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
@@ -452,7 +494,7 @@ static void __init_or_module omap2_cfg_debug(const struct pin_config *cfg, u16 r
 #endif
 
 #ifdef CONFIG_ARCH_OMAP24XX
-int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
+static int __init_or_module omap24xx_cfg_reg(const struct pin_config *cfg)
 {
 	static DEFINE_SPINLOCK(mux_spin_lock);
 	unsigned long flags;
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 6bbf178..f4362b8 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -632,6 +632,15 @@ enum omap24xx_index {
 	AC7_2430_USB0HS_DATA7,
 
 	/* 2430 McBSP */
+	AD6_2430_MCBSP_CLKS,
+
+	AB2_2430_MCBSP1_CLKR,
+	AD5_2430_MCBSP1_FSR,
+	AA1_2430_MCBSP1_DX,
+	AF3_2430_MCBSP1_DR,
+	AB3_2430_MCBSP1_FSX,
+	Y9_2430_MCBSP1_CLKX,
+
 	AC10_2430_MCBSP2_FSX,
 	AD16_2430_MCBSP2_CLX,
 	AE13_2430_MCBSP2_DX,
@@ -641,6 +650,30 @@ enum omap24xx_index {
 	AE13_2430_MCBSP2_DX_OFF,
 	AD13_2430_MCBSP2_DR_OFF,
 
+	AC9_2430_MCBSP3_CLKX,
+	AE4_2430_MCBSP3_FSX,
+	AE2_2430_MCBSP3_DR,
+	AF4_2430_MCBSP3_DX,
+
+	N3_2430_MCBSP4_CLKX,
+	AD23_2430_MCBSP4_DR,
+	AB25_2430_MCBSP4_DX,
+	AC25_2430_MCBSP4_FSX,
+
+	AE16_2430_MCBSP5_CLKX,
+	AF12_2430_MCBSP5_FSX,
+	K7_2430_MCBSP5_DX,
+	M1_2430_MCBSP5_DR,
+
+	/* 2430 McSPI*/
+	Y18_2430_MCSPI1_CLK,
+	AD15_2430_MCSPI1_SIMO,
+	AE17_2430_MCSPI1_SOMI,
+	U1_2430_MCSPI1_CS0,
+
+	/* Touchscreen GPIO */
+	AF19_2430_GPIO_85,
+
 };
 
 enum omap34xx_index {
@@ -749,6 +782,14 @@ enum omap34xx_index {
 	AD2_3430_USB3FS_PHY_MM3_TXDAT,
 	AC1_3430_USB3FS_PHY_MM3_TXEN_N,
 
+	/* 34xx GPIO
+	 *  - normally these are bidirectional, no internal pullup/pulldown
+	 *  - "_UP" suffix (GPIO3_UP) if internal pullup is configured
+	 *  - "_DOWN" suffix (GPIO3_DOWN) with internal pulldown
+	 *  - "_OUT" suffix (GPIO3_OUT) for output-only pins (unlike 24xx)
+	 */
+	AH8_34XX_GPIO29,
+	J25_34XX_GPIO170,
 };
 
 struct omap_mux_cfg {

