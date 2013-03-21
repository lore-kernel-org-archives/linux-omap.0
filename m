From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 3/8] CLK: OMAP4: Clock header register declarations to struct
Date: Thu, 21 Mar 2013 19:35:42 +0200
Message-ID: <1363887347-4686-4-git-send-email-t-kristo@ti.com>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42968 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab3CURgb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Mar 2013 13:36:31 -0400
In-Reply-To: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, khilman@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

Clock header register declarations were previously converting
addresses to direct pointers. This doesn't work with an ioremapping
driver, so these are changed into { module, offset } tuples.
These are parsed by the driver into actual register addresses.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/omap/cm1_44xx.h |    2 +-
 drivers/clk/omap/cm2_44xx.h |    2 +-
 drivers/clk/omap/prm44xx.h  |    6 +-----
 drivers/clk/omap/scrm44xx.h |    2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/omap/cm1_44xx.h b/drivers/clk/omap/cm1_44xx.h
index 1bc00dc..9c80aa0 100644
--- a/drivers/clk/omap/cm1_44xx.h
+++ b/drivers/clk/omap/cm1_44xx.h
@@ -29,7 +29,7 @@
 #define OMAP4430_CM1_BASE		0x4a004000
 
 #define OMAP44XX_CM1_REGADDR(inst, reg)				\
-	OMAP2_L4_IO_ADDRESS(OMAP4430_CM1_BASE + (inst) + (reg))
+	OMAP4_CM1_INDEX, ((inst) + (reg))
 
 /* CM1 instances */
 #define OMAP4430_CM1_OCP_SOCKET_INST	0x0000
diff --git a/drivers/clk/omap/cm2_44xx.h b/drivers/clk/omap/cm2_44xx.h
index b9de72d..3b47ac1 100644
--- a/drivers/clk/omap/cm2_44xx.h
+++ b/drivers/clk/omap/cm2_44xx.h
@@ -29,7 +29,7 @@
 #define OMAP4430_CM2_BASE		0x4a008000
 
 #define OMAP44XX_CM2_REGADDR(inst, reg)				\
-	OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE + (inst) + (reg))
+	OMAP4_CM2_INDEX, ((inst) + (reg))
 
 /* CM2 instances */
 #define OMAP4430_CM2_OCP_SOCKET_INST	0x0000
diff --git a/drivers/clk/omap/prm44xx.h b/drivers/clk/omap/prm44xx.h
index 8ee1fbd..2f9b652 100644
--- a/drivers/clk/omap/prm44xx.h
+++ b/drivers/clk/omap/prm44xx.h
@@ -25,14 +25,10 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM44XX_H
 #define __ARCH_ARM_MACH_OMAP2_PRM44XX_H
 
-#include "prcm-common.h"
-#include "prm.h"
-
 #define OMAP4430_PRM_BASE		0x4a306000
 
 #define OMAP44XX_PRM_REGADDR(inst, reg)				\
-	OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE + (inst) + (reg))
-
+	OMAP4_PRM_INDEX, ((inst) + (reg))
 
 /* PRM instances */
 #define OMAP4430_PRM_OCP_SOCKET_INST	0x0000
diff --git a/drivers/clk/omap/scrm44xx.h b/drivers/clk/omap/scrm44xx.h
index e897ac8..9069917 100644
--- a/drivers/clk/omap/scrm44xx.h
+++ b/drivers/clk/omap/scrm44xx.h
@@ -22,7 +22,7 @@
 #define OMAP4_SCRM_BASE				0x4a30a000
 
 #define OMAP44XX_SCRM_REGADDR(reg)	\
-		OMAP2_L4_IO_ADDRESS(OMAP4_SCRM_BASE + (reg))
+	OMAP4_SCRM_INDEX, (reg)
 
 /* Registers offset */
 #define OMAP4_SCRM_REVISION_SCRM_OFFSET		0x0000
-- 
1.7.4.1

