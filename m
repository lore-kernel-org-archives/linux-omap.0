From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] OMAP: McBSP: Remove unused audio macros in mcbsp.h
Date: Fri,  4 Feb 2011 14:45:09 +0530
Message-ID: <1296810909-24737-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48464 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab1BDJSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 04:18:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Some macros defined in mcbsp.h related to audio, which are never being used
is removed.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Charulatha V <charu@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index b87d83c..6ecf105 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -106,13 +106,6 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP_MCBSP_REG_XCCR	0x00
 #define OMAP_MCBSP_REG_RCCR	0x00
 
-#define AUDIO_MCBSP_DATAWRITE	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1)
-#define AUDIO_MCBSP_DATAREAD	(OMAP1510_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1)
-
-#define AUDIO_MCBSP		OMAP_MCBSP1
-#define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
-#define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
-
 #else
 
 #define OMAP_MCBSP_REG_DRR2	0x00
@@ -168,13 +161,6 @@ static struct platform_device omap_mcbsp##port_nr = {	\
 #define OMAP_ST_REG_SFIRCR	0x28
 #define OMAP_ST_REG_SSELCR	0x2C
 
-#define AUDIO_MCBSP_DATAWRITE	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR1)
-#define AUDIO_MCBSP_DATAREAD	(OMAP24XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR1)
-
-#define AUDIO_MCBSP		OMAP_MCBSP2
-#define AUDIO_DMA_TX		OMAP24XX_DMA_MCBSP2_TX
-#define AUDIO_DMA_RX		OMAP24XX_DMA_MCBSP2_RX
-
 #endif
 
 /************************** McBSP SPCR1 bit definitions ***********************/
-- 
1.7.0.4

