From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 04/27] cbus: tahvo: don't go over 80 columns
Date: Thu, 13 Oct 2011 11:34:39 +0300
Message-ID: <1318494902-13093-4-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:56696 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753874Ab1JMIfR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:17 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so1495500bkb.33
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:16 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

cleanup only, no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 647d263..0e28208 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -299,8 +299,9 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	dev_err(&pdev->dev, "%s v%d.%d found\n", tahvo_is_betty ? "Betty" : "Tahvo",
-	       (rev >> 4) & 0x0f, rev & 0x0f);
+	dev_err(&pdev->dev, "%s v%d.%d found\n",
+			tahvo_is_betty ? "Betty" : "Tahvo",
+			(rev >> 4) & 0x0f, rev & 0x0f);
 
 	irq = platform_get_irq(pdev, 0);
 
-- 
1.7.6.396.ge0613

