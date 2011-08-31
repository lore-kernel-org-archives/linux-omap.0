From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/8] OMAP: DSS2: DSI: Add comment about regn
Date: Wed, 31 Aug 2011 16:21:44 +0300
Message-ID: <1314796908-17354-5-git-send-email-tomi.valkeinen@ti.com>
References: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36649 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755572Ab1HaNWM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:22:12 -0400
In-Reply-To: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

regn divider is one greater than the REGN divider in TRM. Add a comment
to point this out.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 534e3d1..d4c85f2 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -450,6 +450,7 @@ struct omap_dss_device {
 		} dispc;
 
 		struct {
+			/* regn is one greater than TRM's REGN value */
 			u16 regn;
 			u16 regm;
 			u16 regm_dispc;
-- 
1.7.4.1

