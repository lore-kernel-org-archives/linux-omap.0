From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/6] omap4: Add i2c board support on omap4430 sdp platform
Date: Wed,  7 Apr 2010 13:17:24 +0530
Message-ID: <1270626446-10841-5-git-send-email-santosh.shilimkar@ti.com>
References: <1270626446-10841-1-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-2-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-3-git-send-email-santosh.shilimkar@ti.com>
 <1270626446-10841-4-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55112 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218Ab0DGHrd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Apr 2010 03:47:33 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o377lUiN010078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 02:47:32 -0500
In-Reply-To: <1270626446-10841-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>

This patch adds the i2c board support for OMAP4430 SDP platform. The
necessary drivers support patch is posted earlier.

https://patchwork.kernel.org/patch/80659/

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |   19 +++++++++++++++++--
 arch/arm/mach-omap2/board-4430sdp.c     |   10 ++++++++++
 arch/arm/plat-omap/i2c.c                |   21 +++++++++++++++++++--
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index a96bca2..79b3ab1 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -456,8 +456,23 @@ CONFIG_HW_RANDOM=y
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
-# CONFIG_SPI is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
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
 
 #
 # PPS support
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b88f28c..b6c9446 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -111,8 +111,18 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static int __init omap4_i2c_init(void)
+{
+	/* Phoenix Audio IC needs I2C1 to start with 400 KHz and less */
+	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(4, 400, NULL, 0);
+	return 0;
+}
 static void __init omap_4430sdp_init(void)
 {
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

