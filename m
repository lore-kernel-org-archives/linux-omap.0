From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] OMAP2: Serial: Remove arch_initcall dependency
Date: Thu, 21 May 2009 05:09:51 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5129A0B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58675 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbZETXj6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:39:58 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4KNdrcO017012
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 18:39:59 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4KNdqxq028854
	for <linux-omap@vger.kernel.org>; Thu, 21 May 2009 05:09:52 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Vikram Pandita <vikram.pandita@ti.com>

Move platform_device_register() for serial device to
omap_serial_init()

There is no need to have arch_initcall() dependency in serial
as already board files call the function omap_serial_init()

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/serial.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 4dcf39c..3c2d325 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -98,6 +98,14 @@ void omap_serial_enable_clocks(int enable)
 	}
 }
 
+static struct platform_device serial_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev			= {
+		.platform_data	= serial_platform_data,
+	},
+};
+
 void __init omap_serial_init(void)
 {
 	int i;
@@ -142,18 +150,6 @@ void __init omap_serial_init(void)
 
 		omap_serial_reset(p);
 	}
-}
 
-static struct platform_device serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= serial_platform_data,
-	},
-};
-
-static int __init omap_init(void)
-{
-	return platform_device_register(&serial_device);
+	platform_device_register(&serial_device);
 }
-arch_initcall(omap_init);
-- 
1.6.0.3.613.g9f8f13

