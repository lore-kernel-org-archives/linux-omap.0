From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCHv2 01/18] DSPBRIDGE: Fix compile break for WCD debug mask
Date: Wed, 16 Dec 2009 20:15:46 -0600
Message-ID: <1261016163-11091-2-git-send-email-omar.ramirez@ti.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36702 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758234AbZLQCIq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 21:08:46 -0500
In-Reply-To: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

If debug mode is enabled compilation will break because WCD
debug mask is used before behing defined.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   80 ++++++++++++++++++++--------------------
 1 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index bb28cd2..3fb5208 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -144,46 +144,6 @@
 #define MAX_STREAMS     16
 #define MAX_BUFS	64
 
-static inline void __cp_fm_usr(void *to, const void __user *from,
-			       DSP_STATUS *err, unsigned long bytes)
-{
-	if (DSP_FAILED(*err))
-		return;
-
-	if (unlikely(!from)) {
-		*err = DSP_EPOINTER;
-		return;
-	}
-
-	if (unlikely(copy_from_user(to, from, bytes))) {
-		GT_2trace(WCD_debugMask, GT_7CLASS,
-			  "%s failed, from=0x%08x\n", __func__, from);
-		*err = DSP_EPOINTER;
-	}
-}
-#define cp_fm_usr(to, from, err, n)				\
-	__cp_fm_usr(to, from, &(err), (n) * sizeof(*(to)))
-
-static inline void __cp_to_usr(void __user *to, const void *from,
-			       DSP_STATUS *err, unsigned long bytes)
-{
-	if (DSP_FAILED(*err))
-		return;
-
-	if (unlikely(!to)) {
-		*err = DSP_EPOINTER;
-		return;
-	}
-
-	if (unlikely(copy_to_user(to, from, bytes))) {
-		GT_2trace(WCD_debugMask, GT_7CLASS,
-			  "%s failed, to=0x%08x\n", __func__, to);
-		*err = DSP_EPOINTER;
-	}
-}
-#define cp_to_usr(to, from, err, n)				\
-	__cp_to_usr(to, from, &(err), (n) * sizeof(*(from)))
-
 /* Device IOCtl function pointer */
 struct WCD_Cmd {
 	u32(*fxn)(union Trapped_Args *args);
@@ -265,6 +225,46 @@ static struct WCD_Cmd WCD_cmdTable[] = {
 	{CMMWRAP_GetInfo, CMD_CMM_GETINFO_OFFSET}
 };
 
+static inline void __cp_fm_usr(void *to, const void __user *from,
+			       DSP_STATUS *err, unsigned long bytes)
+{
+	if (DSP_FAILED(*err))
+		return;
+
+	if (unlikely(!from)) {
+		*err = DSP_EPOINTER;
+		return;
+	}
+
+	if (unlikely(copy_from_user(to, from, bytes))) {
+		GT_2trace(WCD_debugMask, GT_7CLASS,
+			  "%s failed, from=0x%08x\n", __func__, from);
+		*err = DSP_EPOINTER;
+	}
+}
+#define cp_fm_usr(to, from, err, n)				\
+	__cp_fm_usr(to, from, &(err), (n) * sizeof(*(to)))
+
+static inline void __cp_to_usr(void __user *to, const void *from,
+			       DSP_STATUS *err, unsigned long bytes)
+{
+	if (DSP_FAILED(*err))
+		return;
+
+	if (unlikely(!to)) {
+		*err = DSP_EPOINTER;
+		return;
+	}
+
+	if (unlikely(copy_to_user(to, from, bytes))) {
+		GT_2trace(WCD_debugMask, GT_7CLASS,
+			  "%s failed, to=0x%08x\n", __func__, to);
+		*err = DSP_EPOINTER;
+	}
+}
+#define cp_to_usr(to, from, err, n)				\
+	__cp_to_usr(to, from, &(err), (n) * sizeof(*(from)))
+
 /*
  *  ======== WCD_CallDevIOCtl ========
  *  Purpose:
-- 
1.6.2.4

