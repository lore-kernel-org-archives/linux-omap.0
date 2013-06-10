From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: omap: Fix device tree based PM runtime
Date: Mon, 10 Jun 2013 07:39:09 -0700
Message-ID: <20130610143908.GH8164@atomide.com>
References: <20130607215835.GL3331@atomide.com>
 <87k3m5k07q.fsf@linaro.org>
 <20130607230022.GP3331@atomide.com>
 <20130609053258.GA8104@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22005 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab3FJOjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 10:39:13 -0400
Content-Disposition: inline
In-Reply-To: <20130609053258.GA8104@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kevin Hilman <khilman@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

In the runtime_suspend function pdata is not being used, and
also blocks the function in device tree based booting. Fix it
by removing the unused pdata from the runtime_suspend function.

Further, context loss count is not being passed in pdata, so
let's just reinitialize the port every time for those case.
This can be further optimized later on for the device tree
case by adding detection for the hardware state and possibly
by adding a driver specific autosuspend timeout.

And doing this, we can then make the related dev_err into a
dev_dbg message instead of an error.

In order for the wake-up events to work, we also need to set
autosuspend_timeout to -1 if 0, and also device_init_wakeup()
as that's not being done by the platform init code for the
device tree case.

Note that this does not affect legacy booting, and in fact
might make it work for the cases where the context loss info
is not being passed in pdata.

Thanks to Kevin Hilman <khilman@linaro.org> for debugging
and suggesting fixes for the autosuspend_timeout and
device_init_wakeup() related initializiation.

Reviewed-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Here's this one updated against Linux next.

--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -198,7 +198,7 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
 	struct omap_uart_port_info *pdata = up->dev->platform_data;
 
 	if (!pdata || !pdata->get_context_loss_count)
-		return 0;
+		return -EINVAL;
 
 	return pdata->get_context_loss_count(up->dev);
 }
@@ -1502,6 +1502,9 @@ static int serial_omap_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, up);
 	pm_runtime_enable(&pdev->dev);
+	if (omap_up_info->autosuspend_timeout == 0)
+		omap_up_info->autosuspend_timeout = -1;
+	device_init_wakeup(up->dev, true);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
 			omap_up_info->autosuspend_timeout);
@@ -1611,7 +1614,6 @@ static void serial_omap_restore_context(struct uart_omap_port *up)
 static int serial_omap_runtime_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
-	struct omap_uart_port_info *pdata = dev->platform_data;
 
 	if (!up)
 		return -EINVAL;
@@ -1626,9 +1628,6 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	    uart_console(&up->port))
 		return -EBUSY;
 
-	if (!pdata)
-		return 0;
-
 	up->context_loss_cnt = serial_omap_get_context_loss_count(up);
 
 	if (device_may_wakeup(dev)) {
@@ -1656,7 +1655,7 @@ static int serial_omap_runtime_resume(struct device *dev)
 	int loss_cnt = serial_omap_get_context_loss_count(up);
 
 	if (loss_cnt < 0) {
-		dev_err(dev, "serial_omap_get_context_loss_count failed : %d\n",
+		dev_dbg(dev, "serial_omap_get_context_loss_count failed : %d\n",
 			loss_cnt);
 		serial_omap_restore_context(up);
 	} else if (up->context_loss_cnt != loss_cnt) {
