From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/4] cbus: retu: pass IRQ via struct resource
Date: Thu, 10 Feb 2011 12:21:18 +0200
Message-ID: <1297333281-29853-2-git-send-email-balbi@ti.com>
References: <1297333281-29853-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:44861 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755992Ab1BJKVd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 05:21:33 -0500
Received: by mail-fx0-f49.google.com with SMTP id 19so1263863fxm.36
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 02:21:32 -0800 (PST)
In-Reply-To: <1297333281-29853-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

that's the preferred way to pass resources
to drivers anyway.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index fa666fe..6134781 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -306,12 +306,24 @@ static void retu_power_off(void)
 	for (;;);
 }
 
+static struct resource generic_resources[] = {
+	{
+		.start	= -EINVAL,	/* fixed later */
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= -EINVAL,	/* fixed later */
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 /**
  * retu_allocate_child - Allocates one Retu child
  * @name: name of new child
  * @parent: parent device for this child
  */
-static struct device *retu_allocate_child(char *name, struct device *parent)
+static struct device *retu_allocate_child(char *name, struct device *parent,
+		int irq_base, int irq1, int irq2, int num)
 {
 	struct platform_device		*pdev;
 	int				status;
@@ -324,6 +336,18 @@ static struct device *retu_allocate_child(char *name, struct device *parent)
 
 	pdev->dev.parent = parent;
 
+	if (num) {
+		generic_resources[0].start = irq_base + irq1;
+		generic_resources[1].start = irq_base + irq2;
+
+		status = platform_device_add_resources(pdev,
+				generic_resources, num);
+		if (status < 0) {
+			dev_dbg(parent, "can't add resources to %s\n", name);
+			goto err;
+		}
+	}
+
 	status = platform_device_add(pdev);
 	if (status < 0) {
 		dev_dbg(parent, "can't add %s\n", name);
@@ -334,29 +358,33 @@ static struct device *retu_allocate_child(char *name, struct device *parent)
 
 err:
 	platform_device_put(pdev);
+
 	return NULL;
 }
 
 /**
  * retu_allocate_children - Allocates Retu's children
  */
-static int retu_allocate_children(struct device *parent)
+static int retu_allocate_children(struct device *parent, int irq_base)
 {
 	struct device	*child;
 
-	child = retu_allocate_child("retu-pwrbutton", parent);
+	child = retu_allocate_child("retu-pwrbutton", parent, irq_base,
+			RETU_INT_PWR, -1, 1);
 	if (!child)
 		return -ENOMEM;
 
-	child = retu_allocate_child("retu-headset", parent);
+	child = retu_allocate_child("retu-headset", parent, irq_base,
+			RETU_INT_HOOK, -1, 1);
 	if (!child)
 		return -ENOMEM;
 
-	child = retu_allocate_child("retu-rtc", parent);
+	child = retu_allocate_child("retu-rtc", parent, irq_base,
+			RETU_INT_RTCS, RETU_INT_RTCA, 2);
 	if (!child)
 		return -ENOMEM;
 
-	child = retu_allocate_child("retu-wdt", parent);
+	child = retu_allocate_child("retu-wdt", parent, -1, -1, -1, 0);
 	if (!child)
 		return -ENOMEM;
 
@@ -423,7 +451,7 @@ static int __init retu_probe(struct platform_device *pdev)
 	/* Register power off function */
 	pm_power_off = retu_power_off;
 
-	ret = retu_allocate_children(&pdev->dev);
+	ret = retu_allocate_children(&pdev->dev, retu->irq_base);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to allocate Retu children\n");
 		goto err2;
-- 
1.7.4.rc2

