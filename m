From: "Girish" <girishsg@ti.com>
Subject: [PATCH 2/5] I2C support on 3430
Date: Fri, 2 Nov 2007 20:54:46 +0530
Message-ID: <00f601c81d64$80541bb0$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

This patch supports I2C on OMAP3430

Signed-off-by: Chandra Shekhar <x0044955@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    5 +
 arch/arm/mach-omap2/board-3430sdp.c     |   93 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c           |   13 +---
 arch/arm/plat-omap/devices.c            |    5 -
 drivers/i2c/busses/i2c-omap.c           |   20 +++---
 5 files changed, 112 insertions(+), 24 deletions(-)

Index: linux-omap-git/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-git.orig/arch/arm/configs/omap_3430sdp_defconfig	2007-10-25 16:47:01.000000000 +0530
+++ linux-omap-git/arch/arm/configs/omap_3430sdp_defconfig	2007-10-25 20:42:57.000000000 +0530
@@ -601,8 +601,11 @@
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
 
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_OMAP=y
 #
 # SPI support
 #
Index: linux-omap-git/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-git.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-10-25 16:47:01.000000000 +0530
+++ linux-omap-git/arch/arm/mach-omap2/board-3430sdp.c	2007-10-25 17:11:27.000000000 +0530
@@ -168,6 +168,97 @@
 	{ OMAP_TAG_UART,	&sdp3430_uart_config },
 };
 
