From: Silesh C V <silesh@ti.com>
Subject: [PATCH] OMAP: PM: CPUFREQ: Fix conditional compilation
Date: Fri, 24 Sep 2010 14:24:54 +0530
Message-ID: <1285318494-22092-1-git-send-email-silesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35033 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab0IXIy4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Sep 2010 04:54:56 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8O8stUl009377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 03:54:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Silesh C V <silesh@ti.com>

Fix conditional compilation.

Signed-off-by: Silesh C V <silesh@ti.com>
---

Applies on top of the latest pm branch.

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

