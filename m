From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] omap3: pm: cpufreq: populate l3 opp1 again
Date: Wed, 27 Jan 2010 23:41:00 -0600
Message-ID: <1264657260-12310-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38831 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab0A1FlR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jan 2010 00:41:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Andrew Murray <amurray@mpc-data.co.uk>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

We had removed the frequency for OPP1 L3 when we used to use frequency
to enable/disable frequencies. It is better to populate the same
instead of confusing future readers of the code. The OPP1 remains
disabled as explained in the discussion.

Discussion: http://marc.info/?t=126453821900001&r=1&w=2

Cc: Andrew Murray <amurray@mpc-data.co.uk>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/cpufreq34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
index 209af2b..aec1ffe 100644
--- a/arch/arm/mach-omap2/cpufreq34xx.c
+++ b/arch/arm/mach-omap2/cpufreq34xx.c
@@ -43,7 +43,7 @@ static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
 
 static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
 	/* OPP1 */
-	OMAP_OPP_DEF(false, 0, 975000),
+	OMAP_OPP_DEF(false, 41500000, 975000),
 	/* OPP2 */
 	OMAP_OPP_DEF(true, 83000000, 1050000),
 	/* OPP3 */
-- 
1.6.3.3

