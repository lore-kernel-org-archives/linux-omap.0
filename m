From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 28/32] OMAPDSS: separate compat files in the Makefile
Date: Thu, 15 Nov 2012 17:58:36 +0200
Message-ID: <1352995120-3288-29-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59144 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768316Ab2KOP75 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 10:59:57 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate the core DSS files and compat layer files in the Makefile for
clarity.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Makefile |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index c834f9c..61949ff 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,7 +1,10 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
+# Core DSS files
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
-	manager.o manager-sysfs.o overlay.o overlay-sysfs.o output.o apply.o \
-	display-sysfs.o dispc-compat.o
+	output.o
+# DSS compat layer files
+omapdss-y += manager.o manager-sysfs.o overlay.o overlay-sysfs.o apply.o \
+	dispc-compat.o display-sysfs.o
 omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o venc_panel.o
-- 
1.7.10.4

