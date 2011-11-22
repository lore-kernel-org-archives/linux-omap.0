From: jean.pihet@newoldbits.com
Subject: [PATCH 19/26] OMAP2+: SmartReflex: Remove the notifier handler
Date: Tue, 22 Nov 2011 16:06:03 +0100
Message-ID: <1321974370-25800-20-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43561 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188Ab1KVPHZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:25 -0500
Received: by mail-ww0-f44.google.com with SMTP id 5so432213wwe.1
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:24 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Paul Walmsley <paul@pwsan.com>

If needed should be handled by an atomic notifier. Currently no
code needs this.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    8 +++++---
 arch/arm/mach-omap2/smartreflex.h |    5 -----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 882f1d5..e57263a 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -110,8 +110,10 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		sr_write_reg(sr, IRQSTATUS, status);
 	}
 
-	if (sr_class->notify)
-		sr_class->notify(sr, status);
+	/*
+	 * XXX If the class driver needs to be notified here, it should
+	 * use an atomic notifier
+	 */
 
 	return IRQ_HANDLED;
 }
@@ -184,7 +186,7 @@ static int sr_late_init(struct smartreflex *sr)
 	struct resource *mem;
 	int ret = 0;
 
-	if (sr_class->notify && sr_class->notify_flags && sr->irq) {
+	if (sr->irq) {
 		ret = request_irq(sr->irq, sr_interrupt, 0, sr->name,
 				  (void *)sr);
 		if (ret)
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 59fff8a..e0e8ee3 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -187,9 +187,6 @@ struct omap_sr_dev_attr {
  * @enable:		API to enable a particular class smaartreflex.
  * @disable:		API to disable a particular class smartreflex.
  * @configure:		API to configure a particular class smartreflex.
- * @notify:		API to notify the class driver about an event in SR.
- *			Not needed for class3.
- * @notify_flags:	specify the events to be notified to the class driver
  * @class_type:		specify which smartreflex class.
  *			Can be used by the SR driver to take any class
  *			based decisions.
@@ -198,8 +195,6 @@ struct smartreflex_class_data {
 	int (*enable)(struct smartreflex *sr);
 	int (*disable)(struct smartreflex *sr, int is_volt_reset);
 	int (*configure)(struct smartreflex *sr);
-	int (*notify)(struct smartreflex *sr, u32 status);
-	u8 notify_flags;
 	u8 class_type;
 };
 
-- 
1.7.5.4

