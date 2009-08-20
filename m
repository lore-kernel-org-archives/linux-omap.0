From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/2] ARM: OMAP4: Fix NULL pointer dereference crash.
Date: Thu, 20 Aug 2009 22:04:25 +0530
Message-ID: <1250786066-29777-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54512 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754521AbZHTQef (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Aug 2009 12:34:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>

After the patch series "[PATCH 00/14] OMAP PM fixes for .31-rc"
merge in 2.6.31-rc5 console was not working for OMAP4.
This patch fixes it by adding UART4 support.

The mentioned patch series has split the UART platform data
into separate structure hence needs to rework the first patch.

More info- http://lkml.org/lkml/2009/8/20/192

Without this patch omap_serial_init() would produce kernel crash
on OMAP4430 platform while looping for UART4 platform data.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 arch/arm/mach-omap2/serial.c        |   27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b0c7402..1b22307 100644
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
index a7421a5..e1be77b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -112,7 +112,21 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 		.flags		= 0
 	}
 };
-
+#ifdef CONFIG_ARCH_OMAP4
+static struct plat_serial8250_port serial_platform_data3[] = {
+	{
+		.membase	= IO_ADDRESS(OMAP_UART4_BASE),
+		.mapbase	= OMAP_UART4_BASE,
+		.irq		= 70,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= OMAP24XX_BASE_BAUD * 16,
+	}, {
+		.flags		= 0
+	}
+};
+#endif
 static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
 					   int offset)
 {
@@ -550,6 +564,17 @@ static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
 			},
 		},
 	},
+#ifdef CONFIG_ARCH_OMAP4
+	{
+		.pdev = {
+			.name			= "serial8250",
+			.id			= PLAT8250_DEV_FOURPORT,
+			.dev			= {
+				.platform_data	= serial_platform_data3,
+			},
+		},
+	},
+#endif
 };
 
 void __init omap_serial_init(void)
-- 
1.5.4.7

