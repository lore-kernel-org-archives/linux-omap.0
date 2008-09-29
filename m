From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 13/22] i2c: added a few missing gotos to add_children()
Date: Mon, 29 Sep 2008 16:14:30 +0300
Message-ID: <1222694079-16289-14-git-send-email-felipe.balbi@nokia.com>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-3-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-4-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-5-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-6-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-7-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-8-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-9-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-11-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-12-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-13-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29654 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbYI2NPQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:15:16 -0400
In-Reply-To: <1222694079-16289-13-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Previously we were failing platform_device_add_data()
and returning from add_children but trying to keep going
when platform_device_add() fails.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 4ea6444..80cf231 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -675,6 +675,7 @@ static int add_children(struct twl4030_platform_data *pdata)
 		if (!pdev) {
 			pr_debug("%s: can't alloc gpio dev\n", DRIVER_NAME);
 			status = -ENOMEM;
+			goto err;
 		}
 
 		/* more driver model init */
@@ -735,6 +736,7 @@ static int add_children(struct twl4030_platform_data *pdata)
 				dev_dbg(&twl->client->dev,
 						"can't create keypad dev, %d\n",
 						status);
+				goto err;
 			}
 		} else {
 			pr_debug("%s: can't alloc keypad dev\n", DRIVER_NAME);
@@ -764,6 +766,7 @@ static int add_children(struct twl4030_platform_data *pdata)
 				dev_dbg(&twl->client->dev,
 						"can't create madc dev, %d\n",
 						status);
+				goto err;
 			}
 		} else {
 			pr_debug("%s: can't alloc madc dev\n", DRIVER_NAME);
@@ -799,6 +802,7 @@ static int add_children(struct twl4030_platform_data *pdata)
 				dev_dbg(&twl->client->dev,
 						"can't create rtc dev, %d\n",
 						status);
+				goto err;
 			}
 		} else {
 			pr_debug("%s: can't alloc rtc dev\n", DRIVER_NAME);
@@ -832,7 +836,6 @@ static int add_children(struct twl4030_platform_data *pdata)
 		} else {
 			pr_debug("%s: can't alloc usb dev\n", DRIVER_NAME);
 			status = -ENOMEM;
-			goto err;
 		}
 	}
 
-- 
1.6.0.2.307.gc427

