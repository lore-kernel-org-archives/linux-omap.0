From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP: FB: Fix Null pointer check
Date: Thu, 20 May 2010 19:59:51 +0530
Message-ID: <1274365792-24938-3-git-send-email-manjugk@ti.com>
References: <1274365792-24938-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56263 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755075Ab0ETOa1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 10:30:27 -0400
In-Reply-To: <1274365792-24938-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Satish Kumar <satish.k@ti.com>, Tony Lindgren <tony@atomide.com>

From: Satish Kumar <satish.k@ti.com>

Fix Null pointer check for display pointer in omapfb_blank().

Signed-off-by: Satish Kumar <satish.k@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 4b4506d..63268cf 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1217,6 +1217,11 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 	int do_update = 0;
 	int r = 0;
 
+	if (display == NULL) {
+		printk(KERN_ERR "omapfb_blank: fb2display returned NULL\n");
+		return -EINVAL;
+	}
+
 	omapfb_lock(fbdev);
 
 	switch (blank) {
-- 
1.7.0.4

