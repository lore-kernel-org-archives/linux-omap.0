From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH 2/3] OMAP3: PM: Remove double assignments of mpu_pd, core_pd
Date: Tue, 17 Mar 2009 16:25:44 +0900
Message-ID: <4d34a0a70903170025y9256732xff9b811fa803f2b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:46850 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbZCQHZq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 03:25:46 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2379396wfa.4
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 00:25:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: q1.kim@samsung.com, Kevin Hilman <khilman@deeprootsystems.com>, Jouni Hogander <jouni.hogander@nokia.com>, kyungmin.park@samsung.com

mpu_pd, core_pd is already assigned at the beginning of the
omap3_idle_init() function.

Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
b/arch/arm/mach-omap2/cpuidle34xx.c
index 5e50c46..630108c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -272,8 +272,6 @@ int omap3_idle_init(void)
 		       __func__);
 		return -EIO;
 	}
-	mpu_pd = pwrdm_lookup("mpu_pwrdm");
-	core_pd = pwrdm_lookup("core_pwrdm");
 	return 0;
 }
 #endif /* CONFIG_CPU_IDLE */
-- 
1.5.2.5


-- 
Kyuwon
