From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: omap: repair building without PM_SLEEP
Date: Sat, 01 Jun 2013 11:18:13 +0200
Message-ID: <1844339.mxci2DdvBF@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61012 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab3FAJSK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Jun 2013 05:18:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sourav Poddar <sourav.poddar@ti.com>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>

A recent bug fix in 3.10, ddd85e225c "serial: omap: prevent runtime PM for
"no_console_suspend"", introduced a regression from an obvious typo:

drivers/tty/serial/omap-serial.c:1677:14: error: 'serial_omap_complete' 
	undeclared here (not in a function)

This changes the incorrectly added macro to the one that we need instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please apply for 3.10-rc

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 393a8eb..1aaeca8 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1326,7 +1326,7 @@ static int serial_omap_resume(struct device *dev)
 }
 #else
 #define serial_omap_prepare NULL
-#define serial_omap_prepare NULL
+#define serial_omap_complete NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static void omap_serial_fill_features_erratas(struct uart_omap_port *up)

