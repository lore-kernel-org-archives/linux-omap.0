From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] input: keypad: fix null pointer dereference
Date: Thu, 25 Sep 2008 17:24:20 +0300
Message-ID: <20080925142420.GH24627@gandalf.research.nokia.com>
References: <20080925134742.GF24627@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65327 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbYIYOYx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 10:24:53 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8PEOSIv014903
	for <linux-omap@vger.kernel.org>; Thu, 25 Sep 2008 17:24:50 +0300
Content-Disposition: inline
In-Reply-To: <20080925134742.GF24627@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <felipe.balbi@nokia.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

From: Felipe Balbi <felipe.balbi@nokia.com>

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
