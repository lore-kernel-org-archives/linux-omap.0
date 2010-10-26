From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 4/4] staging: tidspbridge: use new SCM DSP boot control fns
Date: Tue, 26 Oct 2010 11:16:03 -0500
Message-ID: <1288109763-9446-5-git-send-email-omar.ramirez@ti.com>
References: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39461 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab0JZQ0Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 12:26:16 -0400
In-Reply-To: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Rajendra Nayak <rnayak@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Tero Kristo <tero.kristo@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Use the new functions from SCM layer instead of handling registers
directly with __raw_writel, as explained in:

http://marc.info/?l=linux-omap&m=128779652429922&w=2

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index f22bc12..b91d911 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -23,7 +23,7 @@
 #include <dspbridge/host_os.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
-#include <plat/control.h>
+#include <plat/iva2_dsp.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/dbdefs.h>
@@ -293,6 +293,7 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
 	u32 clk_cmd;
 	struct io_mgr *hio_mgr;
 	u32 ul_load_monitor_timer;
+	u8 bootmode;
 	struct omap_dsp_platform_data *pdata =
 		omap_dspbridge_dev->dev.platform_data;
 
@@ -334,15 +335,13 @@ static int bridge_brd_start(struct bridge_dev_context *dev_ctxt,
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
+			bootmode = dsp_debug ? OMAP_IVA2_DSP_BOOTMODE_IDLE : 0;
+			(*pdata->set_dsp_bootmode)(bootmode);
 		}
 	}
 
-- 
1.7.1

