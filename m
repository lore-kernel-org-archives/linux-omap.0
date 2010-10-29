From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 11/14] OMAP3: Update cpufreq driver to use the new set_rate API
Date: Fri, 29 Oct 2010 21:08:25 +0530
Message-ID: <1288366708-32302-12-git-send-email-thara@ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34623 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932704Ab0J2Pim (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Oct 2010 11:38:42 -0400
In-Reply-To: <1288366708-32302-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch updates the cpufreq driver to use the device
set rate API to scale the mpu frequency for OMAP3.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/cpu-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 671e4b9..d9d5bdb 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -31,6 +31,7 @@
 #include <plat/clock.h>
 #include <plat/common.h>
 #include <asm/system.h>
+#include <plat/omap_device.h>
 
 #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 #include <plat/omap-pm.h>
@@ -118,7 +119,7 @@ static int omap_target(struct cpufreq_policy *policy,
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 	freq = target_freq * 1000;
 	if (opp_find_freq_ceil(mpu_dev, &freq))
-		omap_pm_cpu_set_freq(freq);
+		omap_device_scale(mpu_dev, mpu_dev, freq);
 #endif
 	return ret;
 }
-- 
1.7.0.4

