From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/15] OMAPDSS: RFBI: Mark RFBI as broken
Date: Thu, 29 Aug 2013 16:31:46 +0300
Message-ID: <1377783120-14001-2-git-send-email-tomi.valkeinen@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56361 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab3H2NcK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 09:32:10 -0400
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAPDSS's RFBI encoder driver has not been working for some time. The
Nokia N800 is the only board in the mainline that uses RFBI, but it has
never been fully functional.

The RFBI driver needs to be updated to the new panel model, but as
the driver is rather unmaintained and there's no way to test the
changes, let's mark the driver as broken.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 8f70a83..dde4281 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -42,6 +42,7 @@ config OMAP2_DSS_DPI
 
 config OMAP2_DSS_RFBI
 	bool "RFBI support"
+	depends on BROKEN
         default n
 	help
 	  MIPI DBI support (RFBI, Remote Framebuffer Interface, in Texas
-- 
1.8.1.2

