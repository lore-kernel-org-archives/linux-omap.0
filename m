From: hvaibhav@ti.com
Subject: [PATCH 5/5] OMAP3EVM: Kconfig option added for selection between SVIDEO and CVBS
Date: Thu, 17 Dec 2009 20:49:36 +0530
Message-ID: <1261063176-20101-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54610 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965142AbZLQPT6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Dec 2009 10:19:58 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Config option added to arch/arm/plat-omap/Kconfig for selection
of S-Video and Composite output interfaces. The default configuration would
be S-Video.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++++
 drivers/video/omap2/dss/Kconfig      |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index e615254..549e58e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -275,7 +275,11 @@ static struct omap_dss_device omap3_evm_tv_device = {
 	.name			= "tv",
 	.driver_name		= "venc",
 	.type			= OMAP_DISPLAY_TYPE_VENC,
+#if defined(CONFIG_OMAP2_VENC_OUT_TYPE_SVIDEO)
 	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+#elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
+	.u.venc.type		= OMAP_DSS_VENC_TYPE_COMPOSITE,
+#endif
 	.platform_enable	= omap3_evm_enable_tv,
 	.platform_disable	= omap3_evm_disable_tv,
 };
diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 71d8dec..5b7a8bc 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -36,6 +36,21 @@ config OMAP2_DSS_VENC
         default y
 	help
 	  OMAP Video Encoder support.
+choice
+	prompt OMAP2_VENC_OUT_TYPE
+	depends on OMAP2_DSS_VENC
+	default OMAP2_VENC_OUT_TYPE_SVIDEO
+
+config OMAP2_VENC_OUT_TYPE_SVIDEO
+	bool "Use S-Video output interface"
+	help
+	  Select this option if you want to choose TV out over S-Video
+
+config OMAP2_VENC_OUT_TYPE_COMPOSITE
+	bool "Use Composite output interface"
+	help
+	  Select this option if you want to choose TV out over Composite
+endchoice
 
 config OMAP2_DSS_SDI
 	bool "SDI support"
-- 
1.6.2.4

