From: Silesh C V <silesh@ti.com>
Subject: [PATCH v2] OMAP: PM: CPUFREQ: Fix conditional compilation
Date: Wed, 29 Sep 2010 14:52:54 +0530
Message-ID: <1285752174-11394-1-git-send-email-silesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38810 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442Ab0I2JXo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Sep 2010 05:23:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Silesh C V <silesh@ti.com>

Fix conditional compilation. A conditional expresiion
should follow "#elif", in this case #elif clause should
check whether CONFIG_ARCH_OMAP3 is defined or not
(ie. defined(CONFIG_ARCH_OMAP3)) rather than checking for
the value of the macro.

Signed-off-by: Silesh C V <silesh@ti.com>
---
 arch/arm/plat-omap/cpu-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index df08829..02e4865 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -41,7 +41,7 @@ static struct cpufreq_frequency_table *freq_table;
 
 #ifdef CONFIG_ARCH_OMAP1
 #define MPU_CLK		"mpu"
-#elif CONFIG_ARCH_OMAP3
+#elif defined(CONFIG_ARCH_OMAP3)
 #define MPU_CLK		"arm_fck"
 #else
 #define MPU_CLK		"virt_prcm_set"
-- 
1.7.0.4

