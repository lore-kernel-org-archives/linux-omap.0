From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 18/22] cbus: tahvo: drop the get_status hack
Date: Mon, 11 Jul 2011 14:17:31 +0300
Message-ID: <1310383055-20211-19-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36083 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755228Ab1GKLTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:19:15 -0400
Received: by mail-gx0-f175.google.com with SMTP id 3so1851943gxk.34
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:19:14 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

that's really not needed.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo-usb.c |    4 ----
 drivers/cbus/tahvo.c     |    6 ------
 drivers/cbus/tahvo.h     |    1 -
 3 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index e078440..04fe770 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -594,10 +594,6 @@ static int __init tahvo_usb_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 
-	ret = tahvo_get_status();
-	if (!ret)
-		return -ENODEV;
-
 	dev_dbg(dev, "probe\n");
 
 	/* Create driver data */
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index ab6e7ea..2597672 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -59,12 +59,6 @@ struct tahvo {
 
 static struct tahvo *the_tahvo;
 
-int tahvo_get_status(void)
-{
-	return the_tahvo != NULL;
-}
-EXPORT_SYMBOL(tahvo_get_status);
-
 /**
  * __tahvo_read_reg - Reads a value from a register in Tahvo
  * @tahvo: pointer to tahvo structure
diff --git a/drivers/cbus/tahvo.h b/drivers/cbus/tahvo.h
index b2f195f..3c0b381 100644
--- a/drivers/cbus/tahvo.h
+++ b/drivers/cbus/tahvo.h
@@ -50,7 +50,6 @@
 
 #define MAX_TAHVO_IRQ_HANDLERS	8
 
-int tahvo_get_status(void);
 int tahvo_read_reg(unsigned reg);
 void tahvo_write_reg(unsigned reg, u16 val);
 void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear);
-- 
1.7.6

