From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 06/10] ARM: OMAP3: PM: cpuidle: default to C1 in next_valid_state
Date: Thu, 14 Jun 2012 17:05:57 +0200
Message-ID: <1339686361-11526-7-git-send-email-j-pihet@ti.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60855 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210Ab2FNPGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 11:06:19 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so1326955wey.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 08:06:18 -0700 (PDT)
In-Reply-To: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
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
index 1f33b8e..9319f94 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -186,7 +186,7 @@ static int next_valid_state(struct cpuidle_device *dev,
 	u32 mpu_pm_qos_next_state = mpu_pd->wkup_lat_next_state;
 	u32 core_pm_qos_next_state = core_pd->wkup_lat_next_state;
 	int idx;
-	int next_index = -1;
+	int next_index = 0; /* C1 is the default value */
 
 	if (enable_off_mode) {
 		mpu_deepest_state = PWRDM_FUNC_PWRST_OFF;
@@ -221,12 +221,6 @@ static int next_valid_state(struct cpuidle_device *dev,
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

