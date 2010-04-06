From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: [PATCH 3/5] OMAP: Add SDRAM timings for Micron mt46h16m32lf-6
Date: Tue,  6 Apr 2010 09:51:06 -0700
Message-ID: <1270572668-2336-4-git-send-email-lwalkera@ieee.org>
References: <1270572668-2336-1-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-2-git-send-email-lwalkera@ieee.org>
 <1270572668-2336-3-git-send-email-lwalkera@ieee.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og117.obsmtp.com ([64.18.2.6]:35294 "HELO
	exprod7og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757089Ab0DFRB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 13:01:56 -0400
In-Reply-To: <1270572668-2336-3-git-send-email-lwalkera@ieee.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Laine Walker-Avina <lwalkera@ieee.org>


Signed-off-by: Laine Walker-Avina <lwalkera@ieee.org>
---
 arch/arm/mach-omap2/sdram-micron-mt46h16m32lf-6.h |   67 +++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h16m32lf-6.h

diff --git a/arch/arm/mach-omap2/sdram-micron-mt46h16m32lf-6.h b/arch/arm/mach-omap2/sdram-micron-mt46h16m32lf-6.h
new file mode 100644
index 0000000..5e7c3e8
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-micron-mt46h16m32lf-6.h
@@ -0,0 +1,67 @@
+/*
+ * SDRC register values for the Micron MT46H16M32LF-6
+ *
+ * Copyright (C) 2010 PASCO scientifc
+ *
+ * Laine Walker-Avina
+ *
+ * Based on the file for the Micron MT46H32M32LF-6 by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H16M32LF
+#define ARCH_ARM_MACH_OMAP2_SDRAM_MICRON_MT46H16M32LF
+
+#include <plat/sdrc.h>
+
+/* Micron MT46H16M32LF-6 */
+static struct omap_sdrc_params mt46h16m32lf6_sdrc_params[] = {
+	[0] = {
+		.rate	     = 166000000,
+		.actim_ctrla = ACTIM_TRFC(17) | ACTIM_TRC(10) | ACTIM_TRAS(7) |
+			ACTIM_TRP(3) | ACTIM_TRCD(3) | ACTIM_TRRD(2) | ACTIM_TDPL(3) |
+			ACTIM_TDAL(6),
+		.actim_ctrlb = ACTIM_TWTR(2) | ACTIM_TCKE(1) | ACTIM_TXP(1) |
+			ACTIM_TXSR(20),
+		.rfr_ctrl    = RFR_CTRL_ARCV(1244) | RFR_CTRL_ARE(1),
+		.mr	         = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
+	},
+	[1] = {
+		.rate	     = 165941176,
+		.actim_ctrla = ACTIM_TRFC(17) | ACTIM_TRC(10) | ACTIM_TRAS(7) |
+			ACTIM_TRP(3)   | ACTIM_TRCD(3) | ACTIM_TRRD(2) | ACTIM_TDPL(3) |
+			ACTIM_TDAL(6),
+		.actim_ctrlb = ACTIM_TWTR(2)  | ACTIM_TCKE(1) | ACTIM_TXP(1) |
+			ACTIM_TXSR(20),
+		.rfr_ctrl    = RFR_CTRL_ARCV(1244) | RFR_CTRL_ARE(1),
+		.mr	         = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
+	},
+	[2] = {
+		.rate	     = 83000000,
+		.actim_ctrla = ACTIM_TRFC(9) | ACTIM_TRC(5) | ACTIM_TRAS(4) |
+			ACTIM_TRP(2) | ACTIM_TRCD(2) | ACTIM_TRRD(1) | ACTIM_TDPL(2) |
+			ACTIM_TDAL(3),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(1) | ACTIM_TXP(1) |
+			ACTIM_TXSR(10),
+		.rfr_ctrl    = RFR_CTRL_ARCV(597) | RFR_CTRL_ARE(1),
+		.mr	         = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
+	},
+	[3] = {
+		.rate	     = 82970588,
+		.actim_ctrla = ACTIM_TRFC(10) | ACTIM_TRC(5) | ACTIM_TRAS(4) |
+			ACTIM_TRP(2) | ACTIM_TRCD(2) | ACTIM_TRRD(1) | ACTIM_TDPL(2) |
+			ACTIM_TDAL(3),
+		.actim_ctrlb = ACTIM_TWTR(1) | ACTIM_TCKE(1) | ACTIM_TXP(2) |
+			ACTIM_TXSR(12),
+		.rfr_ctrl    = RFR_CTRL_ARCV(597) | RFR_CTRL_ARE(1),
+		.mr	         = MR_WBST(0) | MR_CASL(3) | MR_BL(2),
+	},
+	[4] = {
+		.rate	     = 0
+	},
+};
+
+#endif
-- 
1.6.3.3

