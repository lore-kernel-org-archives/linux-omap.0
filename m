From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-omap] 24xx pinmux updates
Date: Tue, 17 Oct 2006 14:15:45 -0700
Message-ID: <200610171415.46306.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add some OMAP 24xx pin mux declarations to support:

 - TUSB 6010 EVM (on H4)
 - All three full speed USB ports
 - GPIOs used with USB0 on Apollon and H4

For OMAP2, issue MUX_WARNINGS and debug messages correctly; and make the
message look more like the OMAP1 message.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: h4/arch/arm/mach-omap2/mux.c
===================================================================
--- h4.orig/arch/arm/mach-omap2/mux.c	2006-10-13 18:26:36.000000000 -0700
+++ h4/arch/arm/mach-omap2/mux.c	2006-10-14 11:29:08.000000000 -0700
@@ -43,7 +43,7 @@ struct pin_config __initdata_or_module o
 /* 24xx I2C */
 MUX_CFG_24XX("M19_24XX_I2C1_SCL",	0x111,	0,	0,	0,	1)
 MUX_CFG_24XX("L15_24XX_I2C1_SDA",	0x112,	0,	0,	0,	1)
-MUX_CFG_24XX("J15_24XX_I2C2_SCL",	0x113,	0,	0,	0,	1)
+MUX_CFG_24XX("J15_24XX_I2C2_SCL",	0x113,	0,	0,	1,	1)
 MUX_CFG_24XX("H19_24XX_I2C2_SDA",	0x114,	0,	0,	0,	1)
 
 /* Menelaus interrupt */
