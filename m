From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 1/3] OMAP UART: Add omap-serial driver support.
Date: Tue, 24 Nov 2009 11:58:58 -0800
Message-ID: <87aaybu22l.fsf@deeprootsystems.com>
References: <35817.192.168.10.88.1256713980.squirrel@dbdmail.itg.ti.com>
	<45113.192.168.10.88.1258095234.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:59001 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932789AbZKXT6y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 14:58:54 -0500
Received: by pwi3 with SMTP id 3so4379144pwi.21
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 11:59:00 -0800 (PST)
In-Reply-To: <45113.192.168.10.88.1258095234.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Fri\, 13 Nov 2009 12\:23\:54 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From 4756e3743c7acd2de1030b2bd432c1b19f0b9ff5 Mon Sep 17 00:00:00 2001
> From: Govindraj R <govindraj.raja@ti.com>
> Date: Fri, 13 Nov 2009 12:01:54 +0530
> Subject: [PATCH] OMAP UART: Add omap-serial driver support.
>
> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
>
> It adds support for the following features:
> 1. It supports Interrupt mode and DMA mode of operation.
> 2. Supports Hardware flow control and sofware flow control.
> 3. Debug Console support on all UARTs.
>
> Signed-off-by: Govindraj R <govindraj.raja@ti.com>

Govindraj,

FYI... to use this version of the driver with the UART omap_device
conversion I just posted, I used this additional patch on top of your
driver.

These are various issues I pointed out in the review as well, but
wanted to share this with V3 + this patch, I was able to use it
with the omap_device conversion.

Kevin

commit 79285bfc6c8711f580895256a82e7dc127156824
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Mon Nov 23 15:10:13 2009 -0800

    OMAP: HS-UART: misc. fixes

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 4341fae..86bec82 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -28,7 +28,7 @@
  * in bootargs we specify as console=ttyO0 if uart1
  * is used as console uart.
  */
-#define DEVICE_NAME	"ttyO"
+#define DEVICE_NAME	"ttyS"
 
 /* *
  * We default to IRQ0 for the "no irq" hack.   Some
diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-serial.c
index 6dd8bb4..65d05f8 100644
--- a/drivers/serial/omap-serial.c
+++ b/drivers/serial/omap-serial.c
@@ -993,7 +993,7 @@ static struct console serial_omap_console = {
 
 static void serial_omap_add_console_port(struct uart_omap_port *up)
 {
-	serial_omap_console_ports[up->pdev->id - 1] = up;
+	serial_omap_console_ports[up->pdev->id] = up;
 }
 
 #define OMAP_CONSOLE	(&serial_omap_console)
@@ -1237,7 +1237,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.regshift = 2;
 	up->port.fifosize = 64;
 	up->port.ops = &serial_omap_pops;
-	up->port.line = pdev->id - 1;
+	up->port.line = pdev->id;
 	up->port.membase = ioremap_nocache(up->port.mapbase,
 					0x16 << up->port.regshift);
 	up->port.flags = UPF_BOOT_AUTOCONF;
@@ -1263,7 +1263,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 		pr_err("\n %s: UART Driver Init Failed!\n", __func__);
 		return -EPERM;
 	}
-	ui[pdev->id - 1] = up;
+	ui[pdev->id] = up;
 	serial_omap_add_console_port(up);
 
 	ret = uart_add_one_port(&serial_omap_reg, &up->port);
@@ -1298,7 +1298,7 @@ static struct platform_driver serial_omap_driver = {
 	.suspend	= serial_omap_suspend,
 	.resume		= serial_omap_resume,
 	.driver		= {
-		.name	= "omap-uart",
+		.name	= DRIVER_NAME,
 	},
 };
 
