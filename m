From: Adam Ford <aford173@gmail.com>
Subject: [PATCH V2] OMAPDSS: Kconfig: Add HDMI for OMAP4 and OMAP5 dependencies
Date: Tue,  4 Oct 2016 21:07:59 -0500
Message-ID: <1475633279-32424-1-git-send-email-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, airlied@linux.ie, plagnioj@jcrosoft.com, airlied@gmail.com, robdclark@gmail.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Adam Ford <aford173@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make "HDMI for OMAP4" and "HDMI for OMAP5" depend on ARCH_OMAP4
and SOC_OMAP5/DRA7XX respectively.

Signed-off-by: Adam Ford <aford173@gmail.com>

Changes in v2: Add dependancy for DRA7XX or OMAP5

diff --git a/drivers/gpu/drm/omapdrm/dss/Kconfig b/drivers/gpu/drm/omapdrm/dss/Kconfig
index d1fa730..befdd7a 100644
--- a/drivers/gpu/drm/omapdrm/dss/Kconfig
+++ b/drivers/gpu/drm/omapdrm/dss/Kconfig
@@ -69,13 +69,15 @@ config OMAP2_DSS_HDMI_COMMON
 
 config OMAP4_DSS_HDMI
 	bool "HDMI support for OMAP4"
-        default y
+	depends on ARCH_OMAP4
+	default y
 	select OMAP2_DSS_HDMI_COMMON
 	help
 	  HDMI support for OMAP4 based SoCs.
 
 config OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
+	depends on SOC_OMAP5 || SOC_DRA7XX
 	default n
 	select OMAP2_DSS_HDMI_COMMON
 	help
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/Kconfig b/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
index 27d2202..19e2e7b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/dss/Kconfig
@@ -65,13 +65,15 @@ config FB_OMAP2_DSS_HDMI_COMMON
 
 config FB_OMAP4_DSS_HDMI
 	bool "HDMI support for OMAP4"
-        default y
+	depends on ARCH_OMAP4
+	default y
 	select FB_OMAP2_DSS_HDMI_COMMON
 	help
 	  HDMI support for OMAP4 based SoCs.
 
 config FB_OMAP5_DSS_HDMI
 	bool "HDMI support for OMAP5"
+	depends on SOC_OMAP5 || SOC_DRA7XX
 	default n
 	select FB_OMAP2_DSS_HDMI_COMMON
 	help
-- 
2.7.4
