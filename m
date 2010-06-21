From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 4/5] DSPBRIDGE: Remove unnecessary volatile variables
Date: Mon, 21 Jun 2010 17:07:13 -0500
Message-ID: <1277158034-21843-4-git-send-email-ernesto@ti.com>
References: <1277158034-21843-1-git-send-email-ernesto@ti.com>
 <1277158034-21843-2-git-send-email-ernesto@ti.com>
 <1277158034-21843-3-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43108 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409Ab0FUWEM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jun 2010 18:04:12 -0400
In-Reply-To: <1277158034-21843-3-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, hiroshi.doyu@nokia.com, Ernesto Ramos <ernesto@ti.com>

Remove unnecessary volatile variables; use accessor
functions __raw_readl/__raw_writel instead when applicable.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/core/tiomap3430.c |    8 ++++----
 drivers/dsp/bridge/dynload/tramp.c   |    4 ++--
 drivers/dsp/bridge/pmgr/cmm.c        |    7 ++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index 35c6678..8b9892f 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -417,7 +417,7 @@ static int bridge_brd_start(struct bridge_dev_context *hDevContext,
 		pr_err("%s: Illegal SM base\n", __func__);
 		status = -EPERM;
 	} else
-		*((volatile u32 *)dw_sync_addr) = 0xffffffff;
+		__raw_writel(0xffffffff, dw_sync_addr);
 
 	if (DSP_SUCCEEDED(status)) {
 		resources = dev_context->resources;
@@ -603,7 +603,7 @@ static int bridge_brd_start(struct bridge_dev_context *hDevContext,
 		dev_dbg(bridge, "Waiting for Sync @ 0x%x\n", dw_sync_addr);
 		dev_dbg(bridge, "DSP c_int00 Address =  0x%x\n", dwDSPAddr);
 		if (dsp_debug)
-			while (*((volatile u16 *)dw_sync_addr))
+			while (__raw_readw(dw_sync_addr))
 				;;
 
 		/* Wait for DSP to clear word in shared memory */
@@ -621,7 +621,7 @@ static int bridge_brd_start(struct bridge_dev_context *hDevContext,
 			/* Write the synchronization bit to indicate the
 			 * completion of OPP table update to DSP
 			 */
-			*((volatile u32 *)dw_sync_addr) = 0XCAFECAFE;
+			__raw_writel(0XCAFECAFE, dw_sync_addr);
 
 			/* update board state */
 			dev_context->dw_brd_state = BRD_RUNNING;
@@ -1875,7 +1875,7 @@ bool wait_for_start(struct bridge_dev_context *dev_context, u32 dw_sync_addr)
 	u16 timeout = TIHELEN_ACKTIMEOUT;
 
 	/*  Wait for response from board */
-	while (*((volatile u16 *)dw_sync_addr) && --timeout)
+	while (__raw_readw(dw_sync_addr) && --timeout)
 		udelay(10);
 
 	/*  If timed out: return FALSE */
diff --git a/drivers/dsp/bridge/dynload/tramp.c b/drivers/dsp/bridge/dynload/tramp.c
index 7b593fc..8d2d526 100644
--- a/drivers/dsp/bridge/dynload/tramp.c
+++ b/drivers/dsp/bridge/dynload/tramp.c
@@ -86,8 +86,8 @@ static u8 priv_h2a(u8 value)
 static void priv_tramp_sym_gen_name(u32 value, char *dst)
 {
 	u32 i;
-	volatile char *prefix = TRAMP_SYM_PREFIX;
-	volatile char *dst_local = dst;
+	char *prefix = TRAMP_SYM_PREFIX;
+	char *dst_local = dst;
 	u8 tmp;
 
 	/*  Clear out the destination, including the ending NULL */
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 1134193..aa69b5e 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -1009,6 +1009,7 @@ void *cmm_xlator_alloc_buf(struct cmm_xlatorobject *xlator, void *pVaBuf,
 {
 	struct cmm_xlator *xlator_obj = (struct cmm_xlator *)xlator;
 	void *pbuf = NULL;
+	void *tmp_va_buff;
 	struct cmm_attrs attrs;
 
 	DBC_REQUIRE(refs > 0);
@@ -1020,16 +1021,16 @@ void *cmm_xlator_alloc_buf(struct cmm_xlatorobject *xlator, void *pVaBuf,
 
 	if (xlator_obj) {
 		attrs.ul_seg_id = xlator_obj->ul_seg_id;
-		*(volatile u32 *)pVaBuf = 0;
+		__raw_writel(0, pVaBuf);
 		/* Alloc SM */
 		pbuf =
 		    cmm_calloc_buf(xlator_obj->hcmm_mgr, uPaSize, &attrs, NULL);
 		if (pbuf) {
 			/* convert to translator(node/strm) process Virtual
 			 * address */
-			*(volatile u32 **)pVaBuf =
-			    (u32 *) cmm_xlator_translate(xlator,
+			 tmp_va_buff = cmm_xlator_translate(xlator,
 							 pbuf, CMM_PA2VA);
+			__raw_writel((u32)tmp_va_buff, pVaBuf);
 		}
 	}
 	return pbuf;
-- 
1.5.4.5

