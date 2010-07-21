From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap: Add macros to evaluate cpu revision
Date: Wed, 21 Jul 2010 20:42:43 +0530
Message-ID: <1279725163-3481-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32825 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab0GUPMx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jul 2010 11:12:53 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6LFCoT6019445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 21 Jul 2010 10:12:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch adds macros to evaluate the cpu revision.
These macros increase readability by reducing the
repetitive code when multiple silicon and their
revisions have to be tested.

Example usage would be:
  if (cpu_rev_eq(omap34xx, ES_1_0))

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index aa2f4f0..14b1a44 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -70,6 +70,7 @@ unsigned int omap_rev(void);
 #define OMAP_REVBITS_20		0x20
 #define OMAP_REVBITS_30		0x30
 #define OMAP_REVBITS_40		0x40
+#define OMAP_REVBITS_50		0x50
 
 /*
  * Get the CPU revision for OMAP devices
@@ -460,4 +461,35 @@ OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
 
+/*
+ * Map revision bits to silicon specific revisions
+ */
+#define ES_1_0		OMAP_REVBITS_00
+#define ES_2_0		OMAP_REVBITS_10
+#define ES_2_1		OMAP_REVBITS_20
+#define ES_3_0		OMAP_REVBITS_30
+#define ES_3_1		OMAP_REVBITS_40
+#define ES_3_1_2	OMAP_REVBITS_50
+
+/*
+ * Macros to evaluate CPU revision
+ */
+#define cpu_rev_lt(cpu,rev)	\
+	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() < (rev))) ? 1 : 0)
+
+#define cpu_rev_le(cpu,rev)	\
+	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() <= (rev))) ? 1 : 0)
+
+#define cpu_rev_eq(cpu,rev)	\
+	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() == (rev))) ? 1 : 0)
+
+#define cpu_rev_ne(cpu,rev)	\
+	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() != (rev))) ? 1 : 0)
+
+#define cpu_rev_ge(cpu,rev)	\
+	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() >= (rev))) ? 1 : 0)
+
+#define cpu_rev_gt(cpu,rev)	\
+	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() > (rev))) ? 1 : 0)
+
 #endif
-- 
1.6.6.1

