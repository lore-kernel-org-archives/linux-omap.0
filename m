From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/12] omap1: Fix compile for omap1_bl.c
Date: Wed, 06 Jan 2010 16:19:46 -0800
Message-ID: <20100107001946.21352.78046.stgit@baageli.muru.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53839 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab0AGATo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:19:44 -0500
In-Reply-To: <20100107001728.21352.38471.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Emese Revfy <re.emese@gmail.com>, linux-omap@vger.kernel.org, Richard Purdie <rpurdie@linux.intel.com>

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
---
 arch/arm/plat-omap/include/plat/board.h |    1 -
 drivers/video/backlight/omap1_bl.c      |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

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

