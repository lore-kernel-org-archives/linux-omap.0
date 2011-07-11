From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 01/22] cbus: tahvo: convert spinlock into mutex
Date: Mon, 11 Jul 2011 14:17:14 +0300
Message-ID: <1310383055-20211-2-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:35645 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754535Ab1GKLRu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:17:50 -0400
Received: by mail-gx0-f177.google.com with SMTP id 2so2184713gxk.22
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:17:49 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

GPIO operations can sleep, so move to a
mutex.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index d4a89a6..bc3ca6d 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -32,6 +32,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/mutex.h>
 
 #include "cbus.h"
 #include "tahvo.h"
@@ -43,7 +44,7 @@ static int tahvo_initialized;
 static int tahvo_is_betty;
 
 static struct tasklet_struct tahvo_tasklet;
-static DEFINE_SPINLOCK(tahvo_lock);
+static struct mutex tahvo_lock;
 
 static struct device *the_dev;
 
@@ -97,15 +98,14 @@ EXPORT_SYMBOL(tahvo_write_reg);
  */
 void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
 {
-	unsigned long flags;
 	u16 w;
 
-	spin_lock_irqsave(&tahvo_lock, flags);
+	mutex_lock(&tahvo_lock);
 	w = tahvo_read_reg(reg);
 	w &= ~clear;
 	w |= set;
 	tahvo_write_reg(reg, w);
-	spin_unlock_irqrestore(&tahvo_lock, flags);
+	mutex_unlock(&tahvo_lock);
 }
 
 /*
@@ -113,14 +113,13 @@ void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear)
  */
 void tahvo_disable_irq(int id)
 {
-	unsigned long flags;
 	u16 mask;
 
-	spin_lock_irqsave(&tahvo_lock, flags);
+	mutex_lock(&tahvo_lock);
 	mask = tahvo_read_reg(TAHVO_REG_IMR);
 	mask |= 1 << id;
 	tahvo_write_reg(TAHVO_REG_IMR, mask);
-	spin_unlock_irqrestore(&tahvo_lock, flags);
+	mutex_unlock(&tahvo_lock);
 }
 EXPORT_SYMBOL(tahvo_disable_irq);
 
@@ -129,14 +128,13 @@ EXPORT_SYMBOL(tahvo_disable_irq);
  */
 void tahvo_enable_irq(int id)
 {
-	unsigned long flags;
 	u16 mask;
 
-	spin_lock_irqsave(&tahvo_lock, flags);
+	mutex_lock(&tahvo_lock);
 	mask = tahvo_read_reg(TAHVO_REG_IMR);
 	mask &= ~(1 << id);
 	tahvo_write_reg(TAHVO_REG_IMR, mask);
-	spin_unlock_irqrestore(&tahvo_lock, flags);
+	mutex_unlock(&tahvo_lock);
 }
 EXPORT_SYMBOL(tahvo_enable_irq);
 
@@ -297,6 +295,7 @@ static int __init tahvo_probe(struct platform_device *pdev)
 	int rev, id, ret;
 	int irq;
 
+	mutex_init(&tahvo_lock);
 	the_dev = &pdev->dev;
 
 	/* Prepare tasklet */
-- 
1.7.6

