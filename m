From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] USB device support on OMAP2420
Date: Fri, 23 Jun 2006 19:27:24 +0900
Message-ID: <006a01c696af$9e3e15f0$c7a3580a@swcenter.sec.samsung.co.kr>
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

Hi,

Here's a patch for review.
With some tweak apollon board can work as USB device. (stall problem)
There's some problem releated with DMA. Now I just turned off the DMA.

And please ignore MMC parts

Regards
Kyungmin Park

--

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 417cfba..3c60e82 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -25,3 +25,4 @@ config MACH_OMAP_H4
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	select ARCH_OMAP_OTG
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
omap2/board-apollon.c
index 6c6ba17..b6bb322 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -166,14 +166,22 @@ static struct omap_uart_config apollon_u
 
 static struct omap_mmc_config apollon_mmc_config __initdata = {
 	.mmc [0] = {
-		.enabled 	= 0,
-		.wire4		= 0,
+		.enabled 	= 1,
+		.wire4		= 1,
 		.wp_pin		= -1,
 		.power_pin	= -1,
-		.switch_pin	= -1,
+		.switch_pin	= 37,
 	},
 };
 
+static struct omap_usb_config apollon_usb_config __initdata = {
+	.register_dev		= 1,
+	.hmc_mode		= 0x14,	// 0:dev 1: host1 2: disable
+	.rwc			= 1,
+
+	.pins[0]		= 6,
+};
+
 static struct omap_lcd_config apollon_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
@@ -181,6 +189,7 @@ static struct omap_lcd_config apollon_lc  static struct
omap_board_config_kernel apollon_config[] = {
 	{ OMAP_TAG_UART,	&apollon_uart_config },
 	{ OMAP_TAG_MMC,		&apollon_mmc_config },
+	{ OMAP_TAG_USB,		&apollon_usb_config },
 	{ OMAP_TAG_LCD,		&apollon_lcd_config },
 };
 
@@ -249,14 +258,49 @@ static void __init apollon_sw_init(void)
 		return;
 }
 
+static void __init apollon_usb_init(void) {
+	/* USB device */
+	/* DEVICE_SUSPEND */
+	omap_cfg_reg(P21_242X_GPIO12);
+	omap_set_gpio_direction(12, 0);		/* OUT */
+	omap_set_gpio_dataout(12, 0);
+
+	/* USB host */
+	/* HOST_SPEED */
+	omap_cfg_reg(L18_24XX_GPIO102);
+	omap_request_gpio(102);
+	omap_set_gpio_direction(102, 0);	/* OUT */
+	omap_set_gpio_dataout(102, 1);
+#ifdef __APOLLON_USE_ANOTHER_HOST_SPEED
+	omap_cfg_reg(K14_24XX_GPIO105);
+	omap_request_gpio(105);
+	omap_set_gpio_direction(105, 0);	/* OUT */
+	omap_set_gpio_dataout(105, 1);
+#endif
+	/* OVER_CUR */
+	omap_cfg_reg(L19_24XX_GPIO103);
+	omap_request_gpio(103);
+	omap_set_gpio_direction(103, 1);	/* IN */
+	/* PWR_EN */
+	omap_cfg_reg(K15_24XX_GPIO104);
+	omap_request_gpio(104);
+	omap_set_gpio_direction(104, 0);	/* OUT */
+	omap_set_gpio_dataout(104, 1);
+}
+
 static void __init omap_apollon_init(void)  {
 	apollon_led_init();
 	apollon_sw_init();
+	apollon_usb_init();
 
 	/* REVISIT: where's the correct place */
 	omap_cfg_reg(W19_24XX_SYS_NIRQ);
 
+	/* Use Interal loop-back in MMC/SDIO Module Input Clock selection */
+	CONTROL_DEVCONF |= (1 << 24);
+
 	/*
  	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on diff --git
a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h index
971743a..5a487b4 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -861,7 +861,7 @@ static struct clk usb_l4_ick = {	/* FS-U
 				CONFIG_PARTICIPANT,
 	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
 	.enable_bit	= 0,
-	.rate_offset = 25,
+	.rate_offset	= 25,
 	.recalc		= &omap2_clksel_recalc,
 };
 
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c index
c2c482c..09d9a8b 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -65,8 +65,23 @@ MUX_CFG_24XX("R14_24XX_MCBSP2_FSX",	0x12
 MUX_CFG_24XX("W15_24XX_MCBSP2_DR",	0x126,	1,	1,	0,	1)
 MUX_CFG_24XX("V15_24XX_MCBSP2_DX",	0x127,	1,	1,	0,	1)
 
+/* 24xx MMC */
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
 /* 24xx GPIO */
 MUX_CFG_24XX("M21_242X_GPIO11",		0x0c9,  3,      1,      1,
1)
+MUX_CFG_24XX("P21_242X_GPIO12",		0x0ca,	3,	0,	0,
1)
 MUX_CFG_24XX("AA10_242X_GPIO13",	0x0e5,  3,      0,      0,      1)
 MUX_CFG_24XX("AA6_242X_GPIO14",		0x0e6,  3,      0,      0,
1)
 MUX_CFG_24XX("AA4_242X_GPIO15",		0x0e7,  3,      0,      0,
1)
@@ -76,6 +91,10 @@ MUX_CFG_24XX("AA8_242X_GPIO58",		0x0ea, 
 MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,
1)
 MUX_CFG_24XX("W4__24XX_GPIO74",		0x0f2,  3,      0,      0,
1)
 MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,
1)
+MUX_CFG_24XX("L18_24XX_GPIO102",	0x116,	3,	0,	0,	1)
+MUX_CFG_24XX("L19_24XX_GPIO103",	0x117,	3,	0,	0,	1)
+MUX_CFG_24XX("K15_24XX_GPIO104",	0x118,	3,	0,	0,	1)
+MUX_CFG_24XX("K14_24XX_GPIO105",	0x119,	3,	0,	0,	1)
 MUX_CFG_24XX("V14_24XX_GPIO117",	0x128,	3,	1,	0,	1)
 
 /* 242x DBG GPIO */
