From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/8] OMAPDSS: VRFB: remove compiler warnings when CONFIG_BUG=n
Date: Mon, 21 May 2012 12:28:03 +0300
Message-ID: <1337592486-13040-6-git-send-email-tomi.valkeinen@ti.com>
References: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33373 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932522Ab2EUJ2b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:28:31 -0400
Received: by lahg1 with SMTP id g1so7853659lah.16
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:28:28 -0700 (PDT)
In-Reply-To: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

If CONFIG_BUG is not enabled, BUG() does not stop the execution. Many
places in code expect the execution to stop, and this causes compiler
warnings about uninitialized variables and returning from a non-void
function without a return value.

This patch fixes the warnings by initializing the variables and
returning properly after BUG() lines. However, the behaviour is still
undefined after the BUG, but this is the choice the user makes when
using CONFIG_BUG=n.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/vrfb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/vrfb.c b/drivers/video/omap2/vrfb.c
index 4e5b960..7e99022 100644
--- a/drivers/video/omap2/vrfb.c
+++ b/drivers/video/omap2/vrfb.c
@@ -179,8 +179,10 @@ void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
 		pixel_size_exp = 2;
 	else if (bytespp == 2)
 		pixel_size_exp = 1;
-	else
+	else {
 		BUG();
+		return;
+	}
 
 	vrfb_width = ALIGN(width * bytespp, VRFB_PAGE_WIDTH) / bytespp;
 	vrfb_height = ALIGN(height, VRFB_PAGE_HEIGHT);
-- 
1.7.9.5

