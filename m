From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/13] OMAPDSS: DSI: improve wait_for_bit_change
Date: Thu, 24 Nov 2011 15:29:40 +0200
Message-ID: <1322141381-5395-13-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:35669 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756059Ab1KXNaW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:22 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

We sometimes get timeout when disabling the DSI interface with video
mode. It looks like the disable will stall until the current frame has
been finished, and this can take multiple milliseconds.

wait_for_bit_change() currently uses a busyloop to wait for a bit to
change. This is used in multiple places. The problem is, we don't have
clear understanding how long particular operations can take, so the
function needs to support longer waits.

Improve wait_for_bit_change() to first busy loop for 100 times to see if
the bit changes almost right away. If the bit hasn't changed, move to a
loop with a sleep of 1ms, and poll for 500ms.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 22055db..a01a011 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -418,14 +418,29 @@ static void dsi_completion_handler(void *data, u32 mask)
 static inline int wait_for_bit_change(struct platform_device *dsidev,
 		const struct dsi_reg idx, int bitnum, int value)
 {
-	int t = 100000;
+	unsigned long timeout;
+	ktime_t wait;
+	int t;
+
+	/* first busyloop to see if the bit changes right away */
+	t = 100;
+	while (t-- > 0) {
+		if (REG_GET(dsidev, idx, bitnum, bitnum) == value)
+			return value;
+	}
+
+	/* then loop for 500ms, sleeping for 1ms in between */
+	timeout = jiffies + msecs_to_jiffies(500);
+	while (time_before(jiffies, timeout)) {
+		if (REG_GET(dsidev, idx, bitnum, bitnum) == value)
+			return value;
 
-	while (REG_GET(dsidev, idx, bitnum, bitnum) != value) {
-		if (--t == 0)
-			return !value;
+		wait = ns_to_ktime(1000 * 1000);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_hrtimeout(&wait, HRTIMER_MODE_REL);
 	}
 
-	return value;
+	return !value;
 }
 
 u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt)
-- 
1.7.4.1

