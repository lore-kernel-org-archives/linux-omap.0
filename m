From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 02/19] Code clean-up for sound/arm/omap/omap-alsa.h
Date: Tue, 15 Apr 2008 10:02:06 -0400
Message-ID: <1208268143-8789-3-git-send-email-edubezval@gmail.com>
References: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
 <1208268143-8789-2-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40414 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761283AbYDOOCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:36 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE28Mn008266
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:34 +0300
In-Reply-To: <1208268143-8789-2-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 include/asm-arm/arch-omap/omap-alsa.h |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/asm-arm/arch-omap/omap-alsa.h b/include/asm-arm/arch-omap/omap-alsa.h
index 0f8a7d3..5658fab 100644
--- a/include/asm-arm/arch-omap/omap-alsa.h
+++ b/include/asm-arm/arch-omap/omap-alsa.h
@@ -49,12 +49,20 @@
  * Debug functions
  */
 #undef DEBUG
-//#define DEBUG
+/* #define DEBUG */
 
-#define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", __FUNCTION__);printk(ARGS);
+#define ERR(ARGS...)						\
+	do {							\
+		printk(KERN_ERR "{%s}-ERROR: ", __func__);	\
+		printk(ARGS);					\
+	} while (0)
 
 #ifdef DEBUG
-#define DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
+#define DPRINTK(ARGS...)					\
+	do {							\
+		printk(KERN_INFO "<%s>: ",__FUNCTION__);	\
+		printk(ARGS);					\
+	} while (0)
 #define ADEBUG() printk("XXX Alsa debug f:%s, l:%d\n", __FUNCTION__, __LINE__)
 #define FN_IN printk(KERN_INFO "[%s]: start\n", __FUNCTION__)
 #define FN_OUT(n) printk(KERN_INFO "[%s]: end(%u)\n",__FUNCTION__, n)
-- 
1.5.5-rc3.GIT

