From: Archit Taneja <archit@ti.com>
Subject: [PATCH 09/11] OMAPDSS: remove unnecessary DSI external TE pin platform info from omap_dss_device
Date: Wed, 13 Feb 2013 19:37:12 +0530
Message-ID: <1360764434-18788-10-git-send-email-archit@ti.com>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59393 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934052Ab3BMOIW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:08:22 -0500
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The omap_dss_device provides platform related parameters ext_te and ext_te_gpio
for DSI command mode panels. These parameters are now owned by a panel driver's
platform_data instead.

Remove these fields as they aren't used anymore.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 include/video/omapdss.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index d5dcd50..ec68769 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -579,9 +579,6 @@ struct omap_dss_device {
 
 		struct {
 			int module;
-
-			bool ext_te;
-			u8 ext_te_gpio;
 		} dsi;
 
 		struct {
-- 
1.7.9.5

