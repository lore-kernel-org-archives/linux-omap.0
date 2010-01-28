From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP-OPP] [PATCH v2] omap3: pm: cpufreq: populate l3 opp1 again
Date: Thu, 28 Jan 2010 14:38:41 -0600
Message-ID: <1264711121-16873-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57322 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab0A1UjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 15:39:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Andrew Murray <amurray@mpc-data.co.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Romit Dasgupta <romit@ti.com>, Benoit Cousson <b-cousson@ti.com>

We had removed the frequency for OPP1 L3 when we used to use frequency
to enable/disable frequencies. It is better to populate the same
instead of confusing future readers of the code. The OPP1 remains
disabled as explained in the discussion.

Discussion: http://marc.info/?t=126453821900001&r=1&w=2

Cc: Andrew Murray <amurray@mpc-data.co.uk>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Romit Dasgupta <romit@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---

Ref:
v1: http://marc.info/?t=126465729200002&r=1&w=2

Adding Signed-off-by Benoit to attribute the comment message which I
"borrowed" from his excellent explanation in the mail thread and put
as comment.

 arch/arm/mach-omap2/cpufreq34xx.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
index 07873e8..9882451 100644
--- a/arch/arm/mach-omap2/cpufreq34xx.c
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -42,8 +42,15 @@ static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
 };
 
 static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
-	/* OPP1 */
-	OMAP_OPP_DEF(false, 0, 975000),
+	/*
+	 * OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
+	 * almost the same than the one at 83MHz thus providing very little
+	 * gain for the power point of view. In term of energy it will even
+	 * increase the consumption due to the very negative performance
+	 * impact that frequency will do to the MPU and the whole system in
+	 * general.
+	 */
+	OMAP_OPP_DEF(false, 41500000, 975000),
 	/* OPP2 */
 	OMAP_OPP_DEF(true, 83000000, 1050000),
 	/* OPP3 */
-- 
1.6.3.3

