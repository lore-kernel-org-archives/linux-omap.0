From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: Add i2c board support for omap4 platform
Date: Tue, 16 Feb 2010 21:11:29 +0530
Message-ID: <1266334896-30686-17-git-send-email-santosh.shilimkar@ti.com>
References: <1266334896-30686-1-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-2-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-3-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-4-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-5-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-6-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-7-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-8-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-9-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-10-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-11-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-12-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-13-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-14-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-15-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-16-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51307 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932807Ab0BPPmQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:42:16 -0500
In-Reply-To: <1266334896-30686-16-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch enables I2C driver for OMAP4430 SDP board file.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |   19 +++++++++++++++++--
 arch/arm/mach-omap2/board-4430sdp.c     |    9 +++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 7ac3fbf..d791e63 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -453,8 +453,23 @@ CONFIG_HW_RANDOM=y
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
index 86b240e..a325ba5 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -81,8 +81,17 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static int __init omap4_i2c_init(void)
+{
+	/* Phoenix Audio IC needs I2C1 to start with 400 KHz and less */
+	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	return 0;
+}
 static void __init omap_4430sdp_init(void)
 {
+	omap4_i2c_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
-- 
1.6.0.4

