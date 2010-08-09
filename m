From: mturquette@gmail.com
Subject: [PATCH] OMAP: Voltage: fix typos, compile break
Date: Mon,  9 Aug 2010 14:39:19 -0500
Message-ID: <1281382759-13025-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33729 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab0HITjw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 15:39:52 -0400
Received: by gxk23 with SMTP id 23so3538572gxk.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Aug 2010 12:39:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Mike Turquette <mturquette@ti.com>

From: Mike Turquette <mturquette@ti.com>

mach-omap/voltage.c incorrectly called omap_get_mpuss_device and
omap_get_l3_device.  The correct function names are
omap2_get_mpuss_device and omap2_get_l3_device respectively.

This fixes a compile break.  Test on OMAP3430 SDP.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---

This patch is meant to apply to Kevin's pm-srf branch.  Without it
compilation for OMAP3 is broken.

 arch/arm/mach-omap2/voltage.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index e7055f6..148e4d4 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -385,7 +385,7 @@ static void __init omap3_vdd_data_configure(int vdd)
 		vdd_info[vdd].volt_clk = clk_get(NULL, "dpll1_ck");
 		WARN(IS_ERR(vdd_info[vdd].volt_clk),
 				"unable to get clock for VDD%d\n", vdd + 1);
-		vdd_info[vdd].opp_dev = omap_get_mpuss_device();
+		vdd_info[vdd].opp_dev = omap2_get_mpuss_device();
 		vdd_info[vdd].vp_reg.tranxdone_status =
 				OMAP3430_VP1_TRANXDONE_ST_MASK;
 		vdd_info[vdd].cmdval_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET;
@@ -411,7 +411,7 @@ static void __init omap3_vdd_data_configure(int vdd)
 		vdd_info[vdd].volt_clk = clk_get(NULL, "l3_ick");
 		WARN(IS_ERR(vdd_info[vdd].volt_clk),
 				"unable to get clock for VDD%d\n", vdd + 1);
-		vdd_info[vdd].opp_dev = omap_get_l3_device();
+		vdd_info[vdd].opp_dev = omap2_get_l3_device();
 		vdd_info[vdd].vp_reg.tranxdone_status =
 					OMAP3430_VP2_TRANXDONE_ST_MASK;
 		vdd_info[vdd].cmdval_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET;
-- 
1.7.0.5

