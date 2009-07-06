From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v3] OMAP1: AMS_DELTA: add modem support
Date: Mon, 6 Jul 2009 12:24:27 +0200
Message-ID: <200907061224.29292.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757574AbZGFKZV@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

This patch adds support for modem device found on Amstrad E3 (Delta) board.

Based on earlier patch by Jonathan McDowell, available at 
http://the.earth.li/pub/e3/2.6.19/ams-delta-modem.patch.
Modified after Ladislav Michl's arch/arm/mach-omap1/board-voiceblue.c.

This version, unlike v2, is dependent on 8250 driver changes getting accepted
upstream:
Refer: http://patchwork.kernel.org/patch/31884/

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
Registering the modem platform device from a separate arch_initcall (and not
from init_machine() callback) preserves serial console port at ttyS0.

OMAP mux pin set up just for case if Amstrad bootloader is ever replaced.

Warning: 
could cause compilation break if 8250 patch is not integrated first

--- linux-2.6.31-rc1/arch/arm/mach-omap1/board-ams-delta.c.orig	2009-07-04 16:39:37.000000000 +0200
+++ linux-2.6.31-rc1/arch/arm/mach-omap1/board-ams-delta.c	2009-07-05 13:41:08.000000000 +0200
@@ -15,8 +15,11 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/serial_8250.h>
 
+#include <asm/serial.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -235,6 +238,41 @@ static void __init ams_delta_init(void)
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 }
 
+static struct plat_serial8250_port ams_delta_modem_ports[] = {
+	{
+		.membase	= (void *) AMS_DELTA_MODEM_VIRT,
+		.mapbase	= AMS_DELTA_MODEM_PHYS,
+		.irq		= -EINVAL, /* changed later */
+		.flags		= UPF_BOOT_AUTOCONF,
+		.irqflags	= IRQF_TRIGGER_RISING,
+		.iotype		= UPIO_MEM,
+		.regshift	= 1,
+		.uartclk	= BASE_BAUD * 16,
+	},
+	{ },
+};
+
+static struct platform_device ams_delta_modem_device = {
+	.name	= "serial8250",
+	.id	= PLAT8250_DEV_PLATFORM1,
+	.dev		= {
+		.platform_data = ams_delta_modem_ports,
+	},
+};
+
+static int __init ams_delta_modem_init(void)
+{
+	omap_cfg_reg(M14_1510_GPIO2);
+	ams_delta_modem_ports[0].irq = gpio_to_irq(2);
+
+	ams_delta_latch2_write(
+		AMS_DELTA_LATCH2_MODEM_NRESET | AMS_DELTA_LATCH2_MODEM_CODEC,
+		AMS_DELTA_LATCH2_MODEM_NRESET | AMS_DELTA_LATCH2_MODEM_CODEC);
+
+	return platform_device_register(&ams_delta_modem_device);
+}
+arch_initcall(ams_delta_modem_init);
+
 static void __init ams_delta_map_io(void)
 {
 	omap1_map_common_io();
