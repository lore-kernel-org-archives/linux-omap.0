From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 04/22] cbus: tahvo: don't go over 80 columns
Date: Mon, 11 Jul 2011 14:17:17 +0300
Message-ID: <1310383055-20211-5-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:52448 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754826Ab1GKLSF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:18:05 -0400
Received: by mail-gy0-f174.google.com with SMTP id 3so1429246gyh.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:18:04 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

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

