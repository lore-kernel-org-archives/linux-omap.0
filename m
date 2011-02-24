From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/4] OMAP: DSS2: FEATURES: Remove SDI from 3630 displays
Date: Thu, 24 Feb 2011 15:34:19 +0200
Message-ID: <1298554461-9879-2-git-send-email-tomi.valkeinen@ti.com>
References: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52638 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296Ab1BXNed (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 08:34:33 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1ODYXEH022684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:33 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1ODYWmb000612
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:32 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1ODYWo9009313
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:32 -0600 (CST)
In-Reply-To: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP 3630 does not support SDI. Split omap3_dss_supported_displays into
3430 and 3630 entries, and remove the SDI from 3630 entry.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index cf3ef69..f4367f6 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -73,7 +73,7 @@ static const enum omap_display_type omap2_dss_supported_displays[] = {
 	OMAP_DISPLAY_TYPE_VENC,
 };
 
-static const enum omap_display_type omap3_dss_supported_displays[] = {
+static const enum omap_display_type omap3430_dss_supported_displays[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
 	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
 	OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI,
@@ -82,6 +82,15 @@ static const enum omap_display_type omap3_dss_supported_displays[] = {
 	OMAP_DISPLAY_TYPE_VENC,
 };
 
+static const enum omap_display_type omap3630_dss_supported_displays[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
+	OMAP_DISPLAY_TYPE_DSI,
+
+	/* OMAP_DSS_CHANNEL_DIGIT */
+	OMAP_DISPLAY_TYPE_VENC,
+};
+
 static const enum omap_display_type omap4_dss_supported_displays[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
 	OMAP_DISPLAY_TYPE_DBI | OMAP_DISPLAY_TYPE_DSI,
@@ -161,7 +170,7 @@ static struct omap_dss_features omap3430_dss_features = {
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
-	.supported_displays = omap3_dss_supported_displays,
+	.supported_displays = omap3430_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
 };
 
@@ -176,7 +185,7 @@ static struct omap_dss_features omap3630_dss_features = {
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
-	.supported_displays = omap3_dss_supported_displays,
+	.supported_displays = omap3630_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
 };
 
-- 
1.7.1

