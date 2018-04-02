From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2] serial: 8250: omap: Provide ability to enable/disable UART as wakeup source
Date: Mon, 2 Apr 2018 17:50:37 +0530
Message-ID: <20180402122037.2710-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Enable/Clear module level UART wakeup in UART_OMAP_WER register based on
return value of device_may_wakeup() in .suspend(). This allows
userspace to use sysfs to control the ability of UART to wakeup the
system from deep sleep state. Register is restored back in .startup()
call that happens as part of resume sequence.

With this patch, userspace can control UART wakeup capability via sysfs:
To enable wakeup capability:
echo enabled >  /sys/class/tty/ttyXX/device/power/wakeup
For disabling wakeup capability:
echo disabled > /sys/class/tty/ttyXX/device/power/wakeup

Note that the UART wakeup events configured in the 8250 hardware only
work for idle modes that do not cut off power for the UART. For deeper
idle states, dedicated padconf wakeirqs must be used. Or in some cases
the UART RX pin can be remuxed to GPIO input if the GPIO block stays
powered.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---

v2: update commit log.

 drivers/tty/serial/8250/8250_omap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 624b501fd253..6aaa84355fd1 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1310,8 +1310,17 @@ static void omap8250_complete(struct device *dev)
 static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
 
 	serial8250_suspend_port(priv->line);
+
+	pm_runtime_get_sync(dev);
+	if (!device_may_wakeup(dev))
+		priv->wer = 0;
+	serial_out(up, UART_OMAP_WER, priv->wer);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	flush_work(&priv->qos_work);
 	return 0;
 }
@@ -1403,6 +1412,8 @@ static int omap8250_runtime_suspend(struct device *dev)
 
 		/* Restore to UART mode after reset (for wakeup) */
 		omap8250_update_mdr1(up, priv);
+		/* Restore wakeup enable register */
+		serial_out(up, UART_OMAP_WER, priv->wer);
 	}
 
 	if (up->dma && up->dma->rxchan)
-- 
2.16.2
