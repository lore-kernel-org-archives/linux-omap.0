From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] OMAP: omap-mcbsp: Fix building after replacement
Date: Thu, 20 Jan 2011 15:12:11 +0100
Message-ID: <1295532731-5438-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57285 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab1ATOMW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 09:12:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>

Fix building omap-mcbsp after replacing ARCH_OMAP24x0 in
commit 8a9c1aa6a4caa7db1c2fca4b47168af9077e0f95.

>   omap: Start using CONFIG_SOC_OMAP
>
>    We want to have just CONFIG_ARCH_OMAP2, 3 and 4. The rest
>    are nowadays just subcategories of these.
>
>    Search and replace the following:
>
>    ARCH_OMAP2420               SOC_OMAP2420
>    ARCH_OMAP2430               SOC_OMAP2430
>    ARCH_OMAP3430               SOC_OMAP3430

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 sound/soc/omap/omap-mcbsp.c |    1 +
 sound/soc/omap/omap-mcbsp.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 3cc293b..ede6afd 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -113,6 +113,7 @@ static const int omap44xx_dma_reqs[][2] = {
 static const int omap44xx_dma_reqs[][2] = {};
 #endif
 
+#if defined(CONFIG_SOC_OMAP2420)
 static const unsigned long omap2420_mcbsp_port[][2] = {
 	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1,
 	  OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1 },
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index b7b0ce1..37dc721 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -54,6 +54,7 @@ enum omap_mcbsp_div {
 #undef  NUM_LINKS
 #define NUM_LINKS	4
 #endif
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_OMAP2430)
 #undef  NUM_LINKS
 #define NUM_LINKS	5
 #endif
-- 
1.7.4.rc2