@@ -125,6 +144,20 @@ MUX_CFG_24XX("B3__24XX_KBR5",		0x30,	3,

 MUX_CFG_24XX("AA4_24XX_KBC2",		0xe7,	3,	0,	0,	1)
 MUX_CFG_24XX("B13_24XX_KBC6",		0x110,	3,	0,	0,	1)
 
+/* 24xx USB */
+MUX_CFG_24XX("J20_24XX_USB0_PUEN",	0x11d,	0,	0,	0,	1)
+MUX_CFG_24XX("J19_24XX_USB0_VP",	0x11e,	0,	0,	0,	1)
+MUX_CFG_24XX("K20_24XX_USB0_VM",	0x11f,	0,	0,	0,	1)
+MUX_CFG_24XX("J18_24XX_USB0_RCV",	0x120,	0,	0,	0,	1)
+MUX_CFG_24XX("K19_24XX_USB0_TXEN",	0x121,	0,	0,	0,	1)
+MUX_CFG_24XX("J14_24XX_USB0_SE0",	0x122,	0,	0,	0,	1)
+MUX_CFG_24XX("K18_24XX_USB0_DAT",	0x123,	0,	0,	0,	1)
+
+MUX_CFG_24XX("V19_24XX_USB1_RCV",	0x0eb,	1,	0,	0,	1)
+MUX_CFG_24XX("W20_24XX_USB1_TXEN",	0x0ec,	1,	0,	0,	1)
+MUX_CFG_24XX("N14_24XX_USB1_SE0",	0x0ed,	1,	0,	0,	1)
+MUX_CFG_24XX("P15_24XX_USB1_DAT",	0x0ee,	1,	0,	0,	1)
+
 };
 
 int __init omap2_mux_init(void)
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
diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c index
00afc7a..3d48dad 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -38,6 +38,26 @@
 #include <asm/arch/usb.h>
 #include <asm/arch/board.h>
 
+#ifdef CONFIG_ARCH_OMAP1
+
+#define INT_USB_IRQ_GEN		IH2_BASE + 20
+#define INT_USB_IRQ_NISO	IH2_BASE + 30
+#define INT_USB_IRQ_ISO		IH2_BASE + 29
+#define INT_USB_IRQ_HGEN	INT_USB_HHC_1
+#define INT_USB_IRQ_OTG		IH2_BASE + 8
+
+#else
+
+#define INT_USB_IRQ_GEN		INT_24XX_USB_IRQ_GEN
+#define INT_USB_IRQ_NISO	INT_24XX_USB_IRQ_NISO
+#define INT_USB_IRQ_ISO		INT_24XX_USB_IRQ_ISO
+#define INT_USB_IRQ_HGEN	INT_24XX_USB_IRQ_HGEN
+#define INT_USB_IRQ_HSOF	INT_24XX_USB_IRQ_HSOF
+#define INT_USB_IRQ_OTG		INT_24XX_USB_IRQ_OTG
+
+#endif
+
+
 /* These routines should handle the standard chip-specific modes
  * for usb0/1/2 ports, covering basic mux and transceiver setup.
  * Call omap_usb_init() once, from INIT_MACHINE().
@@ -98,15 +118,19 @@ static u32 __init omap_usb0_init(unsigne
 	u32	syscon1 = 0;
 
 	if (nwires == 0) {
-		if (!cpu_is_omap15xx()) {
+		if (cpu_class_is_omap1() && !cpu_is_omap15xx()) {
 			/* pulldown D+/D- */
 			USB_TRANSCEIVER_CTRL_REG &= ~(3 << 1);
 		}
 		return 0;
 	}
 
