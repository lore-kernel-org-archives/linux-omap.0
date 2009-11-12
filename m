From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/10] omap: Eliminate OMAP_MAX_NR_PORTS
Date: Wed, 11 Nov 2009 19:02:04 -0800
Message-ID: <20091112030204.5159.80597.stgit@localhost>
References: <20091112025802.5159.97598.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58081 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760039AbZKLDCE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 22:02:04 -0500
In-Reply-To: <20091112025802.5159.97598.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Alexander Shishkin <virtuoso@slind.org>, linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>

From: Alexander Shishkin <virtuoso@slind.org>

Eliminate OMAP_MAX_NR_PORTS

Note that also the null terminator entry for omap1
serial_platform_data needs to be now removed to avoid
oopsing.

Note that mach-omap1 uses struct plat_serial8250_port
array, which requires a null terminator at the end,
and that's why we need to use ARRAY_SIZE - 1. This
is not needed on mach-omap2 as the array used is
struct omap_uart_state, and does not use a null
terminator.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/serial.c             |    2 +-
 arch/arm/mach-omap2/serial.c             |    6 +++---
 arch/arm/plat-omap/include/plat/serial.h |    4 ----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 5ebf094..6e5207c 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -120,7 +120,7 @@ void __init omap_serial_init(void)
 		serial_platform_data[2].uartclk = OMAP1510_BASE_BAUD * 16;
 	}
 
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+	for (i = 0; i < ARRAY_SIZE(serial_platform_data) - 1; i++) {
 
 		/* Static mapping, never released */
 		serial_platform_data[i].membase =
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 72df1b1..2e17b57 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -533,7 +533,7 @@ static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
 
-static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
+static struct omap_uart_state omap_uart[] = {
 	{
 		.pdev = {
 			.name			= "serial8250",
@@ -583,7 +583,7 @@ void __init omap_serial_early_init(void)
 	 * if not needed.
 	 */
 
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
 		struct omap_uart_state *uart = &omap_uart[i];
 		struct platform_device *pdev = &uart->pdev;
 		struct device *dev = &pdev->dev;
@@ -635,7 +635,7 @@ void __init omap_serial_init(void)
 {
 	int i;
 
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
 		struct omap_uart_state *uart = &omap_uart[i];
 		struct platform_device *pdev = &uart->pdev;
 		struct device *dev = &pdev->dev;
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index e249186..9951345 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -20,26 +20,22 @@
 #define OMAP_UART1_BASE		0xfffb0000
 #define OMAP_UART2_BASE		0xfffb0800
 #define OMAP_UART3_BASE		0xfffb9800
-#define OMAP_MAX_NR_PORTS	3
 #elif defined(CONFIG_ARCH_OMAP2)
 /* OMAP2 serial ports */
 #define OMAP_UART1_BASE		0x4806a000
 #define OMAP_UART2_BASE		0x4806c000
 #define OMAP_UART3_BASE		0x4806e000
-#define OMAP_MAX_NR_PORTS	3
 #elif defined(CONFIG_ARCH_OMAP3)
 /* OMAP3 serial ports */
 #define OMAP_UART1_BASE		0x4806a000
 #define OMAP_UART2_BASE		0x4806c000
 #define OMAP_UART3_BASE		0x49020000
-#define OMAP_MAX_NR_PORTS	3
 #elif defined(CONFIG_ARCH_OMAP4)
 /* OMAP4 serial ports */
 #define OMAP_UART1_BASE		0x4806a000
 #define OMAP_UART2_BASE		0x4806c000
 #define OMAP_UART3_BASE		0x48020000
 #define OMAP_UART4_BASE		0x4806e000
-#define OMAP_MAX_NR_PORTS	4
 #endif
 
 #define OMAP1510_BASE_BAUD	(12000000/16)

