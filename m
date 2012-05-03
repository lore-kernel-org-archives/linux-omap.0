From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 3/3] staging: tidspbridge: use scm functions to set boot address and mode
Date: Wed,  2 May 2012 21:11:53 -0500
Message-ID: <1336011113-31502-4-git-send-email-omar.luna@linaro.org>
References: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63256 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092Ab2ECCMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 22:12:10 -0400
Received: by mail-ob0-f174.google.com with SMTP id tb18so1792752obb.19
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 19:12:10 -0700 (PDT)
In-Reply-To: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-dev@lists.linaro.org, Omar Ramirez Luna <omar.luna@linaro.org>

Instead of ioremapping SCM registers, use the correspondent layer
to write into them.

This allows us to get rid of a layer violation, since the registers
are no longer touched by driver code.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |   32 +++++-------------------
 1 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 9cf29fc..40b35ca 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -70,14 +70,9 @@
 #define PAGES_II_LVL_TABLE   512
 #define PHYS_TO_PAGE(phys)      pfn_to_page((phys) >> PAGE_SHIFT)
 
-/*
- * This is a totally ugly layer violation, but needed until
- * omap_ctrl_set_dsp_boot*() are provided.
- */
-#define OMAP3_IVA2_BOOTMOD_IDLE 1
-#define OMAP2_CONTROL_GENERAL 0x270
-#define OMAP343X_CONTROL_IVA2_BOOTADDR (OMAP2_CONTROL_GENERAL + 0x0190)
-#define OMAP343X_CONTROL_IVA2_BOOTMOD (OMAP2_CONTROL_GENERAL + 0x0194)
+/* IVA Boot modes */
+#define DIRECT		0
+#define IDLE		1
 
 /* Forward Declarations: */
 static int bridge_brd_monitor(struct bridge_dev_context *dev_ctxt);
@@ -414,27 +409,14 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 
 		/* Assert RST1 i.e only the RST only for DSP megacell */
 		if (!status) {
-			/*
-			 * XXX: ioremapping  MUST be removed once ctrl
-			 * function is made available.
-			 */
-			void __iomem *ctrl = ioremap(OMAP343X_CTRL_BASE, SZ_4K);
-			if (!ctrl)
-				return -ENOMEM;
-
 			(*pdata->dsp_prm_rmw_bits)(OMAP3430_RST1_IVA2_MASK,
 					OMAP3430_RST1_IVA2_MASK, OMAP3430_IVA2_MOD,
 					OMAP2_RM_RSTCTRL);
-			/* Mask address with 1K for compatibility */
-			__raw_writel(dsp_addr & OMAP3_IVA2_BOOTADDR_MASK,
-					ctrl + OMAP343X_CONTROL_IVA2_BOOTADDR);
-			/*
-			 * Set bootmode to self loop if dsp_debug flag is true
-			 */
-			__raw_writel((dsp_debug) ? OMAP3_IVA2_BOOTMOD_IDLE : 0,
-					ctrl + OMAP343X_CONTROL_IVA2_BOOTMOD);
 
-			iounmap(ctrl);
+			/* Mask address with 1K for compatibility */
+			pdata->set_bootaddr(dsp_addr &
+						OMAP3_IVA2_BOOTADDR_MASK);
+			pdata->set_bootmode(dsp_debug ? IDLE : DIRECT);
 		}
 	}
 	if (!status) {
-- 
1.7.4.1

