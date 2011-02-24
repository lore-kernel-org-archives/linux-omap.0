From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 13/13] OMAP: hwmod: Removal of macros for data that is obtained from hwmod database
Date: Thu, 24 Feb 2011 15:16:57 +0530
Message-ID: <1298540817-15874-14-git-send-email-kishon@ti.com>
References: <1298540817-15874-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36672 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166Ab1BXJwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 04:52:43 -0500
In-Reply-To: <1298540817-15874-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, peter.ujfalusi@nokia.com
Cc: p-basak2@ti.com, kishon@ti.com, charu@ti.com, shubhrajyoti@ti.com

Information like base address and DMA channel nubers should no longer
be obtained using macros. These information should be obtained from
hwmod database. Hence the macros that define the base address are removed.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |   25 +------------------------
 1 files changed, 1 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 21c9b10..f8f690a 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -52,30 +52,7 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP1610_MCBSP2_BASE	0xfffb1000
 #define OMAP1610_MCBSP3_BASE	0xe1017000
 
-#define OMAP24XX_MCBSP1_BASE	0x48074000
-#define OMAP24XX_MCBSP2_BASE	0x48076000
-#define OMAP2430_MCBSP3_BASE	0x4808c000
-#define OMAP2430_MCBSP4_BASE	0x4808e000
-#define OMAP2430_MCBSP5_BASE	0x48096000
-
-#define OMAP34XX_MCBSP1_BASE	0x48074000
-#define OMAP34XX_MCBSP2_BASE	0x49022000
-#define OMAP34XX_MCBSP2_ST_BASE	0x49028000
-#define OMAP34XX_MCBSP3_BASE	0x49024000
-#define OMAP34XX_MCBSP3_ST_BASE	0x4902A000
-#define OMAP34XX_MCBSP3_BASE	0x49024000
-#define OMAP34XX_MCBSP4_BASE	0x49026000
-#define OMAP34XX_MCBSP5_BASE	0x48096000
-
-#define OMAP44XX_MCBSP1_BASE	0x40122000
-#define OMAP44XX_MCBSP1_DMA_BASE	0x49022000
-#define OMAP44XX_MCBSP2_BASE	0x40124000
-#define OMAP44XX_MCBSP2_DMA_BASE	0x49024000
-#define OMAP44XX_MCBSP3_BASE	0x40126000
-#define OMAP44XX_MCBSP3_DMA_BASE	0x49026000
-#define OMAP44XX_MCBSP4_BASE	0x48096000
-
-#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+#ifdef CONFIG_ARCH_OMAP1
 
 #define OMAP_MCBSP_REG_DRR2	0x00
 #define OMAP_MCBSP_REG_DRR1	0x02
-- 
1.7.0.4

