From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/4] serial: omap: enable PM runtime only when its fully configured
Date: Mon, 22 Jul 2013 15:31:15 +0530
Message-ID: <1374487277-26099-3-git-send-email-rnayak@ti.com>
References: <1374487277-26099-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50255 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757284Ab3GVKCL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Jul 2013 06:02:11 -0400
In-Reply-To: <1374487277-26099-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, balbi@ti.com, mpfj-list@newflow.co.uk, vaibhav.bedia@ti.com, khilman@linaro.org, sourav.poddar@ti.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, grygorii.strashko@ti.com, Rajendra Nayak <rnayak@ti.com>

From: Grygorii Strashko <grygorii.strashko@ti.com>

If earlyprintk is enabled and current UART is console port the platform
code can mark it as RPM_ACTIVE to sync real IP state with PM Runtime and
avoid resuming of already active device, but now, driver initialization
will be performed in the wrong way:

	pm_runtime_enable(&pdev->dev);
    <-- PM runtime alowed (device state RPM_ACTIVE)
	if (omap_up_info->autosuspend_timeout == 0)
		omap_up_info->autosuspend_timeout = -1;
	device_init_wakeup(up->dev, true);
	pm_runtime_use_autosuspend(&pdev->dev);
	<-- update_autosuspend() will be called and it will disable device
        (device state RPM_SUSPENDED)
	pm_runtime_set_autosuspend_delay(&pdev->dev,
			omap_up_info->autosuspend_timeout);
	<-- update_autosuspend() will be called which will re-enable device
        (device state RPM_ACTIVE), because autosuspend_timeout < 0

	pm_runtime_irq_safe(&pdev->dev);
	pm_runtime_get_sync(&pdev->dev);
	<-- will do nothing

Such behavior isn't expected by OMAP serial drivers and causes
unpredictable calls of serial_omap_runtime_suspend() and
serial_omap_runtime_resume().

Hence, fix it by allowing PM runtime only after all its parameters are
configured.

CC: Tony Lindgren <tony@atomide.com>
CC: Rajendra Nayak <rnayak@ti.com>
CC: Felipe Balbi <balbi@ti.com>
CC: Kevin Hilman <khilman@linaro.org>

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/tty/serial/omap-serial.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index b6d1728..f39bf0c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1501,7 +1501,6 @@ static int serial_omap_probe(struct platform_device *pdev)
 	INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
 
 	platform_set_drvdata(pdev, up);
-	pm_runtime_enable(&pdev->dev);
 	if (omap_up_info->autosuspend_timeout == 0)
 		omap_up_info->autosuspend_timeout = -1;
 	device_init_wakeup(up->dev, true);
@@ -1510,6 +1509,8 @@ static int serial_omap_probe(struct platform_device *pdev)
 			omap_up_info->autosuspend_timeout);
 
 	pm_runtime_irq_safe(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	pm_runtime_get_sync(&pdev->dev);
 
 	omap_serial_fill_features_erratas(up);
-- 
1.7.9.5

