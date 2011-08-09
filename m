From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH 04/14] OMAP: McBSP: use existing macros for converting between devices
Date: Tue, 09 Aug 2011 19:10:22 +0500
Message-ID: <1312897232-4792-5-git-send-email-manjugk@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.76.145] ([117.192.76.145]:56117 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750820Ab1HINxm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Aug 2011 09:53:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, Kevin Hilman <khilman@ti.com>


From: Kevin Hilman <khilman@ti.com>

For converting from struct device to platform_device, and from
platform_device to struct device, there are existing macros.  Use
them instead of manual use of container_of().

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/mcbsp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 5587acf..3f4a45d 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -295,9 +295,9 @@ EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap_device *find_omap_device_by_dev(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-					struct platform_device, dev);
-	return container_of(pdev, struct omap_device, pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return to_omap_device(pdev);
 }
 
 static void omap_st_on(struct omap_mcbsp *mcbsp)
-- 
1.7.1