+#if	 defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+
+#define OMAP2_I2C_BASE1		0x48070000
+#define OMAP2_I2C_BASE2		0x48072000
+#define OMAP2_I2C_BASE3		0x48060000
+#define OMAP2_I2C_INT1		56
+#define OMAP2_I2C_INT2		57
+#define OMAP2_I2C_INT3		61
+
+static u32 omap2_i2c1_clkrate	= 2600;
+static u32 omap2_i2c2_clkrate	= 400;
+static u32 omap2_i2c3_clkrate	= 400;
+
+static struct resource i2c_resources1[] = {
+	{
+		.start		= OMAP2_I2C_BASE1,
+		.end		= OMAP2_I2C_BASE1 + 0x57,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_I2C_INT1,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource i2c_resources2[] = {
+	{
+		.start		= OMAP2_I2C_BASE2,
+		.end		= OMAP2_I2C_BASE2 + 0x57,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_I2C_INT2,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+static struct resource i2c_resources3[] = {
+	{
+		.start		= OMAP2_I2C_BASE3,
+		.end		= OMAP2_I2C_BASE3 + 0x57,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_I2C_INT3,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+static struct platform_device omap_i2c_device1 = {
+	.name		= "i2c_omap",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(i2c_resources1),
+	.resource	= i2c_resources1,
+	.dev		= {
+			.platform_data = &omap2_i2c1_clkrate,
+	},
+};
+static struct platform_device omap_i2c_device2 = {
+	.name		= "i2c_omap",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(i2c_resources2),
+	.resource	= i2c_resources2,
+	.dev		= {
+			.platform_data = &omap2_i2c2_clkrate,
+	},
+};
+static struct platform_device omap_i2c_device3 = {
+	.name		= "i2c_omap",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(i2c_resources3),
+	.resource	= i2c_resources3,
+	.dev		= {
+			.platform_data = &omap2_i2c3_clkrate,
+	},
+};
+static void omap_init_i2c(void)
+{
+	(void) platform_device_register(&omap_i2c_device1);
+	(void) platform_device_register(&omap_i2c_device2);
+	(void) platform_device_register(&omap_i2c_device3);
+}
+#else
+
+static void omap_init_i2c(void){}
+
+#endif
+
+static int __init omap3430_i2c_init(void){
+	omap_init_i2c();
+	return (0);
+}
+
 static void __init omap_3430sdp_init(void)
 {
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
@@ -181,6 +272,8 @@
 	omap2_map_common_io();
 }
 
+arch_initcall(omap3430_i2c_init);
+
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
 	.phys_io	= 0x48000000,
Index: linux-omap-git/arch/arm/mach-omap2/devices.c
===================================================================
--- linux-omap-git.orig/arch/arm/mach-omap2/devices.c	2007-10-25 16:47:01.000000000 +0530
+++ linux-omap-git/arch/arm/mach-omap2/devices.c	2007-10-25 17:11:27.000000000 +0530
@@ -55,9 +55,8 @@
 {
 }
 #endif
-
-#if	!defined(CONFIG_ARCH_OMAP243X)
-#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+#if	(defined(CONFIG_ARCH_OMAP2420)) && \
+		(defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE))
 
 #define OMAP2_I2C_BASE2		0x48072000
 #define OMAP2_I2C_INT2		57
@@ -97,12 +96,8 @@
 
 	(void) platform_device_register(&omap_i2c_device2);
 }
-
 #else
-
 static void omap_init_i2c(void) {}
-
-#endif
 #endif
 
 #if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
@@ -278,9 +273,9 @@
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_init_camera();
-	if (!cpu_is_omap2430()) {
+	if (!cpu_is_omap2430() && !cpu_is_omap34xx())
 		omap_init_i2c();
-	}
+
 	omap_init_mbox();
 	omap_init_mcspi();
 	omap_init_sti();
Index: linux-omap-git/arch/arm/plat-omap/devices.c
===================================================================
--- linux-omap-git.orig/arch/arm/plat-omap/devices.c	2007-10-25 16:47:01.000000000 +0530
+++ linux-omap-git/arch/arm/plat-omap/devices.c	2007-10-25 17:11:27.000000000 +0530
@@ -89,8 +89,8 @@
 #endif	/* CONFIG_OMAP_DSP */
 
 /*-------------------------------------------------------------------------*/
-#if	!defined(CONFIG_ARCH_OMAP243X)
-#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+#if	(defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2420)) && \
+		(defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE))
 
 #define	OMAP1_I2C_BASE		0xfffb3800
 #define OMAP2_I2C_BASE1		0x48070000
@@ -157,7 +157,6 @@
 #else
 static inline void omap_init_i2c(void) {}
 #endif
-#endif
 /*-------------------------------------------------------------------------*/
 #if	defined(CONFIG_KEYBOARD_OMAP) || defined(CONFIG_KEYBOARD_OMAP_MODULE)
 
Index: linux-omap-git/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-omap-git.orig/drivers/i2c/busses/i2c-omap.c	2007-10-25 16:47:01.000000000 +0530
+++ linux-omap-git/drivers/i2c/busses/i2c-omap.c	2007-10-25 18:23:57.000000000 +0530
@@ -160,7 +160,7 @@
 
 static int omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
-	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		dev->iclk = clk_get(dev->dev, "i2c_ick");
 		if (IS_ERR(dev->iclk)) {
 			dev->iclk = NULL;
@@ -265,7 +265,7 @@
 			psc = fclk_rate / 12000000;
 	}
 
-	if (cpu_is_omap2430()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 
 		/* HSI2C controller internal clk rate should be 19.2 Mhz */
 		internal_clk = 19200;
@@ -603,10 +603,9 @@
 				if (dev->buf_len) {
 					*dev->buf++ = w;
 					dev->buf_len--;
-					/*
-					 * Data reg in 2430 is 8 bit wide,
-					 */
-					if (!cpu_is_omap2430()) {
+					/* data reg from 2430 is 8 bit wide */
+					if (!cpu_is_omap2430() &&
+							!cpu_is_omap34xx()) {
 						if (dev->buf_len) {
 							*dev->buf++ = w >> 8;
 							dev->buf_len--;
@@ -637,10 +636,9 @@
 				if (dev->buf_len) {
 					w = *dev->buf++;
 					dev->buf_len--;
-					/*
-					 * Data reg in 2430 is 8 bit wide,
-					 */
-					if (!cpu_is_omap2430()) {
+					/* data reg from 2430 is 8 bit wide */
+					if (!cpu_is_omap2430() &&
+							!cpu_is_omap34xx()) {
 						if (dev->buf_len) {
 							w |= *dev->buf++ << 8;
 							dev->buf_len--;
@@ -740,7 +738,7 @@
 	if (cpu_is_omap15xx())
 		dev->rev1 = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) < 0x20;
 
-	if (cpu_is_omap2430()) {
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		/* Set up the fifo size - Get total size */
 		dev->fifo_size = 0x8 <<
 			((omap_i2c_read_reg(dev, OMAP_I2C_BUFSTAT_REG) >> 14) & 0x3);
