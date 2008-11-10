From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 06/08] OMAP3 SRF: Voltage scaling support
Date: Mon, 10 Nov 2008 16:58:54 +0530
Message-ID: <00c401c94327$838448c0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50566 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497AbYKJL3C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 06:29:02 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAABStkc028038
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 05:29:01 -0600
Received: from wipultra1382 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAABSslq013053
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 16:58:54 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Adds Voltage scaling support

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/board-3430sdp.c       |   26 +++++++++++++-------------
 arch/arm/mach-omap2/resource34xx.c        |   17 ++++++++++++++++-
 arch/arm/mach-omap2/resource34xx.h        |    1 +
 arch/arm/plat-omap/include/mach/omap-pm.h |    2 +-
 4 files changed, 31 insertions(+), 15 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2008-11-10 12:09:13.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2008-11-10 12:09:14.000000000 +0530
@@ -71,39 +71,39 @@
 static struct omap_opp mpu_rate_table[] = {
 	{0, 0, 0},
 	/*OPP1*/
-	{S125M, VDD1_OPP1, 0},
+	{S125M, VDD1_OPP1, 0x18},
 	/*OPP2*/
-	{S250M, VDD1_OPP2, 0},
+	{S250M, VDD1_OPP2, 0x20},
 	/*OPP3*/
-	{S500M, VDD1_OPP3, 0},
+	{S500M, VDD1_OPP3, 0x30},
 	/*OPP4*/
-	{S550M, VDD1_OPP4, 0},
+	{S550M, VDD1_OPP4, 0x36},
 	/*OPP5*/
-	{S600M, VDD1_OPP5, 0},
+	{S600M, VDD1_OPP5, 0x3C},
 };
 
 static struct omap_opp l3_rate_table[] = {
 	{0, 0, 0},
 	/*OPP1*/
-	{0, VDD2_OPP1, 0},
+	{0, VDD2_OPP1, 0x18},
 	/*OPP2*/
-	{S83M, VDD2_OPP2, 0},
+	{S83M, VDD2_OPP2, 0x20},
 	/*OPP3*/
-	{S166M, VDD2_OPP3, 0},
+	{S166M, VDD2_OPP3, 0x2C},
 };
 
 struct omap_opp dsp_rate_table[] = {
 	{0, 0, 0},
 	/*OPP1*/
-	{S90M, VDD1_OPP1, 0},
+	{S90M, VDD1_OPP1, 0x18},
 	/*OPP2*/
-	{S180M, VDD1_OPP2, 0},
+	{S180M, VDD1_OPP2, 0x20},
 	/*OPP3*/
-	{S360M, VDD1_OPP3, 0},
+	{S360M, VDD1_OPP3, 0x30},
 	/*OPP4*/
-	{S400M, VDD1_OPP4, 0},
+	{S400M, VDD1_OPP4, 0x36},
 	/*OPP5*/
-	{S430M, VDD1_OPP5, 0},
+	{S430M, VDD1_OPP5, 0x3C},
 };
 
 #define CONFIG_DISABLE_HFCLK 1
Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/resource34xx.c	2008-11-10 12:09:13.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c	2008-11-10 12:09:14.000000000 +0530
@@ -19,6 +19,7 @@
 #include <linux/pm_qos_params.h>
 #include <mach/powerdomain.h>
 #include <mach/clockdomain.h>
+#include "smartreflex.h"
 #include "resource34xx.h"
 #include "pm.h"
 
@@ -157,10 +158,24 @@ void init_opp(struct shared_resource *re
 int set_opp(struct shared_resource *resp, u32 target_level)
 {
 	unsigned long mpu_freq;
+
+	if (resp->curr_level == target_level)
+		return 0;
+
 	if (strcmp(resp->name, "vdd1_opp") == 0) {
 		mpu_freq = get_freq(mpu_opps + MAX_VDD1_OPP,
 					target_level);
-		clk_set_rate(vdd1_clk, mpu_freq);
+		if (resp->curr_level > target_level) {
+			/* Scale Frequency and then voltage */
+			clk_set_rate(vdd1_clk, mpu_freq);
+			sr_voltagescale_vcbypass(PRCM_VDD1,
+					mpu_opps[target_level-1].vsel);
+		} else {
+			/* Scale Voltage and then frequency */
+			sr_voltagescale_vcbypass(PRCM_VDD1,
+					mpu_opps[target_level-1].vsel);
+			clk_set_rate(vdd1_clk, mpu_freq);
+		}
 		resp->curr_level = curr_vdd1_prcm_set->opp_id;
 	} else if (strcmp(resp->name, "vdd2_opp") == 0) {
 		/* Not supported yet */
Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/resource34xx.h	2008-11-10 12:09:13.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.h	2008-11-10 12:09:14.000000000 +0530
@@ -31,6 +31,7 @@ extern struct omap_opp *curr_vdd1_prcm_s
 extern struct omap_opp *curr_vdd2_prcm_set;
 extern unsigned long get_freq(struct  omap_opp *, unsigned short);
 extern unsigned short get_opp(struct omap_opp *, unsigned long);
+extern int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel);
 
 /*
  * mpu_latency/core_latency are used to control the cpuidle C state.
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/omap-pm.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/omap-pm.h	2008-11-10 12:09:13.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/omap-pm.h	2008-11-10 12:09:14.000000000 +0530
@@ -30,7 +30,7 @@
 struct omap_opp {
 	unsigned long rate;
 	u8 opp_id;
-	u16 min_vdd;
+	u16 vsel;
 };
 
 extern struct omap_opp *mpu_opps;

