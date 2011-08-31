From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 01/14] omap: mcbsp: Remove omap device API
Date: Wed, 31 Aug 2011 18:22:48 +0300
Message-ID: <1314804181-17260-2-git-send-email-jarkko.nikula@bitmer.com>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:53059 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756451Ab1HaPX1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 11:23:27 -0400
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jhnikula@gmail.com>

From: Jarkko Nikula <jhnikula@gmail.com>

struct omap_device *od is only set with find_omap_device_by_dev but not used
otherwise so remove them and references to omap device API.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/mcbsp.c |   27 ---------------------------
 1 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6c62af1..4b233e8 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -24,7 +24,6 @@
 #include <linux/slab.h>
 
 #include <plat/mcbsp.h>
-#include <plat/omap_device.h>
 #include <linux/pm_runtime.h>
 
 /* XXX These "sideways" includes are a sign that something is wrong */
@@ -258,19 +257,9 @@ int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream)
 EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
 
 #ifdef CONFIG_ARCH_OMAP3
-static struct omap_device *find_omap_device_by_dev(struct device *dev)
-{
-	struct platform_device *pdev = container_of(dev,
-					struct platform_device, dev);
-	return container_of(pdev, struct omap_device, pdev);
-}
-
 static void omap_st_on(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
-	struct omap_device *od;
-
-	od = find_omap_device_by_dev(mcbsp->dev);
 
 	/*
 	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
@@ -292,9 +281,6 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 static void omap_st_off(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
-	struct omap_device *od;
-
-	od = find_omap_device_by_dev(mcbsp->dev);
 
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
 	MCBSP_ST_WRITE(mcbsp, SSELCR, w & ~(ST_SIDETONEEN));
@@ -310,9 +296,6 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
 static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
 {
 	u16 val, i;
-	struct omap_device *od;
-
-	od = find_omap_device_by_dev(mcbsp->dev);
 
 	val = MCBSP_ST_READ(mcbsp, SSELCR);
 
@@ -340,9 +323,6 @@ static void omap_st_chgain(struct omap_mcbsp *mcbsp)
 {
 	u16 w;
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
-	struct omap_device *od;
-
-	od = find_omap_device_by_dev(mcbsp->dev);
 
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
 
@@ -685,9 +665,6 @@ EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
 static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 {
-	struct omap_device *od;
-
-	od = find_omap_device_by_dev(mcbsp->dev);
 	/*
 	 * Enable wakup behavior, smart idle and all wakeups
 	 * REVISIT: some wakeups may be unnecessary
@@ -699,10 +676,6 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 
 static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 {
-	struct omap_device *od;
-
-	od = find_omap_device_by_dev(mcbsp->dev);
-
 	/*
 	 * Disable wakup behavior, smart idle and all wakeups
 	 */
-- 
1.7.5.4

