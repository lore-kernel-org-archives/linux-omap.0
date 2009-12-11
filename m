From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC/PATCH 2/5] usb: otg: twl4030: add support for notifier
Date: Fri, 11 Dec 2009 13:31:23 +0200
Message-ID: <1260531086-23857-3-git-send-email-felipe.balbi@nokia.com>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50302 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762323AbZLKLcQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 06:32:16 -0500
In-Reply-To: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

it's expected that the transceiver driver will
initialize and call the notifier chain when
necessary. Implement that for twl4030-usb driver.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/otg/twl4030-usb.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 2ffc8eb..c3e498a 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -36,7 +36,7 @@
 #include <linux/i2c/twl4030.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
-
+#include <linux/notifier.h>
 
 /* Register defines */
 
@@ -628,7 +628,8 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 		else
 			twl4030_phy_resume(twl);
 
-		twl4030charger_usb_en(status == USB_LINK_VBUS);
+		blocking_notifier_call_chain(&twl->otg.notifier, status,
+				twl->otg.gadget);
 	}
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
 
@@ -718,6 +719,8 @@ static int __devinit twl4030_usb_probe(struct platform_device *pdev)
 	if (device_create_file(&pdev->dev, &dev_attr_vbus))
 		dev_warn(&pdev->dev, "could not create sysfs file\n");
 
+	BLOCKING_INIT_NOTIFIER_HEAD(&twl->otg.notifier);
+
 	/* Our job is to use irqs and status from the power module
 	 * to keep the transceiver disabled when nothing's connected.
 	 *
-- 
1.6.6.rc0

