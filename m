From: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Subject: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Thu, 12 Feb 2009 16:10:29 +0200
Message-ID: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62502 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbZBLOLB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 09:11:01 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1CEAQQA023929
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 16:10:57 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>

This patch allows I2C_OMAP to be compiled as a module.
Only drivers/i2c/busses/i2c-omap.c can be compiled as a module,
but not arch/arm/plat-omap/i2c.c , so let the contents of i2c.c
to compile into the kernel if either I2C_OMAP was selected to compile in
or as a module.

Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
---
 arch/arm/plat-omap/Makefile |    3 +--
 arch/arm/plat-omap/i2c.c    |    4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index b3f0e6b..3617bfe 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
-	 usb.o fb.o io.o
+	 usb.o fb.o io.o i2c.o
 obj-m :=
 obj-n :=
 obj-  :=
@@ -21,7 +21,6 @@ obj-$(CONFIG_OMAP_COMPONENT_VERSION) += component-version.o
 obj-$(CONFIG_OMAP_GPIO_SWITCH) += gpio-switch.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
-obj-$(CONFIG_I2C_OMAP) += i2c.o
 
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 467531e..a98a07f 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -35,6 +35,8 @@
 #define OMAP2_I2C_BASE2		0x48072000
 #define OMAP2_I2C_BASE3		0x48060000
 
+#if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
+
 static const char name[] = "i2c_omap";
 
 #define I2C_RESOURCE_BUILDER(base, irq)			\
@@ -163,3 +165,5 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 	omap_i2c_mux_pins(bus_id - 1);
 	return platform_device_register(pdev);
 }
+
+#endif
-- 
1.5.4.3

