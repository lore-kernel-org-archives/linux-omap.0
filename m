From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH] OMAPDSS: OMAPFB: Fix possible null pointer dereferencing
Date: Mon, 19 Nov 2012 10:40:15 +0530
Message-ID: <1353301815-21277-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:43252 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab2KSFQX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 00:16:23 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so586716dak.19
        for <linux-omap@vger.kernel.org>; Sun, 18 Nov 2012 21:16:22 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, patches@linaro.org, tomi.valkeinen@ti.com

If display is NULL, display->output would lead to kernel panic.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 55a39be..532a31b 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -787,7 +787,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 
 	case OMAPFB_WAITFORVSYNC:
 		DBG("ioctl WAITFORVSYNC\n");
-		if (!display && !display->output && !display->output->manager) {
+		if (!display || !display->output || !display->output->manager) {
 			r = -EINVAL;
 			break;
 		}
-- 
1.7.4.1

