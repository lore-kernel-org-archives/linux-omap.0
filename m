From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.18-omap-git] omap2 fullspeed usb 1/2
Date: Fri, 20 Oct 2006 12:50:25 -0700
Message-ID: <200610201250.25276.david-b@pacbell.net>
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

[PATCH] Initial USB support on OMAP2

Initial full speed USB support on OMAP2 platform.
Remaining issues include:

    -	only usb0 port tested (not usb1, usb2)
    -	only peripheral/gadget controller tested (not ohci, otg)
    -	UDC DMA is not working
    -	clocks are not turned off

Board support is in separate patches.

Also minor omap_udc updates:  whitespace fixes, syncing with a few
changes from upstream, warning removal.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
-------
NOTE:  this is just a cleaned up version of the code from Kyungmin,
I don't have it behaving yet on H4, and didn't re-test on e.g. OSK.

Index: h4/include/asm-arm/arch-omap/irqs.h
===================================================================
--- h4.orig/include/asm-arm/arch-omap/irqs.h	2006-10-18 01:40:22.000000000 -0700
+++ h4/include/asm-arm/arch-omap/irqs.h	2006-10-18 01:41:51.000000000 -0700
@@ -269,6 +269,12 @@
 #define INT_24XX_UART1_IRQ	72
 #define INT_24XX_UART2_IRQ	73
 #define INT_24XX_UART3_IRQ	74
+#define INT_24XX_USB_IRQ_GEN	75
+#define INT_24XX_USB_IRQ_NISO	76
+#define INT_24XX_USB_IRQ_ISO	77
+#define INT_24XX_USB_IRQ_HGEN	78
+#define INT_24XX_USB_IRQ_HSOF	79
+#define INT_24XX_USB_IRQ_OTG	80
 #define INT_24XX_MMC_IRQ	83
 
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
Index: h4/include/asm-arm/arch-omap/usb.h
===================================================================
--- h4.orig/include/asm-arm/arch-omap/usb.h	2006-10-18 01:40:22.000000000 -0700
+++ h4/include/asm-arm/arch-omap/usb.h	2006-10-18 01:41:51.000000000 -0700
@@ -7,9 +7,27 @@
 
 /*-------------------------------------------------------------------------*/
 
-#define OTG_BASE			0xfffb0400
-#define UDC_BASE			0xfffb4000
-#define OMAP_OHCI_BASE			0xfffba000
+#define OMAP1_OTG_BASE			0xfffb0400
+#define OMAP1_UDC_BASE			0xfffb4000
+#define OMAP1_OHCI_BASE			0xfffba000
+
+#define OMAP2_OHCI_BASE			0x4805e000
+#define OMAP2_UDC_BASE			0x4805e200
+#define OMAP2_OTG_BASE			0x4805e300
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
 
 /*-------------------------------------------------------------------------*/
 
@@ -28,6 +46,7 @@
 #	define	 HST_IDLE_EN		(1 << 14)
 #	define	 DEV_IDLE_EN		(1 << 13)
 #	define	 OTG_RESET_DONE		(1 << 2)
+#	define	 OTG_SOFT_RESET		(1 << 1)
 #define OTG_SYSCON_2_REG		OTG_REG32(0x08)
 #	define	 OTG_EN			(1 << 31)
 #	define	 USBX_SYNCHRO		(1 << 30)
@@ -103,6 +122,7 @@
 
 /*-------------------------------------------------------------------------*/
 
+/* OMAP1 */
 #define	USB_TRANSCEIVER_CTRL_REG	__REG32(0xfffe1000 + 0x0064)
 #	define	CONF_USB2_UNI_R		(1 << 8)
 #	define	CONF_USB1_UNI_R		(1 << 7)
@@ -111,7 +131,17 @@
 #	define	CONF_USB_PWRDN_DM_R	(1 << 2)
 #	define	CONF_USB_PWRDN_DP_R	(1 << 1)
 
