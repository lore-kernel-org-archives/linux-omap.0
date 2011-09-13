From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/6] OMAP2+: id: remove OMAP_REVBITS_* macros
Date: Tue, 13 Sep 2011 15:28:07 -0600
Message-ID: <20110913212806.26161.37867.stgit@dusk>
References: <20110913212638.26161.62284.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40118 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932880Ab1IMVbV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 17:31:21 -0400
In-Reply-To: <20110913212638.26161.62284.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The OMAP_REVBITS_* macros are just used as otherwise meaningless
aliases for the numbers zero through five, so remove these macros.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |   33 ++++++++++-----------------------
 1 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 566975c..0ec90cf 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -60,19 +60,6 @@ struct omap_chip_id {
 unsigned int omap_rev(void);
 
 /*
- * Define CPU revision bits
- *
- * Verbose meaning of the revision bits may be different for a silicon
- * family. This difference can be handled separately.
- */
-#define OMAP_REVBITS_00		0x00
-#define OMAP_REVBITS_01		0x01
-#define OMAP_REVBITS_02		0x02
-#define OMAP_REVBITS_03		0x03
-#define OMAP_REVBITS_04		0x04
-#define OMAP_REVBITS_05		0x05
-
-/*
  * Get the CPU revision for OMAP devices
  */
 #define GET_OMAP_REVISION()	((omap_rev() >> 8) & 0xff)
@@ -379,31 +366,31 @@ IS_OMAP_TYPE(3517, 0x3517)
 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
 #define OMAP2420_REV_ES1_0	OMAP242X_CLASS
-#define OMAP2420_REV_ES2_0	(OMAP242X_CLASS | (OMAP_REVBITS_01 << 8))
+#define OMAP2420_REV_ES2_0	(OMAP242X_CLASS | (0x1 << 8))
 
 #define OMAP243X_CLASS		0x24300024
 #define OMAP2430_REV_ES1_0	OMAP243X_CLASS
 
 #define OMAP343X_CLASS		0x34300034
 #define OMAP3430_REV_ES1_0	OMAP343X_CLASS
-#define OMAP3430_REV_ES2_0	(OMAP343X_CLASS | (OMAP_REVBITS_01 << 8))
-#define OMAP3430_REV_ES2_1	(OMAP343X_CLASS | (OMAP_REVBITS_02 << 8))
-#define OMAP3430_REV_ES3_0	(OMAP343X_CLASS | (OMAP_REVBITS_03 << 8))
-#define OMAP3430_REV_ES3_1	(OMAP343X_CLASS | (OMAP_REVBITS_04 << 8))
-#define OMAP3430_REV_ES3_1_2	(OMAP343X_CLASS | (OMAP_REVBITS_05 << 8))
+#define OMAP3430_REV_ES2_0	(OMAP343X_CLASS | (0x1 << 8))
+#define OMAP3430_REV_ES2_1	(OMAP343X_CLASS | (0x2 << 8))
+#define OMAP3430_REV_ES3_0	(OMAP343X_CLASS | (0x3 << 8))
+#define OMAP3430_REV_ES3_1	(OMAP343X_CLASS | (0x4 << 8))
+#define OMAP3430_REV_ES3_1_2	(OMAP343X_CLASS | (0x5 << 8))
 
 #define OMAP363X_CLASS		0x36300034
 #define OMAP3630_REV_ES1_0	OMAP363X_CLASS
-#define OMAP3630_REV_ES1_1	(OMAP363X_CLASS | (OMAP_REVBITS_01 << 8))
-#define OMAP3630_REV_ES1_2	(OMAP363X_CLASS | (OMAP_REVBITS_02 << 8))
+#define OMAP3630_REV_ES1_1	(OMAP363X_CLASS | (0x1 << 8))
+#define OMAP3630_REV_ES1_2	(OMAP363X_CLASS | (0x2 << 8))
 
 #define OMAP3517_CLASS		0x35170000
 #define OMAP3517_REV_ES1_0	OMAP3517_CLASS
-#define OMAP3517_REV_ES1_1	(OMAP3517_CLASS | (OMAP_REVBITS_01 << 8))
+#define OMAP3517_REV_ES1_1	(OMAP3517_CLASS | (0x1 << 8))
 
 #define TI816X_CLASS		0x81600034
 #define TI8168_REV_ES1_0	TI816X_CLASS
-#define TI8168_REV_ES1_1	(TI816X_CLASS | (OMAP_REVBITS_01 << 8))
+#define TI8168_REV_ES1_1	(TI816X_CLASS | (0x1 << 8))
 
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))


