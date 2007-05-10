From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 1/2] ARM: OMAP: pin-mux fixups for 2430
Date: Thu, 10 May 2007 11:34:06 -0700
Message-ID: <20070510183421.446066553@mvista.com>
References: <20070510183405.565400315@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=mux.patch
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

Fix base register used for 2430 which is different from 2420. 
And add mux regs for HSUSB and McBSP

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/mux.c            |   36 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-regs.h      |    2 -
 arch/arm/plat-omap/mux.c             |    9 ++++----
 include/asm-arm/arch-omap/mux.h      |   37 +++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/omap24xx.h |    3 ++
 5 files changed, 81 insertions(+), 6 deletions(-)

Index: dev/arch/arm/mach-omap2/mux.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/mux.c
+++ dev/arch/arm/mach-omap2/mux.c
@@ -167,6 +167,42 @@ MUX_CFG_24XX("B3__24XX_KBR5",		0x30,	3,	
 MUX_CFG_24XX("AA4_24XX_KBC2",		0xe7,	3,	0,	0,	1)
 MUX_CFG_24XX("B13_24XX_KBC6",		0x110,	3,	0,	0,	1)
 
+/* 2430 USB */
+MUX_CFG_24XX("AD9_2430_USB0_PUEN",	0x133,	4,	0,	0,	1)
+MUX_CFG_24XX("Y11_2430_USB0_VP",	0x134,	4,	0,	0,	1)
+MUX_CFG_24XX("AD7_2430_USB0_VM",	0x135,	4,	0,	0,	1)
+MUX_CFG_24XX("AE7_2430_USB0_RCV",	0x136,	4,	0,	0,	1)
+MUX_CFG_24XX("AD4_2430_USB0_TXEN",	0x137,	4,	0,	0,	1)
+MUX_CFG_24XX("AF9_2430_USB0_SE0",	0x138,	4,	0,	0,	1)
+MUX_CFG_24XX("AE6_2430_USB0_DAT",	0x139,	4,	0,	0,	1)
+MUX_CFG_24XX("AD24_2430_USB1_SE0",	0x107,	2,	0,	0,	1)
+MUX_CFG_24XX("AB24_2430_USB1_RCV",	0x108,	2,	0,	0,	1)
+MUX_CFG_24XX("Y25_2430_USB1_TXEN",	0x109,	2,	0,	0,	1)
+MUX_CFG_24XX("AA26_2430_USB1_DAT",	0x10A,	2,	0,	0,	1)
+
+/* 2430 HS-USB */
+MUX_CFG_24XX("AD9_2430_USB0HS_DATA3",	0x133,	0,	0,	0,	1)
+MUX_CFG_24XX("Y11_2430_USB0HS_DATA4",	0x134,	0,	0,	0,	1)
+MUX_CFG_24XX("AD7_2430_USB0HS_DATA5",	0x135,	0,	0,	0,	1)
+MUX_CFG_24XX("AE7_2430_USB0HS_DATA6",	0x136,	0,	0,	0,	1)
+MUX_CFG_24XX("AD4_2430_USB0HS_DATA2",	0x137,	0,	0,	0,	1)
+MUX_CFG_24XX("AF9_2430_USB0HS_DATA0",	0x138,	0,	0,	0,	1)
+MUX_CFG_24XX("AE6_2430_USB0HS_DATA1",	0x139,	0,	0,	0,	1)
+MUX_CFG_24XX("AE8_2430_USB0HS_CLK",	0x13A,	0,	0,	0,	1)
+MUX_CFG_24XX("AD8_2430_USB0HS_DIR",	0x13B,	0,	0,	0,	1)
+MUX_CFG_24XX("AE5_2430_USB0HS_STP",	0x13c,	0,	1,	1,	1)
+MUX_CFG_24XX("AE9_2430_USB0HS_NXT",	0x13D,	0,	0,	0,	1)
+MUX_CFG_24XX("AC7_2430_USB0HS_DATA7",	0x13E,	0,	0,	0,	1)
+
+/* 2430 McBSP */
+MUX_CFG_24XX("AC10_2430_MCBSP2_FSX",	0x012E,	1,	0,	0,	1)
+MUX_CFG_24XX("AD16_2430_MCBSP2_CLX",	0x012F,	1,	0,	0,	1)
+MUX_CFG_24XX("AE13_2430_MCBSP2_DX",	0x0130,	1,	0,	0,	1)
+MUX_CFG_24XX("AD13_2430_MCBSP2_DR",	0x0131,	1,	0,	0,	1)
+MUX_CFG_24XX("AC10_2430_MCBSP2_FSX_OFF",0x012E,	0,	0,	0,	1)
+MUX_CFG_24XX("AD16_2430_MCBSP2_CLX_OFF",0x012F,	0,	0,	0,	1)
+MUX_CFG_24XX("AE13_2430_MCBSP2_DX_OFF",	0x0130,	0,	0,	0,	1)
+MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)
 };
 
 int __init omap2_mux_init(void)
Index: dev/arch/arm/mach-omap2/prcm-regs.h
===================================================================
--- dev.orig/arch/arm/mach-omap2/prcm-regs.h
+++ dev/arch/arm/mach-omap2/prcm-regs.h
@@ -350,9 +350,7 @@
 #endif
 
 /* IO CONFIG */
-#define OMAP24XX_CTRL_BASE		(L4_24XX_BASE)
 #define CONTROL_REG32(offset)		__REG32(OMAP24XX_CTRL_BASE + (offset))
