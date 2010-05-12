From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/3] omap4: Add i2c board support on omap4430 sdp platform
Date: Wed, 12 May 2010 13:57:29 +0530
Message-ID: <1273652851-14147-2-git-send-email-santosh.shilimkar@ti.com>
References: <1273652851-14147-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49769 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab0ELI1h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 04:27:37 -0400
In-Reply-To: <1273652851-14147-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>

This patch adds the i2c board support for OMAP4430 SDP platform. The
necessary drivers support patch is posted earlier.

https://patchwork.kernel.org/patch/80659/

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |   46 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/board-4430sdp.c     |   14 +++++++++-
 arch/arm/plat-omap/i2c.c                |   21 +++++++++++++-
 3 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index d87a349..a555305 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -490,14 +490,58 @@ CONFIG_HW_RANDOM=y
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_DESIGNWARE is not set
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_OMAP=y
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_XILINX is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
 CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
 CONFIG_SPI_MASTER=y
 
 #
 # SPI Master Controller Drivers
 #
+# CONFIG_SPI_BITBANG is not set
+# CONFIG_SPI_GPIO is not set
 CONFIG_SPI_OMAP24XX=y
+# CONFIG_SPI_XILINX is not set
+# CONFIG_SPI_DESIGNWARE is not set
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 
 #
 # PPS support
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 6cce6f2..41fed92 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -135,11 +135,23 @@ static struct omap_musb_board_data musb_board_data = {
 	.mode			= MUSB_PERIPHERAL,
 	.power			= 100,
 };
-
+static int __init omap4_i2c_init(void)
+{
+	/*
+	 * Phoenix Audio IC needs I2C1 to
+	 * start with 400 KHz or less
+	 */
+	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(4, 400, NULL, 0);
+	return 0;
+}
 static void __init omap_4430sdp_init(void)
 {
 	int status;
 
+	omap4_i2c_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 624e262..87bc3f1 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -35,6 +35,7 @@
 #define OMAP2_I2C_BASE1		0x48070000
 #define OMAP2_I2C_BASE2		0x48072000
 #define OMAP2_I2C_BASE3		0x48060000
+#define OMAP2_I2C_BASE4		0x48350000
 
 static const char name[] = "i2c_omap";
 
@@ -54,9 +55,16 @@ static struct resource i2c_resources[][2] = {
 #if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
 #endif
+#if	defined(CONFIG_ARCH_OMAP4)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, OMAP44XX_IRQ_I2C2) },
+#endif
 #if	defined(CONFIG_ARCH_OMAP3)
 	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
 #endif
+#if	defined(CONFIG_ARCH_OMAP4)
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, OMAP44XX_IRQ_I2C3) },
+	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE4, OMAP44XX_IRQ_I2C4) },
+#endif
 };
 
 #define I2C_DEV_BUILDER(bus_id, res, data)		\
@@ -73,12 +81,15 @@ static struct resource i2c_resources[][2] = {
 static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
 static struct platform_device omap_i2c_devices[] = {
 	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
-#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if	defined(CONFIG_ARCH_OMAP2PLUS)
 	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
 #endif
-#if	defined(CONFIG_ARCH_OMAP3)
+#if	defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
 #endif
+#if	defined(CONFIG_ARCH_OMAP4)
+	I2C_DEV_BUILDER(4, i2c_resources[3], &i2c_rate[3]),
+#endif
 };
 
 #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
@@ -93,6 +104,8 @@ static int __init omap_i2c_nr_ports(void)
 		ports = 2;
 	else if (cpu_is_omap34xx())
 		ports = 3;
+	else if (cpu_is_omap44xx())
+		ports = 4;
 
 	return ports;
 }
@@ -113,6 +126,10 @@ static int __init omap_i2c_add_bus(int bus_id)
 			base = OMAP2_I2C_BASE1;
 			irq = INT_24XX_I2C1_IRQ;
 		}
+		if (cpu_is_omap44xx()) {
+			base = OMAP2_I2C_BASE1;
+			irq = OMAP44XX_IRQ_I2C1;
+		}
 		res[0].start = base;
 		res[0].end = base + OMAP_I2C_SIZE;
 		res[1].start = irq;
-- 
1.6.0.4

