From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 10/10] OMAP3: SR: Replace (0x1 << n) with BIT(n)
Date: Fri, 3 Apr 2009 21:39:34 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102C26@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47604 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935194AbZDCQJp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 12:09:45 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n33G9aBK014700
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 11:09:42 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n33G9Z5u014986
	for <linux-omap@vger.kernel.org>; Fri, 3 Apr 2009 21:39:35 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Rajendra Nayak <rnayak@ti.com>

This patch converts all the bit defines from (0x1 << n)
to BIT(n) in smartreflex driver

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/smartreflex.h |   42 +++++++++++++++++++-------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/smartreflex.h
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/smartreflex.h
+++ linux-omap-pm/arch/arm/mach-omap2/smartreflex.h
@@ -43,22 +43,22 @@
 #define GAIN_MAXLIMIT	16
 #define R_MAXLIMIT	256
 
-#define SR1_CLK_ENABLE	(0x1 << 6)
-#define SR2_CLK_ENABLE	(0x1 << 7)
+#define SR1_CLK_ENABLE	BIT(6)
+#define SR2_CLK_ENABLE	BIT(7)
 
 /* PRM_VP1_CONFIG */
 #define PRM_VP1_CONFIG_ERROROFFSET	(0x00 << 24)
 #define PRM_VP1_CONFIG_ERRORGAIN	(0x20 << 16)
 
 #define PRM_VP1_CONFIG_INITVOLTAGE	(0x30 << 8) /* 1.2 volt */
-#define PRM_VP1_CONFIG_TIMEOUTEN	(0x1 << 3)
-#define PRM_VP1_CONFIG_INITVDD		(0x1 << 2)
-#define PRM_VP1_CONFIG_FORCEUPDATE	(0x1 << 1)
-#define PRM_VP1_CONFIG_VPENABLE		(0x1 << 0)
+#define PRM_VP1_CONFIG_TIMEOUTEN	BIT(3)
+#define PRM_VP1_CONFIG_INITVDD		BIT(2)
+#define PRM_VP1_CONFIG_FORCEUPDATE	BIT(1)
+#define PRM_VP1_CONFIG_VPENABLE		BIT(0)
 
 /* PRM_VP1_VSTEPMIN */
 #define PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN	(0x01F4 << 8)
-#define PRM_VP1_VSTEPMIN_VSTEPMIN		(0x01 << 0)
+#define PRM_VP1_VSTEPMIN_VSTEPMIN		BIT(0)
 
 /* PRM_VP1_VSTEPMAX */
 #define PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX	(0x01F4 << 8)
@@ -74,14 +74,14 @@
 #define PRM_VP2_CONFIG_ERRORGAIN	(0x20 << 16)
 
 #define PRM_VP2_CONFIG_INITVOLTAGE	(0x30 << 8) /* 1.2 volt */
-#define PRM_VP2_CONFIG_TIMEOUTEN	(0x1 << 3)
-#define PRM_VP2_CONFIG_INITVDD		(0x1 << 2)
-#define PRM_VP2_CONFIG_FORCEUPDATE	(0x1 << 1)
-#define PRM_VP2_CONFIG_VPENABLE		(0x1 << 0)
+#define PRM_VP2_CONFIG_TIMEOUTEN	BIT(3)
+#define PRM_VP2_CONFIG_INITVDD		BIT(2)
+#define PRM_VP2_CONFIG_FORCEUPDATE	BIT(1)
+#define PRM_VP2_CONFIG_VPENABLE		BIT(0)
 
 /* PRM_VP2_VSTEPMIN */
 #define PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN	(0x01F4 << 8)
-#define PRM_VP2_VSTEPMIN_VSTEPMIN		(0x01 << 0)
+#define PRM_VP2_VSTEPMIN_VSTEPMIN		BIT(0)
 
 /* PRM_VP2_VSTEPMAX */
 #define PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX	(0x01F4 << 8)
@@ -106,20 +106,20 @@
 #define SRCONFIG_SENNENABLE_SHIFT	5
 #define SRCONFIG_SENPENABLE_SHIFT	3
 
-#define SRCONFIG_SRENABLE		(0x01 << 11)
-#define SRCONFIG_SENENABLE		(0x01 << 10)
-#define SRCONFIG_ERRGEN_EN		(0x01 << 9)
-#define SRCONFIG_MINMAXAVG_EN		(0x01 << 8)
+#define SRCONFIG_SRENABLE		BIT(11)
+#define SRCONFIG_SENENABLE		BIT(10)
+#define SRCONFIG_ERRGEN_EN		BIT(9)
+#define SRCONFIG_MINMAXAVG_EN		BIT(8)
 
-#define SRCONFIG_DELAYCTRL		(0x01 << 2)
+#define SRCONFIG_DELAYCTRL		BIT(2)
 #define SRCONFIG_CLKCTRL		(0x00 << 0)
 
 /* AVGWEIGHT */
 #define SR1_AVGWEIGHT_SENPAVGWEIGHT	(0x03 << 2)
 #define SR1_AVGWEIGHT_SENNAVGWEIGHT	(0x03 << 0)
 
-#define SR2_AVGWEIGHT_SENPAVGWEIGHT	(0x01 << 2)
-#define SR2_AVGWEIGHT_SENNAVGWEIGHT	(0x01 << 0)
+#define SR2_AVGWEIGHT_SENPAVGWEIGHT	BIT(2)
+#define SR2_AVGWEIGHT_SENNAVGWEIGHT	BIT(0)
 
 /* NVALUERECIPROCAL */
 #define NVALUERECIPROCAL_SENPGAIN_SHIFT	20
@@ -136,8 +136,8 @@
 #define SR_CLKACTIVITY_IOFF_FOFF	(0x00 << 20)
 #define SR_CLKACTIVITY_IOFF_FON		(0x02 << 20)
 
-#define ERRCONFIG_VPBOUNDINTEN		(0x1 << 31)
-#define ERRCONFIG_VPBOUNDINTST		(0x1 << 30)
+#define ERRCONFIG_VPBOUNDINTEN		BIT(31)
+#define ERRCONFIG_VPBOUNDINTST		BIT(30)
 
 #define SR1_ERRWEIGHT			(0x07 << 16)
 #define SR1_ERRMAXLIMIT			(0x02 << 8)