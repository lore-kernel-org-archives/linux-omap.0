From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/4] OMAP: DSS2: FEATURES: Remove DSI & SDI from OMAP2
Date: Thu, 24 Feb 2011 15:34:20 +0200
Message-ID: <1298554461-9879-3-git-send-email-tomi.valkeinen@ti.com>
References: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49196 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296Ab1BXNef (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 08:34:35 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1ODYYKx000803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:34 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1ODYYYI024544
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:34 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1ODYYgp009317
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:34 -0600 (CST)
In-Reply-To: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP2 doesn't support SDI or DSI. Remove them from
omap2_dss_supported_displays.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index f4367f6..fe22d11 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -66,8 +66,7 @@ static const struct dss_reg_field omap3_dss_reg_fields[] = {
 
 static const enum omap_display_type omap2_dss_supported_displays[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
-	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
-	OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI,
+	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI,
 
 	/* OMAP_DSS_CHANNEL_DIGIT */
 	OMAP_DISPLAY_TYPE_VENC,
-- 
1.7.1

