From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/5] staging: tidspbridge: use boot control functions
Date: Sun,  7 Nov 2010 23:43:29 +0200
Message-ID: <1289166209-32251-6-git-send-email-felipe.contreras@gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44122 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab0KGVpX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 16:45:23 -0500
Received: by mail-fx0-f46.google.com with SMTP id 16so3600214fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 13:45:22 -0800 (PST)
In-Reply-To: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

From: Paul Walmsley <paul@pwsan.com>

Use the new functions from SCM layer instead of handling registers
directly with __raw_writel, as explained in:

http://marc.info/?l=linux-omap&m=128779652429922&w=2

This fixes the build on 2.6.37 since control.h is not available for
drivers any more.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index cb38743..84de0c2 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -23,7 +23,7 @@
 #include <dspbridge/host_os.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
-#include <plat/control.h>
+#include <plat/dsp.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/dbdefs.h>
@@ -412,19 +412,18 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 
 		/* Assert RST1 i.e only the RST only for DSP megacell */
 		if (!status) {
+			u8 bootmode;
 			(*pdata->dsp_prm_rmw_bits)(OMAP3430_RST1_IVA2_MASK,
 					OMAP3430_RST1_IVA2_MASK, OMAP3430_IVA2_MOD,
 					OMAP2_RM_RSTCTRL);
 			/* Mask address with 1K for compatibility */
-			__raw_writel(dsp_addr & OMAP3_IVA2_BOOTADDR_MASK,
-					OMAP343X_CTRL_REGADDR(
-					OMAP343X_CONTROL_IVA2_BOOTADDR));
+			dsp_addr &= OMAP3_IVA2_BOOTADDR_MASK;
+			(*pdata->set_dsp_bootaddr)(dsp_addr);
 			/*
 			 * Set bootmode to self loop if dsp_debug flag is true
 			 */
-			__raw_writel((dsp_debug) ? OMAP3_IVA2_BOOTMOD_IDLE : 0,
-					OMAP343X_CTRL_REGADDR(
-					OMAP343X_CONTROL_IVA2_BOOTMOD));
+			bootmode = dsp_debug ? OMAP_DSP_BOOTMODE_IDLE : 0;
+			(*pdata->set_dsp_bootmode)(bootmode);
 		}
 	}
 	if (!status) {
-- 
1.7.3.2.3.gf8529

