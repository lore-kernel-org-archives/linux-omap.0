From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V4 1/5] OMAPDSS: Move definition of DEBUG flag to Makefile
Date: Sat, 29 Sep 2012 16:19:22 +0530
Message-ID: <fbaf2825628b01a7b660993a83a8f3de37cfcd04.1348914940.git.cmahapatra@ti.com>
References: <cover.1348826106.git.cmahapatra@ti.com> <cover.1348914940.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39142 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab2I2Kvy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Sep 2012 06:51:54 -0400
In-Reply-To: <cover.1348914940.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

In OMAPDSS the DEBUG flag is set only after the OMAPDSS module is called, for
which the debugging capabilities are available only after its proper
initialization. As a result of which tracking of bugs prior to or during initial
process becomes difficult. So, the definition of DEBUG is being moved to the
corresponding Makefile.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/Makefile |    1 +
 drivers/video/omap2/dss/dss.h    |    4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 4549869..86493e3 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -8,3 +8,4 @@ omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi.o \
 				    hdmi_panel.o ti_hdmi_4xxx_ip.o
+ccflags-$(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) += -DDEBUG
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6728892..ffbba7e 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -23,10 +23,6 @@
 #ifndef __OMAP2_DSS_H
 #define __OMAP2_DSS_H
 
-#ifdef CONFIG_OMAP2_DSS_DEBUG_SUPPORT
-#define DEBUG
-#endif
-
 #ifdef DEBUG
 extern bool dss_debug;
 #ifdef DSS_SUBSYS_NAME
-- 
1.7.10

