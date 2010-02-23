From: Thara Gopinath <thara@ti.com>
Subject: [PATCH V2] [PM-WIP-OPP]: Fixing wrong target level being passed during Core DVFS.
Date: Tue, 23 Feb 2010 22:33:52 +0530
Message-ID: <1266944632-9744-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58881 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077Ab0BWREA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 12:04:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

As per the current implementaion (u8*)&target_level is being passed
to freq_to_opp in set_opp. This would result in updating just the first
8 bits of a u32 variable. Later target_level is passed to
resource_set_opp_level as a u32 parameter. This maens
a. Initially target_level was 0xabcdefgh.
b. freq_to_opp updates the lower eight bits of target_level
to 0xXX. Now target_level = 0xabcdefXX.
c. We pass 0xabcdefXX as target_level to resource_set_opp_level
when we want to pass just 0xXX.
This is leading to some corrupted bookkeeping later on in the
dvfs path.

This patch ensures that target_level passed to resource_set_opp_level
is actually the level that is intended by freq_to_opp API.

Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/resource34xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 3604a38..2c850a2 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -478,6 +478,7 @@ int set_opp(struct shared_resource *resp, u32 target_level)
 		/* uh uh.. no OPPs?? */
 		BUG_ON(IS_ERR(oppx));
 
+		target_level = 0;
 		ret = freq_to_opp((u8 *)&target_level, OPP_L3, req_l3_freq);
 		/* we dont expect this to fail */
 		BUG_ON(ret);
-- 
1.5.4.7