@@ -52,7 +52,9 @@ MUX_CFG_24XX("W19_24XX_SYS_NIRQ",	0x12c,
 /* 24xx clocks */
 MUX_CFG_24XX("W14_24XX_SYS_CLKOUT",	0x137,	0,	1,	1,	1)
 
-/* 24xx GPMC wait pin monitoring */
+/* 24xx GPMC chipselects, wait pin monitoring */
+MUX_CFG_24XX("E2_GPMC_NCS2",		0x08e,	0,	1,	1,	1)
+MUX_CFG_24XX("L2_GPMC_NCS7",		0x093,	0,	1,	1,	1)
 MUX_CFG_24XX("L3_GPMC_WAIT0",		0x09a,	0,	1,	1,	1)
 MUX_CFG_24XX("N7_GPMC_WAIT1",		0x09b,	0,	1,	1,	1)
 MUX_CFG_24XX("M1_GPMC_WAIT2",		0x09c,	0,	1,	1,	1)
@@ -66,6 +68,7 @@ MUX_CFG_24XX("V15_24XX_MCBSP2_DX",	0x127
 
 /* 24xx GPIO */
 MUX_CFG_24XX("M21_242X_GPIO11",		0x0c9,  3,      1,      1,      1)
+MUX_CFG_24XX("P21_242X_GPIO12",		0x0ca,	3,	0,	0,	1)
 MUX_CFG_24XX("AA10_242X_GPIO13",	0x0e5,  3,      0,      0,      1)
 MUX_CFG_24XX("AA6_242X_GPIO14",		0x0e6,  3,      0,      0,      1)
 MUX_CFG_24XX("AA4_242X_GPIO15",		0x0e7,  3,      0,      0,      1)
@@ -75,7 +78,9 @@ MUX_CFG_24XX("AA8_242X_GPIO58",		0x0ea, 
 MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,	1)
 MUX_CFG_24XX("W4__24XX_GPIO74",		0x0f2,  3,      0,      0,      1)
 MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,	1)
+MUX_CFG_24XX("J15_24XX_GPIO99",		0x113,	3,	1,	1,	1)
 MUX_CFG_24XX("V14_24XX_GPIO117",	0x128,	3,	1,	0,	1)
+MUX_CFG_24XX("P14_24XX_GPIO125",	0x140,	3,	1,	1,	1)
 
 /* 242x DBG GPIO */
 MUX_CFG_24XX("V4_242X_GPIO49",		0xd3,	3,	0,	0,	1)
@@ -118,6 +123,30 @@ MUX_CFG_24XX("E18_24XX_MMC_DAT_DIR3",	0x
 MUX_CFG_24XX("G18_24XX_MMC_CMD_DIR",	0x0fd,	0,	0,	0,	1)
 MUX_CFG_24XX("H15_24XX_MMC_CLKI",	0x0fe,	0,	0,	0,	1)
 
+/* Full speed USB */
+MUX_CFG_24XX("J20_24XX_USB0_PUEN",	0x11d,	0,	0,	0,	1)
+MUX_CFG_24XX("J19_24XX_USB0_VP",	0x11e,	0,	0,	0,	1)
+MUX_CFG_24XX("K20_24XX_USB0_VM",	0x11f,	0,	0,	0,	1)
+MUX_CFG_24XX("J18_24XX_USB0_RCV",	0x120,	0,	0,	0,	1)
+MUX_CFG_24XX("K19_24XX_USB0_TXEN",	0x121,	0,	0,	0,	1)
+MUX_CFG_24XX("J14_24XX_USB0_SE0",	0x122,	0,	0,	0,	1)
+MUX_CFG_24XX("K18_24XX_USB0_DAT",	0x123,	0,	0,	0,	1)
+
+MUX_CFG_24XX("N14_24XX_USB1_SE0",	0x0ed,  2,      0,      0,      1)
+MUX_CFG_24XX("W12_24XX_USB1_SE0",	0x0dd,  3,      0,      0,      1)
+MUX_CFG_24XX("P15_24XX_USB1_DAT",	0x0ee,  2,      0,      0,      1)
+MUX_CFG_24XX("R13_24XX_USB1_DAT",	0x0e0,  3,      0,      0,      1)
+MUX_CFG_24XX("W20_24XX_USB1_TXEN",	0x0ec,  2,      0,      0,      1)
+MUX_CFG_24XX("P13_24XX_USB1_TXEN",	0x0df,  3,      0,      0,      1)
+MUX_CFG_24XX("V19_24XX_USB1_RCV",	0x0eb,  2,      0,      0,      1)
+MUX_CFG_24XX("V12_24XX_USB1_RCV",	0x0de,  3,      0,      0,      1)
+
+MUX_CFG_24XX("AA10_24XX_USB2_SE0",	0x0e5,  2,      0,      0,      1)
+MUX_CFG_24XX("Y11_24XX_USB2_DAT",	0x0e8,  2,      0,      0,      1)
+MUX_CFG_24XX("AA12_24XX_USB2_TXEN",	0x0e9,  2,      0,      0,      1)
+MUX_CFG_24XX("AA6_24XX_USB2_RCV",	0x0e6,  2,      0,      0,      1)
+MUX_CFG_24XX("AA4_24XX_USB2_TLLSE0",	0x0e7,	2,	0,	0,	1)
+
 /* Keypad GPIO*/
 MUX_CFG_24XX("T19_24XX_KBR0",		0x106,	3,	1,	1,	1)
 MUX_CFG_24XX("R19_24XX_KBR1",		0x107,	3,	1,	1,	1)
Index: h4/include/asm-arm/arch-omap/mux.h
===================================================================
--- h4.orig/include/asm-arm/arch-omap/mux.h	2006-10-13 18:26:36.000000000 -0700
+++ h4/include/asm-arm/arch-omap/mux.h	2006-10-14 13:24:36.000000000 -0700
@@ -421,7 +421,9 @@ enum omap24xx_index {
 	/* 24xx clock */
 	W14_24XX_SYS_CLKOUT,
 
-	/* 24xx GPMC wait pin monitoring */
+	/* 24xx GPMC chipselects, wait pin monitoring */
+	E2_GPMC_NCS2,
+	L2_GPMC_NCS7,
 	L3_GPMC_WAIT0,
 	N7_GPMC_WAIT1,
 	M1_GPMC_WAIT2,
@@ -435,6 +437,7 @@ enum omap24xx_index {
 
 	/* 24xx GPIO */
 	M21_242X_GPIO11,
+	P21_242X_GPIO12,
 	AA10_242X_GPIO13,
 	AA6_242X_GPIO14,
 	AA4_242X_GPIO15,
@@ -444,7 +447,9 @@ enum omap24xx_index {
 	Y20_24XX_GPIO60,
 	W4__24XX_GPIO74,
 	M15_24XX_GPIO92,
+	J15_24XX_GPIO99,
 	V14_24XX_GPIO117,
+	P14_24XX_GPIO125,
 
 	/* 242x DBG GPIO */
 	V4_242X_GPIO49,
@@ -486,6 +491,30 @@ enum omap24xx_index {
 	G18_24XX_MMC_CMD_DIR,
 	H15_24XX_MMC_CLKI,
 
+	/* Full speed USB */
+	J20_24XX_USB0_PUEN,
+	J19_24XX_USB0_VP,
+	K20_24XX_USB0_VM,
+	J18_24XX_USB0_RCV,
+	K19_24XX_USB0_TXEN,
+	J14_24XX_USB0_SE0,
+	K18_24XX_USB0_DAT,
+
+	N14_24XX_USB1_SE0,
+	W12_24XX_USB1_SE0,
+	P15_24XX_USB1_DAT,
+	R13_24XX_USB1_DAT,
+	W20_24XX_USB1_TXEN,
+	P13_24XX_USB1_TXEN,
+	V19_24XX_USB1_RCV,
+	V12_24XX_USB1_RCV,
+
+	AA10_24XX_USB2_SE0,
+	Y11_24XX_USB2_DAT,
+	AA12_24XX_USB2_TXEN,
+	AA6_24XX_USB2_RCV,
+	AA4_24XX_USB2_TLLSE0,
+
 	/* Keypad GPIO*/
 	T19_24XX_KBR0,
 	R19_24XX_KBR1,
Index: h4/arch/arm/plat-omap/mux.c
===================================================================
--- h4.orig/arch/arm/plat-omap/mux.c	2006-10-13 18:29:17.000000000 -0700
+++ h4/arch/arm/plat-omap/mux.c	2006-10-13 18:43:29.000000000 -0700
@@ -83,10 +83,21 @@ int __init_or_module omap_cfg_reg(const 
 			reg |= OMAP24XX_PULL_ENA;
 		if(cfg->pu_pd_val)
 			reg |= OMAP24XX_PULL_UP;
-#ifdef CONFIG_OMAP_MUX_DEBUG
-		printk("Muxing %s (0x%08x): 0x%02x -> 0x%02x\n",
-		       cfg->name, OMAP24XX_L4_BASE + cfg->mux_reg,
-		       omap_readb(OMAP24XX_L4_BASE + cfg->mux_reg), reg);
+#if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
+		{
+			u8 orig = omap_readb(OMAP24XX_L4_BASE + cfg->mux_reg);
+			u8 debug = 0;
+
+#ifdef	CONFIG_OMAP_MUX_DEBUG
+			debug = cfg->debug;
+#endif
+			warn = (orig != reg);
+			if (debug || warn)
+				printk("MUX: setup %s (0x%08x): 0x%02x -> 0x%02x\n",
+				       cfg->name,
+				       OMAP24XX_L4_BASE + cfg->mux_reg,
+				       orig, reg);
+		}
 #endif
 		omap_writeb(reg, OMAP24XX_L4_BASE + cfg->mux_reg);
 
