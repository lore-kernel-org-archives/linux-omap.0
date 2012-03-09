From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] OMAPDSS: OMAPFB: check for matching memory size early
Date: Fri,  9 Mar 2012 02:42:49 +0200
Message-ID: <1331253769-9770-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33813 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635Ab2CIAmz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 19:42:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

If the size of memory region that is being set up is the same as before,
we don't have to do memory and layer busy checks.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
I'm not sure if this is semantically correct, but this helps to get
some old programs working, that rely on old DSS version which didn't
check for mmap lock, but incidentally they are using same size too..

 drivers/video/omap2/omapfb/omapfb-ioctl.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index df7bcce..a0ac95c 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -225,6 +225,9 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 	down_write_nested(&rg->lock, rg->id);
 	atomic_inc(&rg->lock_count);
 
+	if (rg->size == size && rg->type == mi->type)
+		goto out;
+
 	if (atomic_read(&rg->map_count)) {
 		r = -EBUSY;
 		goto out;
@@ -245,12 +248,10 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 		}
 	}
 
-	if (rg->size != size || rg->type != mi->type) {
-		r = omapfb_realloc_fbmem(fbi, size, mi->type);
-		if (r) {
-			dev_err(fbdev->dev, "realloc fbmem failed\n");
-			goto out;
-		}
+	r = omapfb_realloc_fbmem(fbi, size, mi->type);
+	if (r) {
+		dev_err(fbdev->dev, "realloc fbmem failed\n");
+		goto out;
 	}
 
  out:
-- 
1.7.0.4