-
 #define CONTROL_PADCONF_SPI1_NCS2	CONTROL_REG32(0x104)
 #define CONTROL_PADCONF_SYS_XTALOUT	CONTROL_REG32(0x134)
 #define CONTROL_PADCONF_UART1_RX	CONTROL_REG32(0x0C8)
Index: dev/arch/arm/plat-omap/mux.c
===================================================================
--- dev.orig/arch/arm/plat-omap/mux.c
+++ dev/arch/arm/plat-omap/mux.c
@@ -32,7 +32,6 @@
 
 #ifdef CONFIG_OMAP_MUX
 
-#define OMAP24XX_L4_BASE	0x48000000
 #define OMAP24XX_PULL_ENA	(1 << 3)
 #define OMAP24XX_PULL_UP	(1 << 4)
 
@@ -75,6 +74,7 @@ int __init_or_module omap_cfg_reg(const 
 	}
 
 	cfg = (struct pin_config *)&pin_table[index];
+#ifdef CONFIG_ARCH_OMAP24XX
 	if (cpu_is_omap24xx()) {
 		u8 reg = 0;
 
@@ -85,7 +85,7 @@ int __init_or_module omap_cfg_reg(const 
 			reg |= OMAP24XX_PULL_UP;
 #if defined(CONFIG_OMAP_MUX_DEBUG) || defined(CONFIG_OMAP_MUX_WARNINGS)
 		{
-			u8 orig = omap_readb(OMAP24XX_L4_BASE + cfg->mux_reg);
+			u8 orig = omap_readb(OMAP24XX_CTRL_BASE + cfg->mux_reg);
 			u8 debug = 0;
 
 #ifdef	CONFIG_OMAP_MUX_DEBUG
@@ -95,14 +95,15 @@ int __init_or_module omap_cfg_reg(const 
 			if (debug || warn)
 				printk("MUX: setup %s (0x%08x): 0x%02x -> 0x%02x\n",
 						cfg->name,
-						OMAP24XX_L4_BASE + cfg->mux_reg,
+						OMAP24XX_CTRL_BASE + cfg->mux_reg,
 						orig, reg);
 		}
 #endif
-		omap_writeb(reg, OMAP24XX_L4_BASE + cfg->mux_reg);
+		omap_writeb(reg, OMAP24XX_CTRL_BASE + cfg->mux_reg);
 
 		return 0;
 	}
+#endif /* ARCH_OMAP24XX */
 
 	/* Check the mux register in question */
 	if (cfg->mux_reg) {
Index: dev/include/asm-arm/arch-omap/mux.h
===================================================================
--- dev.orig/include/asm-arm/arch-omap/mux.h
+++ dev/include/asm-arm/arch-omap/mux.h
@@ -557,6 +557,43 @@ enum omap24xx_index {
 	B3__24XX_KBR5,
 	AA4_24XX_KBC2,
 	B13_24XX_KBC6,
+
+	/* 2430 USB */
+	AD9_2430_USB0_PUEN,
+	Y11_2430_USB0_VP,
+	AD7_2430_USB0_VM,
+	AE7_2430_USB0_RCV,
+	AD4_2430_USB0_TXEN,
+	AF9_2430_USB0_SE0,
+	AE6_2430_USB0_DAT,
+	AD24_2430_USB1_SE0,
+	AB24_2430_USB1_RCV,
+	Y25_2430_USB1_TXEN,
+	AA26_2430_USB1_DAT,
+
+	/* 2430 HS-USB */
+	AD9_2430_USB0HS_DATA3,
+	Y11_2430_USB0HS_DATA4,
+	AD7_2430_USB0HS_DATA5,
+	AE7_2430_USB0HS_DATA6,
+	AD4_2430_USB0HS_DATA2,
+	AF9_2430_USB0HS_DATA0,
+	AE6_2430_USB0HS_DATA1,
+	AE8_2430_USB0HS_CLK,
+	AD8_2430_USB0HS_DIR,
+	AE5_2430_USB0HS_STP,
+	AE9_2430_USB0HS_NXT,
+	AC7_2430_USB0HS_DATA7,
+
+	/* 2430 McBSP */
+	AC10_2430_MCBSP2_FSX,
+	AD16_2430_MCBSP2_CLX,
+	AE13_2430_MCBSP2_DX,
+	AD13_2430_MCBSP2_DR,
+	AC10_2430_MCBSP2_FSX_OFF,
+	AD16_2430_MCBSP2_CLX_OFF,
+	AE13_2430_MCBSP2_DX_OFF,
+	AD13_2430_MCBSP2_DR_OFF,
 };
 
 #ifdef	CONFIG_OMAP_MUX
Index: dev/include/asm-arm/arch-omap/omap24xx.h
===================================================================
--- dev.orig/include/asm-arm/arch-omap/omap24xx.h
+++ dev/include/asm-arm/arch-omap/omap24xx.h
@@ -23,6 +23,7 @@
 #define OMAP24XX_32KSYNCT_BASE	(L4_24XX_BASE + 0x4000)
 #define OMAP24XX_PRCM_BASE	(L4_24XX_BASE + 0x8000)
 #define OMAP24XX_SDRC_BASE	(L3_24XX_BASE + 0x9000)
+#define OMAP24XX_CTRL_BASE	L4_24XX_BASE
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
@@ -31,6 +32,8 @@
 #define OMAP243X_SMS_BASE	0x6C000000
 #define OMAP24XX_SDRC_BASE	0x6D000000
 #define OMAP243X_GPMC_BASE	0x6E000000
+#define OMAP243X_SCM_BASE	(L4_WK_243X_BASE + 0x2000)
+#define OMAP24XX_CTRL_BASE	OMAP243X_SCM_BASE
 #endif
 
 /* DSP SS */

--