-
-
+/* OMAP2 */
+#define	CONTROL_DEVCONF_REG		__REG32(L4_24XX_BASE + 0x0274)
+#	define	USB_UNIDIR			0x0
+#	define	USB_UNIDIR_TLL			0x1
+#	define	USB_BIDIR			0x2
+#	define	USB_BIDIR_TLL			0x3
+#	define	USBT0WRMODEI(x)		((x) << 22)
+#	define	USBT1WRMODEI(x)		((x) << 20)
+#	define	USBT2WRMODEI(x)		((x) << 18)
+#	define	USBT2TLL5PI		(1 << 17)
+#	define	USB0PUENACTLOI		(1 << 16)
+#	define	USBSTANDBYCTRL		(1 << 15)
 
 #endif	/* __ASM_ARCH_OMAP_USB_H */
Index: h4/arch/arm/mach-omap2/Kconfig
===================================================================
--- h4.orig/arch/arm/mach-omap2/Kconfig	2006-10-18 01:41:50.000000000 -0700
+++ h4/arch/arm/mach-omap2/Kconfig	2006-10-18 01:41:51.000000000 -0700
@@ -9,6 +9,7 @@ config ARCH_OMAP2420
 	bool "OMAP2420 support"
 	depends on ARCH_OMAP24XX
 	select OMAP_DM_TIMER
+	select ARCH_OMAP_OTG
 
 comment "OMAP Board Type"
 	depends on ARCH_OMAP2
