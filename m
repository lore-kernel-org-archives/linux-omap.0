From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 3/3] staging: drm/omap: use current time for page-flip event
Date: Sun, 11 Mar 2012 21:11:22 -0500
Message-ID: <1331518282-6870-3-git-send-email-rob.clark@linaro.org>
References: <1331518282-6870-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46788 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660Ab2CLCLQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Mar 2012 22:11:16 -0400
Received: by yhmm54 with SMTP id m54so2087016yhm.19
        for <linux-omap@vger.kernel.org>; Sun, 11 Mar 2012 19:11:16 -0700 (PDT)
In-Reply-To: <1331518282-6870-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Because we don't have vblank hooked up via drm_irq (which is a bit
awkward due to separation between omapdss (which knows the irq #)
and omapdrm, for now use gettimeofday to have a semi-sane timestamp
in the page-flip event.  Otherwise apps like weston drm compositor,
which use the timestamp in it's animations, get highly confused.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_crtc.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_crtc.c b/drivers/staging/omapdrm/omap_crtc.c
index 13e3c7f..490a7f1 100644
--- a/drivers/staging/omapdrm/omap_crtc.c
+++ b/drivers/staging/omapdrm/omap_crtc.c
@@ -134,9 +134,19 @@ static void vblank_cb(void *arg)
 
 	/* wakeup userspace */
 	if (event) {
+		do_gettimeofday(&now);
+
 		spin_lock_irqsave(&dev->event_lock, flags);
+		/* TODO: we can't yet use the vblank time accounting,
+		 * because omapdss lower layer is the one that knows
+		 * the irq # and registers the handler, which more or
+		 * less defeats how drm_irq works.. for now just fake
+		 * the sequence number and use gettimeofday..
+		 *
 		event->event.sequence = drm_vblank_count_and_time(
 				dev, omap_crtc->id, &now);
+		 */
+		event->event.sequence = sequence++;
 		event->event.tv_sec = now.tv_sec;
 		event->event.tv_usec = now.tv_usec;
 		list_add_tail(&event->base.link,
-- 
1.7.5.4

