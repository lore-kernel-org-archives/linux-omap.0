From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 9/9] OMAPDSS: DSI: make OMAP2_DSS_DSI depend on ARCH_OMAP5
Date: Mon, 24 Sep 2012 16:58:39 +0300
Message-ID: <1348495119-8262-10-git-send-email-tomi.valkeinen@ti.com>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:42610 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755601Ab2IXN7D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 09:59:03 -0400
Received: by lbbgj3 with SMTP id gj3so6750413lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 06:59:00 -0700 (PDT)
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Change omapdss Kconfig file to make OMAP2_DSS_DSI depend on ARCH_OMAP5.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index b337a84..80f5390 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -84,7 +84,7 @@ config OMAP2_DSS_SDI
 
 config OMAP2_DSS_DSI
 	bool "DSI support"
-	depends on ARCH_OMAP3 || ARCH_OMAP4
+	depends on ARCH_OMAP3 || ARCH_OMAP4 || ARCH_OMAP5
         default n
 	help
 	  MIPI DSI (Display Serial Interface) support.
-- 
1.7.9.5

