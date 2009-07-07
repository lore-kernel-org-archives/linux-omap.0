From: rafiuddin.syed@ti.com
Subject: [PATCH 3/4] ARM: OMAP4: UART4 Support on OMAP4
Date: Tue,  7 Jul 2009 14:17:09 +0530
Message-ID: <1246956430-24863-3-git-send-email-rafiuddin.syed@ti.com>
References: <1246956430-24863-1-git-send-email-rafiuddin.syed@ti.com>
 <1246956430-24863-2-git-send-email-rafiuddin.syed@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44906 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939AbZGGIrc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jul 2009 04:47:32 -0400
In-Reply-To: <1246956430-24863-2-git-send-email-rafiuddin.syed@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Syed Rafiuddin <rafiuddin.syed@ti.com>

From: Syed Rafiuddin <rafiuddin.syed@ti.com>

This patch adds UART4 support on OMAP4430 development platform.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 arch/arm/mach-omap2/serial.c        |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 57e477b..7e1e721 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -39,7 +39,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 };
 
 static struct omap_uart_config sdp4430_uart_config __initdata = {
-	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
+	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
 };
 
 static struct omap_lcd_config sdp4430_lcd_config __initdata = {
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b094c15..c0bea75 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -97,6 +97,16 @@ static struct plat_serial8250_port serial_platform_data[] = {
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
-- 
1.5.4.7

