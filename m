From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/23] OMAPDSS: HDMI: improve Makefile
Date: Thu, 24 Apr 2014 13:17:13 +0300
Message-ID: <1398334639-14172-18-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47178 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850AbaDXKTX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:23 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We'll soon add support for OMAP5 HDMI, which uses some of the same files
as OMAP4 HDMI does.

This patch adds a new config entry "OMAP2_DSS_HDMI_COMMON", which both
OMAP4 and OMAP5 HDMI config entries can select. OMAP2_DSS_HDMI_COMMON
will cause the common HDMI files to be compiled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/Kconfig  | 9 ++++++---
 drivers/video/fbdev/omap2/dss/Makefile | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbdev/omap2/dss/Kconfig
index dde4281663b1..36de3d5d2896 100644
--- a/drivers/video/fbdev/omap2/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/dss/Kconfig
@@ -59,12 +59,15 @@ config OMAP2_DSS_VENC
 	help
 	  OMAP Video Encoder support for S-Video and composite TV-out.
 
+config OMAP2_DSS_HDMI_COMMON
+	bool
+
 config OMAP4_DSS_HDMI
-	bool "HDMI support"
+	bool "HDMI support for OMAP4"
         default y
+	select OMAP2_DSS_HDMI_COMMON
 	help
-	  HDMI Interface. This adds the High Definition Multimedia Interface.
-	  See http://www.hdmi.org/ for HDMI specification.
+	  HDMI support for OMAP4 based SoCs.
 
 config OMAP4_DSS_HDMI_AUDIO
 	bool
diff --git a/drivers/video/fbdev/omap2/dss/Makefile b/drivers/video/fbdev/omap2/dss/Makefile
index 8aec8bda27cc..4cbe7ce406f9 100644
--- a/drivers/video/fbdev/omap2/dss/Makefile
+++ b/drivers/video/fbdev/omap2/dss/Makefile
@@ -10,6 +10,7 @@ omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
 omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
-omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi4.o hdmi_common.o hdmi_wp.o hdmi_pll.o \
-	hdmi_phy.o hdmi4_core.o
+omapdss-$(CONFIG_OMAP2_DSS_HDMI_COMMON) += hdmi_common.o hdmi_wp.o hdmi_pll.o \
+	hdmi_phy.o
+omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi4.o hdmi4_core.o
 ccflags-$(CONFIG_OMAP2_DSS_DEBUG) += -DDEBUG
-- 
1.9.1

