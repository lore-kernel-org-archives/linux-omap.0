From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 11/13] OMAP3: Update cpufreq driver to use the new set_rate API
Date: Wed, 18 Aug 2010 16:50:10 +0530
Message-ID: <1282130412-12027-12-git-send-email-thara@ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41241 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806Ab0HRLU0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 07:20:26 -0400
In-Reply-To: <1282130412-12027-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

This patch updates the cpufreq driver to use the device
set rate API to scale the mpu frequency for OMAP3.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/cpu-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index df08829..9232246 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -29,6 +29,7 @@
 #include <mach/hardware.h>
 #include <plat/clock.h>
 #include <asm/system.h>
+#include <plat/omap_device.h>
 
 #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 #include <plat/omap-pm.h>
@@ -117,7 +118,7 @@ static int omap_target(struct cpufreq_policy *policy,
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 	freq = target_freq * 1000;
 	if (opp_find_freq_ceil(mpu_dev, &freq))
-		omap_pm_cpu_set_freq(freq);
+		omap_device_set_rate(mpu_dev, mpu_dev, freq);
 #endif
 	return ret;
 }
-- 
1.7.1.GIT

