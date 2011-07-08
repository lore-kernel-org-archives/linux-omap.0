From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 10/11] cbus: tahvo: drop some unneded defines
Date: Sat,  9 Jul 2011 01:52:38 +0300
Message-ID: <1310165559-31037-11-git-send-email-balbi@ti.com>
References: <1310165559-31037-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:60114 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752391Ab1GHWxS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 18:53:18 -0400
Received: by bwb11 with SMTP id 11so2123355bwb.9
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 15:53:15 -0700 (PDT)
In-Reply-To: <1310165559-31037-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 04b8203..a538f13 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -33,14 +33,12 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/cbus.h>
 #include <linux/mutex.h>
 
 #include "cbus.h"
 #include "tahvo.h"
 
-#define TAHVO_ID		0x02
-#define PFX			"tahvo: "
-
 struct tahvo {
 	/* device lock */
 	struct mutex	mutex;
@@ -73,7 +71,7 @@ EXPORT_SYMBOL(tahvo_get_status);
  */
 static int __tahvo_read_reg(struct tahvo *tahvo, unsigned reg)
 {
-	return cbus_read_reg(tahvo->dev, TAHVO_ID, reg);
+	return cbus_read_reg(tahvo->dev, CBUS_TAHVO_DEVICE_ID, reg);
 }
 
 /**
@@ -84,7 +82,7 @@ static int __tahvo_read_reg(struct tahvo *tahvo, unsigned reg)
  */
 static void __tahvo_write_reg(struct tahvo *tahvo, unsigned reg, u16 val)
 {
-	cbus_write_reg(tahvo->dev, TAHVO_ID, reg, val);
+	cbus_write_reg(tahvo->dev, CBUS_TAHVO_DEVICE_ID, reg, val);
 }
 
 /**
-- 
1.7.6

