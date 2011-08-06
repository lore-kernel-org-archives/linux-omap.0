From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 3/9] OMAP: omap_device: make latency autoadjust messages debug
Date: Fri,  5 Aug 2011 17:19:19 -0700
Message-ID: <1312589965-19416-4-git-send-email-khilman@ti.com>
References: <1312589965-19416-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:41114 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757363Ab1HFATc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 20:19:32 -0400
Received: by mail-iy0-f174.google.com with SMTP id 40so4813555iyf.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 17:19:31 -0700 (PDT)
In-Reply-To: <1312589965-19416-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>

From: Grazvydas Ignotas <notasas@gmail.com>

During normal system operation warning messages similar to this
are appearing quite often:
omap_device: omap4-keypad.-1: new worst case activate latency 0: 61035

This doesn't seem to be reporting a problem, nor is it very useful for
non-developers, so reduce it to debug level.

Acked-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/omap_device.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 28ef0b4..14c5363 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -146,10 +146,10 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 			odpl->activate_lat_worst = act_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->activate_lat = act_lat;
-				dev_warn(&od->pdev.dev,
-					 "new worst case activate latency "
-					 "%d: %llu\n",
-					 od->pm_lat_level, act_lat);
+				dev_dbg(&od->pdev.dev,
+					"new worst case activate latency "
+					"%d: %llu\n",
+					od->pm_lat_level, act_lat);
 			} else
 				dev_warn(&od->pdev.dev,
 					 "activate latency %d "
@@ -213,10 +213,10 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 			odpl->deactivate_lat_worst = deact_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->deactivate_lat = deact_lat;
-				dev_warn(&od->pdev.dev,
-					 "new worst case deactivate latency "
-					 "%d: %llu\n",
-					 od->pm_lat_level, deact_lat);
+				dev_dbg(&od->pdev.dev,
+					"new worst case deactivate latency "
+					"%d: %llu\n",
+					od->pm_lat_level, deact_lat);
 			} else
 				dev_warn(&od->pdev.dev,
 					 "deactivate latency %d "
-- 
1.7.6

