From: "Girish. S. G." <girishsg@ti.com>
Subject: [PATCH 2/2] ARM:OMAP2: irda support 3430
Date: Thu, 3 Jul 2008 12:15:54 +0530 (IST)
Message-ID: <63619.192.168.10.89.1215067554.squirrel@dbdmail.itg.ti.com>
Reply-To: girishsg@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52394 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400AbYGCGqA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2008 02:46:00 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m636jstM012533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 01:45:59 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m636jqNN022350
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 01:45:53 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This adds board specific changes to support IrDA on 3430

Signed-off-by: Girish S G <girishsg@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |   34 +++++++
 arch/arm/mach-omap2/board-3430sdp.c     |  145 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.c               |   16 +++
 include/asm-arm/arch-omap/gpio.h        |    3
 include/asm-arm/arch-omap/mux.h         |    9 +
 5 files changed, 204 insertions(+), 3 deletions(-)

Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/configs/omap_3430sdp_defconfig	2008-07-02
18:54:15.000000000 +0530
+++ linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig	2008-07-02
18:56:41.000000000 +0530
@@ -392,7 +392,39 @@
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_CAN is not set
-# CONFIG_IRDA is not set
+CONFIG_IRDA=y
+
+#
+# IrDA protocols
+#
+# CONFIG_IRLAN is not set
+CONFIG_IRCOMM=y
+# CONFIG_IRDA_ULTRA is not set
+
+#
+# IrDA options
+#
+CONFIG_IRDA_CACHE_LAST_LSAP=y
+CONFIG_IRDA_FAST_RR=y
+# CONFIG_IRDA_DEBUG is not set
+
+#
+# Infrared-port device drivers
+#
+
+#
+# SIR device drivers
+#
+# CONFIG_IRTTY_SIR is not set
+
+#
+# Dongle support
+#
+
+#
+# FIR device drivers
+#
+CONFIG_OMAP_IR=y
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set

Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2008-07-02
18:54:15.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2008-07-02
18:56:41.000000000 +0530
@@ -32,6 +32,7 @@
 #include <asm/arch/mcspi.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
+#include <asm/arch/irda.h>
 #include <asm/arch/board.h>
 #include <asm/arch/usb-musb.h>
 #include <asm/arch/usb-ehci.h>
@@ -46,6 +47,9 @@

 #define	SDP3430_SMC91X_CS	3

+#define ENABLE_VAUX1_DEDICATED	0x03
+#define ENABLE_VAUX1_DEV_GRP	0x20
+
 #define ENABLE_VAUX3_DEDICATED	0x03
 #define ENABLE_VAUX3_DEV_GRP	0x20

@@ -70,6 +74,146 @@
 	.resource	= sdp3430_smc91x_resources,
 };

