From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/14] OMAP3: serial - allow platforms specify which UARTs to
	initialize
Date: Fri, 11 Dec 2009 15:52:41 -0800
Message-ID: <20091211235241.3189.29246.stgit@localhost>
References: <20091211234919.3189.95607.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60127 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762822AbZLKXwg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 18:52:36 -0500
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Mika Westerberg <ext-mika.1.westerberg@nokia.com>

From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

This patch adds new function: omap_serial_init_port(port) that can be
used to initialize only selected UARTs as serial ports. Platforms can
then in their board files call this function instead of omap_serial_init()
if they don't want to use all UARTs as serial ports.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c             |   70 ++++++++++++++++++++++++------
 arch/arm/plat-omap/include/plat/serial.h |    1 
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2e17b57..6278fe5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -631,24 +631,64 @@ void __init omap_serial_early_init(void)
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
+
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

