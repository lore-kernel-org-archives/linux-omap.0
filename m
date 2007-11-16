From: "Chandra shekhar" <x0044955@ti.com>
Subject: [PATCH 1/2] I2C and TWL4030 suport on 34xx
Date: Fri, 16 Nov 2007 19:16:52 +0530
Message-ID: <200711161346.lAGDkqsV013002@dbdp31.itg.ti.com>
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

Resubmitting the I2C patch for 3430, after Jarkko's I2C registration helper changes.

Signed-off-by: chandra shekhar <x0044955@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    5 ++++-
 arch/arm/mach-omap2/board-3430sdp.c     |    8 ++++++++
 arch/arm/plat-omap/i2c.c                |    2 +-
 drivers/i2c/busses/i2c-omap.c           |   20 +++++++++-----------
 4 files changed, 22 insertions(+), 13 deletions(-)

Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-2.6.orig/arch/arm/configs/omap_3430sdp_defconfig	2007-11-16 08:06:39.000000000 -0500
+++ linux-omap-2.6/arch/arm/configs/omap_3430sdp_defconfig	2007-11-16 09:59:35.780049672 -0500
@@ -601,7 +601,10 @@
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
Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-11-16 08:06:39.000000000 -0500
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2007-11-16 10:00:11.269654432 -0500
@@ -167,6 +167,13 @@
 static struct omap_board_config_kernel sdp3430_config[] = {
 	{ OMAP_TAG_UART,	&sdp3430_uart_config },
 };
+static int __init omap3430_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 2600, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	return 0;
+}
 
 static void __init omap_3430sdp_init(void)
 {
@@ -180,6 +187,7 @@
 {
 	omap2_map_common_io();
 }
+arch_initcall(omap3430_i2c_init);
 
 MACHINE_START(OMAP_3430SDP, "OMAP3430 3430SDP board")
 	/* Maintainer: Syed Khasim - Texas Instruments Inc */
Index: linux-omap-2.6/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-omap-2.6.orig/drivers/i2c/busses/i2c-omap.c	2007-11-16 08:06:40.000000000 -0500
+++ linux-omap-2.6/drivers/i2c/busses/i2c-omap.c	2007-11-16 09:10:33.531339464 -0500
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
+					/* Data reg from 2430 is 8 bit wide */
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
+					/* Data reg from  2430 is 8 bit wide */
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
Index: linux-omap-2.6/arch/arm/plat-omap/i2c.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/i2c.c	2007-11-16 09:19:08.000000000 -0500
+++ linux-omap-2.6/arch/arm/plat-omap/i2c.c	2007-11-16 09:20:14.646996456 -0500
@@ -88,7 +88,7 @@
 		if (cpu_class_is_omap1()) {
 			omap_cfg_reg(I2C_SCL);
 			omap_cfg_reg(I2C_SDA);
-		} else if (cpu_class_is_omap2()) {
+		} else if (cpu_is_omap24xx()) {
 			omap_cfg_reg(M19_24XX_I2C1_SCL);
 			omap_cfg_reg(L15_24XX_I2C1_SDA);
 		}
