From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] Apollon MMC support
Date: Wed, 07 Jun 2006 10:22:07 +0900
Message-ID: <00ec01c689d0$ce2baed0$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Apollon board MMC supports on OMAP2

TODO:
	We have to check MMC on H4

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
omap2/board-apollon.c
index 6c6ba17..f19c49f 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -166,8 +166,8 @@ static struct omap_uart_config apollon_u
 
 static struct omap_mmc_config apollon_mmc_config __initdata = {
 	.mmc [0] = {
-		.enabled 	= 0,
-		.wire4		= 0,
+		.enabled 	= 1,
+		.wire4		= 1,
 		.wp_pin		= -1,
 		.power_pin	= -1,
 		.switch_pin	= -1,
@@ -257,6 +257,9 @@ static void __init omap_apollon_init(voi
 	/* REVISIT: where's the correct place */
 	omap_cfg_reg(W19_24XX_SYS_NIRQ);
 
+	/* Use Interal loop-back in MMC/SDIO Module Input Clock selection */
+	CONTROL_DEVCONF |= (1 << 24);
+
 	/*
  	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on diff --git
a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c index
1197dc3..782796e 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -79,6 +79,20 @@ MUX_CFG_24XX("P20_24XX_TSC_IRQ",	0x108,	
 MUX_CFG_24XX("K15_24XX_UART3_TX",	0x118,	0,	0,	0,	1)
 MUX_CFG_24XX("K14_24XX_UART3_RX",	0x119,	0,	0,	0,	1)
 
+/* MMC/SDIO */
+MUX_CFG_24XX("G19_24XX_MMC_CLKO",	0x0f3,	0,	0,	0,	1)
+MUX_CFG_24XX("H18_24XX_MMC_CMD",	0x0f4,	0,	0,	0,	1)
+MUX_CFG_24XX("F20_24XX_MMC_DAT0",	0x0f5,	0,	0,	0,	1)
+MUX_CFG_24XX("H14_24XX_MMC_DAT1",	0x0f6,	0,	0,	0,	1)
+MUX_CFG_24XX("E19_24XX_MMC_DAT2",	0x0f7,	0,	0,	0,	1)
+MUX_CFG_24XX("D19_24XX_MMC_DAT3",	0x0f8,	0,	0,	0,	1)
+MUX_CFG_24XX("F19_24XX_MMC_DAT_DIR0",	0x0f9,	0,	0,	0,	1)
+MUX_CFG_24XX("E20_24XX_MMC_DAT_DIR1",	0x0fa,	0,	0,	0,	1)
+MUX_CFG_24XX("F18_24XX_MMC_DAT_DIR2",	0x0fb,	0,	0,	0,	1)
+MUX_CFG_24XX("E18_24XX_MMC_DAT_DIR3",	0x0fc,	0,	0,	0,	1)
+MUX_CFG_24XX("G18_24XX_MMC_CMD_DIR",	0x0fd,	0,	0,	0,	1)
+MUX_CFG_24XX("H15_24XX_MMC_CLKI",	0x0fe,	0,	0,	0,	1)
+
 /* Keypad GPIO*/
 MUX_CFG_24XX("T19_24XX_KBR0",		0x106,	3,	1,	1,	1)
 MUX_CFG_24XX("R19_24XX_KBR1",		0x107,	3,	1,	1,	1)
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 8bff566..67d6c3e 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -149,7 +149,7 @@ static inline void omap_init_kp(void) {}
 
 #ifdef CONFIG_ARCH_OMAP24XX
 #define	OMAP_MMC1_BASE		0x4809c000
-#define OMAP_MMC1_INT		83
+#define OMAP_MMC1_INT		INT_24XX_MMC_IRQ
 #else
 #define	OMAP_MMC1_BASE		0xfffb7800
 #define OMAP_MMC1_INT		INT_MMC
@@ -226,7 +226,14 @@ static void __init omap_init_mmc(void)
 	/* block 1 is always available and has just one pinout option */
 	mmc = &mmc_conf->mmc[0];
 	if (mmc->enabled) {
-		if (!cpu_is_omap24xx()) {
+		if (cpu_is_omap24xx()) {
+			omap_cfg_reg(H18_24XX_MMC_CMD);
+			omap_cfg_reg(H15_24XX_MMC_CLKI);
+			omap_cfg_reg(G19_24XX_MMC_CLKO);
+			omap_cfg_reg(F20_24XX_MMC_DAT0);
+			omap_cfg_reg(F19_24XX_MMC_DAT_DIR0);
+			omap_cfg_reg(G18_24XX_MMC_CMD_DIR);
+		} else {
 			omap_cfg_reg(MMC_CMD);
 			omap_cfg_reg(MMC_CLK);
 			omap_cfg_reg(MMC_DAT0);
@@ -237,7 +244,14 @@ static void __init omap_init_mmc(void)
 			}
 		}
 		if (mmc->wire4) {
-			if (!cpu_is_omap24xx()) {
+			if (cpu_is_omap24xx()) {
+				omap_cfg_reg(H14_24XX_MMC_DAT1);
+				omap_cfg_reg(E19_24XX_MMC_DAT2);
+				omap_cfg_reg(D19_24XX_MMC_DAT3);
+				omap_cfg_reg(E20_24XX_MMC_DAT_DIR1);
+				omap_cfg_reg(F18_24XX_MMC_DAT_DIR2);
+				omap_cfg_reg(E18_24XX_MMC_DAT_DIR3);
+			} else {
 				omap_cfg_reg(MMC_DAT1);
 				/* NOTE:  DAT2 can be on W10 (here) or M15
*/
 				if (!mmc->nomux)
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-
omap/irqs.h
index 42098d9..31a79a1 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -247,6 +247,7 @@
 #define INT_24XX_MCBSP2_IRQ_TX	62
 #define INT_24XX_MCBSP2_IRQ_RX	63
 #define INT_24XX_UART3_IRQ	74
+#define INT_24XX_MMC_IRQ	83
 
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-
omap/mux.h index 0dc24d4..eee8906 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -435,6 +435,20 @@ enum omap24xx_index {
 	K15_24XX_UART3_TX,
 	K14_24XX_UART3_RX,
 
+	/* MMC/SDIO */
+	G19_24XX_MMC_CLKO,
+	H18_24XX_MMC_CMD,
+	F20_24XX_MMC_DAT0,
+	H14_24XX_MMC_DAT1,
+	E19_24XX_MMC_DAT2,
+	D19_24XX_MMC_DAT3,
+	F19_24XX_MMC_DAT_DIR0,
+	E20_24XX_MMC_DAT_DIR1,
+	F18_24XX_MMC_DAT_DIR2,
+	E18_24XX_MMC_DAT_DIR3,
+	G18_24XX_MMC_CMD_DIR,
+	H15_24XX_MMC_CLKI,
+
 	/* Keypad GPIO*/
 	T19_24XX_KBR0,
 	R19_24XX_KBR1,
