From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 04/13] DSPBRIDGE: fix macros that break when inside an if/else
Date: Wed, 15 Jul 2009 17:56:27 +0300
Message-ID: <1247669795-23895-5-git-send-email-ameya.palande@nokia.com>
References: <1247669795-23895-1-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-2-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-3-git-send-email-ameya.palande@nokia.com>
 <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61029 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbZGOO4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 10:56:39 -0400
In-Reply-To: <1247669795-23895-4-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, x0095840@ti.com, nm@ti.com, hiroshi.doyu@nokia.com

From: Doyu Hiroshi (Nokia-D/Helsinki) <hiroshi.doyu@nokia.com>

Based on the following discussion:
      http://marc.info/?l=linux-omap&m=124697893724881&w=2

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   60 ++++++++++++++++++++++++++--------------
 1 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 441130c..8708c78 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -145,27 +145,45 @@
 #define MAX_STREAMS     16
 #define MAX_BUFS	64
 
-/* Following two macros should ideally have do{}while(0) */
-
-#define cp_fm_usr(dest, src, status, elements)    \
-    if (DSP_SUCCEEDED(status)) {\
-	    if (unlikely(src == NULL) ||				\
-		unlikely(copy_from_user(dest, src, elements * sizeof(*(dest))))) { \
-		GT_1trace(WCD_debugMask, GT_7CLASS, \
-		"copy_from_user failed, src=0x%x\n", src);  \
-		status = DSP_EPOINTER ; \
-	} \
-    }
-
-#define cp_to_usr(dest, src, status, elements)    \
-    if (DSP_SUCCEEDED(status)) {\
-	    if (unlikely(dest == NULL) ||				\
-		unlikely(copy_to_user(dest, src, elements * sizeof(*(src))))) { \
-		GT_1trace(WCD_debugMask, GT_7CLASS, \
-		"copy_to_user failed, dest=0x%x\n", dest); \
-		status = DSP_EPOINTER ;\
-	} \
-    }
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
 
 /* Device IOCtl function pointer */
 struct WCD_Cmd {
-- 
1.6.2.4

