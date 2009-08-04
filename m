From: Nishanth Menon <nm@ti.com>
Subject: [RFC][PATCH v3]OMAP3:PM: Fix OPP scale logic
Date: Tue,  4 Aug 2009 10:33:52 -0500
Message-ID: <1249400032-23759-1-git-send-email-nm@ti.com>
References: <Re: [RFC][PATCH v2] OMAP3:PM: Fix OPP scale logic>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58841 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932570AbZHDPeE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Aug 2009 11:34:04 -0400
In-Reply-To: <Re: [RFC][PATCH v2] OMAP3:PM: Fix OPP scale logic>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Paul <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

While switching from higher OPP to lower OPP,
current scale logic can fail by switching to lower
voltage while frequency remains at old value.

This patch adds a cleaner recovery logic and
additional freq dpll checks. This changes
program_freq_opp return type in the process
for program_opp to handle error in a consistent
manner.

NOTE: I moved the *cur_opp setting to under the
scratchpad locked region to allow for code
simplicity - i wonder if anyone sees an issue with it

Thanks to Roger in patiently catching my goofups :(

Tested on:rx-51, ported to pm branch - untested linux-omap
Patch generated on linux-omap pm branch, commit:
7e7377395d6b4576341a6939bf2179f3946f2ea0

Signed-off-by: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com> 
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/resource34xx.c |   61 +++++++++++++++++++++++++++---------
 1 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 25535a3..9766d55 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -240,13 +240,23 @@ static int program_opp_freq(int res, int target_level, int current_level)
 	lock_scratchpad_sem();
 	if (res == VDD1_OPP) {
 		curr_opp = &curr_vdd1_opp;
-		clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
-		clk_set_rate(dpll2_clk, dsp_opps[target_level].rate);
+		ret = clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
+		if (unlikely(ret))
+			goto out;
+
+		ret = clk_set_rate(dpll2_clk, dsp_opps[target_level].rate);
+		if (unlikely(ret))
+			/* reset the dpll1 if failed */
+			clk_set_rate(dpll1_clk, mpu_opps[current_level].rate);
 #ifndef CONFIG_CPU_FREQ
-		/*Update loops_per_jiffy if processor speed is being changed*/
-		loops_per_jiffy = compute_lpj(loops_per_jiffy,
-			mpu_opps[current_level].rate/1000,
-			mpu_opps[target_level].rate/1000);
+		else
+			/*
+			 * Update loops_per_jiffy if processor speed
+			 * is being changed
+			 */
+			loops_per_jiffy = compute_lpj(loops_per_jiffy,
+				mpu_opps[current_level].rate/1000,
+				mpu_opps[target_level].rate/1000);
 #endif
 	} else {
 		curr_opp = &curr_vdd2_opp;
@@ -255,17 +265,16 @@ static int program_opp_freq(int res, int target_level, int current_level)
 		ret = clk_set_rate(dpll3_clk,
 				l3_opps[target_level].rate * l3_div);
 	}
-	if (ret) {
-		unlock_scratchpad_sem();
-		return current_level;
-	}
+out:
+	if (!ret) {
 #ifdef CONFIG_PM
-	omap3_save_scratchpad_contents();
+		omap3_save_scratchpad_contents();
 #endif
+		*curr_opp = target_level;
+	}
 	unlock_scratchpad_sem();
 
-	*curr_opp = target_level;
-	return target_level;
+	return ret;
 }
 
 static int program_opp(int res, struct omap_opp *opp, int target_level,
@@ -289,13 +298,35 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 					current_level);
 #ifdef CONFIG_OMAP_SMARTREFLEX
 		else
-			sr_voltagescale_vcbypass(t_opp, c_opp,
+			ret = sr_voltagescale_vcbypass(t_opp, c_opp,
 				opp[target_level].vsel,
 				opp[current_level].vsel);
+		if (ret) {
+			int ret1 = 0;
+			/*
+			 * If something did not work, put me back to old state.
+			 * Recover the other guy if at least 1 prev iteration
+			 * had run
+			 */
+			if (i && raise)
+				ret1 = sr_voltagescale_vcbypass(c_opp, t_opp,
+					opp[current_level].vsel,
+					opp[target_level].vsel);
+			else if (i)
+				ret1 = program_opp_freq(res, current_level,
+						target_level);
+			/*
+			 * If I could not reset my old state back.. system
+			 * is no longer in a controlled state.. bug me
+			 */
+			if (unlikely(ret1))
+				BUG();
+			break;
+		}
 #endif
 	}
 
-	return ret;
+	return (res == PRCM_VDD1) ?  curr_vdd1_opp : curr_vdd2_opp;
 }
 
 int resource_set_opp_level(int res, u32 target_level, int flags)
-- 
1.5.4.3

