From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 08/12] omap: mcbsp: Remove omap device API
Date: Fri,  1 Jul 2011 11:52:32 +0300
Message-ID: <1309510356-27147-9-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab1GAIxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 04:53:09 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so2453487bwd.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 01:53:08 -0700 (PDT)
In-Reply-To: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

struct omap_device *od is only set with find_omap_device_by_dev but not used
otherwise so remove them and references to omap device API.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/plat-omap/mcbsp.c |   27 ---------------------------
 1 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 47720b1..7511287 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -24,7 +24,6 @@
 #include <linux/slab.h>
 
 #include <plat/mcbsp.h>
-#include <plat/omap_device.h>
 #include <linux/pm_runtime.h>
 
 /* XXX These "sideways" includes are a sign that something is wrong */
@@ -264,19 +263,9 @@ int omap_mcbsp_dma_reg_params(unsigned int id, unsigned int stream)
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
@@ -298,9 +287,6 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 static void omap_st_off(struct omap_mcbsp *mcbsp)
 {
 	unsigned int w;
-	struct omap_device *od;
-
-	od = find_omap_device_by_dev(mcbsp->dev);
 
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
 	MCBSP_ST_WRITE(mcbsp, SSELCR, w & ~(ST_SIDETONEEN));
@@ -316,9 +302,6 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
 static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)
 {
 	u16 val, i;
-	struct omap_device *od;
-
-	od = find_omap_device_by_dev(mcbsp->dev);
 
 	val = MCBSP_ST_READ(mcbsp, SSELCR);
 
@@ -346,9 +329,6 @@ static void omap_st_chgain(struct omap_mcbsp *mcbsp)
 {
 	u16 w;
 	struct omap_mcbsp_st_data *st_data = mcbsp->st_data;
-	struct omap_device *od;
-
-	od = find_omap_device_by_dev(mcbsp->dev);
 
 	w = MCBSP_ST_READ(mcbsp, SSELCR);
 
@@ -689,9 +669,6 @@ EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
 
 static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 {
-	struct omap_device *od;
-
-	od = find_omap_device_by_dev(mcbsp->dev);
 	/*
 	 * Enable wakup behavior, smart idle and all wakeups
 	 * REVISIT: some wakeups may be unnecessary
@@ -703,10 +680,6 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 
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
1.7.0.4

