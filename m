From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] fbdev: omap2: Fix typo in tvc_probe_pdata
Date: Mon,  5 Jan 2015 14:09:47 +0100
Message-ID: <1420463387-26391-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:39874 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbbAENKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2015 08:10:08 -0500
Received: by mail-lb0-f180.google.com with SMTP id l4so17391517lbv.39
        for <linux-omap@vger.kernel.org>; Mon, 05 Jan 2015 05:10:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Assigning ddata->invert_polarity to itself is not very useful; the
context suggests that the right-hand side should have been
pdata->invert_polarity.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c b/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
index 9a2b5ce58545..8511c648a15c 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
@@ -208,7 +208,7 @@ static int tvc_probe_pdata(struct platform_device *pdev)
 	ddata->in = in;
 
 	ddata->connector_type = pdata->connector_type;
-	ddata->invert_polarity = ddata->invert_polarity;
+	ddata->invert_polarity = pdata->invert_polarity;
 
 	dssdev = &ddata->dssdev;
 	dssdev->name = pdata->name;
-- 
2.1.3

