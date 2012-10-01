From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V5 2/5] OMAPDSS: Create new debug config options
Date: Mon, 1 Oct 2012 13:18:00 +0530
Message-ID: <1349077680-13559-1-git-send-email-cmahapatra@ti.com>
References: <af097b99b4d2eab96850fd6d8a0c260917aa4f98.1348914940.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33856 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953Ab2JAHvE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Oct 2012 03:51:04 -0400
In-Reply-To: <af097b99b4d2eab96850fd6d8a0c260917aa4f98.1348914940.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The config option CONFIG_OMAP2_DSS_DEBUG_SUPPORT has been removed and replaced
with CONFIG_OMAP2_DSS_DEBUG and CONFIG_OMAP2_DSS_DEBUGFS. CONFIG_OMAP2_DSS_DEBUG
enables DEBUG flag and CONFIG_OMAP2_DSS_DEBUGFS enables creation of debugfs for
OMAPDSS. Both the config options are disabled by default and can be enabled
independently of one another as per convenience.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
changes from V4 to V5
 * added "depends on DEBUG_FS" to OMAP2_DSS_DEBUGFS defintion in Kconfig so that
   CONFIG_OMAP2_DSS_DEBUGFS check become cleaner

 drivers/video/omap2/dss/Kconfig  |   22 ++++++++++++++++------
 drivers/video/omap2/dss/Makefile |    2 +-
 drivers/video/omap2/dss/core.c   |    6 +++---
 drivers/video/omap2/dss/dss.c    |    2 +-
 drivers/video/omap2/dss/dss.h    |    2 +-
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 80f5390..7052487 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -18,16 +18,26 @@ config OMAP2_VRAM_SIZE
 	  You can also set this with "vram=<bytes>" kernel argument, or
 	  in the board file.
 
-config OMAP2_DSS_DEBUG_SUPPORT
-        bool "Debug support"
-	default y
+config OMAP2_DSS_DEBUG
+	bool "Debug support"
+	default n
+	help
+	  This enables printing of debug messages. Alternatively, debug messages
+	  can also be enabled by setting CONFIG_DYNAMIC_DEBUG and then setting
+	  appropriate flags in <debugfs>/dynamic_debug/control.
+
+config OMAP2_DSS_DEBUGFS
+	bool "Debugfs filesystem support"
+	depends on DEBUG_FS
+	default n
 	help
-	  This enables debug messages. You need to enable printing
-	  with 'debug' module parameter.
+	  This enables debugfs for OMAPDSS at <debugfs>/omapdss. This enables
+	  querying about clock configuration and register configuration of dss,
+	  dispc, dsi, hdmi and rfbi.
 
 config OMAP2_DSS_COLLECT_IRQ_STATS
 	bool "Collect DSS IRQ statistics"
-	depends on OMAP2_DSS_DEBUG_SUPPORT
+	depends on OMAP2_DSS_DEBUGFS
 	default n
 	help
 	  Collect DSS IRQ statistics, printable via debugfs.
diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 86493e3..4070191 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -8,4 +8,4 @@ omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
 omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
 omapdss-$(CONFIG_OMAP4_DSS_HDMI) += hdmi.o \
 				    hdmi_panel.o ti_hdmi_4xxx_ip.o
-ccflags-$(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) += -DDEBUG
+ccflags-$(CONFIG_OMAP2_DSS_DEBUG) += -DDEBUG
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index b2af72d..826d64f 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -138,7 +138,7 @@ int dss_set_min_bus_tput(struct device *dev, unsigned long tput)
 		return 0;
 }
 
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
+#if defined(CONFIG_OMAP2_DSS_DEBUGFS)
 static int dss_debug_show(struct seq_file *s, void *unused)
 {
 	void (*func)(struct seq_file *) = s->private;
@@ -193,7 +193,7 @@ int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 
 	return 0;
 }
-#else /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
+#else /* CONFIG_OMAP2_DSS_DEBUGFS */
 static inline int dss_initialize_debugfs(void)
 {
 	return 0;
@@ -205,7 +205,7 @@ int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 {
 	return 0;
 }
-#endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
+#endif /* CONFIG_OMAP2_DSS_DEBUGFS */
 
 /* PLATFORM DEVICE */
 static int omap_dss_pm_notif(struct notifier_block *b, unsigned long v, void *d)
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 2ab1c3e..3954742 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -746,7 +746,7 @@ static void dss_runtime_put(void)
 }
 
 /* DEBUGFS */
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
+#if defined(CONFIG_OMAP2_DSS_DEBUGFS)
 void dss_debug_dump_clocks(struct seq_file *s)
 {
 	dss_dump_clocks(s);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ffbba7e..685275e 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -301,7 +301,7 @@ enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
+#if defined(CONFIG_OMAP2_DSS_DEBUGFS)
 void dss_debug_dump_clocks(struct seq_file *s);
 #endif
 
-- 
1.7.10

