From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] input: keypad: fix null pointer dereference
Date: Thu, 25 Sep 2008 16:47:42 +0300
Message-ID: <20080925134742.GF24627@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62293 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbYIYNtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 09:49:15 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8PDn09t009992
	for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 16:49:13 +0300
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

There was a potential NULL pointer dereference if we don't pass
some fields of omap_kp_platform_data.

At the point of the error message, kp->dbg_dev is not set so it
would generate a NULL pointer dereference right away.

Fix it by using &pdev->dev

Signed-of-by: Felipe Balbi <felipe.balbi@nokia.com>
---

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index 3893d63..48f29d3 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -238,7 +238,7 @@ static int __init omap_kp_probe(struct platform_device *pdev)
                return -ENOMEM;
 
        if (!pdata->rows || !pdata->cols || !pdata->keymap) {
-               dev_err(kp->dbg_dev, "No rows, cols or keymap from pdata\n");
+               dev_err(&pdev->dev, "No rows, cols or keymap from pdata\n");
                kfree(kp);
                return -EINVAL;
        }


-- 
balbi
