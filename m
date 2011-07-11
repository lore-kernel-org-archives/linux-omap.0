From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 10/22] cbus: tahvo: drop some unneded defines
Date: Mon, 11 Jul 2011 14:17:23 +0300
Message-ID: <1310383055-20211-11-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:49345 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754517Ab1GKLSg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:18:36 -0400
Received: by gxk8 with SMTP id 8so1474549gxk.9
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:18:34 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

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