-	if (is_device)
-		omap_cfg_reg(W4_USB_PUEN);
+	if (is_device) {
+		if (cpu_is_omap24xx())
+			omap_cfg_reg(J20_24XX_USB0_PUEN);
+		else
+			omap_cfg_reg(W4_USB_PUEN);
+	}
 
 	/* internal transceiver */
 	if (nwires == 2) {
@@ -124,9 +148,13 @@ static u32 __init omap_usb0_init(unsigne
 		 *  - OTG support on this port not yet written
 		 */
 
-		USB_TRANSCEIVER_CTRL_REG &= ~(7 << 4);
-		if (!is_device)
-			USB_TRANSCEIVER_CTRL_REG |= (3 << 1);
+		if (cpu_is_omap24xx()) {
+			OTG_OUTCTRL_REG |= USB0PDEN;
+		} else {
+			USB_TRANSCEIVER_CTRL_REG &= ~(7 << 4);
+			if (!is_device)
+				USB_TRANSCEIVER_CTRL_REG |= (3 << 1);
+		}
 
 		return 3 << 16;
 	}
@@ -137,29 +165,50 @@ static u32 __init omap_usb0_init(unsigne
 		return 0;
 	}
 
-	omap_cfg_reg(V6_USB0_TXD);
-	omap_cfg_reg(W9_USB0_TXEN);
-	omap_cfg_reg(W5_USB0_SE0);
-
+	if (cpu_is_omap24xx()) {
+		omap_cfg_reg(K18_24XX_USB0_DAT);
+		omap_cfg_reg(K19_24XX_USB0_TXEN);
+		omap_cfg_reg(J14_24XX_USB0_SE0);
+	} else {
+		omap_cfg_reg(V6_USB0_TXD);
+		omap_cfg_reg(W9_USB0_TXEN);
+		omap_cfg_reg(W5_USB0_SE0);
+	}
 	/* NOTE:  SPEED and SUSP aren't configured here */
 
-	if (nwires != 3)
-		omap_cfg_reg(Y5_USB0_RCV);
-	if (nwires != 6)
+	if (nwires != 3) {
+		if (cpu_is_omap24xx())
+			omap_cfg_reg(J18_24XX_USB0_RCV);
+		else
+			omap_cfg_reg(Y5_USB0_RCV);
+	}
+	if (cpu_is_omap24xx())
+		CONTROL_DEVCONF_REG &= ~USBT0WRMODEI(BIDIR_TTL);
+	else if (nwires != 6)
 		USB_TRANSCEIVER_CTRL_REG &= ~CONF_USB2_UNI_R;
 
 	switch (nwires) {
 	case 3:
 		syscon1 = 2;
+		if (cpu_is_omap24xx())
+			CONTROL_DEVCONF_REG |= USBT0WRMODEI(BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
+		if (cpu_is_omap24xx())
+			CONTROL_DEVCONF_REG |= USBT0WRMODEI(BIDIR);
 		break;
 	case 6:
 		syscon1 = 3;
-		omap_cfg_reg(AA9_USB0_VP);
-		omap_cfg_reg(R9_USB0_VM);
-		USB_TRANSCEIVER_CTRL_REG |= CONF_USB2_UNI_R;
+		if (cpu_is_omap24xx()) {
+			omap_cfg_reg(J19_24XX_USB0_VP);
+			omap_cfg_reg(K20_24XX_USB0_VM);
+			CONTROL_DEVCONF_REG |= USBT0WRMODEI(UNIDIR);
+		} else {
+			omap_cfg_reg(AA9_USB0_VP);
+			omap_cfg_reg(R9_USB0_VM);
+			USB_TRANSCEIVER_CTRL_REG |= CONF_USB2_UNI_R;
+		}
 		break;
 	default:
 		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n", @@ -
172,14 +221,22 @@ static u32 __init omap_usb1_init(unsigne  {
 	u32	syscon1 = 0;
 
-	if (nwires != 6 && !cpu_is_omap15xx())
+	if (cpu_is_omap24xx())
+		CONTROL_DEVCONF_REG &= ~USBT1WRMODEI(BIDIR_TTL);
+	else if (nwires != 6 && !cpu_is_omap15xx())
 		USB_TRANSCEIVER_CTRL_REG &= ~CONF_USB1_UNI_R;
 	if (nwires == 0)
 		return 0;
 
 	/* external transceiver */
-	omap_cfg_reg(USB1_TXD);
-	omap_cfg_reg(USB1_TXEN);
+	if (cpu_is_omap24xx()) {
+		omap_cfg_reg(P15_24XX_USB1_DAT);
+		omap_cfg_reg(W20_24XX_USB1_TXEN);
+	} else {
+		omap_cfg_reg(USB1_TXD);
+		omap_cfg_reg(USB1_TXEN);
+	}
+
 	if (cpu_is_omap15xx()) {
 		omap_cfg_reg(USB1_SEO);
 		omap_cfg_reg(USB1_SPEED);
@@ -191,25 +248,40 @@ static u32 __init omap_usb1_init(unsigne
 	} else if (cpu_is_omap1710()) {
 		omap_cfg_reg(R13_1710_USB1_SE0);
 		// SUSP
+	} else if (cpu_is_omap24xx()) {
+		omap_cfg_reg(N14_24XX_USB1_SE0);
+		// SUSP
 	} else {
 		pr_debug("usb unrecognized\n");
 	}
-	if (nwires != 3)
-		omap_cfg_reg(USB1_RCV);
+	if (nwires != 3) {
+		if (cpu_is_omap24xx())
+			omap_cfg_reg(V19_24XX_USB1_RCV);
+		else
+			omap_cfg_reg(USB1_RCV);
+	}
 
 	switch (nwires) {
 	case 3:
 		syscon1 = 2;
+		if (cpu_is_omap24xx())
+			CONTROL_DEVCONF_REG |= USBT1WRMODEI(BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
+		if (cpu_is_omap24xx())
+			CONTROL_DEVCONF_REG |= USBT1WRMODEI(BIDIR);
 		break;
 	case 6:
 		syscon1 = 3;
-		omap_cfg_reg(USB1_VP);
-		omap_cfg_reg(USB1_VM);
-		if (!cpu_is_omap15xx())
-			USB_TRANSCEIVER_CTRL_REG |= CONF_USB1_UNI_R;
+		if (cpu_is_omap24xx()) {
+			CONTROL_DEVCONF_REG |= USBT1WRMODEI(UNIDIR);
+		} else {
+			omap_cfg_reg(USB1_VP);
+			omap_cfg_reg(USB1_VM);
+			if (!cpu_is_omap15xx())
+				USB_TRANSCEIVER_CTRL_REG |= CONF_USB1_UNI_R;
+		}
 		break;
 	default:
 		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n", @@ -
222,6 +294,9 @@ static u32 __init omap_usb2_init(unsigne  {
 	u32	syscon1 = 0;
 
+	if (cpu_is_omap24xx())
+		return 0;
+
 	/* NOTE erratum: must leave USB2_UNI_R set if usb0 in use */
 	if (alt_pingroup || nwires == 0)
 		return 0;
@@ -295,13 +370,13 @@ static struct resource udc_resources[] =
 		.end		= UDC_BASE + 0xff,
 		.flags		= IORESOURCE_MEM,
 	}, {		/* general IRQ */
-		.start		= IH2_BASE + 20,
+		.start		= INT_USB_IRQ_GEN,
 		.flags		= IORESOURCE_IRQ,
 	}, {		/* PIO IRQ */
-		.start		= IH2_BASE + 30,
+		.start		= INT_USB_IRQ_NISO,
 		.flags		= IORESOURCE_IRQ,
 	}, {		/* SOF IRQ */
-		.start		= IH2_BASE + 29,
+		.start		= INT_USB_IRQ_ISO,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -334,9 +409,15 @@ static struct resource ohci_resources[] 
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= INT_USB_HHC_1,
+		.start	= INT_USB_IRQ_HGEN,
 		.flags	= IORESOURCE_IRQ,
 	},
+#ifdef CONFIG_ARCH_OMAP2
+	{
+		.start	= INT_USB_IRQ_HSOF,
+		.flags	= IORESOURCE_IRQ,
+	},
+#endif
 };
 
 static struct platform_device ohci_device = { @@ -362,7 +443,7 @@ static
struct resource otg_resources[] =
 		.end		= OTG_BASE + 0xff,
 		.flags		= IORESOURCE_MEM,
 	}, {
-		.start		= IH2_BASE + 8,
+		.start		= INT_USB_IRQ_OTG,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -423,16 +504,24 @@ omap_otg_init(struct omap_usb_config *co
 
 	syscon = config->hmc_mode;
 	syscon |= USBX_SYNCHRO | (4 << 16) /* B_ASE0_BRST */;
+
+#if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+	/* OMAP2 needs UHOST_EN to register host */
+	if (config->otg || config->register_host)
+                syscon |= UHOST_EN;
+#endif
+
 #ifdef	CONFIG_USB_OTG
 	if (config->otg)
 		syscon |= OTG_EN;
 #endif
-	pr_debug("USB_TRANSCEIVER_CTRL_REG = %03x\n",
USB_TRANSCEIVER_CTRL_REG);
+	if (cpu_class_is_omap1())
+		pr_debug("USB_TRANSCEIVER_CTRL_REG = %03x\n", 
+USB_TRANSCEIVER_CTRL_REG);
 	pr_debug("OTG_SYSCON_2_REG = %08x\n", syscon);
 	OTG_SYSCON_2_REG = syscon;
 
 	printk("USB: hmc %d", config->hmc_mode);
-	if (alt_pingroup)
+	if (!alt_pingroup)
 		printk(", usb2 alt %d wires", config->pins[2]);
 	else if (config->pins[0])
 		printk(", usb0 %d wires%s", config->pins[0], @@ -445,10
+534,12 @@ omap_otg_init(struct omap_usb_config *co
 		printk(", Mini-AB on usb%d", config->otg - 1);
 	printk("\n");
 
-	/* leave USB clocks/controllers off until needed */
-	ULPD_SOFT_REQ_REG &= ~SOFT_USB_CLK_REQ;
-	ULPD_CLOCK_CTRL_REG &= ~USB_MCLK_EN;
-	ULPD_CLOCK_CTRL_REG |= DIS_USB_PVCI_CLK;
+	if (cpu_class_is_omap1()) {
+		/* leave USB clocks/controllers off until needed */
+		ULPD_SOFT_REQ_REG &= ~SOFT_USB_CLK_REQ;
+		ULPD_CLOCK_CTRL_REG &= ~USB_MCLK_EN;
+		ULPD_CLOCK_CTRL_REG |= DIS_USB_PVCI_CLK;
+	}
 	syscon = OTG_SYSCON_1_REG;
 	syscon |= HST_IDLE_EN|DEV_IDLE_EN|OTG_IDLE_EN;
 
@@ -469,6 +560,8 @@ omap_otg_init(struct omap_usb_config *co
 		ohci_device.dev.platform_data = config;
 		if (cpu_is_omap730())
 			ohci_resources[1].start = INT_730_USB_HHC_1;
+		if (cpu_is_omap24xx())
+			ohci_resources[0].end = OMAP_OHCI_BASE + 0x200 - 1;
 		status = platform_device_register(&ohci_device);
 		if (status)
 			pr_debug("can't register OHCI device, %d\n",
status); @@ -586,7 +679,7 @@ omap_usb_init(void)
 	}
 	platform_data = *config;
 
-	if (cpu_is_omap730() || cpu_is_omap16xx())
+	if (cpu_is_omap730() || cpu_is_omap16xx() || cpu_is_omap24xx())
 		omap_otg_init(&platform_data);
 	else if (cpu_is_omap15xx())
 		omap_1510_usb_init(&platform_data);
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig index
e14a0a3..363b2ad 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -157,7 +157,7 @@ config USB_LH7A40X
 
 config USB_GADGET_OMAP
 	boolean "OMAP USB Device Controller"
-	depends on ARCH_OMAP1
+	depends on ARCH_OMAP
 	select ISP1301_OMAP if MACH_OMAP_H2 || MACH_OMAP_H3
 	help
 	   Many Texas Instruments OMAP processors have flexible full diff --
git a/drivers/usb/gadget/file_storage.c b/drivers/usb/gadget/file_storage.c
index 6f88747..3abca42 100644
--- a/drivers/usb/gadget/file_storage.c
+++ b/drivers/usb/gadget/file_storage.c
@@ -2490,7 +2490,13 @@ static int finish_reply(struct fsg_dev *
 				start_transfer(fsg, fsg->bulk_in, bh->inreq,
 						&bh->inreq_busy, &bh-
>state);
 				fsg->next_buffhd_to_fill = bh->next;
+				/* Note: should not halt for bad SCSI
commands
+				 * halts/stalls should only be used at the
USB
+				 * layer
+				 */
+#ifndef CONFIG_MACH_OMAP_APOLLON
 				rc = halt_bulk_in_endpoint(fsg);
+#endif
 			} else
 				rc = pad_with_zeros(fsg);
 		}
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 4b564bf..ea1f705 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -62,6 +62,11 @@
 /* bulk DMA seems to be behaving for both IN and OUT */
 #define	USE_DMA
 
+#ifdef CONFIG_ARCH_OMAP2
+/* FIXME: Now OMAP2 has some problem in DMA mode */ #undef USE_DMA 
+#endif
+
 /* ISO too */
 #define	USE_ISO
 
@@ -70,7 +75,6 @@
 
 #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
-
 /*
  * The OMAP UDC needs _very_ early endpoint setup:  before enabling the
  * D+ pullup to allow enumeration.  That's too early for the gadget @@ -
616,20 +620,25 @@ static void next_in_dma(struct omap_ep *
 	const int	sync_mode = cpu_is_omap15xx()
 				? OMAP_DMA_SYNC_FRAME
 				: OMAP_DMA_SYNC_ELEMENT;
+	int		dma_trigger = 0;
+
+	if (cpu_is_omap24xx())
+		dma_trigger = OMAP24XX_DMA_USB_W2FC_TX0 + ((ep->dma_channel
- 1) << 
+1);
 
 	/* measure length in either bytes or packets */
 	if ((cpu_is_omap16xx() && length <= UDC_TXN_TSC)
+			|| (cpu_is_omap24xx() && length <= ep->maxpacket)
 			|| (cpu_is_omap15xx() && length < ep->maxpacket)) {
 		txdma_ctrl = UDC_TXN_EOT | length;
 		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S8,
-				length, 1, sync_mode, 0, 0);
+				length, 1, sync_mode, dma_trigger, 0);
 	} else {
 		length = min(length / ep->maxpacket,
 				(unsigned) UDC_TXN_TSC + 1);
  		txdma_ctrl = length;
 		omap_set_dma_transfer_params(ep->lch,
OMAP_DMA_DATA_TYPE_S16,
 				ep->ep.maxpacket >> 1, length, sync_mode,
-				0, 0);
+				dma_trigger, 0);
 		length *= ep->maxpacket;
 	}
 	omap_set_dma_src_params(ep->lch, OMAP_DMA_PORT_EMIFF, @@ -668,11
+677,15 @@ static void finish_in_dma(struct omap_ep  static void
next_out_dma(struct omap_ep *ep, struct omap_req *req)  {
 	unsigned packets;
+	int dma_trigger = 0;
 
 	/* NOTE:  we filtered out "short reads" before, so we know
 	 * the buffer has only whole numbers of packets.
 	 */
 
+	if (cpu_is_omap24xx())
+		dma_trigger = OMAP24XX_DMA_USB_W2FC_RX0 + ((ep->dma_channel
- 1) << 
+1);
+
 	/* set up this DMA transfer, enable the fifo, start */
 	packets = (req->req.length - req->req.actual) / ep->ep.maxpacket;
 	packets = min(packets, (unsigned)UDC_RXN_TC + 1); @@ -680,7 +693,7
@@ static void next_out_dma(struct omap_ep 
 	omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
 			ep->ep.maxpacket >> 1, packets,
 			OMAP_DMA_SYNC_ELEMENT,
-			0, 0);
+			dma_trigger, 0);
 	omap_set_dma_dest_params(ep->lch, OMAP_DMA_PORT_EMIFF,
 		OMAP_DMA_AMODE_POST_INC, req->req.dma + req->req.actual,
 		0, 0);
@@ -788,6 +801,7 @@ static void dma_channel_claim(struct oma  {
 	u16	reg;
 	int	status, restart, is_in;
+	int	dma_channel;
 
 	is_in = ep->bEndpointAddress & USB_DIR_IN;
 	if (is_in)
@@ -814,14 +828,20 @@ static void dma_channel_claim(struct oma
 	ep->dma_channel = channel;
 
 	if (is_in) {
-		status = omap_request_dma(OMAP_DMA_USB_W2FC_TX0 - 1 +
channel,
+		if (cpu_is_omap24xx())
+			dma_channel = OMAP24XX_DMA_USB_W2FC_TX0 + ((channel
- 1) << 1);
+		else
+			dma_channel = OMAP_DMA_USB_W2FC_TX0 - 1 + channel;
+		status = omap_request_dma(dma_channel,
 			ep->ep.name, dma_error, ep, &ep->lch);
 		if (status == 0) {
 			UDC_TXDMA_CFG_REG = reg;
-			/* EMIFF */
+			/* EMIFF or SDRC */
+			if (cpu_class_is_omap1()) {
 			omap_set_dma_src_burst_mode(ep->lch,
 						OMAP_DMA_DATA_BURST_4);
 			omap_set_dma_src_data_pack(ep->lch, 1);
+			}
 			/* TIPB */
 			omap_set_dma_dest_params(ep->lch,
 				OMAP_DMA_PORT_TIPB,
@@ -830,7 +850,11 @@ static void dma_channel_claim(struct oma
 				0, 0);
 		}
 	} else {
-		status = omap_request_dma(OMAP_DMA_USB_W2FC_RX0 - 1 +
channel,
+		if (cpu_is_omap24xx())
+			dma_channel = OMAP24XX_DMA_USB_W2FC_RX0 + ((channel
- 1) << 1);
+		else
+			dma_channel = OMAP_DMA_USB_W2FC_RX0 - 1 + channel;
+		status = omap_request_dma(dma_channel,
 			ep->ep.name, dma_error, ep, &ep->lch);
 		if (status == 0) {
 			UDC_RXDMA_CFG_REG = reg;
@@ -840,10 +864,12 @@ static void dma_channel_claim(struct oma
 				OMAP_DMA_AMODE_CONSTANT,
 				(unsigned long)
io_v2p((u32)&UDC_DATA_DMA_REG),
 				0, 0);
-			/* EMIFF */
+			/* EMIFF or SDRC */
+			if (cpu_class_is_omap1()) {
 			omap_set_dma_dest_burst_mode(ep->lch,
 						OMAP_DMA_DATA_BURST_4);
 			omap_set_dma_dest_data_pack(ep->lch, 1);
+			}
 		}
 	}
 	if (status)
@@ -853,7 +879,7 @@ static void dma_channel_claim(struct oma
 		omap_disable_dma_irq(ep->lch, OMAP_DMA_BLOCK_IRQ);
 
 		/* channel type P: hw synch (fifo) */
-		if (!cpu_is_omap15xx())
+		if (cpu_class_is_omap1() && !cpu_is_omap15xx())
 			OMAP1_DMA_LCH_CTRL_REG(ep->lch) = 2;
 	}
 
@@ -1839,6 +1865,7 @@ static void devstate_irq(struct omap_udc
 		}
 		change &= ~UDC_SUS;
 	}
+
 	if (!cpu_is_omap15xx() && (change & OTG_FLAGS)) {
 		update_otg(udc);
 		change &= ~OTG_FLAGS;
@@ -2070,6 +2097,12 @@ omap_udc_iso_irq(int irq, void *_dev, st
 
 /*-------------------------------------------------------------------------
*/
 
+static inline int machine_needs_vbus_session(void) {
+	return (machine_is_omap_innovator()
+		|| machine_is_omap_osk()
+		|| machine_is_omap_apollon());
+}
 
 int usb_gadget_register_driver (struct usb_gadget_driver *driver)  { @@ -
2146,7 +2179,7 @@ int usb_gadget_register_driver (struct u
 	/* boards that don't have VBUS sensing can't autogate 48MHz;
 	 * can't enter deep sleep while a gadget driver is active.
 	 */
-	if (machine_is_omap_innovator() || machine_is_omap_osk())
+	if (machine_needs_vbus_session())
 		omap_vbus_session(&udc->gadget, 1);
 
 done:
@@ -2169,7 +2202,7 @@ int usb_gadget_unregister_driver (struct
 	if (udc->dc_clk != NULL)
 		omap_udc_enable_clock(1);
 
-	if (machine_is_omap_innovator() || machine_is_omap_osk())
+	if (machine_needs_vbus_session())
 		omap_vbus_session(&udc->gadget, 0);
 
 	if (udc->transceiver)
@@ -2278,11 +2311,18 @@ static int proc_otg_show(struct seq_file  {
 	u32		tmp;
 	u32		trans;
+	char		*ctrl_name;
 
 	tmp = OTG_REV_REG;
-	trans = USB_TRANSCEIVER_CTRL_REG;
-	seq_printf(s, "\nOTG rev %d.%d, transceiver_ctrl %05x\n",
-		tmp >> 4, tmp & 0xf, trans);
+	if (cpu_is_omap24xx()) {
+		ctrl_name = "control_devconf";
+		trans = CONTROL_DEVCONF_REG;
+	} else {
+		ctrl_name = "transceivcer_ctrl";
+		trans = USB_TRANSCEIVER_CTRL_REG;
+	}
+	seq_printf(s, "\nOTG rev %d.%d, %s %05x\n",
+		tmp >> 4, tmp & 0xf, ctrl_name, trans);
 	tmp = OTG_SYSCON_1_REG;
 	seq_printf(s, "otg_syscon1 %08x usb2 %s, usb1 %s, usb0 %s,"
 			FOURBITS "\n", tmp,
@@ -2366,10 +2406,11 @@ static int proc_udc_show(struct seq_file
 		udc->driver ? udc->driver->driver.name : "(none)",
 		HMC,
 		udc->transceiver ? udc->transceiver->label : "(none)");
-	seq_printf(s, "ULPD control %04x req %04x status %04x\n",
-		__REG16(ULPD_CLOCK_CTRL),
-		__REG16(ULPD_SOFT_REQ),
-		__REG16(ULPD_STATUS_REQ));
+	if (cpu_class_is_omap1())
+		seq_printf(s, "ULPD control %04x req %04x status %04x\n",
+			__REG16(ULPD_CLOCK_CTRL),
+			__REG16(ULPD_SOFT_REQ),
+			__REG16(ULPD_STATUS_REQ));
 
 	/* OTG controller registers */
 	if (!cpu_is_omap15xx())
@@ -2780,6 +2821,15 @@ static int __init omap_udc_probe(struct 
 		udelay(100);
 	}
 
+	if (cpu_is_omap24xx()) {
+		dc_clk = clk_get(&pdev->dev, "usb_fck");
+		hhc_clk = clk_get(&pdev->dev, "usb_l4_ick");
+		BUG_ON(IS_ERR(dc_clk) || IS_ERR(hhc_clk));
+		clk_enable(dc_clk);
+		clk_enable(hhc_clk);
+		udelay(100);
+	}
+
 	INFO("OMAP UDC rev %d.%d%s\n",
 		UDC_REV_REG >> 4, UDC_REV_REG & 0xf,
 		config->otg ? ", Mini-AB" : "");
@@ -2909,6 +2959,16 @@ bad_on_1710:
 		clk_disable(dc_clk);
 	}
 
+	if (cpu_is_omap24xx()) {
+		udc->dc_clk = dc_clk;
+		udc->hhc_clk = hhc_clk;
+		/* FIXME OMAP2 don't release hhc & dc clock */ #if 0
+		clk_disable(hhc_clk);
+		clk_disable(dc_clk);
+#endif
+	}
+
 	create_proc_file();
 	device_add(&udc->gadget.dev);
 	return 0;
@@ -2929,7 +2989,7 @@ cleanup0:
 	if (xceiv)
 		put_device(xceiv->dev);
 
- 	if (cpu_is_omap16xx()) {
+ 	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
  		clk_disable(hhc_clk);
  		clk_disable(dc_clk);
  		clk_put(hhc_clk);
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-
omap/irqs.h
index 2542495..f23481b 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -261,6 +261,13 @@
 #define INT_24XX_UART1_IRQ	72
 #define INT_24XX_UART2_IRQ	73
 #define INT_24XX_UART3_IRQ	74
+#define INT_24XX_USB_IRQ_GEN	75
+#define INT_24XX_USB_IRQ_NISO	76
+#define INT_24XX_USB_IRQ_ISO	77
+#define INT_24XX_USB_IRQ_HGEN	78
+#define INT_24XX_USB_IRQ_HSOF	79
+#define INT_24XX_USB_IRQ_OTG	80
+#define INT_24XX_MMC_IRQ	83
 
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-
omap/mux.h index 679869c..8489392 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -422,8 +422,23 @@ enum omap24xx_index {
 	W15_24XX_MCBSP2_DR,
 	V15_24XX_MCBSP2_DX,
 
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
 	/* 24xx GPIO */
 	M21_242X_GPIO11,
+	P21_242X_GPIO12,
 	AA10_242X_GPIO13,
 	AA6_242X_GPIO14,
 	AA4_242X_GPIO15,
@@ -433,6 +448,10 @@ enum omap24xx_index {
 	Y20_24XX_GPIO60,
 	W4__24XX_GPIO74,
 	M15_24XX_GPIO92,
+	L18_24XX_GPIO102,
+	L19_24XX_GPIO103,
+	K15_24XX_GPIO104,
+	K14_24XX_GPIO105,
 	V14_24XX_GPIO117,
 
 	/* 242x DBG GPIO */
@@ -480,6 +499,20 @@ enum omap24xx_index {
 	B3__24XX_KBR5,
 	AA4_24XX_KBC2,
 	B13_24XX_KBC6,
+
+	/* USB */
+	J20_24XX_USB0_PUEN,
+	J19_24XX_USB0_VP,
+	K20_24XX_USB0_VM,
+	J18_24XX_USB0_RCV,
+	K19_24XX_USB0_TXEN,
+	J14_24XX_USB0_SE0,
+	K18_24XX_USB0_DAT,
+
+	V19_24XX_USB1_RCV,
+	W20_24XX_USB1_TXEN,
+	N14_24XX_USB1_SE0,
+	P15_24XX_USB1_DAT,
 };
 
 #ifdef	CONFIG_OMAP_MUX
diff --git a/include/asm-arm/arch-omap/usb.h b/include/asm-arm/arch-
omap/usb.h index 054fb9a..64f470f 100644
--- a/include/asm-arm/arch-omap/usb.h
+++ b/include/asm-arm/arch-omap/usb.h
@@ -7,9 +7,29 @@
 
 /*-------------------------------------------------------------------------
*/
 
-#define OTG_BASE			0xfffb0400
-#define UDC_BASE			0xfffb4000
-#define OMAP_OHCI_BASE			0xfffba000
+
+#define OMAP1_OTG_BASE			0xfffb0400
+#define OMAP1_UDC_BASE			0xfffb4000
+#define OMAP1_OHCI_BASE			0xfffba000
+
+#define OMAP2_OHCI_BASE			0x4805E000
+#define OMAP2_UDC_BASE			0x4805E200
+#define OMAP2_OTG_BASE			0x4805E300
+
+#ifdef CONFIG_ARCH_OMAP1
+
+#define OTG_BASE			OMAP1_OTG_BASE
+#define UDC_BASE			OMAP1_UDC_BASE
+#define OMAP_OHCI_BASE			OMAP1_OHCI_BASE
+
+#else
+
+#define OTG_BASE			OMAP2_OTG_BASE
+#define UDC_BASE			OMAP2_UDC_BASE
+#define OMAP_OHCI_BASE			OMAP2_OHCI_BASE
+
+#endif
+
 
 /*-------------------------------------------------------------------------
*/
 
@@ -103,6 +123,7 @@
 
 /*-------------------------------------------------------------------------
*/
 
+/* OMAP1 */
 #define	USB_TRANSCEIVER_CTRL_REG	__REG32(0xfffe1000 + 0x0064)
 #	define	CONF_USB2_UNI_R		(1 << 8)
 #	define	CONF_USB1_UNI_R		(1 << 7)
@@ -111,7 +132,16 @@
 #	define	CONF_USB_PWRDN_DM_R	(1 << 2)
 #	define	CONF_USB_PWRDN_DP_R	(1 << 1)
 
-
-
+/* OMAP2 */
+#define CONTROL_DEVCONF_REG		__REG32(0x48000000 + 0x0274)
+#	define UNIDIR			0x0
+#	define UNIDIR_TTL		0x1
+#	define BIDIR			0x2
+#	define BIDIR_TTL		0x3
+#	define USBT0WRMODEI(x)		((x) << 22)
+#	define USBT1WRMODEI(x)		((x) << 20)
+#	define USBT2WRMODEI(x)		((x) << 18)
+#	define USB0PUENACTLOI		(1 << 16)
+#	define USBSTANDBYCTRLE		(1 << 15)
 
 #endif	/* __ASM_ARCH_OMAP_USB_H */
