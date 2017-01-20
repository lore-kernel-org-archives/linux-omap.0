From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] serial: 8250_omap: Fix probe and remove for PM runtime
Date: Fri, 20 Jan 2017 12:22:31 -0800
Message-ID: <20170120202231.16137-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vignesh R <vigneshr@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Otherwise the interconnect related code implementing PM runtime will
produce these errors on a failed probe:

omap_uart 48066000.serial: omap_device: omap_device_enable() called
from invalid state 1
omap_uart 48066000.serial: use pm_runtime_put_sync_suspend() in driver?

Note that we now also need to check for priv in omap8250_runtime_suspend()
as it has not yet been registered if probe fails. And we need to use
pm_runtime_put_sync() to properly idle the device like we already do
in omap8250_remove().

Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

As far as I'm concerned, this can safely wait for the merge window

---
 drivers/tty/serial/8250/8250_omap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1240,7 +1240,8 @@ static int omap8250_probe(struct platform_device *pdev)
 	pm_runtime_put_autosuspend(&pdev->dev);
 	return 0;
 err:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
@@ -1249,6 +1250,7 @@ static int omap8250_remove(struct platform_device *pdev)
 {
 	struct omap8250_priv *priv = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	serial8250_unregister_port(priv->line);
@@ -1348,6 +1350,10 @@ static int omap8250_runtime_suspend(struct device *dev)
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up;
 
+	/* In case runtime-pm tries this before we are setup */
+	if (!priv)
+		return 0;
+
 	up = serial8250_get_port(priv->line);
 	/*
 	 * When using 'no_console_suspend', the console UART must not be
-- 
2.11.0
