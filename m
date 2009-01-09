From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 7/8] PM: OMAP3: Removed a couple of unused variables from DVFS code
Date: Fri,  9 Jan 2009 17:49:07 +0200
Message-ID: <1231516148-10260-8-git-send-email-tero.kristo@nokia.com>
References: <>
 <1231516148-10260-1-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-2-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-3-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-4-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-5-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-6-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-7-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49584 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbZAIQBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 11:01:46 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n09G1PFk019646
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 18:01:45 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n09FwtlQ031435
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:59:05 +0200
In-Reply-To: <1231516148-10260-7-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

- freqs_notify is only used by CPU_FREQ => added compiler flags
- req_l3_freq was a copy paste bug and was never used by this function => rm

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/resource34xx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index f862ee6..aec2bcb 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -183,8 +183,10 @@ int resource_access_opp_lock(int res, int delta)
 
 int resource_set_opp_level(int res, u32 target_level, int flags)
 {
-	unsigned long mpu_freq, mpu_old_freq, l3_freq, req_l3_freq, t_opp;
+	unsigned long mpu_freq, mpu_old_freq, l3_freq, t_opp;
+#ifdef CONFIG_CPU_FREQ
 	struct cpufreq_freqs freqs_notify;
+#endif
 	struct shared_resource *resp;
 
 	if (res == VDD1_OPP)
-- 
1.5.4.3

