From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/2] DSPBRIDGE: fix build error for undefined WCD_debugMask with debug
Date: Wed, 26 Aug 2009 09:42:15 +0300
Message-ID: <1251268935-1215-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1251268935-1215-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33831 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbZHZGmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Aug 2009 02:42:22 -0400
In-Reply-To: <1251268935-1215-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, nm@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 8708c78..ee15b02 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -145,6 +145,18 @@
 #define MAX_STREAMS     16
 #define MAX_BUFS	64
 
+/* Device IOCtl function pointer */
+struct WCD_Cmd {
+	u32(*fxn)(union Trapped_Args *args);
+	u32 dwIndex;
+} ;
+
+/*  ----------------------------------- Globals */
+#if GT_TRACE
+static struct GT_Mask WCD_debugMask = { NULL, NULL };	/* Core VxD Mask */
+#endif
+static u32 WCD_cRefs;
+
 static inline void __cp_fm_usr(void *to, const void __user *from,
 			       DSP_STATUS *err, unsigned long bytes)
 {
@@ -185,18 +197,6 @@ static inline void __cp_to_usr(void __user *to, const void *from,
 #define cp_to_usr(to, from, err, n)				\
 	__cp_to_usr(to, from, &(err), (n) * sizeof(*(from)))
 
-/* Device IOCtl function pointer */
-struct WCD_Cmd {
-	u32(*fxn)(union Trapped_Args *args);
-	u32 dwIndex;
-} ;
-
-/*  ----------------------------------- Globals */
-#if GT_TRACE
-static struct GT_Mask WCD_debugMask = { NULL, NULL };	/* Core VxD Mask */
-#endif
-static u32 WCD_cRefs;
-
 /*
  *  Function table.
  *  The order of these functions MUST be the same as the order of the command
-- 
1.6.0.4

