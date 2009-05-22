From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] ARM: OMAP2/3: Serial: Remove arch_initcall dependency
Date: Fri, 22 May 2009 15:40:20 -0700
Message-ID: <20090522224020.31586.89346.stgit@localhost>
References: <20090522223543.31586.44534.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65463 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468AbZEVWkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 18:40:20 -0400
In-Reply-To: <20090522223543.31586.44534.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

From: Vikram Pandita <vikram.pandita@ti.com>

Move platform_device_register() for serial device to
omap_serial_init()

There is no need to have arch_initcall() dependency in serial
as already board files call the function omap_serial_init()

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

