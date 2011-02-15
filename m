From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 10/15] cbus: retu: pwrbutton: save device pointer on our structure
Date: Tue, 15 Feb 2011 10:45:57 +0200
Message-ID: <1297759562-25682-11-git-send-email-balbi@ti.com>
References: <1297759562-25682-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53856 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752004Ab1BOIrV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:47:21 -0500
Received: by mail-yw0-f43.google.com with SMTP id 5so2439394yws.16
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 00:47:04 -0800 (PST)
In-Reply-To: <1297759562-25682-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

We will start passing our device pointer to
read/write functions exported from retu so
we need to save the device pointer on our
context structure.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu-pwrbutton.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
index 593a73a..77c655d 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -47,6 +47,7 @@
 
 struct retu_pwrbutton {
 	struct input_dev	*idev;
+	struct device		*dev;
 
 	int			state;
 	int			irq;
@@ -83,6 +84,7 @@ static int __init retubutton_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
+	pwr->dev = &pdev->dev;
 	pwr->irq = platform_get_irq(pdev, 0);
 	platform_set_drvdata(pdev, pwr);
 
-- 
1.7.4.rc2

