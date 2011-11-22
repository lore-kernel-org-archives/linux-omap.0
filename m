From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/65] OMAPDSS: DISPC: add missing prototype
Date: Tue, 22 Nov 2011 11:21:00 +0200
Message-ID: <1321953724-6350-2-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55044 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756181Ab1KVJWf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:22:35 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc_mgr_is_enabled() was missing a prototype in dss.h

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6308fc5..3310f10 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -414,6 +414,7 @@ void dispc_mgr_set_cpr_coef(enum omap_channel channel,
 		struct omap_dss_cpr_coefs *coefs);
 bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
+bool dispc_mgr_is_enabled(enum omap_channel channel);
 void dispc_mgr_enable(enum omap_channel channel, bool enable);
 bool dispc_mgr_is_channel_enabled(enum omap_channel channel);
 void dispc_mgr_set_io_pad_mode(enum dss_io_pad_mode mode);
-- 
1.7.4.1

