From: Mike Turquette <mturquette@gmail.com>
Subject: [PATCH 3/3] HACK: OMAP3630: PM: allow testing of DVFS & FBB
Date: Fri, 16 Apr 2010 16:33:23 -0500
Message-ID: <1271453603-21929-4-git-send-email-mturquette@ti.com>
References: <1271453603-21929-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:62370 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525Ab0DPVeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 17:34:07 -0400
Received: by yxe37 with SMTP id 37so1682877yxe.21
        for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 14:34:06 -0700 (PDT)
In-Reply-To: <1271453603-21929-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, Thara Gopinath <thara@ti.com>, Shweta Gulati <shweta.gulati@ti.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Mike Turquette <mturquette@ti.com>

This hack should not be applied to any git trees.

Enables 800MHz and 1GHz OPPs on VDD1 for 36XX silicon and bypasses an
error condition in vp_forceupdate_scale_voltage to allow for voltage
scaling to happen in the absence of complete SmartReflex support.

These changes are needed to allow DVFS transitions via cpufreq on top of
pm-wip-sr and to test the FBB transitions that only happen @ 1GHz on
3630.

Not-Signed-Off-By: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/cpufreq34xx.c |    8 ++++----
 arch/arm/mach-omap2/voltage.c     |    1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
index 189c42e..47913dc 100644
--- a/arch/arm/mach-omap2/cpufreq34xx.c
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -80,9 +80,9 @@ static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
 	/* OPP2 - OPP100 */
 	OMAP_OPP_DEF(true,  600000000, 1100000),
 	/* OPP3 - OPP-Turbo */
-	OMAP_OPP_DEF(false, 800000000, 1260000),
+	OMAP_OPP_DEF(true, 800000000, 1260000),
 	/* OPP4 - OPP-SB */
-	OMAP_OPP_DEF(false, 1000000000, 1350000),
+	OMAP_OPP_DEF(true, 1000000000, 1350000),
 	/* Terminator */
 	OMAP_OPP_DEF(0, 0, 0)
 };
@@ -102,9 +102,9 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
 	/* OPP2 - OPP100 */
 	OMAP_OPP_DEF(true,  520000000, 1100000),
 	/* OPP3 - OPP-Turbo */
-	OMAP_OPP_DEF(false, 660000000, 1260000),
+	OMAP_OPP_DEF(true, 660000000, 1260000),
 	/* OPP4 - OPP-SB */
-	OMAP_OPP_DEF(false, 800000000, 1350000),
+	OMAP_OPP_DEF(true, 800000000, 1350000),
 	/* Terminator */
 	OMAP_OPP_DEF(0, 0, 0)
 };
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 98d8bb3..bec8c18 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -571,7 +571,6 @@ static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt,
 			pr_warning("Unable to get voltage table for VDD%d \
 				during voltage scaling. Some really Wrong!",
 				vdd + 1);
-			return false;
 		}
 		vp_reg[vdd].vp_errorgain = (volt_data.vp_errorgain <<
 				OMAP3430_ERRORGAIN_SHIFT);
-- 
1.6.3.2

