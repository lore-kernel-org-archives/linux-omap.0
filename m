From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/10] OMAP: OMAPFB: string parsing cleanups
Date: Mon, 22 Aug 2011 11:27:47 +0300
Message-ID: <1314001671-18123-7-git-send-email-tomi.valkeinen@ti.com>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:33234 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756693Ab1HVI2S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:28:18 -0400
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use strtobool instead of kstrtoint when parsing bool from sysfs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-sysfs.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
index 153bf1a..1694d51 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -104,16 +104,14 @@ static ssize_t store_mirror(struct device *dev,
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct omapfb_info *ofbi = FB2OFB(fbi);
-	int mirror;
+	bool mirror;
 	int r;
 	struct fb_var_screeninfo new_var;
 
-	r = kstrtoint(buf, 0, &mirror);
+	r = strtobool(buf, &mirror);
 	if (r)
 		return r;
 
-	mirror = !!mirror;
-
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
 
-- 
1.7.4.1

