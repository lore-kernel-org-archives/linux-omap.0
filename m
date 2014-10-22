From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/5] OMAPDSS: DISPC: fix mflag offset
Date: Wed, 22 Oct 2014 11:39:32 +0300
Message-ID: <1413967174-28009-3-git-send-email-tomi.valkeinen@ti.com>
References: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42061 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011AbaJVIkK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 04:40:10 -0400
In-Reply-To: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The register offset for DISPC_OVL_MFLAG_THRESHOLD is wrong, fix it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.h b/drivers/video/fbdev/omap2/dss/dispc.h
index 78edb449c763..3043d6e0a5f9 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.h
+++ b/drivers/video/fbdev/omap2/dss/dispc.h
@@ -101,8 +101,7 @@
 					DISPC_FIR_COEF_V2_OFFSET(n, i))
 #define DISPC_OVL_PRELOAD(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_PRELOAD_OFFSET(n))
-#define DISPC_OVL_MFLAG_THRESHOLD(n)	(DISPC_OVL_BASE(n) + \
-					DISPC_MFLAG_THRESHOLD_OFFSET(n))
+#define DISPC_OVL_MFLAG_THRESHOLD(n)	DISPC_MFLAG_THRESHOLD_OFFSET(n)
 
 /* DISPC up/downsampling FIR filter coefficient structure */
 struct dispc_coef {
-- 
2.1.1

