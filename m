From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 1/3] ARM: OMAP3: PM: cpuidle: default to C1 in next_valid_state
Date: Fri,  1 Jun 2012 17:11:06 +0200
Message-ID: <1338563468-31403-2-git-send-email-j-pihet@ti.com>
References: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55263 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab2FAPLV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 11:11:21 -0400
Received: by weyu7 with SMTP id u7so1434685wey.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 08:11:20 -0700 (PDT)
In-Reply-To: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org
Cc: Jean Pihet <j-pihet@ti.com>

If the next state is no found in the next_valid_state function,
fallback to the default value of C1 (which is state 0).
This prevents the use of a bogus state -1 in the rest of the cpuidle
code.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 207bc1c..f619a92 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -178,7 +178,7 @@ static int next_valid_state(struct cpuidle_device *dev,
 	u32 mpu_deepest_state = PWRDM_POWER_RET;
 	u32 core_deepest_state = PWRDM_POWER_RET;
 	int idx;
-	int next_index = -1;
+	int next_index = 0; /* C1 is the default value */
 
 	if (enable_off_mode) {
 		mpu_deepest_state = PWRDM_POWER_OFF;
@@ -209,12 +209,6 @@ static int next_valid_state(struct cpuidle_device *dev,
 		}
 	}
 
-	/*
-	 * C1 is always valid.
-	 * So, no need to check for 'next_index == -1' outside
-	 * this loop.
-	 */
-
 	return next_index;
 }
 
-- 
1.7.7.6

