From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCHv2 1/4] DSPBRIDGE: Fix macros that break when inside an if/else
Date: Mon, 13 Jul 2009 15:38:46 +0300
Message-ID: <1247488726-14960-1-git-send-email-ameya.palande@nokia.com>
References: <496565EC904933469F292DDA3F1663E602A30E140D@dlee06.ent.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17022 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574AbZGMMiq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jul 2009 08:38:46 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602A30E140D@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, ext-phil.2.carmody@nokia.com

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

cp_{to,fm}_usr break if between an if and an else (with no {}).

http://www.faqs.org/faqs/C-faq/abridged/
10.4: What's the best way to write a multi-statement macro?
A:    #define Func() do {stmt1; stmt2; ... } while(0) /* (no trailing ;) */

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   42 ++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 86812c6..da0467c 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -147,25 +147,29 @@
 
 /* Following two macros should ideally have do{}while(0) */
 
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
+#define cp_fm_usr(dest, src, status, elements)	\
+do {						\
+  if (DSP_SUCCEEDED(status)) {			\
+    if (unlikely((src) == NULL) ||		\
+      unlikely(copy_from_user(dest, src, (elements) * sizeof(*(dest))))) { \
+        GT_1trace(WCD_debugMask, GT_7CLASS,	\
+	  "copy_from_user failed, src=0x%x\n", src);	\
+      (status) = DSP_EPOINTER ;			\
+    }						\
+  }						\
+} while (0)
+
+#define cp_to_usr(dest, src, status, elements)	\
+do {						\
+  if (DSP_SUCCEEDED(status)) {			\
+    if (unlikely((dest) == NULL) ||		\
+      unlikely(copy_to_user(dest, src, (elements) * sizeof(*(src))))) { \
+        GT_1trace(WCD_debugMask, GT_7CLASS,	\
+          "copy_to_user failed, dest=0x%x\n", dest);	\
+        (status) = DSP_EPOINTER ;		\
+    }						\
+  }						\
+} while (0)
 
 /* Device IOCtl function pointer */
 struct WCD_Cmd {
-- 
1.6.2.4

