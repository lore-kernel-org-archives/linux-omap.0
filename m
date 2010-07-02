From: Thara Gopinath <thara@ti.com>
Subject: [RFC 7/7] OMAP3: Update cpufreq driver to use the new set_rate API
Date: Fri,  2 Jul 2010 15:48:29 +0530
Message-ID: <1278065909-32148-8-git-send-email-thara@ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
 <1278065909-32148-2-git-send-email-thara@ti.com>
 <1278065909-32148-3-git-send-email-thara@ti.com>
 <1278065909-32148-4-git-send-email-thara@ti.com>
 <1278065909-32148-5-git-send-email-thara@ti.com>
 <1278065909-32148-6-git-send-email-thara@ti.com>
 <1278065909-32148-7-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47178 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478Ab0GBKSk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Jul 2010 06:18:40 -0400
In-Reply-To: <1278065909-32148-7-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, p-basak2@ti.com, Thara Gopinath <thara@ti.com>

This patch updates the cpufreq driver to use the device
set rate API to scale the mpu frequency for OMAP3.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/cpu-omap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 9467827..cde02b5 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -29,6 +29,7 @@
 #include <mach/hardware.h>
 #include <plat/clock.h>
 #include <asm/system.h>
+#include <plat/omap_device.h>
 
 #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 #include <plat/omap-pm.h>
@@ -84,7 +85,7 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-#ifdef CONFIG_ARCH_OMAP1
+#ifdef CONFIG_ARiCH_OMAP1
 	struct cpufreq_freqs freqs;
 #endif
 #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
@@ -117,7 +118,7 @@ static int omap_target(struct cpufreq_policy *policy,
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 	freq = target_freq * 1000;
 	if (opp_find_freq_ceil(mpu_dev, &freq))
-		omap_pm_cpu_set_freq(freq);
+		omap_device_set_rate(mpu_dev, freq);
 #endif
 	return ret;
 }
-- 
1.7.0.rc1.33.g07cf0f

