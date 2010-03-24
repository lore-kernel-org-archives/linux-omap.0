From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap: Macros for comapring si revisions
Date: Wed, 24 Mar 2010 20:33:47 +0530
Message-ID: <1269443027-14973-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40391 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755429Ab0CXPEI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Mar 2010 11:04:08 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2OF433W024735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 24 Mar 2010 10:04:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Fresh attempt to compare the silicon revision
bits independent of the silicon id.

Currently, omap_revision is compared as whole.
But, it doesn't represent multiple processors.

This patch only contains the basic set of macros
for discussion before I make changes in rest of
the code.

Sample usage:
	/* Check for revision of processor(s) */
	if (cpu_rev_eq(3430, ES_3_1)
		&& cpu_rev_ge(3630, ES_1_0) ) {
		...
	}

	/* Check for revision in class of processors */
	if (class_rev_eq(34, ES_3_1)) {
		...
	}

Since last patch[1], the real change is to make macros/
functions more parameterized.

  [1] http://marc.info/?l=linux-omap&m=126322767404669&w=2

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |  150 +++++++++++++++++++++++++++++++++
 1 files changed, 150 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 7514174..00507d1 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -72,6 +72,11 @@ unsigned int omap_rev(void);
 #define OMAP_REVBITS_40		0x40
 
 /*
+ * Get the CPU Id for OMAP devices
+ */
+#define GET_OMAP_ID()	((omap_rev() >> 16) & 0xffff)
+
+/*
  * Get the CPU revision for OMAP devices
  */
 #define GET_OMAP_REVISION()	((omap_rev() >> 8) & 0xff)
@@ -458,4 +463,149 @@ OMAP3_HAS_FEATURE(neon, NEON)
 OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 
+
+/*
+ * Mapping revision to silicon classes
+ */
+#define OMAP34XX_ES_1_0		OMAP_REVBITS_00
+#define OMAP34XX_ES_2_0		OMAP_REVBITS_10
+#define OMAP34XX_ES_2_1		OMAP_REVBITS_20
+#define OMAP34XX_ES_3_0		OMAP_REVBITS_30
+#define OMAP34XX_ES_3_1		OMAP_REVBITS_40
+
+/*
+ * Mapping revision to individual silicons
+ */
+#define OMAP3430_ES_1_0		OMAP_REVBITS_00
+#define OMAP3430_ES_2_0		OMAP_REVBITS_10
+#define OMAP3430_ES_2_1		OMAP_REVBITS_20
+#define OMAP3430_ES_3_0		OMAP_REVBITS_30
+#define OMAP3430_ES_3_1		OMAP_REVBITS_40
+
+
+/*
+ * Inline functions to compare revision for specific silicons
+ */
+static inline bool is_omap_rev_lt (u16 id, u16 rev)
+{
+	if (((GET_OMAP_ID()) == id) &&
+		((GET_OMAP_REVISION()) < rev))
+		return true;
+	else
+		return false;
+}
+
+static inline bool is_omap_rev_le (u16 id, u16 rev)
+{
+	if (((GET_OMAP_ID()) == id) &&
+		((GET_OMAP_REVISION()) <= rev))
+		return true;
+	else
+		return false;
+}
+
+static inline bool is_omap_rev_eq (u16 id, u16 rev)
+{
+	if (((GET_OMAP_ID()) == id) &&
+		((GET_OMAP_REVISION()) == rev))
+		return true;
+	else
+		return false;
+}
+
+static inline bool is_omap_rev_ne (u16 id, u16 rev)
+{
+	if (((GET_OMAP_ID()) == id) &&
+		((GET_OMAP_REVISION()) != rev))
+		return true;
+	else
+		return false;
+}
+
+static inline bool is_omap_rev_gt (u16 id, u16 rev)
+{
+	if (((GET_OMAP_ID()) == id) &&
+		((GET_OMAP_REVISION()) > rev))
+		return true;
+	else
+		return false;
+}
+
+static inline bool is_omap_rev_ge (u16 id, u16 rev)
+{
+	if (((GET_OMAP_ID()) == id) &&
+		((GET_OMAP_REVISION()) >= rev))
+		return true;
+	else
+		return false;
+}
+
+#define cpu_rev_lt(id, rev)	is_omap_rev_lt(0x##id, OMAP##id##_##rev)
+#define cpu_rev_le(id, rev)	is_omap_rev_le(0x##id, OMAP##id##_##rev)
+#define cpu_rev_eq(id, rev)	is_omap_rev_eq(0x##id, OMAP##id##_##rev)
+#define cpu_rev_ne(id, rev)	is_omap_rev_ne(0x##id, OMAP##id##_##rev)
+#define cpu_rev_gt(id, rev)	is_omap_rev_gt(0x##id, OMAP##id##_##rev)
+#define cpu_rev_ge(id, rev)	is_omap_rev_ge(0x##id, OMAP##id##_##rev)
+
+
+/*
+ * Inline functions to compare revision for class of silicons
+ */
+static inline bool is_class_rev_lt (u16 c, u16 rev)
+{
+	if (((GET_OMAP_CLASS) == c) && ((GET_OMAP_REVISION()) < rev))
+		return true;
+	else
+		return false;
+
+    return true;
+}
+
+static inline bool is_class_rev_le (u16 c, u16 rev)
+{
+	if (((GET_OMAP_CLASS) == c) && ((GET_OMAP_REVISION()) <= rev))
+		return true;
+	else
+		return false;
+
+    return true;
+}
+
+static inline bool is_class_rev_eq (u16 c, u16 rev)
+{
+	if (((GET_OMAP_CLASS) == c) && ((GET_OMAP_REVISION()) == rev))
+		return true;
+	else
+		return false;
+
+    return true;
+}
+
+static inline bool is_class_rev_gt (u16 c, u16 rev)
+{
+	if (((GET_OMAP_CLASS) == c) && ((GET_OMAP_REVISION()) > rev))
+		return true;
+	else
+		return false;
+
+    return true;
+}
+
+static inline bool is_class_rev_ge (u16 c, u16 rev)
+{
+	if (((GET_OMAP_CLASS) == c) && ((GET_OMAP_REVISION()) >= rev))
+		return true;
+	else
+		return false;
+
+    return true;
+}
+
+#define class_rev_lt(c, rev)	is_class_rev_lt(0x##c, OMAP##c##XX_##rev)
+#define class_rev_le(c, rev)	is_class_rev_le(0x##c, OMAP##c##XX_##rev)
+#define class_rev_eq(c, rev)	is_class_rev_eq(0x##c, OMAP##c##XX_##rev)
+#define class_rev_ne(c, rev)	is_class_rev_ne(0x##c, OMAP##c##XX_##rev)
+#define class_rev_gt(c, rev)	is_class_rev_gt(0x##c, OMAP##c##XX_##rev)
+#define class_rev_ge(c, rev)	is_class_rev_ge(0x##c, OMAP##c##XX_##rev)
+
 #endif
-- 
1.6.6.1