+/* IrDA
+ */
+#if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
+
+#define	IRDA_SD	164	/* gpio 164 */
+#define	IRDA_TX	166	/* gpio 166 */
+#define	IRDA_SD_PIN	T21_3430_GPIO164
+#define	IRDA_TX_PIN	V21_3430_GPIO166
+
+#define IRDA_VAUX_EN	1
+#define IRDA_VAUX_DIS	0
+
+/*
+ * This enable(1)/disable(0) the voltage for IrDA: uses twl4030 calls
+ */
+static int irda_vaux_control(int vaux_cntrl)
+{
+	int ret = 0;
+
+#ifdef CONFIG_TWL4030_CORE
+	/* check for return value of ldo_use: if success it returns 0 */
+	if (vaux_cntrl == IRDA_VAUX_EN) {
+		if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			ENABLE_VAUX1_DEDICATED, TWL4030_VAUX1_DEDICATED))
+			return -EIO;
+		if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			ENABLE_VAUX1_DEV_GRP, TWL4030_VAUX1_DEV_GRP))
+			return -EIO;
+	} else if (vaux_cntrl == IRDA_VAUX_DIS) {
+		if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			0x00, TWL4030_VAUX1_DEDICATED))
+			return -EIO;
+		if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			0x00, TWL4030_VAUX1_DEV_GRP))
+			return -EIO;
+	}
+#else
+	ret = -EIO;
+#endif
+	return ret;
+}
+
+static int select_irda(struct device *dev, int state)
+{
+	int err;
+	if (state == IR_SEL) {
+		err = irda_vaux_control(IRDA_VAUX_EN);
+		if (err != 0) {
+			printk(KERN_ERR "OMAP: IrDA vaux enable failed\n");
+			return err;
+		}
+
+		omap_cfg_reg(R21_3430_UART3_CTS_RCTX);
+		omap_cfg_reg(T21_3430_UART3_RTS_SD);
+		omap_cfg_reg(U21_3430_UART3_RX_IRRX);
+		omap_cfg_reg(V21_3430_UART3_TX_IRTX);
+
+		omap_request_gpio(IRDA_SD);
+		omap_request_gpio(IRDA_TX);
+		omap_cfg_reg(IRDA_SD_PIN);
+		omap_set_gpio_direction(IRDA_SD, GPIO_DIR_OUTPUT);
+		omap_set_gpio_direction(IRDA_TX, GPIO_DIR_OUTPUT);
+		omap_set_gpio_dataout(IRDA_SD, 0);
+	} else {
+		omap_free_gpio(IRDA_SD);
+		omap_free_gpio(IRDA_TX);
+		err = irda_vaux_control(IRDA_VAUX_EN);
+		if (err != 0) {
+			printk(KERN_ERR "OMAP: IrDA vaux Enable failed\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int transceiver_mode(struct device *dev, int mode)
+{
+	omap_cfg_reg(IRDA_SD_PIN);
+	omap_cfg_reg(IRDA_TX_PIN);
+
+	if (mode & IR_SIRMODE) {
+		/* SIR */
+		omap_set_gpio_dataout(IRDA_SD, 1);
+		udelay(1);
+		omap_set_gpio_dataout(IRDA_TX, 0);
+		udelay(1);
+		omap_set_gpio_dataout(IRDA_SD, 0);
+		udelay(1);
+	} else {
+		/* MIR/FIR */
+		omap_set_gpio_dataout(IRDA_SD, 1);
+		udelay(1);
+		omap_set_gpio_dataout(IRDA_TX, 1);
+		udelay(1);
+		omap_set_gpio_dataout(IRDA_SD, 0);
+		udelay(1);
+		omap_set_gpio_dataout(IRDA_TX, 0);
+		udelay(1);
+	}
+
+	omap_cfg_reg(T21_3430_UART3_RTS_SD);
+	omap_cfg_reg(V21_3430_UART3_TX_IRTX);
+	return 0;
+}
+#else
+static int select_irda(struct device *dev, int state) { return 0; }
+static int transceiver_mode(struct device *dev, int mode) { return 0; }
+#endif
+
+static struct omap_irda_config irda_data = {
+	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
+	.transceiver_mode	= transceiver_mode,
+	.select_irda	 	= select_irda,
+	.rx_channel		= OMAP24XX_DMA_UART3_RX,
+	.tx_channel		= OMAP24XX_DMA_UART3_TX,
+	.dest_start		= OMAP_UART3_BASE,
+	.src_start		= OMAP_UART3_BASE,
+	.tx_trigger		= OMAP24XX_DMA_UART3_TX,
+	.rx_trigger		= OMAP24XX_DMA_UART3_RX,
+};
+
+static struct resource irda_resources[] = {
+	[0] = {
+		.start	= INT_24XX_UART3_IRQ,
+		.end	= INT_24XX_UART3_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device irda_device = {
+	.name		= "omapirda",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &irda_data,
+	},
+	.num_resources	= 1,
+	.resource	= irda_resources,
+};
+
 static int sdp3430_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -210,6 +354,7 @@

 static struct platform_device *sdp3430_devices[] __initdata = {
 	&sdp3430_smc91x_device,
+	&irda_device,
 	&sdp3430_kp_device,
 	&sdp3430_lcd_device,
 };
Index: linux-omap-2.6/arch/arm/mach-omap2/mux.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/mux.c	2008-07-02 18:54:15.000000000
+0530
+++ linux-omap-2.6/arch/arm/mach-omap2/mux.c	2008-07-02 18:56:41.000000000 +0530
@@ -373,6 +373,22 @@
 		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
 MUX_CFG_34XX("AA12_3430_USB3HS_TLL_D7", 0x172,
 		OMAP34XX_MUX_MODE5 | OMAP34XX_PIN_INPUT_PULLDOWN)
+
+ /* UART3 */
+MUX_CFG_34XX("R21_3430_UART3_CTS_RCTX",	0x19a,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("T21_3430_UART3_RTS_SD", 0x19c,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("U21_3430_UART3_RX_IRRX", 0x19e,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("V21_3430_UART3_TX_IRTX", 0x1a0,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
+
+ /* GPIO */
+MUX_CFG_34XX("T21_3430_GPIO164", 0x19c,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("V21_3430_GPIO166", 0x1a0,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLDOWN)
 };

 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
Index: linux-omap-2.6/include/asm-arm/arch-omap/gpio.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/gpio.h	2008-07-02
18:54:35.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/gpio.h	2008-07-02
18:56:41.000000000 +0530
@@ -31,6 +31,9 @@

 #define OMAP_MPUIO_BASE			(void __iomem *)0xfffb5000

+#define GPIO_DIR_INPUT			1
+#define GPIO_DIR_OUTPUT			0
+
 #ifdef CONFIG_ARCH_OMAP730
 #define OMAP_MPUIO_INPUT_LATCH		0x00
 #define OMAP_MPUIO_OUTPUT		0x02
Index: linux-omap-2.6/include/asm-arm/arch-omap/mux.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mux.h	2008-07-02
18:54:35.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/mux.h	2008-07-02
18:56:41.000000000 +0530
@@ -640,7 +640,6 @@
 	AD16_2430_MCBSP2_CLX_OFF,
 	AE13_2430_MCBSP2_DX_OFF,
 	AD13_2430_MCBSP2_DR_OFF,
-
 };

 enum omap34xx_index {
@@ -723,8 +722,14 @@
 	AB12_3430_USB3HS_TLL_DATA4,
 	AB13_3430_USB3HS_TLL_DATA5,
 	AA13_3430_USB3HS_TLL_DATA6,
-	AA12_3430_USB3HS_TLL_DATA7
+	AA12_3430_USB3HS_TLL_DATA7,

+	R21_3430_UART3_CTS_RCTX,
+	T21_3430_UART3_RTS_SD,
+	U21_3430_UART3_RX_IRRX,
+	V21_3430_UART3_TX_IRTX,
+	T21_3430_GPIO164,
+	V21_3430_GPIO166,
 };

 struct omap_mux_cfg {

