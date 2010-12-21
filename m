From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/6] omap: add macros to mark SoC-specific data/code
Date: Tue, 21 Dec 2010 19:20:00 +0100
Message-ID: <1292955604-8809-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44884 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab0LUSUZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 13:20:25 -0500
In-Reply-To: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Petazzoni <t-petazzoni@ti.com>

From: Thomas Petazzoni <t-petazzoni@ti.com>

Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 3fd8b40..31f806e 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -31,6 +31,7 @@
 #define __ASM_ARCH_OMAP_CPU_H
 
 #include <linux/bitops.h>
+#include <linux/condsections.h>
 #include <plat/multi.h>
 
 /*
@@ -470,4 +471,14 @@ OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
 
+/*
+ * OMAP section markers
+ */
+#define __omap2_data cond_data_section(omap2)
+#define __omap3_data cond_data_section(omap3)
+#define __omap4_data cond_data_section(omap4)
+#define __omap2_text cond_text_section(omap2)
+#define __omap3_text cond_text_section(omap3)
+#define __omap4_text cond_text_section(omap4)
+
 #endif
-- 
1.7.0.4

