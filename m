From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [PATCH 2/2][RFC] OMAP4: UART4 Support for OMAP_4430SDP.
Date: Tue, 12 May 2009 11:50:34 +0530 (IST)
Message-ID: <55287.192.168.10.89.1242109234.squirrel@dbdmail.itg.ti.com>
References: <51950.192.168.10.89.1241612607.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42192 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754695AbZELGUq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 May 2009 02:20:46 -0400
In-Reply-To: <51950.192.168.10.89.1241612607.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch enables support for UART4 on OMAP4430 development platform.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 arch/arm/mach-omap2/serial.c        |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c	2009-05-12
10:43:41.000000000 +0530
+++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c	2009-05-12 11:40:54.000000000
+0530
@@ -38,7 +38,7 @@
 };

 static struct omap_uart_config sdp4430_uart_config __initdata = {
-	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
+	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2) | (1 << 3)),
 };

 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
Index: linux-2.6/arch/arm/mach-omap2/serial.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/serial.c	2009-05-12 11:35:55.000000000
+0530
+++ linux-2.6/arch/arm/mach-omap2/serial.c	2009-05-12 11:46:13.000000000 +0530
@@ -53,8 +53,20 @@
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
+
+	}, {
+#ifdef CONFIG_ARCH_OMAP4
+		.membase        = IO_ADDRESS(OMAP_UART3_BASE),
+		.mapbase        = OMAP_UART4_BASE,
+		.irq            = 70,
+		.flags          = UPF_BOOT_AUTOCONF,
+		.iotype         = UPIO_MEM,
+		.regshift       = 2,
+		.uartclk        = OMAP24XX_BASE_BAUD * 16,
 	}, {
+#else
 		.flags		= 0
+#endif
 	}
 };

