From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 10/27] cbus: tahvo: drop some unneded defines
Date: Thu, 13 Oct 2011 11:34:45 +0300
Message-ID: <1318494902-13093-10-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42754 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753890Ab1JMIf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:28 -0400
Received: by mail-bw0-f48.google.com with SMTP id r19so1581388bka.35
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:27 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
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
1.7.6.396.ge0613

