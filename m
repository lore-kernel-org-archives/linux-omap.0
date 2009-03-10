From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/12] ARM: OMAP3: Add base address definitions and resources
	for OMAP 3 IS
Date: Tue, 10 Mar 2009 14:15:09 -0700
Message-ID: <20090310211509.16425.5352.stgit@localhost>
References: <20090310205824.16425.97745.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61183 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbZCJVPO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 17:15:14 -0400
In-Reply-To: <20090310205824.16425.97745.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>

This replaces earlier patch from Sergio Aguirre titled "[REVIEW PATCH 03/14]
OMAP34XX: CAM: Resources fixes".

Signed-off-by: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c              |  108 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/omap34xx.h |   27 +++++++
 2 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index ce03fa7..bf84305 100644
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
 #if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 #define OMAP2_MBOX_BASE		IO_ADDRESS(OMAP24XX_MAILBOX_BASE)
 
@@ -506,6 +613,7 @@ static int __init omap2_init_devices(void)
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_hsmmc_reset();
+	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
 	omap_hdq_init();
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index 8e0479f..e50c98f 100644
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

