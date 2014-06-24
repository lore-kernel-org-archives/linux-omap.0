From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/15] OMAPDSS: Kconfig: select HDMI
Date: Tue, 24 Jun 2014 13:03:50 +0300
Message-ID: <1403604240-16738-6-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39609 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbaFXKER (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2014 06:04:17 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Select HDMI support to be able to use HDMI infoframe helpers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index 285bcd103dce..3d5eb6c36c22 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -5,6 +5,7 @@ menuconfig OMAP2_DSS
         tristate "OMAP2+ Display Subsystem support"
 	select VIDEOMODE_HELPERS
 	select OMAP2_DSS_INIT
+	select HDMI
         help
 	  OMAP2+ Display Subsystem support.
 
-- 
1.9.1

