From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/9] twl4030: fix potential null pointer dereference
Date: Fri, 26 Sep 2008 14:19:48 +0300
Message-ID: <1222427996-7018-2-git-send-email-felipe.balbi@nokia.com>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37402 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbYIZLUj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 07:20:39 -0400
In-Reply-To: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

The following patch fix a potential null pointer
dereference in twl4030 keypad driver when parts
of keypad platform_data aren't passed down to the
driver. At that point kp->dbg_dev is not set yet.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/keyboard/omap-twl4030keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index 3893d63..48f29d3 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -238,7 +238,7 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
-		dev_err(kp->dbg_dev, "No rows, cols or keymap from pdata\n");
+		dev_err(&pdev->dev, "No rows, cols or keymap from pdata\n");
 		kfree(kp);
 		return -EINVAL;
 	}
-- 
1.6.0.2.307.gc427

