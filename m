From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: [PATCH 4/5] staging: tidspbridge: use scm functions to set boot address and mode
Date: Thu, 10 Jan 2013 03:37:01 -0600
Message-ID: <1357810622-1709-5-git-send-email-omar.ramirez@copitl.com>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:33573 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab3AJJhX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 04:37:23 -0500
Received: by mail-oa0-f45.google.com with SMTP id i18so341550oag.32
        for <linux-omap@vger.kernel.org>; Thu, 10 Jan 2013 01:37:23 -0800 (PST)
In-Reply-To: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chen Gang <gang.chen@asianux.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@copitl.com>

Instead of ioremapping SCM registers, use the correspondent layer
to write into them.

This allows us to get rid of a layer violation, since the registers
are no longer touched by driver code.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |   34 +++++-------------------
 1 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index f619fb3..b770b22 100644
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
@@ -423,29 +418,14 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 
 		/* Assert RST1 i.e only the RST only for DSP megacell */
 		if (!status) {
-			/*
-			 * XXX: OMAP343X_CTRL_BASE ioremapping  MUST be removed once ctrl
-			 * function is made available.
-			 */
-			void __iomem *ctrl = ioremap(0x48002000, SZ_4K);
-			if (!ctrl) {
-				iounmap(sync_addr);
-				return -ENOMEM;
-			}
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
1.7.4.4

