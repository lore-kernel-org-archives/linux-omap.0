From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP3: SR: Wait for VP idle before a VP disable
Date: Tue, 30 Jun 2009 15:15:37 +0530
Message-ID: <1246355137-13600-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39984 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbZF3Jpn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jun 2009 05:45:43 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5U9je1w022795
	for <linux-omap@vger.kernel.org>; Tue, 30 Jun 2009 04:45:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

In the SR disable path it is recommended to wait
for Voltage processor to idle before disabling the
VP.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   47 +++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 9d462e3..1407783 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -36,6 +36,8 @@
 #include "smartreflex.h"
 #include "prm-regbits-34xx.h"
 
+#define MAX_TRIES 100
+
 struct omap_sr {
 	int		srid;
 	int		is_sr_reset;
@@ -620,16 +622,39 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 
 static void sr_disable(struct omap_sr *sr)
 {
+	u32 i = 0;
+
 	sr->is_sr_reset = 1;
 
 	/* SRCONFIG - disable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, ~SRCONFIG_SRENABLE);
 
 	if (sr->srid == SR1) {
+		/* Wait for VP idle before disabling VP */
+		while ((!prm_read_mod_reg(OMAP3430_GR_MOD,
+					OMAP3_PRM_VP1_STATUS_OFFSET))
+					&& i++ < MAX_TRIES)
+			udelay(1);
+
+		if (i >= MAX_TRIES)
+			pr_warning("VP1 not idle, still going ahead with \
+							VP1 disable\n");
+
 		/* Disable VP1 */
 		prm_clear_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE, OMAP3430_GR_MOD,
 					OMAP3_PRM_VP1_CONFIG_OFFSET);
+
 	} else if (sr->srid == SR2) {
+		/* Wait for VP idle before disabling VP */
+		while ((!prm_read_mod_reg(OMAP3430_GR_MOD,
+					OMAP3_PRM_VP2_STATUS_OFFSET))
+					&& i++ < MAX_TRIES)
+			udelay(1);
+
+		if (i >= MAX_TRIES)
+			pr_warning("VP2 not idle, still going ahead with \
+							 VP2 disable\n");
+
 		/* Disable VP2 */
 		prm_clear_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE, OMAP3430_GR_MOD,
 					OMAP3_PRM_VP2_CONFIG_OFFSET);
@@ -731,6 +756,8 @@ void enable_smartreflex(int srid)
 
 void disable_smartreflex(int srid)
 {
+	u32 i = 0;
+
 	struct omap_sr *sr = NULL;
 
 	if (srid == SR1)
@@ -751,11 +778,31 @@ void disable_smartreflex(int srid)
 			/* Disable SR clk */
 			sr_clk_disable(sr);
 			if (sr->srid == SR1) {
+				/* Wait for VP idle before disabling VP */
+				while ((!prm_read_mod_reg(OMAP3430_GR_MOD,
+						OMAP3_PRM_VP1_STATUS_OFFSET))
+						&& i++ < MAX_TRIES)
+					udelay(1);
+
+				if (i >= MAX_TRIES)
+					pr_warning("VP1 not idle, still going \
+						ahead with VP1 disable\n");
+
 				/* Disable VP1 */
 				prm_clear_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE,
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VP1_CONFIG_OFFSET);
 			} else if (sr->srid == SR2) {
+				/* Wait for VP idle before disabling VP */
+				while ((!prm_read_mod_reg(OMAP3430_GR_MOD,
+						OMAP3_PRM_VP2_STATUS_OFFSET))
+						&& i++ < MAX_TRIES)
+					udelay(1);
+
+				if (i >= MAX_TRIES)
+					pr_warning("VP2 not idle, still going \
+						 ahead with VP2 disable\n");
+
 				/* Disable VP2 */
 				prm_clear_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE,
 						OMAP3430_GR_MOD,
-- 
1.5.4.7

