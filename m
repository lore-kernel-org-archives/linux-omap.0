From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/12] ARM: OMAP3: Add base address definitions and
	resources for OMAP 3 IS, v2
Date: Mon, 23 Mar 2009 18:37:36 -0700
Message-ID: <20090324013736.GO29546@atomide.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310211509.16425.5352.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UFHRwCdBEJvubb2X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57896 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbZCXBhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 21:37:31 -0400
Content-Disposition: inline
In-Reply-To: <20090310211509.16425.5352.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090310 14:15]:
> This replaces earlier patch from Sergio Aguirre titled "[REVIEW PATCH 03/14]
> OMAP34XX: CAM: Resources fixes".

Here's this one updated to apply on top of Hiroshi's mbox updates
series.

Tony

--UFHRwCdBEJvubb2X
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="camera-isp-resources-v2.patch"

>From 85262ef9917eea14d5aaa37996e3f9205eee9e3d Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 23 Mar 2009 18:23:49 -0700
Subject: [PATCH] ARM: OMAP3: Add base address definitions and resources for OMAP 3 IS, v2

This replaces earlier patch from Sergio Aguirre titled "[REVIEW PATCH 03/14]
OMAP34XX: CAM: Resources fixes".

Signed-off-by: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 14537ff..7b2af1b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -28,6 +28,113 @@
 #include <mach/eac.h>
 #include <mach/mmc.h>
 
+#if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
+
+static struct resource cam_resources[] = {
+	{
+		.start		= OMAP24XX_CAMERA_BASE,
+		.end		= OMAP24XX_CAMERA_BASE + 0xfff,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= INT_24XX_CAM_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device omap_cam_device = {
+	.name		= "omap24xxcam",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(cam_resources),
+	.resource	= cam_resources,
+};
+
+static inline void omap_init_camera(void)
+{
+	platform_device_register(&omap_cam_device);
+}
+
+#elif defined(CONFIG_VIDEO_OMAP3) || defined(CONFIG_VIDEO_OMAP3_MODULE)
+
+static struct resource omap3isp_resources[] = {
+	{
+		.start		= OMAP3430_ISP_BASE,
+		.end		= OMAP3430_ISP_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3430_ISP_CBUFF_BASE,
+		.end		= OMAP3430_ISP_CBUFF_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3430_ISP_CCP2_BASE,
+		.end		= OMAP3430_ISP_CCP2_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3430_ISP_CCDC_BASE,
+		.end		= OMAP3430_ISP_CCDC_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3430_ISP_HIST_BASE,
+		.end		= OMAP3430_ISP_HIST_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3430_ISP_H3A_BASE,
+		.end		= OMAP3430_ISP_H3A_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3430_ISP_PREV_BASE,
+		.end		= OMAP3430_ISP_PREV_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3430_ISP_RESZ_BASE,
+		.end		= OMAP3430_ISP_RESZ_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3430_ISP_SBL_BASE,
+		.end		= OMAP3430_ISP_SBL_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3430_ISP_CSI2A_BASE,
+		.end		= OMAP3430_ISP_CSI2A_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP3430_ISP_CSI2PHY_BASE,
+		.end		= OMAP3430_ISP_CSI2PHY_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= INT_34XX_CAM_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device omap3isp_device = {
+	.name		= "omap3isp",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(omap3isp_resources),
+	.resource	= omap3isp_resources,
+};
+
+static inline void omap_init_camera(void)
+{
+	platform_device_register(&omap3isp_device);
+}
+#else
+static inline void omap_init_camera(void)
+{
+}
+#endif
+
 #if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
 
 #define MBOX_REG_SIZE	0x120
@@ -527,6 +634,7 @@ static int __init omap2_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_hsmmc_reset();
+	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
 	omap_hdq_init();
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index 89173f1..1b1c35d 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -49,6 +49,33 @@
 #define OMAP343X_CTRL_BASE	OMAP343X_SCM_BASE
 
 #define OMAP34XX_IC_BASE	0x48200000
+
+#define OMAP3430_ISP_BASE		(L4_34XX_BASE + 0xBC000)
+#define OMAP3430_ISP_CBUFF_BASE		(OMAP3430_ISP_BASE + 0x0100)
+#define OMAP3430_ISP_CCP2_BASE		(OMAP3430_ISP_BASE + 0x0400)
+#define OMAP3430_ISP_CCDC_BASE		(OMAP3430_ISP_BASE + 0x0600)
+#define OMAP3430_ISP_HIST_BASE		(OMAP3430_ISP_BASE + 0x0A00)
+#define OMAP3430_ISP_H3A_BASE		(OMAP3430_ISP_BASE + 0x0C00)
+#define OMAP3430_ISP_PREV_BASE		(OMAP3430_ISP_BASE + 0x0E00)
+#define OMAP3430_ISP_RESZ_BASE		(OMAP3430_ISP_BASE + 0x1000)
+#define OMAP3430_ISP_SBL_BASE		(OMAP3430_ISP_BASE + 0x1200)
+#define OMAP3430_ISP_MMU_BASE		(OMAP3430_ISP_BASE + 0x1400)
+#define OMAP3430_ISP_CSI2A_BASE		(OMAP3430_ISP_BASE + 0x1800)
+#define OMAP3430_ISP_CSI2PHY_BASE	(OMAP3430_ISP_BASE + 0x1970)
+
+#define OMAP3430_ISP_END		(OMAP3430_ISP_BASE         + 0x06F)
+#define OMAP3430_ISP_CBUFF_END		(OMAP3430_ISP_CBUFF_BASE   + 0x077)
+#define OMAP3430_ISP_CCP2_END		(OMAP3430_ISP_CCP2_BASE    + 0x1EF)
+#define OMAP3430_ISP_CCDC_END		(OMAP3430_ISP_CCDC_BASE    + 0x0A7)
+#define OMAP3430_ISP_HIST_END		(OMAP3430_ISP_HIST_BASE    + 0x047)
+#define OMAP3430_ISP_H3A_END		(OMAP3430_ISP_H3A_BASE     + 0x05F)
+#define OMAP3430_ISP_PREV_END		(OMAP3430_ISP_PREV_BASE    + 0x09F)
+#define OMAP3430_ISP_RESZ_END		(OMAP3430_ISP_RESZ_BASE    + 0x0AB)
+#define OMAP3430_ISP_SBL_END		(OMAP3430_ISP_SBL_BASE     + 0x0FB)
+#define OMAP3430_ISP_MMU_END		(OMAP3430_ISP_MMU_BASE     + 0x06F)
+#define OMAP3430_ISP_CSI2A_END		(OMAP3430_ISP_CSI2A_BASE   + 0x16F)
+#define OMAP3430_ISP_CSI2PHY_END	(OMAP3430_ISP_CSI2PHY_BASE + 0x007)
+
 #define OMAP34XX_IVA_INTC_BASE	0x40000000
 #define OMAP34XX_HSUSB_OTG_BASE	(L4_34XX_BASE + 0xAB000)
 #define OMAP34XX_HSUSB_HOST_BASE	(L4_34XX_BASE + 0x64000)

--UFHRwCdBEJvubb2X--
