From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: [PATCH] DSPBRIDGE:Fix sparse warnings
Date: Fri, 26 Mar 2010 18:30:43 -0500
Message-ID: <1269646243-9236-1-git-send-email-deepak.chitriki@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36273 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845Ab0CZXaw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Mar 2010 19:30:52 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2QNUpnS017736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 18:30:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>

This patch fixes sparse warning "cast removes address space of expression"
in drivers/dsp/bridge/wmd/tiomap_io.c

Signed-off-by: Deepak Chitriki <deepak.chitriki@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap_io.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index b5504a9..cc20f65 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -431,22 +431,22 @@ dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val)
 		 * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
 		 *     in CM_AUTOIDLE_PLL_IVA2 register
 		 */
-		*(reg_uword32 *) (resources.dw_cm_base + 0x34) = 0x1;
+		*(reg_uword32 *) ((u32)(resources.dw_cm_base) + 0x34) = 0x1;
 
 		/*
 		 * 7:4 IVA2_DPLL_FREQSEL - IVA2 internal frq set to
 		 *     0.75 MHz - 1.0 MHz
 		 * 2:0 EN_IVA2_DPLL - Enable IVA2 DPLL in lock mode
 		 */
-		temp = *(reg_uword32 *) (resources.dw_cm_base + 0x4);
+		temp = *(reg_uword32 *) ((u32)(resources.dw_cm_base) + 0x4);
 		temp = (temp & 0xFFFFFF08) | 0x37;
-		*(reg_uword32 *) (resources.dw_cm_base + 0x4) = temp;
+		*(reg_uword32 *) ((u32)(resources.dw_cm_base) + 0x4) = temp;
 
 		/* Restore mailbox settings */
 		omap_mbox_restore_ctx(dev_context->mbox);
 
 		/* Access MMU SYS CONFIG register to generate a short wakeup */
-		temp = *(reg_uword32 *) (resources.dw_dmmu_base + 0x10);
+		temp = *(reg_uword32 *) ((u32)(resources.dw_dmmu_base) + 0x10);
 
 		dev_context->dw_brd_state = BRD_RUNNING;
 	} else if (dev_context->dw_brd_state == BRD_RETENTION) {
@@ -462,4 +462,4 @@ dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val)
 	}
 
 	return DSP_SOK;
-}
\ No newline at end of file
+}
-- 
1.6.3.3

