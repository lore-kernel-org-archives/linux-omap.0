From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 24/35] ARM: OMAP2+: display: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:11 +0300
Message-ID: <1429102402-5276-25-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35765 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755394AbbDOMxL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:53:11 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed by hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/common.h  |    4 ++--
 arch/arm/mach-omap2/devices.c |    4 ++--
 arch/arm/mach-omap2/display.c |    8 ++++----
 arch/arm/mach-omap2/display.h |    2 +-
 arch/arm/mach-omap2/drm.c     |    4 ++--
 arch/arm/mach-omap2/fb.c      |    8 ++++----
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 46e2458..54cf6ca 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -321,8 +321,8 @@ extern int omap_dss_reset(struct omap_hwmod *);
 /* SoC specific clock initializer */
 int omap_clk_init(void);
 
-int __init omapdss_init_of(void);
-void __init omapdss_early_init_of(void);
+int omapdss_init_of(void);
+void omapdss_early_init_of(void);
 
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 1afb50d..b7f717a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -346,12 +346,12 @@ static struct platform_device omap_vout_device = {
 	.id		= -1,
 };
 
-int __init omap_init_vout(void)
+int omap_init_vout(void)
 {
 	return platform_device_register(&omap_vout_device);
 }
 #else
-int __init omap_init_vout(void) { return 0; }
+int omap_init_vout(void) { return 0; }
 #endif
 
 /*-------------------------------------------------------------------------*/
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 7a050f9..6a2d4aa 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -254,7 +254,7 @@ err:
 	return ERR_PTR(r);
 }
 
-static enum omapdss_version __init omap_display_get_version(void)
+static enum omapdss_version omap_display_get_version(void)
 {
 	if (cpu_is_omap24xx())
 		return OMAPDSS_VER_OMAP24xx;
@@ -557,12 +557,12 @@ int omap_dss_reset(struct omap_hwmod *oh)
 	return r;
 }
 
-void __init omapdss_early_init_of(void)
+void omapdss_early_init_of(void)
 {
 
 }
 
-struct device_node * __init omapdss_find_dss_of_node(void)
+struct device_node *omapdss_find_dss_of_node(void)
 {
 	struct device_node *node;
 
@@ -585,7 +585,7 @@ struct device_node * __init omapdss_find_dss_of_node(void)
 	return NULL;
 }
 
-int __init omapdss_init_of(void)
+int omapdss_init_of(void)
 {
 	int r;
 	enum omapdss_version ver;
diff --git a/arch/arm/mach-omap2/display.h b/arch/arm/mach-omap2/display.h
index 7375854..4fcc326 100644
--- a/arch/arm/mach-omap2/display.h
+++ b/arch/arm/mach-omap2/display.h
@@ -31,6 +31,6 @@ int omap_init_vrfb(void);
 int omap_init_fb(void);
 int omap_init_vout(void);
 
-struct device_node * __init omapdss_find_dss_of_node(void);
+struct device_node *omapdss_find_dss_of_node(void);
 
 #endif
diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index facd740..c1ea886 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -41,7 +41,7 @@ static struct platform_device omap_drm_device = {
 	.id = 0,
 };
 
-int __init omap_init_drm(void)
+int omap_init_drm(void)
 {
 	platform_data.omaprev = GET_OMAP_TYPE;
 
@@ -49,5 +49,5 @@ int __init omap_init_drm(void)
 
 }
 #else
-int __init omap_init_drm(void) { return 0; }
+int omap_init_drm(void) { return 0; }
 #endif
diff --git a/arch/arm/mach-omap2/fb.c b/arch/arm/mach-omap2/fb.c
index 26e28e9..028976a 100644
--- a/arch/arm/mach-omap2/fb.c
+++ b/arch/arm/mach-omap2/fb.c
@@ -65,7 +65,7 @@ static const struct resource omap3_vrfb_resources[] = {
 	DEFINE_RES_MEM_NAMED(0xfc000000u, 0x4000000, "vrfb-area-11"),
 };
 
-int __init omap_init_vrfb(void)
+int omap_init_vrfb(void)
 {
 	struct platform_device *pdev;
 	const struct resource *res;
@@ -87,7 +87,7 @@ int __init omap_init_vrfb(void)
 	return PTR_RET(pdev);
 }
 #else
-int __init omap_init_vrfb(void) { return 0; }
+int omap_init_vrfb(void) { return 0; }
 #endif
 
 #if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
@@ -106,10 +106,10 @@ static struct platform_device omap_fb_device = {
 	.num_resources = 0,
 };
 
-int __init omap_init_fb(void)
+int omap_init_fb(void)
 {
 	return platform_device_register(&omap_fb_device);
 }
 #else
-int __init omap_init_fb(void) { return 0; }
+int omap_init_fb(void) { return 0; }
 #endif
-- 
1.7.9.5

