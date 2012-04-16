From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 7/7] UART: OMAP: Trivial optimisation of the probe and remove
Date: Mon, 16 Apr 2012 20:37:01 +0530
Message-ID: <1334588821-5224-8-git-send-email-shubhrajyoti@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35047 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754676Ab2DPPHQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 11:07:16 -0400
In-Reply-To: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

The probe and remove may not be needed after initialisation and
remove the code could be be put in the devint and devexit section.

Cc: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index cbc9d64..42ad500 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1358,7 +1358,7 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
 	return omap_up_info;
 }
 
-static int serial_omap_probe(struct platform_device *pdev)
+static int __devinit serial_omap_probe(struct platform_device *pdev)
 {
 	struct uart_omap_port	*up;
 	struct resource		*mem, *irq, *dma_tx, *dma_rx;
@@ -1489,7 +1489,7 @@ err_port_line:
 	return ret;
 }
 
-static int serial_omap_remove(struct platform_device *dev)
+static int __devexit serial_omap_remove(struct platform_device *dev)
 {
 	struct uart_omap_port *up = platform_get_drvdata(dev);
 
@@ -1654,7 +1654,7 @@ MODULE_DEVICE_TABLE(of, omap_serial_of_match);
 
 static struct platform_driver serial_omap_driver = {
 	.probe          = serial_omap_probe,
-	.remove         = serial_omap_remove,
+	.remove         = __devexit_p(serial_omap_remove),
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= &serial_omap_dev_pm_ops,
-- 
1.7.4.1

