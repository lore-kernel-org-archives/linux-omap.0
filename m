From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 02/10] OMAP3: PM: Additional api's in omap-pm layer
Date: Wed, 15 Apr 2009 18:25:32 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB25180D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39279 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758334AbZDOMzl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 08:55:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3FCtYge008084
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 07:55:40 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3FCtXvb021672
	for <linux-omap@vger.kernel.org>; Wed, 15 Apr 2009 18:25:33 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Rajendra Nayak <rnayak@ti.com>

This patch adds 2 new apis to the OMAP PM layer to be able
to get the latest VDD1 as well as VDD2 opps.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/include/mach/omap-pm.h |   17 +++++++++++++++++
 arch/arm/plat-omap/omap-pm-noop.c         |   22 ++++++++++++++++++++++
 arch/arm/plat-omap/omap-pm-srf.c          |   15 ++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/plat-omap/omap-pm-noop.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/omap-pm-noop.c	2009-04-15 11:44:51.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/omap-pm-noop.c	2009-04-15 11:46:11.000000000 +0530
@@ -198,6 +198,28 @@ u8 omap_pm_dsp_get_opp(void)
 	return 0;
 }
 
+u8 omap_pm_vdd1_get_opp(void)
+{
+	pr_debug("OMAP PM: User requests current VDD1 OPP\n");
+
+	/*
+	 * For l-o call resource_get_level of vdd1_opp resource.
+	 */
+
+	return 0;
+}
+
+u8 omap_pm_vdd2_get_opp(void)
+{
+	pr_debug("OMAP PM: User requests current VDD2 OPP\n");
+
+	/*
+	 * For l-o call resource_get_level of vdd2_opp resource.
+	 */
+
+	return 0;
+}
+
 /*
  * CPUFreq-originated constraint
  *
Index: linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/omap-pm-srf.c	2009-04-15 11:44:51.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/omap-pm-srf.c	2009-04-15 11:46:11.000000000 +0530
@@ -209,10 +209,23 @@ u8 omap_pm_dsp_get_opp(void)
 {
 	pr_debug("OMAP PM: DSP requests current DSP OPP ID\n");
 	return resource_get_level("vdd1_opp");
-	return 0;
 }
 EXPORT_SYMBOL(omap_pm_dsp_get_opp);
 
+u8 omap_pm_vdd1_get_opp(void)
+{
+	pr_debug("OMAP PM: User requests current VDD1 OPP\n");
+	return resource_get_level("vdd1_opp");
+}
+EXPORT_SYMBOL(omap_pm_vdd1_get_opp);
+
+u8 omap_pm_vdd2_get_opp(void)
+{
+	pr_debug("OMAP PM: User requests current VDD2 OPP\n");
+	return resource_get_level("vdd2_opp");
+}
+EXPORT_SYMBOL(omap_pm_vdd2_get_opp);
+
 /*
  * CPUFreq-originated constraint
  *
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/omap-pm.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/omap-pm.h	2009-04-15 11:44:51.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/omap-pm.h	2009-04-15 11:46:11.000000000 +0530
@@ -239,6 +239,23 @@ void omap_pm_dsp_set_min_opp(u8 opp_id);
  */
 u8 omap_pm_dsp_get_opp(void);
 
+/**
+ * omap_pm_vdd1_get_opp - report the current VDD1 OPP
+ *
+ * Report the current VDD1 OPP number.
+ *
+ * Returns the current VDD1 OPP ID, or 0 upon error.
+ */
+u8 omap_pm_vdd1_get_opp(void);
+
+/**
+ * omap_pm_vdd2_get_opp - report the current VDD2 OPP
+ *
+ * Report the current VDD2 OPP number.
+ *
+ * Returns the current VDD2 OPP ID, or 0 upon error.
+ */
+u8 omap_pm_vdd2_get_opp(void);
 
 /*
  * CPUFreq-originated constraint
