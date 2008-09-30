From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 01/25] twl4030: fix potential null pointer dereference
Date: Tue, 30 Sep 2008 21:42:45 +0300
Message-ID: <1222800189-29737-2-git-send-email-me@felipebalbi.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51183 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbYI3SnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:43:23 -0400
In-Reply-To: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

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
1.6.0.1.196.g01914

