From: felipe.balbi@nokia.com
Subject: [RFC PATCH 25/37] cbus: retu: allocate platform_device for Retu's children
Date: Wed,  7 Apr 2010 19:04:16 +0300
Message-ID: <1270656268-7034-26-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62354 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570Ab0DGQFe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:34 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5Psp007673
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:05:33 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

after this patch, Retu's children can start moving to
platform_driver infrastructure.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index ea09c17..bc81a9b 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -330,6 +330,67 @@ static void retu_power_off(void)
 }
 
 /**
+ * retu_allocate_child - Allocates one Retu child
+ * @name: name of new child
+ * @parent: parent device for this child
+ */
+static struct device *retu_allocate_child(char *name, struct device *parent)
+{
+	struct platform_device		*pdev;
+	int				status;
+
+	pdev = platform_device_alloc(name, -1);
+	if (!pdev) {
+		dev_dbg(parent, "can't allocate %s\n", name);
+		goto err;
+	}
+
+	pdev->dev.parent = parent;
+
+	status = platform_device_add(pdev);
+	if (status < 0) {
+		dev_dbg(parent, "can't add %s\n", name);
+		goto err;
+	}
+
+	return &pdev->dev;
+
+err:
+	platform_device_put(pdev);
+	return NULL;
+}
+
+/**
+ * retu_allocate_children - Allocates Retu's children
+ */
+static int retu_allocate_children(struct device *parent)
+{
+	struct device	*child;
+
+	child = retu_allocate_child("retu-pwrbutton", parent);
+	if (!child)
+		return -ENOMEM;
+
+	child = retu_allocate_child("retu-headset", parent);
+	if (!child)
+		return -ENOMEM;
+
+	child = retu_allocate_child("retu-rtc", parent);
+	if (!child)
+		return -ENOMEM;
+
+	child = retu_allocate_child("retu-user", parent);
+	if (!child)
+		return -ENOMEM;
+
+	child = retu_allocate_child("retu-wdt", parent);
+	if (!child)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
  * retu_probe - Probe for Retu ASIC
  * @dev: the Retu device
  *
@@ -400,6 +461,19 @@ static int __devinit retu_probe(struct platform_device *pdev)
 	}
 #endif
 
+	ret = retu_allocate_children(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to allocate Retu children\n");
+#ifdef CONFIG_CBUS_RETU_USER
+		retu_user_cleanup();
+#endif
+		retu_write_reg(RETU_REG_IMR, 0xffff);
+		free_irq(gpio_to_irq(retu_irq_pin), 0);
+		gpio_free(retu_irq_pin);
+		tasklet_kill(&retu_tasklet);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
1.7.0.rc0.33.g7c3932

