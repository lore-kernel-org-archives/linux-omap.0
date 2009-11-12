From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/9] omap3: pm: introduce enabled flag to omap_opp
Date: Wed, 11 Nov 2009 23:45:13 -0600
Message-ID: <1258004721-7315-2-git-send-email-nm@ti.com>
References: <1258004721-7315-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46927 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbZKLFpq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 00:45:46 -0500
In-Reply-To: <1258004721-7315-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

We used to enable and disable OPPs based on rate being set to 0, this
has been confusing in general. So, we now allow specific OPPs to be
now enabled/disabled by an explicit enabled flag instead of re-using
rate flag itself.

Tested on: SDP3430

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Romit Dasgupta <romit@ti.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap3-opp.h           |   32 ++++++++++++++--------------
 arch/arm/mach-omap2/resource34xx.c        |    4 +++
 arch/arm/plat-omap/include/plat/omap-pm.h |    2 +
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
index c773ea7..42557e1 100644
--- a/arch/arm/mach-omap2/omap3-opp.h
+++ b/arch/arm/mach-omap2/omap3-opp.h
@@ -22,41 +22,41 @@
 #define S166M   166000000
 
 static struct omap_opp omap3_mpu_rate_table[] = {
-	{0, 0, 0},
+	{0, 0, 0, 0},
 	/*OPP1*/
-	{S125M, VDD1_OPP1, 0x1E},
+	{true, S125M, VDD1_OPP1, 0x1E},
 	/*OPP2*/
-	{S250M, VDD1_OPP2, 0x26},
+	{true, S250M, VDD1_OPP2, 0x26},
 	/*OPP3*/
-	{S500M, VDD1_OPP3, 0x30},
+	{true, S500M, VDD1_OPP3, 0x30},
 	/*OPP4*/
-	{S550M, VDD1_OPP4, 0x36},
+	{true, S550M, VDD1_OPP4, 0x36},
 	/*OPP5*/
-	{S600M, VDD1_OPP5, 0x3C},
+	{true, S600M, VDD1_OPP5, 0x3C},
 };
 
 static struct omap_opp omap3_l3_rate_table[] = {
-	{0, 0, 0},
+	{0, 0, 0, 0},
 	/*OPP1*/
-	{0, VDD2_OPP1, 0x1E},
+	{false, 0, VDD2_OPP1, 0x1E},
 	/*OPP2*/
-	{S83M, VDD2_OPP2, 0x24},
+	{true, S83M, VDD2_OPP2, 0x24},
 	/*OPP3*/
-	{S166M, VDD2_OPP3, 0x2C},
+	{true, S166M, VDD2_OPP3, 0x2C},
 };
 
 static struct omap_opp omap3_dsp_rate_table[] = {
-	{0, 0, 0},
+	{0, 0, 0, 0},
 	/*OPP1*/
-	{S90M, VDD1_OPP1, 0x1E},
+	{true, S90M, VDD1_OPP1, 0x1E},
 	/*OPP2*/
-	{S180M, VDD1_OPP2, 0x26},
+	{true, S180M, VDD1_OPP2, 0x26},
 	/*OPP3*/
-	{S360M, VDD1_OPP3, 0x30},
+	{true, S360M, VDD1_OPP3, 0x30},
 	/*OPP4*/
-	{S400M, VDD1_OPP4, 0x36},
+	{true, S400M, VDD1_OPP4, 0x36},
 	/*OPP5*/
-	{S430M, VDD1_OPP5, 0x3C},
+	{true, S430M, VDD1_OPP5, 0x3C},
 };
 
 #endif
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 04be4d2..af6b3c1 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -285,6 +285,10 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level].opp_id);
 #endif
 
+	/* Only allow enabled OPPs */
+	if (!opp[target_level].enabled)
+		return -EINVAL;
+
 	/* Sanity check of the OPP params before attempting to set */
 	if (!opp[target_level].rate || !opp[target_level].vsel)
 		return -EINVAL;
diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
index 583e540..5dc2048 100644
--- a/arch/arm/plat-omap/include/plat/omap-pm.h
+++ b/arch/arm/plat-omap/include/plat/omap-pm.h
@@ -21,6 +21,7 @@
 
 /**
  * struct omap_opp - clock frequency-to-OPP ID table for DSP, MPU
+ * @enabled: enabled if true, disabled if false
  * @rate: target clock rate
  * @opp_id: OPP ID
  * @min_vdd: minimum VDD1 voltage (in millivolts) for this OPP
@@ -28,6 +29,7 @@
  * Operating performance point data.  Can vary by OMAP chip and board.
  */
 struct omap_opp {
+	bool enabled;
 	unsigned long rate;
 	u8 opp_id;
 	u16 vsel;
-- 
1.6.3.3

