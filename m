From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 04/11] cbus: tahvo: don't go over 80 columns
Date: Sat,  9 Jul 2011 01:52:32 +0300
Message-ID: <1310165559-31037-5-git-send-email-balbi@ti.com>
References: <1310165559-31037-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38532 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752296Ab1GHWw7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 18:52:59 -0400
Received: by bwb5 with SMTP id 5so909157bwb.7
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 15:52:56 -0700 (PDT)
In-Reply-To: <1310165559-31037-1-git-send-email-balbi@ti.com>
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
1.7.6

