From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 3/7] OMAP3ISP: Preview: Dynamic update of Color
 effects
Date: Tue, 6 Jan 2009 14:41:58 -0600
Message-ID: <A24693684029E5489D1D202277BE894416328060@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59715 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbZAFUmG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 15:42:06 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n06Kg1QO004972
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:06 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n06Kg1v1007662
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:01 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From 7489c709a46cbc2f0c4fe4f6ed716597b930a0fe Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 6 Jan 2009 14:17:35 -0600
Subject: [PATCH] OMAP3ISP: Preview: Dynamic update of Color effects

This patch allows to update color effects instantly when streaming is off.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isppreview.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/isp/isppreview.c b/drivers/media/video/isp/isppreview.c
index 4bd2ed5..3c214c3 100755
--- a/drivers/media/video/isp/isppreview.c
+++ b/drivers/media/video/isp/isppreview.c
@@ -1457,7 +1457,15 @@ EXPORT_SYMBOL(isppreview_get_brightness_range);
 void isppreview_set_color(u8 *mode)
 {
 	ispprev_obj.color = *mode;
-	update_color_matrix = 1;
+	spin_lock(&ispprev_obj.ispprev_lock);
+	if (ispprev_obj.stream_on == 0) {
+		isppreview_config_rgb_to_ycbcr(
+			flr_prev_csc[ispprev_obj.color]);
+		update_color_matrix = 0;
+	} else
+		update_color_matrix = 1;
+
+	spin_unlock(&ispprev_obj.ispprev_lock);
 }
 EXPORT_SYMBOL(isppreview_set_color);
 
-- 
1.5.6.5

