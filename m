From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/14] OMAPDSS: remove dsi videomode from dssdev
Date: Fri, 8 Mar 2013 13:52:49 +0200
Message-ID: <1362743569-10289-15-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44149 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933530Ab3CHLxc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 06:53:32 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DSI videomode is no longer needed in the omap_dss_device, so remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index cbaf60f..8979086 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -631,7 +631,6 @@ struct omap_dss_device {
 
 		enum omap_dss_dsi_pixel_format dsi_pix_fmt;
 		enum omap_dss_dsi_mode dsi_mode;
-		struct omap_dss_dsi_videomode_timings dsi_vm_timings;
 	} panel;
 
 	struct {
-- 
1.7.10.4

