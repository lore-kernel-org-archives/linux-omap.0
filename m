From: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Subject: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Thu, 12 Feb 2009 14:54:54 +0200
Message-ID: <cf33789c708e166cea5350a1d3c19e20c6bf0056.1234439236.git.ext-atal.shargorodsky@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46790 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZBLMzh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 07:55:37 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1CCtF9g002016
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 06:55:34 -0600
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>

This patch allows I2C_OMAP to be compiled as a module.
Only drivers/i2c/busses/i2c-omap.c can be compiled as a module,
but not arch/arm/plat-omap/i2c.c , so let the contents of i2c.c
to compile into the kernel if I2C_OMAP was selected to compile in
or as a module.

Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
---
 arch/arm/plat-omap/Makefile |    3 +--
 arch/arm/plat-omap/i2c.c    |    4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 175bfd6..fe4738e 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
-	 usb.o fb.o io.o dss.o
+	 usb.o fb.o io.o dss.o i2c.o
 obj-m :=
 obj-n :=
 obj-  :=
@@ -21,7 +21,6 @@ obj-$(CONFIG_OMAP_COMPONENT_VERSION) += component-version.o
 obj-$(CONFIG_OMAP_GPIO_SWITCH) += gpio-switch.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
-obj-$(CONFIG_I2C_OMAP) += i2c.o
 
 # OMAP MMU framework
 obj-$(CONFIG_OMAP_MMU_FWK) += mmu.o
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 89a6ab0..08b8681 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -34,6 +34,8 @@
 #define OMAP2_I2C_BASE2		0x48072000
 #define OMAP2_I2C_BASE3		0x48060000
 
+#if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+
 static const char name[] = "i2c_omap";
 
 #define I2C_RESOURCE_BUILDER(base, irq)			\
@@ -162,3 +164,5 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 	omap_i2c_mux_pins(bus_id - 1);
 	return platform_device_register(pdev);
 }
+
+#endif
-- 
1.5.4.3

