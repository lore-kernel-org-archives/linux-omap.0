From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [RESUBMIT] [PATCH 2/2][RFC] OMAP4: UART4 Support for OMAP_4430SDP
Date: Sat, 23 May 2009 16:27:00 +0530 (IST)
Message-ID: <55691.192.168.10.89.1243076220.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42495 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbZEWK5F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 May 2009 06:57:05 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4NAv1hR009312
	for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 05:57:06 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4NAuxku022736
	for <linux-omap@vger.kernel.org>; Sat, 23 May 2009 05:57:00 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch enables support for UART4 on OMAP4430 development platform.
Updating the patch with kevin's comments.

Signed-off-by: <rafiuddin.syed@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 arch/arm/mach-omap2/serial.c        |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

Index: omap4_dev/arch/arm/mach-omap2/board-4430sdp.c
=================================================================== ---
omap4_dev.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ omap4_dev/arch/arm/mach-omap2/board-4430sdp.c
@@ -39,7 +39,7 @@ static struct platform_device *sdp4430_d
 };

 static struct omap_uart_config sdp4430_uart_config __initdata = {
-	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
+	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
 };

 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
Index: omap4_dev/arch/arm/mach-omap2/serial.c
=================================================================== ---
omap4_dev.orig/arch/arm/mach-omap2/serial.c
+++ omap4_dev/arch/arm/mach-omap2/serial.c
@@ -54,6 +54,16 @@ static struct plat_serial8250_port seria
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
+#ifdef CONFIG_ARCH_OMAP4
+		.membase	= IO_ADDRESS(OMAP_UART4_BASE),
+		.mapbase	= OMAP_UART4_BASE,
+		.irq		= 70,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
+	}, {
+#endif
 		.flags		= 0
 	}
 };



