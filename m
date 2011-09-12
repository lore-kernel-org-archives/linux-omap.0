From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 4/8] OMAP: DSS2: DSI: Add comment about regn
Date: Mon, 12 Sep 2011 12:12:49 +0300
Message-ID: <1315818773-18660-5-git-send-email-tomi.valkeinen@ti.com>
References: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:41905 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753204Ab1ILJNR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:13:17 -0400
In-Reply-To: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

regn divider is one greater than the REGN divider in TRM. Add a comment
to point this out.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 528cf79..ce1aacd 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -503,6 +503,7 @@ struct omap_dss_device {
 		} dispc;
 
 		struct {
+			/* regn is one greater than TRM's REGN value */
 			u16 regn;
 			u16 regm;
 			u16 regm_dispc;
-- 
1.7.4.1

