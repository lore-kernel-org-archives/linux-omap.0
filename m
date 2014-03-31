From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 46/55] ARM: OMAP3+: VP: move OMAP*_VP_VDD_*_ID definitions to prm public headers
Date: Mon, 31 Mar 2014 18:16:25 +0300
Message-ID: <1396278994-12624-47-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58894 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbaCaPTZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:19:25 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

vp.h is not publicly available, however the PRM driver requires access to
these so moved to prm public headers.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm3xxx.c      |    1 -
 arch/arm/mach-omap2/prm44xx.c      |    1 -
 arch/arm/mach-omap2/vp.h           |    9 ---------
 include/linux/power/omap/prm3xxx.h |    3 +++
 include/linux/power/omap/prm44xx.h |    4 ++++
 5 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 93f87e1..e7d409c 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -18,7 +18,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 
-#include "vp.h"
 #include "powerdomain.h"
 #include <linux/power/omap/prm3xxx.h>
 #include "prm2xxx_3xxx_private.h"
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 7cbb35f..2b25710 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 
 
-#include "vp.h"
 #include <linux/power/omap/prm44xx.h>
 #include <linux/power/omap/prm54xx.h>
 #include <linux/power/omap/prm7xx.h>
diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
index 0fdf7080..7e08296 100644
--- a/arch/arm/mach-omap2/vp.h
+++ b/arch/arm/mach-omap2/vp.h
@@ -21,15 +21,6 @@
 
 struct voltagedomain;
 
-/*
- * Voltage Processor (VP) identifiers
- */
-#define OMAP3_VP_VDD_MPU_ID 0
-#define OMAP3_VP_VDD_CORE_ID 1
-#define OMAP4_VP_VDD_CORE_ID 0
-#define OMAP4_VP_VDD_IVA_ID 1
-#define OMAP4_VP_VDD_MPU_ID 2
-
 /* XXX document */
 #define VP_IDLE_TIMEOUT		200
 #define VP_TRANXDONE_TIMEOUT	300
diff --git a/include/linux/power/omap/prm3xxx.h b/include/linux/power/omap/prm3xxx.h
index 3bdc372..af39ebd 100644
--- a/include/linux/power/omap/prm3xxx.h
+++ b/include/linux/power/omap/prm3xxx.h
@@ -18,6 +18,9 @@
 
 #include <linux/power/omap/prm2xxx_3xxx.h>
 
+#define OMAP3_VP_VDD_MPU_ID	0
+#define OMAP3_VP_VDD_CORE_ID	1
+
 /*
  * OMAP3-specific global PRM registers
  * Use __raw_{read,write}l() with these registers.
diff --git a/include/linux/power/omap/prm44xx.h b/include/linux/power/omap/prm44xx.h
index 3c5852e..9395c0d 100644
--- a/include/linux/power/omap/prm44xx.h
+++ b/include/linux/power/omap/prm44xx.h
@@ -25,6 +25,10 @@
 #ifndef __LINUX_POWER_OMAP_PRM44XX_H
 #define __LINUX_POWER_OMAP_PRM44XX_H
 
+#define OMAP4_VP_VDD_CORE_ID	0
+#define OMAP4_VP_VDD_IVA_ID	1
+#define OMAP4_VP_VDD_MPU_ID	2
+
 /* PRM instances */
 #define OMAP4430_PRM_OCP_SOCKET_INST	0x0000
 #define OMAP4430_PRM_CKGEN_INST		0x0100
-- 
1.7.9.5

