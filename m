From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP3: CPUidle: remove redundant setting of PER next power state
Date: Fri,  1 Oct 2010 14:01:19 -0700
Message-ID: <1285966880-26448-2-git-send-email-khilman@deeprootsystems.com>
References: <1285966880-26448-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50296 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380Ab0JAVBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:01:25 -0400
Received: by pwj5 with SMTP id 5so654956pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 14:01:25 -0700 (PDT)
In-Reply-To: <1285966880-26448-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

When checking how to program the next powerstate for the PER
powerdomain, the next state of PER powerdomain was written twice.
Remove the duplicate write.

Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 8ea012e..703b5ec 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -272,10 +272,8 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 */
 	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
 	if ((per_next_state == PWRDM_POWER_OFF) &&
-	    (core_next_state > PWRDM_POWER_RET)) {
+	    (core_next_state > PWRDM_POWER_RET))
 		per_next_state = PWRDM_POWER_RET;
-		pwrdm_set_next_pwrst(per_pd, per_next_state);
-	}
 
 	/* Are we changing PER target state? */
 	if (per_next_state != per_saved_state)
-- 
1.7.2.1

