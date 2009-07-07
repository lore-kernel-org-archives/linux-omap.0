From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 1/4] DSPBRIDGE: Fix macros that break when inside an if/else
Date: Tue,  7 Jul 2009 18:02:04 +0300
Message-ID: <1246978928-7139-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61406 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473AbZGGPCP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 11:02:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, h-kanigeri2@ti.com, ext-phil.2.carmody@nokia.com

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
index 86812c6..aaf3019 100644
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
+    do {						\
+	if (DSP_SUCCEEDED(status)) {			\
+	    if (unlikely((src) == NULL) ||		\
+		unlikely(copy_from_user(dest, src, (elements) * sizeof(*(dest))))) { \
+		GT_1trace(WCD_debugMask, GT_7CLASS,	\
+			  "copy_from_user failed, src=0x%x\n", src);	\
+		(status) = DSP_EPOINTER ;				\
+	    }						\
+	}						\
+    } while (0)
+
+#define cp_to_usr(dest, src, status, elements) \
+    do {						\
+	if (DSP_SUCCEEDED(status)) {			\
+	    if (unlikely((dest) == NULL) ||				\
+		unlikely(copy_to_user(dest, src, (elements) * sizeof(*(src))))) { \
+		GT_1trace(WCD_debugMask, GT_7CLASS,	\
+			  "copy_to_user failed, dest=0x%x\n", dest);	\
+		(status) = DSP_EPOINTER ;		\
+	    }						\
+	}						\
+    } while (0)
 
 /* Device IOCtl function pointer */
 struct WCD_Cmd {
-- 
1.6.2.4

