From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix compile for omap1_bl.c
Date: Wed, 6 Jan 2010 10:56:11 -0800
Message-ID: <20100106185611.GA11511@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53602 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584Ab0AFS4N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 13:56:13 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Emese Revfy <re.emese@gmail.com>, Richard Purdie <rpurdie@linux.intel.com>
Cc: linux-omap@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'd like to push the following compile fix via the omap-fixes
queue. Emese & Richard, care to ack?

Regards,

Tony


--bg08WKrSYDhXBjb5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap1-bl.patch"

>From 72318a4604b7fa40a1e65d3e18f639ba0134d789 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 6 Jan 2010 10:31:06 -0800
Subject: [PATCH] omap: Fix compile for omap1_bl.c

Commit 9905a43b made struct backlight_ops const. Omap was
setting check_fb dynamically, which caused the following
compile error:

drivers/video/backlight/omap1_bl.c: In function 'omapbl_probe':
drivers/video/backlight/omap1_bl.c:142: error: assignment of read-only variable 'omapbl_ops'

Turns out pdata->check_fb is not being used, so just remove
it to fix the compile.

Cc: Emese Revfy <re.emese@gmail.com>
Cc: Richard Purdie <rpurdie@linux.intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index 376ce18..5cd6220 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -99,7 +99,6 @@ struct fb_info;
 struct omap_backlight_config {
 	int default_intensity;
 	int (*set_power)(struct device *dev, int state);
-	int (*check_fb)(struct fb_info *fb);
 };
 
 struct omap_fbmem_config {
diff --git a/drivers/video/backlight/omap1_bl.c b/drivers/video/backlight/omap1_bl.c
index 409ca96..a3a7f89 100644
--- a/drivers/video/backlight/omap1_bl.c
+++ b/drivers/video/backlight/omap1_bl.c
@@ -139,8 +139,6 @@ static int omapbl_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENXIO;
 
-	omapbl_ops.check_fb = pdata->check_fb;
-
 	bl = kzalloc(sizeof(struct omap_backlight), GFP_KERNEL);
 	if (unlikely(!bl))
 		return -ENOMEM;

--bg08WKrSYDhXBjb5--
