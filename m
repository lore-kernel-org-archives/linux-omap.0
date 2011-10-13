From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 23/27] cbus: tahvo: prepare for children without IRQ
Date: Thu, 13 Oct 2011 11:34:58 +0300
Message-ID: <1318494902-13093-23-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48178 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753840Ab1JMIfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:55 -0400
Received: by mail-bw0-f52.google.com with SMTP id zs2so85840bkb.25
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:53 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

not all tahvo children have a dedicated IRQ
so don't add a resource for those.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 43f6d6a..1540042 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -266,13 +266,15 @@ static struct device *tahvo_allocate_child(const char *name,
 
 	pdev->dev.parent = parent;
 
-	generic_resources[0].start = irq;
-
-	ret = platform_device_add_resources(pdev,
-			generic_resources, ARRAY_SIZE(generic_resources));
-	if (ret < 0) {
-		dev_dbg(parent, "can't add resources to %s\n", name);
-		goto err1;
+	if (irq > 0) {
+		generic_resources[0].start = irq;
+
+		ret = platform_device_add_resources(pdev, generic_resources,
+				ARRAY_SIZE(generic_resources));
+		if (ret < 0) {
+			dev_dbg(parent, "can't add resources to %s\n", name);
+			goto err1;
+		}
 	}
 
 	ret = platform_device_add(pdev);
-- 
1.7.6.396.ge0613

