From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] ARM: OMAP3: cpuidle - check the powerdomain lookup
Date: Fri,  4 May 2012 19:18:40 +0200
Message-ID: <1336151921-9485-2-git-send-email-daniel.lezcano@linaro.org>
References: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51993 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab2EDRSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 13:18:46 -0400
Received: by werb10 with SMTP id b10so62111wer.19
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 10:18:45 -0700 (PDT)
In-Reply-To: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

At init time, check the powerdomains lookup is successful otherwise
exit the cpuidle driver init function with -ENODEV like what is done for the
omap3 cpuidle driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f682e17..207bc1c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -363,6 +363,9 @@ int __init omap3_idle_init(void)
 	per_pd = pwrdm_lookup("per_pwrdm");
 	cam_pd = pwrdm_lookup("cam_pwrdm");
 
+	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
+		return -ENODEV;
+
 	cpuidle_register_driver(&omap3_idle_driver);
 
 	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
-- 
1.7.5.4

