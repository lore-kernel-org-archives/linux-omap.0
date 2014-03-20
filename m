From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 01/11] tty: serial: add missing braces
Date: Thu, 20 Mar 2014 14:29:57 -0500
Message-ID: <1395343807-21618-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53489 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067AbaCTTb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2014 15:31:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org, peter@hurleysoftware.com, m-karicheri2@ti.com, b32955@freescale.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

per CodingStyle we should have those braces, no
functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 77f0351..73abba8 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1677,8 +1677,10 @@ static int serial_omap_probe(struct platform_device *pdev)
 	    omap_up_info->DTR_present) {
 		up->DTR_gpio = omap_up_info->DTR_gpio;
 		up->DTR_inverted = omap_up_info->DTR_inverted;
-	} else
+	} else {
 		up->DTR_gpio = -EINVAL;
+	}
+
 	up->DTR_active = 0;
 
 	up->dev = &pdev->dev;
@@ -1740,6 +1742,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, up);
 	if (omap_up_info->autosuspend_timeout == 0)
 		omap_up_info->autosuspend_timeout = -1;
+
 	device_init_wakeup(up->dev, true);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
-- 
1.9.1.286.g5172cb3

