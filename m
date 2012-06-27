From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] omap dss2: fix specification spelling in Kconfig
Date: Wed, 27 Jun 2012 22:09:22 +0200
Message-ID: <1340827762-27688-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42929 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757508Ab2F0UJZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 16:09:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/video/omap2/dss/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 43324e5..b337a84 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -52,7 +52,7 @@ config OMAP2_DSS_RFBI
 	  DBI is a bus between the host processor and a peripheral,
 	  such as a display or a framebuffer chip.
 
-	  See http://www.mipi.org/ for DBI spesifications.
+	  See http://www.mipi.org/ for DBI specifications.
 
 config OMAP2_DSS_VENC
 	bool "VENC support"
@@ -92,7 +92,7 @@ config OMAP2_DSS_DSI
 	  DSI is a high speed half-duplex serial interface between the host
 	  processor and a peripheral, such as a display or a framebuffer chip.
 
-	  See http://www.mipi.org/ for DSI spesifications.
+	  See http://www.mipi.org/ for DSI specifications.
 
 config OMAP2_DSS_MIN_FCK_PER_PCK
 	int "Minimum FCK/PCK ratio (for scaling)"
-- 
1.7.9.5

