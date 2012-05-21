From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/8] OMAPFB: remove compiler warnings when CONFIG_BUG=n
Date: Mon, 21 May 2012 12:28:02 +0300
Message-ID: <1337592486-13040-5-git-send-email-tomi.valkeinen@ti.com>
References: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:57369 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932536Ab2EUJ2b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:28:31 -0400
Received: by lahc1 with SMTP id c1so4056029lah.4
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:28:26 -0700 (PDT)
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
 drivers/video/omap2/omapfb/omapfb-main.c |    1 +
 drivers/video/omap2/omapfb/omapfb.h      |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 165a4be..3450ea0 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -179,6 +179,7 @@ static unsigned omapfb_get_vrfb_offset(const struct omapfb_info *ofbi, int rot)
 		break;
 	default:
 		BUG();
+		return 0;
 	}
 
 	offset *= vrfb->bytespp;
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index c0bdc9b..30361a0 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -166,6 +166,7 @@ static inline struct omapfb_display_data *get_display_data(
 
 	/* This should never happen */
 	BUG();
+	return NULL;
 }
 
 static inline void omapfb_lock(struct omapfb2_device *fbdev)
-- 
1.7.9.5

