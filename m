From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] OMAP: DSS2: storage class should be before const qualifier
Date: Thu, 20 May 2010 17:12:52 +0200
Message-ID: <1274368372-4043-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:58520 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab0ETPM5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 11:12:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the beginning
of the declaration specifiers in a declaration is an obsolescent
feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/arm/plat-omap/include/plat/display.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 1c529ce..fbbb966 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -277,8 +277,8 @@ struct omap_video_timings {
  * identify the mode, and does not actually use the configs
  * itself. However, the configs should be something that
  * a normal monitor can also show */
-const extern struct omap_video_timings omap_dss_pal_timings;
-const extern struct omap_video_timings omap_dss_ntsc_timings;
+extern const struct omap_video_timings omap_dss_pal_timings;
+extern const struct omap_video_timings omap_dss_ntsc_timings;
 #endif
 
 struct omap_overlay_info {
-- 
1.6.3.3

