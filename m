From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC][PATCH 1/2] OMAP4: PRCM: Add prcm_mpu_base to omap_globals
Date: Tue, 10 Aug 2010 20:32:55 +0530
Message-ID: <1281452576-5705-2-git-send-email-rnayak@ti.com>
References: <1281452576-5705-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57617 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab0HJPDG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Aug 2010 11:03:06 -0400
In-Reply-To: <1281452576-5705-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

OMAP4 has a local PRCM (for individual CPU control) block.
Hence add a new prcm_mpu_base to handle this in the omap_globals
structure.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/prcm.c               |    5 +++++
 arch/arm/plat-omap/common.c              |    1 +
 arch/arm/plat-omap/include/plat/common.h |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index c201374..4df30d0 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -35,6 +35,7 @@
 #include "prm-regbits-24xx.h"
 
 static void __iomem *prm_base;
+static void __iomem *prcm_mpu_base;
 static void __iomem *cm_base;
 static void __iomem *cm2_base;
 
@@ -282,6 +283,10 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 		prm_base = ioremap(omap2_globals->prm, SZ_8K);
 		WARN_ON(!prm_base);
 	}
+	if (omap2_globals->prcm_mpu) {
+		prcm_mpu_base = ioremap(omap2_globals->prcm_mpu, SZ_8K);
+		WARN_ON(!prcm_mpu_base);
+	}
 	if (omap2_globals->cm) {
 		cm_base = ioremap(omap2_globals->cm, SZ_8K);
 		WARN_ON(!cm_base);
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 3008e71..8603a46 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -338,6 +338,7 @@ static struct omap_globals omap4_globals = {
 	.tap	= OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
 	.ctrl	= OMAP443X_CTRL_BASE,
 	.prm	= OMAP4430_PRM_BASE,
+	.prcm_mpu	= OMAP4430_PRCM_MPU_BASE,
 	.cm	= OMAP4430_CM_BASE,
 	.cm2	= OMAP4430_CM2_BASE,
 	.uart1_phys	= OMAP4_UART1_BASE,
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 9776b41..47baf9d 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -48,6 +48,7 @@ struct omap_globals {
 	unsigned long   sms;            /* SDRAM Memory Scheduler */
 	unsigned long   ctrl;           /* System Control Module */
 	unsigned long   prm;            /* Power and Reset Management */
+	unsigned long   prcm_mpu;	/* Local MPU PRM */
 	unsigned long   cm;             /* Clock Management */
 	unsigned long   cm2;
 	unsigned long	uart1_phys;
-- 
1.7.0.4

