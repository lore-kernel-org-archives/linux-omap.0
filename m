From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/4] cbus: retu: pwrbutton: grab IRQ via struct resource
Date: Thu, 10 Feb 2011 12:21:20 +0200
Message-ID: <1297333281-29853-4-git-send-email-balbi@ti.com>
References: <1297333281-29853-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:41797 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756043Ab1BJKVj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 05:21:39 -0500
Received: by mail-fx0-f51.google.com with SMTP id 5so1293562fxm.38
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 02:21:37 -0800 (PST)
In-Reply-To: <1297333281-29853-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

now that we pass IRQ via struct resource, we can
simply use it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-pwrbutton.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
index 24efdee..593a73a 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -83,7 +83,7 @@ static int __init retubutton_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	pwr->irq = CBUS_RETU_IRQ_BASE + RETU_INT_PWR;
+	pwr->irq = platform_get_irq(pdev, 0);
 	platform_set_drvdata(pdev, pwr);
 
 	ret = request_threaded_irq(pwr->irq, NULL, retubutton_irq, 0,
-- 
1.7.4.rc2