Index: h4/arch/arm/plat-omap/usb.c
===================================================================
--- h4.orig/arch/arm/plat-omap/usb.c	2006-10-18 01:40:22.000000000 -0700
+++ h4/arch/arm/plat-omap/usb.c	2006-10-18 01:41:51.000000000 -0700
@@ -37,9 +37,27 @@
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
+#define INT_USB_IRQ_OTG		INT_24XX_USB_IRQ_OTG
+
+#endif
+
+
 /* These routines should handle the standard chip-specific modes
  * for usb0/1/2 ports, covering basic mux and transceiver setup.
- * Call omap_usb_init() once, from INIT_MACHINE().
  *
  * Some board-*.c files will need to set up additional mux options,
  * like for suspend handling, vbus sensing, GPIOs, and the D+ pullup.
@@ -96,19 +116,26 @@ static u32 __init omap_usb0_init(unsigne
 {
 	u32	syscon1 = 0;
 
+	if (cpu_is_omap24xx())
+		CONTROL_DEVCONF_REG &= ~USBT0WRMODEI(USB_BIDIR_TLL);
+
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
 
-	/* internal transceiver */
-	if (nwires == 2) {
+	/* internal transceiver (unavailable on 17xx, 24xx) */
+	if (!cpu_class_is_omap2() && nwires == 2) {
 		// omap_cfg_reg(P9_USB_DP);
 		// omap_cfg_reg(R8_USB_DM);
 
@@ -136,29 +163,50 @@ static u32 __init omap_usb0_init(unsigne
 		return 0;
 	}
 
-	omap_cfg_reg(V6_USB0_TXD);
-	omap_cfg_reg(W9_USB0_TXEN);
-	omap_cfg_reg(W5_USB0_SE0);
-
-	/* NOTE:  SPEED and SUSP aren't configured here */
-
-	if (nwires != 3)
-		omap_cfg_reg(Y5_USB0_RCV);
-	if (nwires != 6)
+	if (cpu_is_omap24xx()) {
+		omap_cfg_reg(K18_24XX_USB0_DAT);
+		omap_cfg_reg(K19_24XX_USB0_TXEN);
+		omap_cfg_reg(J14_24XX_USB0_SE0);
+		if (nwires != 3)
+			omap_cfg_reg(J18_24XX_USB0_RCV);
+	} else {
+		omap_cfg_reg(V6_USB0_TXD);
+		omap_cfg_reg(W9_USB0_TXEN);
+		omap_cfg_reg(W5_USB0_SE0);
+		if (nwires != 3)
+			omap_cfg_reg(Y5_USB0_RCV);
+	}
+
+	/* NOTE:  SPEED and SUSP aren't configured here.  OTG hosts
+	 * may be able to use I2C requests to set those bits along
+	 * with VBUS switching and overcurrent detction.
+	 */
+
+	if (cpu_class_is_omap1() && nwires != 6)
 		USB_TRANSCEIVER_CTRL_REG &= ~CONF_USB2_UNI_R;
 
 	switch (nwires) {
 	case 3:
 		syscon1 = 2;
+		if (cpu_is_omap24xx())
+			CONTROL_DEVCONF_REG |= USBT0WRMODEI(USB_BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
+		if (cpu_is_omap24xx())
+			CONTROL_DEVCONF_REG |= USBT0WRMODEI(USB_BIDIR);
 		break;
 	case 6:
 		syscon1 = 3;
-		omap_cfg_reg(AA9_USB0_VP);
-		omap_cfg_reg(R9_USB0_VM);
-		USB_TRANSCEIVER_CTRL_REG |= CONF_USB2_UNI_R;
+		if (cpu_is_omap24xx()) {
+			omap_cfg_reg(J19_24XX_USB0_VP);
+			omap_cfg_reg(K20_24XX_USB0_VM);
+			CONTROL_DEVCONF_REG |= USBT0WRMODEI(USB_UNIDIR);
+		} else {
+			omap_cfg_reg(AA9_USB0_VP);
+			omap_cfg_reg(R9_USB0_VM);
+			USB_TRANSCEIVER_CTRL_REG |= CONF_USB2_UNI_R;
+		}
 		break;
 	default:
 		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
@@ -171,14 +219,22 @@ static u32 __init omap_usb1_init(unsigne
 {
 	u32	syscon1 = 0;
 
-	if (nwires != 6 && !cpu_is_omap15xx())
+	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6)
 		USB_TRANSCEIVER_CTRL_REG &= ~CONF_USB1_UNI_R;
+	if (cpu_is_omap24xx())
+		CONTROL_DEVCONF_REG &= ~USBT1WRMODEI(USB_BIDIR_TLL);
+
 	if (nwires == 0)
 		return 0;
 
 	/* external transceiver */
-	omap_cfg_reg(USB1_TXD);
-	omap_cfg_reg(USB1_TXEN);
+	if (cpu_class_is_omap1()) {
+		omap_cfg_reg(USB1_TXD);
+		omap_cfg_reg(USB1_TXEN);
+		if (nwires != 3)
+			omap_cfg_reg(USB1_RCV);
+	}
+
 	if (cpu_is_omap15xx()) {
 		omap_cfg_reg(USB1_SEO);
 		omap_cfg_reg(USB1_SPEED);
@@ -190,20 +246,38 @@ static u32 __init omap_usb1_init(unsigne
 	} else if (cpu_is_omap1710()) {
 		omap_cfg_reg(R13_1710_USB1_SE0);
 		// SUSP
+	} else if (cpu_is_omap24xx()) {
+		/* NOTE:  board-specific code must set up pin muxing for usb1,
+		 * since each signal could come out on either of two balls.
+		 */
 	} else {
-		pr_debug("usb unrecognized\n");
+		pr_debug("usb%d cpu unrecognized\n", 1);
+		return 0;
 	}
-	if (nwires != 3)
-		omap_cfg_reg(USB1_RCV);
 
 	switch (nwires) {
+	case 2:
+		if (!cpu_is_omap24xx())
+			goto bad;
+		/* NOTE: board-specific code must override this setting if
+		 * this TLL link is not using DP/DM
+		 */
+		syscon1 = 1;
+		CONTROL_DEVCONF_REG |= USBT1WRMODEI(USB_BIDIR_TLL);
+		break;
 	case 3:
 		syscon1 = 2;
+		if (cpu_is_omap24xx())
+			CONTROL_DEVCONF_REG |= USBT1WRMODEI(USB_BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
+		if (cpu_is_omap24xx())
+			CONTROL_DEVCONF_REG |= USBT1WRMODEI(USB_BIDIR);
 		break;
 	case 6:
+		if (cpu_is_omap24xx())
+			goto bad;
 		syscon1 = 3;
 		omap_cfg_reg(USB1_VP);
 		omap_cfg_reg(USB1_VM);
@@ -211,6 +285,7 @@ static u32 __init omap_usb1_init(unsigne
 			USB_TRANSCEIVER_CTRL_REG |= CONF_USB1_UNI_R;
 		break;
 	default:
+bad:
 		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
 			1, nwires);
 	}
@@ -221,10 +296,17 @@ static u32 __init omap_usb2_init(unsigne
 {
 	u32	syscon1 = 0;
 
-	/* NOTE erratum: must leave USB2_UNI_R set if usb0 in use */
+	if (cpu_is_omap24xx()) {
+		CONTROL_DEVCONF_REG &= ~(USBT2WRMODEI(USB_BIDIR_TLL)
+					| USBT2TLL5PI);
+		alt_pingroup = 0;
+	}
+
+	/* NOTE omap1 erratum: must leave USB2_UNI_R set if usb0 in use */
 	if (alt_pingroup || nwires == 0)
 		return 0;
-	if (nwires != 6 && !cpu_is_omap15xx())
+
+	if (cpu_class_is_omap1() && !cpu_is_omap15xx() && nwires != 6)
 		USB_TRANSCEIVER_CTRL_REG &= ~CONF_USB2_UNI_R;
 
 	/* external transceiver */
@@ -242,19 +324,54 @@ static u32 __init omap_usb2_init(unsigne
 		if (nwires != 3)
 			omap_cfg_reg(Y5_USB2_RCV);
 		// FIXME omap_cfg_reg(USB2_SPEED);
+	} else if (cpu_is_omap24xx()) {
+		omap_cfg_reg(Y11_24XX_USB2_DAT);
+		omap_cfg_reg(AA10_24XX_USB2_SE0);
+		if (nwires > 2)
+			omap_cfg_reg(AA12_24XX_USB2_TXEN);
+		if (nwires > 3)
+			omap_cfg_reg(AA6_24XX_USB2_RCV);
 	} else {
-		pr_debug("usb unrecognized\n");
+		pr_debug("usb%d cpu unrecognized\n", 1);
+		return 0;
 	}
-	// omap_cfg_reg(USB2_SUSP);
+	// if (cpu_class_is_omap1()) omap_cfg_reg(USB2_SUSP);
 
 	switch (nwires) {
+	case 2:
+		if (!cpu_is_omap24xx())
+			goto bad;
+		/* NOTE: board-specific code must override this setting if
+		 * this TLL link is not using DP/DM
+		 */
+		syscon1 = 1;
+		CONTROL_DEVCONF_REG |= USBT2WRMODEI(USB_BIDIR_TLL);
+		break;
 	case 3:
 		syscon1 = 2;
+		if (cpu_is_omap24xx())
+			CONTROL_DEVCONF_REG |= USBT2WRMODEI(USB_BIDIR);
 		break;
 	case 4:
 		syscon1 = 1;
+		if (cpu_is_omap24xx())
+			CONTROL_DEVCONF_REG |= USBT2WRMODEI(USB_BIDIR);
+		break;
+	case 5:
+		if (!cpu_is_omap24xx())
+			goto bad;
+		omap_cfg_reg(AA4_24XX_USB2_TLLSE0);
+		/* NOTE: board-specific code must override this setting if
+		 * this TLL link is not using DP/DM.  Something must also
+		 * set up OTG_SYSCON2.HMC_TLL{ATTACH,SPEED}
+		 */
+		syscon1 = 3;
+		CONTROL_DEVCONF_REG |= USBT2WRMODEI(USB_UNIDIR_TLL)
+					| USBT2TLL5PI;
 		break;
 	case 6:
+		if (cpu_is_omap24xx())
+			goto bad;
 		syscon1 = 3;
 		if (cpu_is_omap15xx()) {
 			omap_cfg_reg(USB2_VP);
@@ -266,6 +383,7 @@ static u32 __init omap_usb2_init(unsigne
 		}
 		break;
 	default:
+bad:
 		printk(KERN_ERR "illegal usb%d %d-wire transceiver\n",
 			2, nwires);
 	}
@@ -294,13 +412,13 @@ static struct resource udc_resources[] =
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
@@ -329,11 +447,11 @@ static u64 ohci_dmamask = ~(u32)0;
 static struct resource ohci_resources[] = {
 	{
 		.start	= OMAP_OHCI_BASE,
-		.end	= OMAP_OHCI_BASE + 4096 - 1,
+		.end	= OMAP_OHCI_BASE + 0xff,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= INT_USB_HHC_1,
+		.start	= INT_USB_IRQ_HGEN,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -361,7 +479,7 @@ static struct resource otg_resources[] =
 		.end		= OTG_BASE + 0xff,
 		.flags		= IORESOURCE_MEM,
 	}, {
-		.start		= IH2_BASE + 8,
+		.start		= INT_USB_IRQ_OTG,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -385,7 +503,7 @@ static struct platform_device otg_device
 
 
 // FIXME correct answer depends on hmc_mode,
-// as does any nonzero value for config->otg port number
+// as does (on omap1) any nonzero value for config->otg port number
 #ifdef	CONFIG_USB_GADGET_OMAP
 #define	is_usb0_device(config)	1
 #else
@@ -426,12 +544,13 @@ omap_otg_init(struct omap_usb_config *co
 	if (config->otg)
 		syscon |= OTG_EN;
 #endif
-	pr_debug("USB_TRANSCEIVER_CTRL_REG = %03x\n", USB_TRANSCEIVER_CTRL_REG);
+	if (cpu_class_is_omap1())
+		pr_debug("USB_TRANSCEIVER_CTRL_REG = %03x\n", USB_TRANSCEIVER_CTRL_REG);
 	pr_debug("OTG_SYSCON_2_REG = %08x\n", syscon);
 	OTG_SYSCON_2_REG = syscon;
 
 	printk("USB: hmc %d", config->hmc_mode);
-	if (alt_pingroup)
+	if (!alt_pingroup)
 		printk(", usb2 alt %d wires", config->pins[2]);
 	else if (config->pins[0])
 		printk(", usb0 %d wires%s", config->pins[0],
@@ -444,10 +563,12 @@ omap_otg_init(struct omap_usb_config *co
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
 
@@ -585,7 +706,7 @@ omap_usb_init(void)
 	}
 	platform_data = *config;
 
-	if (cpu_is_omap730() || cpu_is_omap16xx())
+	if (cpu_is_omap730() || cpu_is_omap16xx() || cpu_is_omap24xx())
 		omap_otg_init(&platform_data);
 	else if (cpu_is_omap15xx())
 		omap_1510_usb_init(&platform_data);
Index: h4/drivers/usb/gadget/omap_udc.c
===================================================================
--- h4.orig/drivers/usb/gadget/omap_udc.c	2006-10-18 01:40:22.000000000 -0700
+++ h4/drivers/usb/gadget/omap_udc.c	2006-10-18 01:41:51.000000000 -0700
@@ -61,6 +61,11 @@
 /* bulk DMA seems to be behaving for both IN and OUT */
 #define	USE_DMA
 
+/* FIXME: OMAP2 currently has some problem in DMA mode */
+#ifdef CONFIG_ARCH_OMAP2
+#undef USE_DMA
+#endif
+
 /* ISO too */
 #define	USE_ISO
 
@@ -100,7 +105,7 @@ static unsigned fifo_mode = 0;
  * boot parameter "omap_udc:fifo_mode=42"
  */
 module_param (fifo_mode, uint, 0);
-MODULE_PARM_DESC (fifo_mode, "endpoint setup (0 == default)");
+MODULE_PARM_DESC (fifo_mode, "endpoint configuration");
 
 #ifdef	USE_DMA
 static unsigned use_dma = 1;
@@ -123,7 +128,7 @@ static const char driver_desc [] = DRIVE
 /*-------------------------------------------------------------------------*/
 
 /* there's a notion of "current endpoint" for modifying endpoint
- * state, and PIO access to its FIFO.  
+ * state, and PIO access to its FIFO.
  */
 
 static void use_ep(struct omap_ep *ep, u16 select)
@@ -392,7 +397,7 @@ done(struct omap_ep *ep, struct omap_req
 #define FIFO_EMPTY	(UDC_NON_ISO_FIFO_EMPTY | UDC_ISO_FIFO_EMPTY)
 #define FIFO_UNREADABLE (UDC_EP_HALTED | FIFO_EMPTY)
 
-static inline int 
+static inline int
 write_packet(u8 *buf, struct omap_req *req, unsigned max)
 {
 	unsigned	len;
@@ -457,7 +462,7 @@ static int write_fifo(struct omap_ep *ep
 	return is_last;
 }
 
-static inline int 
+static inline int
 read_packet(u8 *buf, struct omap_req *req, unsigned avail)
 {
 	unsigned	len;
@@ -625,7 +630,7 @@ static void next_in_dma(struct omap_ep *
 	} else {
 		length = min(length / ep->maxpacket,
 				(unsigned) UDC_TXN_TSC + 1);
- 		txdma_ctrl = length;
+		txdma_ctrl = length;
 		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
 				ep->ep.maxpacket >> 1, length, sync_mode,
 				0, 0);
@@ -1124,7 +1129,7 @@ static int omap_ep_dequeue(struct usb_ep
 		 */
 		dma_channel_release(ep);
 		dma_channel_claim(ep, channel);
-	} else 
+	} else
 		done(ep, req, -ECONNRESET);
 	spin_unlock_irqrestore(&ep->udc->lock, flags);
 	return 0;
@@ -1160,7 +1165,7 @@ static int omap_ep_set_halt(struct usb_e
 
 		/* IN endpoints must already be idle */
 		if ((ep->bEndpointAddress & USB_DIR_IN)
-				&& !list_empty(&ep->queue)) { 
+				&& !list_empty(&ep->queue)) {
 			status = -EAGAIN;
 			goto done;
 		}
@@ -1477,7 +1482,7 @@ static void ep0_irq(struct omap_udc *udc
 		}
 	}
 
-	/* IN/OUT packets mean we're in the DATA or STATUS stage.  
+	/* IN/OUT packets mean we're in the DATA or STATUS stage.
 	 * This driver uses only uses protocol stalls (ep0 never halts),
 	 * and if we got this far the gadget driver already had a
 	 * chance to stall.  Tries to be forgiving of host oddities.
@@ -1545,7 +1550,7 @@ static void ep0_irq(struct omap_udc *udc
 				} else if (stat == 0)
 					UDC_CTRL_REG = UDC_SET_FIFO_EN;
 				UDC_EP_NUM_REG = 0;
-				
+
 				/* activate status stage */
 				if (stat == 1) {
 					done(ep0, req, 0);
@@ -1917,10 +1922,8 @@ static void pio_out_timer(unsigned long 
 			UDC_EP_NUM_REG = ep->bEndpointAddress;
 			UDC_CTRL_REG = UDC_SET_FIFO_EN;
 			ep->ackwait = 1 + ep->double_buf;
-		}
-		else {
-		    deselect_ep();
-		}
+		} else
+			deselect_ep();
 	}
 	mod_timer(&ep->timer, PIO_OUT_TIMEOUT);
 	spin_unlock_irqrestore(&ep->udc->lock, flags);
@@ -2069,6 +2072,16 @@ omap_udc_iso_irq(int irq, void *_dev, st
 
 /*-------------------------------------------------------------------------*/
 
+static inline int machine_needs_vbus_session(void)
+{
+	return (machine_is_omap_innovator()
+		|| machine_is_omap_osk()
+		|| machine_is_omap_apollon()
+#ifndef CONFIG_MACH_OMAP_H4_OTG
+		|| machine_is_omap_h4()
+#endif
+		);
+}
 
 int usb_gadget_register_driver (struct usb_gadget_driver *driver)
 {
@@ -2145,7 +2158,7 @@ int usb_gadget_register_driver (struct u
 	/* boards that don't have VBUS sensing can't autogate 48MHz;
 	 * can't enter deep sleep while a gadget driver is active.
 	 */
-	if (machine_is_omap_innovator() || machine_is_omap_osk())
+	if (machine_needs_vbus_session())
 		omap_vbus_session(&udc->gadget, 1);
 
 done:
@@ -2168,7 +2181,7 @@ int usb_gadget_unregister_driver (struct
 	if (udc->dc_clk != NULL)
 		omap_udc_enable_clock(1);
 
-	if (machine_is_omap_innovator() || machine_is_omap_osk())
+	if (machine_needs_vbus_session())
 		omap_vbus_session(&udc->gadget, 0);
 
 	if (udc->transceiver)
@@ -2268,7 +2281,7 @@ static char *trx_mode(unsigned m, int en
 	case 0:		return enabled ? "*6wire" : "unused";
 	case 1:		return "4wire";
 	case 2:		return "3wire";
-	case 3: 	return "6wire";
+	case 3:		return "6wire";
 	default:	return "unknown";
 	}
 }
@@ -2277,11 +2290,18 @@ static int proc_otg_show(struct seq_file
 {
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
+		ctrl_name = "tranceiver_ctrl";
+		trans = USB_TRANSCEIVER_CTRL_REG;
+	}
+	seq_printf(s, "\nOTG rev %d.%d, %s %05x\n",
+		tmp >> 4, tmp & 0xf, ctrl_name, trans);
 	tmp = OTG_SYSCON_1_REG;
 	seq_printf(s, "otg_syscon1 %08x usb2 %s, usb1 %s, usb0 %s,"
 			FOURBITS "\n", tmp,
@@ -2356,7 +2376,7 @@ static int proc_udc_show(struct seq_file
 		driver_desc,
 		use_dma ?  " (dma)" : "");
 
-	tmp = UDC_REV_REG & 0xff; 
+	tmp = UDC_REV_REG & 0xff;
 	seq_printf(s,
 		"UDC rev %d.%d, fifo mode %d, gadget %s\n"
 		"hmc %d, transceiver %s\n",
@@ -2364,11 +2384,16 @@ static int proc_udc_show(struct seq_file
 		fifo_mode,
 		udc->driver ? udc->driver->driver.name : "(none)",
 		HMC,
-		udc->transceiver ? udc->transceiver->label : "(none)");
-	seq_printf(s, "ULPD control %04x req %04x status %04x\n",
-		__REG16(ULPD_CLOCK_CTRL),
-		__REG16(ULPD_SOFT_REQ),
-		__REG16(ULPD_STATUS_REQ));
+		udc->transceiver
+			? udc->transceiver->label
+			: ((cpu_is_omap1710() || cpu_is_omap24xx())
+				? "external" : "(none)"));
+	if (cpu_class_is_omap1()) {
+		seq_printf(s, "ULPD control %04x req %04x status %04x\n",
+			__REG16(ULPD_CLOCK_CTRL),
+			__REG16(ULPD_SOFT_REQ),
+			__REG16(ULPD_STATUS_REQ));
+	}
 
 	/* OTG controller registers */
 	if (!cpu_is_omap15xx())
@@ -2484,7 +2509,7 @@ static int proc_udc_open(struct inode *i
 	return single_open(file, proc_udc_show, NULL);
 }
 
-static struct file_operations proc_ops = {
+static const struct file_operations proc_ops = {
 	.open		= proc_udc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -2553,9 +2578,11 @@ omap_ep_setup(char *name, u8 addr, u8 ty
 		dbuf = 1;
 	} else {
 		/* double-buffering "not supported" on 15xx,
-		 * and ignored for PIO-IN on 16xx
+		 * and ignored for PIO-IN on newer chips
+		 * (for more reliable behavior)
 		 */
-		if (!use_dma || cpu_is_omap15xx())
+		if ((!use_dma && (addr & USB_DIR_IN))
+				|| cpu_is_omap15xx())
 			dbuf = 0;
 
 		switch (maxp) {
@@ -2598,7 +2625,7 @@ omap_ep_setup(char *name, u8 addr, u8 ty
 	ep->bEndpointAddress = addr;
 	ep->bmAttributes = type;
 	ep->double_buf = dbuf;
-	ep->udc = udc; 
+	ep->udc = udc;
 
 	ep->ep.name = ep->name;
 	ep->ep.ops = &omap_ep_ops;
@@ -2762,7 +2789,7 @@ static int __init omap_udc_probe(struct 
 	struct clk		*hhc_clk;
 
 	/* NOTE:  "knows" the order of the resources! */
-	if (!request_mem_region(pdev->resource[0].start, 
+	if (!request_mem_region(pdev->resource[0].start,
 			pdev->resource[0].end - pdev->resource[0].start + 1,
 			driver_name)) {
 		DBG("request_mem_region failed\n");
@@ -2779,6 +2806,16 @@ static int __init omap_udc_probe(struct 
 		udelay(100);
 	}
 
+	if (cpu_is_omap24xx()) {
+		dc_clk = clk_get(&pdev->dev, "usb_fck");
+		hhc_clk = clk_get(&pdev->dev, "usb_l4_ick");
+		BUG_ON(IS_ERR(dc_clk) || IS_ERR(hhc_clk));
+		/* can't use omap_udc_enable_clock yet */
+		clk_enable(dc_clk);
+		clk_enable(hhc_clk);
+		udelay(100);
+	}
+
 	INFO("OMAP UDC rev %d.%d%s\n",
 		UDC_REV_REG >> 4, UDC_REV_REG & 0xf,
 		config->otg ? ", Mini-AB" : "");
@@ -2817,6 +2854,15 @@ static int __init omap_udc_probe(struct 
 		}
 
 		hmc = HMC_1610;
+
+		if (cpu_is_omap24xx()) {
+			/* this could be transceiverless in one of the
+			 * "we don't need to know" modes.
+			 */
+			type = "external";
+			goto known;
+		}
+
 		switch (hmc) {
 		case 0:			/* POWERUP DEFAULT == 0 */
 		case 4:
@@ -2855,6 +2901,7 @@ bad_on_1710:
 			goto cleanup0;
 		}
 	}
+known:
 	INFO("hmc mode %d, %s transceiver\n", hmc, type);
 
 	/* a "gadget" abstracts/virtualizes the controller */
@@ -2879,8 +2926,8 @@ bad_on_1710:
 	status = request_irq(pdev->resource[1].start, omap_udc_irq,
 			IRQF_SAMPLE_RANDOM, driver_name, udc);
 	if (status != 0) {
-		ERR( "can't get irq %ld, err %d\n",
-			pdev->resource[1].start, status);
+		ERR("can't get irq %d, err %d\n",
+			(int) pdev->resource[1].start, status);
 		goto cleanup1;
 	}
 
@@ -2888,16 +2935,16 @@ bad_on_1710:
 	status = request_irq(pdev->resource[2].start, omap_udc_pio_irq,
 			IRQF_SAMPLE_RANDOM, "omap_udc pio", udc);
 	if (status != 0) {
-		ERR( "can't get irq %ld, err %d\n",
-			pdev->resource[2].start, status);
+		ERR("can't get irq %d, err %d\n",
+			(int) pdev->resource[2].start, status);
 		goto cleanup2;
 	}
 #ifdef	USE_ISO
 	status = request_irq(pdev->resource[3].start, omap_udc_iso_irq,
 			IRQF_DISABLED, "omap_udc iso", udc);
 	if (status != 0) {
-		ERR("can't get irq %ld, err %d\n",
-			pdev->resource[3].start, status);
+		ERR("can't get irq %d, err %d\n",
+			(int) pdev->resource[3].start, status);
 		goto cleanup3;
 	}
 #endif
@@ -2908,6 +2955,16 @@ bad_on_1710:
 		clk_disable(dc_clk);
 	}
 
+	if (cpu_is_omap24xx()) {
+		udc->dc_clk = dc_clk;
+		udc->hhc_clk = hhc_clk;
+		/* FIXME OMAP2 don't release hhc & dc clock */
+#if 0
+		clk_disable(hhc_clk);
+		clk_disable(dc_clk);
+#endif
+	}
+
 	create_proc_file();
 	device_add(&udc->gadget.dev);
 	return 0;
@@ -2928,12 +2985,12 @@ cleanup0:
 	if (xceiv)
 		put_device(xceiv->dev);
 
- 	if (cpu_is_omap16xx()) {
- 		clk_disable(hhc_clk);
- 		clk_disable(dc_clk);
- 		clk_put(hhc_clk);
- 		clk_put(dc_clk);
- 	}
+	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+		clk_disable(hhc_clk);
+		clk_disable(dc_clk);
+		clk_put(hhc_clk);
+		clk_put(dc_clk);
+	}
 
 	release_mem_region(pdev->resource[0].start,
 			pdev->resource[0].end - pdev->resource[0].start + 1);
@@ -2943,7 +3000,7 @@ cleanup0:
 
 static int __exit omap_udc_remove(struct platform_device *pdev)
 {
-	DECLARE_COMPLETION(done);
+	DECLARE_COMPLETION_ONSTACK(done);
 
 	if (!udc)
 		return -ENODEV;
@@ -2966,11 +3023,11 @@ static int __exit omap_udc_remove(struct
 	free_irq(pdev->resource[1].start, udc);
 
 	if (udc->dc_clk) {
- 		if (udc->clk_requested)
- 			omap_udc_enable_clock(0);
- 		clk_put(udc->hhc_clk);
- 		clk_put(udc->dc_clk);
- 	}
+		if (udc->clk_requested)
+			omap_udc_enable_clock(0);
+		clk_put(udc->hhc_clk);
+		clk_put(udc->dc_clk);
+	}
 
 	release_mem_region(pdev->resource[0].start,
 			pdev->resource[0].end - pdev->resource[0].start + 1);
