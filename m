From: virtuoso@slind.org
Subject: [PATCH] [RFC] OMAP: eliminate OMAP_MAX_NR_PORTS
Date: Thu,  8 Oct 2009 12:59:57 +0300
Message-ID: <1254995997-26420-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33365 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442AbZJHKB7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 06:01:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Alexander Shishkin <virtuoso@slind.org>

From: Alexander Shishkin <virtuoso@slind.org>

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/mach-omap1/serial.c             |    2 +-
 arch/arm/mach-omap2/serial.c             |    6 +++---
 arch/arm/plat-omap/include/mach/serial.h |    4 ----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index ed07af1..a86de7c 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -123,7 +123,7 @@ void __init omap_serial_init(void)
 		serial_platform_data[2].uartclk = OMAP1510_BASE_BAUD * 16;
 	}
 
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+	for (i = 0; i < ARRAY_SIZE(serial_platform_data); i++) {
 		unsigned char reg;
 
 		switch (i) {
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index ae21868..c5bef44 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -549,7 +549,7 @@ static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
 
-static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
+static struct omap_uart_state omap_uart[] = {
 	{
 		.pdev = {
 			.name			= "serial8250",
@@ -599,7 +599,7 @@ void __init omap_serial_early_init(void)
 	 * if not needed.
 	 */
 
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
 		struct omap_uart_state *uart = &omap_uart[i];
 		struct platform_device *pdev = &uart->pdev;
 		struct device *dev = &pdev->dev;
@@ -641,7 +641,7 @@ void __init omap_serial_init(void)
 {
 	int i;
 
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
 		struct omap_uart_state *uart = &omap_uart[i];
 		struct platform_device *pdev = &uart->pdev;
 		struct device *dev = &pdev->dev;
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index e249186..9951345 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
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
-- 
1.6.3.3

