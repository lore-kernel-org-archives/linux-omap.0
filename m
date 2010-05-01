From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [CBUS PATCH 2/2] cbus: switch kmalloc() + memset() to kzalloc()
Date: Sat,  1 May 2010 21:01:10 +0300
Message-ID: <1272736870-5216-2-git-send-email-felipe.balbi@nokia.com>
References: <1272736870-5216-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44227 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab0EASBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 14:01:02 -0400
In-Reply-To: <1272736870-5216-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Felipe Balbi <me@felipebalbi.com>

From: Felipe Balbi <me@felipebalbi.com>

no functional changes, just using kzalloc().

compile tested with n8x0_defconfig and n770_defconfig

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/cbus/retu-user.c  |    6 +++---
 drivers/cbus/tahvo-usb.c  |    4 ++--
 drivers/cbus/tahvo-user.c |    6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cbus/retu-user.c b/drivers/cbus/retu-user.c
index 1a29492..953d92a 100644
--- a/drivers/cbus/retu-user.c
+++ b/drivers/cbus/retu-user.c
@@ -382,12 +382,12 @@ int retu_user_init(void)
 	struct retu_irq *irq;
 	int res, i;
 
-	irq = kmalloc(sizeof(*irq) * RETU_MAX_IRQ_BUF_LEN, GFP_KERNEL);
+	irq = kzalloc(sizeof(*irq) * RETU_MAX_IRQ_BUF_LEN, GFP_KERNEL);
 	if (irq == NULL) {
-		printk(KERN_ERR PFX "kmalloc failed\n");
+		printk(KERN_ERR PFX "kzalloc failed\n");
 		return -ENOMEM;
 	}
-	memset(irq, 0, sizeof(*irq) * RETU_MAX_IRQ_BUF_LEN);
+
 	for (i = 0; i < RETU_MAX_IRQ_BUF_LEN; i++)
 		list_add(&irq[i].node, &retu_irqs_reserve);
 
diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index ef9fc37..5a344b6 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -655,10 +655,10 @@ static int tahvo_usb_probe(struct device *dev)
 	dev_dbg(dev, "probe\n");
 
 	/* Create driver data */
-	tu = kmalloc(sizeof(*tu), GFP_KERNEL);
+	tu = kzalloc(sizeof(*tu), GFP_KERNEL);
 	if (!tu)
 		return -ENOMEM;
-	memset(tu, 0, sizeof(*tu));
+
 	tu->pt_dev = container_of(dev, struct platform_device, dev);
 #ifdef CONFIG_USB_OTG
 	/* Default mode */
diff --git a/drivers/cbus/tahvo-user.c b/drivers/cbus/tahvo-user.c
index 01e7f20..bd30f06 100644
--- a/drivers/cbus/tahvo-user.c
+++ b/drivers/cbus/tahvo-user.c
@@ -364,12 +364,12 @@ int tahvo_user_init(void)
 	struct tahvo_irq *irq;
 	int res, i;
 
-	irq = kmalloc(sizeof(*irq) * TAHVO_MAX_IRQ_BUF_LEN, GFP_KERNEL);
+	irq = kzalloc(sizeof(*irq) * TAHVO_MAX_IRQ_BUF_LEN, GFP_KERNEL);
 	if (irq == NULL) {
-		printk(KERN_ERR PFX "kmalloc failed\n");
+		printk(KERN_ERR PFX "kzalloc failed\n");
 		return -ENOMEM;
 	}
-	memset(irq, 0, sizeof(*irq) * TAHVO_MAX_IRQ_BUF_LEN);
+
 	for (i = 0; i < TAHVO_MAX_IRQ_BUF_LEN; i++)
 		list_add(&irq[i].node, &tahvo_irqs_reserve);
 
-- 
1.7.1.rc2.7.g3e7f1

