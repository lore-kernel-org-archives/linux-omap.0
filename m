From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 5/8] OMAP: DSS2: DISPC: Add missing IRQ  definitions
Date: Mon, 12 Sep 2011 12:12:50 +0300
Message-ID: <1315818773-18660-6-git-send-email-tomi.valkeinen@ti.com>
References: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:41180 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751972Ab1ILJNU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:13:20 -0400
In-Reply-To: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add IRQ definitions for missing OMAP4 IRQs: FRAMEDONEWB, FRAMEDONETV,
WBBUFFEROVERFLOW.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ce1aacd..8120433 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -43,6 +43,9 @@
 #define DISPC_IRQ_VSYNC2		(1 << 18)
 #define DISPC_IRQ_ACBIAS_COUNT_STAT2	(1 << 21)
 #define DISPC_IRQ_FRAMEDONE2		(1 << 22)
+#define DISPC_IRQ_FRAMEDONEWB		(1 << 23)
+#define DISPC_IRQ_FRAMEDONETV		(1 << 24)
+#define DISPC_IRQ_WBBUFFEROVERFLOW	(1 << 25)
 
 struct omap_dss_device;
 struct omap_overlay_manager;
-- 
1.7.4.1

