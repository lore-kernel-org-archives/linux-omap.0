From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH] OMAP3: serial - allow platforms specify which UARTs to initialize
Date: Thu, 10 Dec 2009 12:33:44 +0200
Message-ID: <1260441224-29815-1-git-send-email-ext-mika.1.westerberg@nokia.com>
References: <878wdbu5sx.fsf@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64919 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118AbZLJKce (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 05:32:34 -0500
In-Reply-To: <878wdbu5sx.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

This patch adds new function: omap_serial_init_port(port) that can be
used to initialize only selected UARTs as serial ports. Platforms can
then in their board files call this function instead of omap_serial_init()
if they don't want to use all UARTs as serial ports.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
I refreshed this against latest l-o master and added Kevins SoB. Tested
with RX-51.

 arch/arm/mach-omap2/serial.c             |   78 ++++++++++++++++++++---------
 arch/arm/plat-omap/include/plat/serial.h |    1 +
 2 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index e853115..eb2ba6e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -649,34 +649,64 @@ void __init omap_serial_early_init(void)
 	}
 }
 
-void __init omap_serial_init(void)
+/**
+ * omap_serial_init_port() - initialize single serial port
+ * @port: serial port number (0-3)
+ *
+ * This function initialies serial driver for given @port only.
+ * Platforms can call this function instead of omap_serial_init()
+ * if they don't plan to use all available UARTs as serial ports.
+ *
+ * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
+ * use only one of the two.
+ */
+void __init omap_serial_init_port(int port)
 {
-	int i;
+	struct omap_uart_state *uart;
+	struct platform_device *pdev;
+	struct device *dev;
 
-	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
-		struct omap_uart_state *uart = &omap_uart[i];
-		struct platform_device *pdev = &uart->pdev;
-		struct device *dev = &pdev->dev;
+	BUG_ON(port < 0);
+	BUG_ON(port >= ARRAY_SIZE(omap_uart));
 
-		omap_uart_reset(uart);
-		omap_uart_idle_init(uart);
+	uart = &omap_uart[port];
+	pdev = &uart->pdev;
+	dev = &pdev->dev;
 
-		if (WARN_ON(platform_device_register(pdev)))
-			continue;
-		if ((cpu_is_omap34xx() && uart->padconf) ||
-		    (uart->wk_en && uart->wk_mask)) {
-			device_init_wakeup(dev, true);
-			DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
-		}
+	omap_uart_reset(uart);
+	omap_uart_idle_init(uart);
 
-		/* omap44xx: Never read empty UART fifo
-		 * omap3xxx: Never read empty UART fifo on UARTs
-		 * with IP rev >=0x52
-		 */
-		if (cpu_is_omap44xx())
-			uart->p->serial_in = serial_in_override;
-		else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
-				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
-			uart->p->serial_in = serial_in_override;
+	if (WARN_ON(platform_device_register(pdev)))
+		return;
+
+	if ((cpu_is_omap34xx() && uart->padconf) ||
+	    (uart->wk_en && uart->wk_mask)) {
+		device_init_wakeup(dev, true);
+		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
 	}
+
+	/* omap44xx: Never read empty UART fifo
+	 * omap3xxx: Never read empty UART fifo on UARTs
+	 * with IP rev >=0x52
+	 */
+	if (cpu_is_omap44xx())
+		uart->p->serial_in = serial_in_override;
+	else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
+			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
+		uart->p->serial_in = serial_in_override;
+}
+
+/**
+ * omap_serial_init() - intialize all supported serial ports
+ *
+ * Initializes all available UARTs as serial ports. Platforms
+ * can call this function when they want to have default behaviour
+ * for serial ports (e.g initialize them all as serial ports).
+ */
+void __init omap_serial_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(omap_uart); i++)
+		omap_serial_init_port(i);
 }
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 9951345..f5a4a92 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -53,6 +53,7 @@
 #ifndef __ASSEMBLER__
 extern void __init omap_serial_early_init(void);
 extern void omap_serial_init(void);
+extern void omap_serial_init_port(int port);
 extern int omap_uart_can_sleep(void);
 extern void omap_uart_check_wakeup(void);
 extern void omap_uart_prepare_suspend(void);
-- 
1.5.6.5

