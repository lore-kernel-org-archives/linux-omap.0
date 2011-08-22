From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/10] OMAP: DSS2: DISPC: remove non-existing func prototypes
Date: Mon, 22 Aug 2011 11:27:48 +0300
Message-ID: <1314001671-18123-8-git-send-email-tomi.valkeinen@ti.com>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:56567 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754735Ab1HVI2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:28:19 -0400
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The functions do not exist, so remove the prototypes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index adeff04..c9b50af 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -395,10 +395,6 @@ void dispc_enable_cpr(enum omap_channel channel, bool enable);
 void dispc_set_cpr_coef(enum omap_channel channel,
 		struct omap_dss_cpr_coefs *coefs);
 
-void dispc_set_plane_ba0(enum omap_plane plane, u32 paddr);
-void dispc_set_plane_ba1(enum omap_plane plane, u32 paddr);
-void dispc_set_plane_pos(enum omap_plane plane, u16 x, u16 y);
-void dispc_set_plane_size(enum omap_plane plane, u16 width, u16 height);
 void dispc_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel_out);
 
-- 
1.7.4.1

