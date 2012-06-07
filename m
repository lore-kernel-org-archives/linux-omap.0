From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 05/10] ARM: OMAP2+: PMU: Add runtime PM support
Date: Thu, 7 Jun 2012 16:22:07 -0500
Message-ID: <1339104132-26885-6-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39024 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932917Ab2FGVXB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 17:23:01 -0400
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

The original implementation of this patch was done by Ming Lei for PMU on OMAP4
[1]. Since then the PM runtime calls have been moved into the ARM PMU code and
this greatly simplifies the changes.

The another differnce since the original version, is that it is no longer
necessary to call pm_runtime_get/put during the PMU initialisation was we are no
longer accessing the hardware at this stage.

By adding runtime PM support, we can ensure that the appropriate power and clock
domains are kept on while PMU is being used.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074153.html

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/pmu.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
index b3b9306..1b36eda 100644
--- a/arch/arm/mach-omap2/pmu.c
+++ b/arch/arm/mach-omap2/pmu.c
@@ -13,6 +13,8 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+#include <linux/pm_runtime.h>
+
 #include <asm/pmu.h>
 
 #include <plat/omap_hwmod.h>
@@ -45,6 +47,9 @@ static int __init omap2_init_pmu(void)
 	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
 				dev_name);
 
+	if (omap_pmu_dev)
+		pm_runtime_enable(&omap_pmu_dev->dev);
+
 	return 0;
 }
 
@@ -88,6 +93,9 @@ static int __init omap4430_init_pmu(void)
 	WARN(IS_ERR(omap_pmu_dev), "Can't build omap_device for %s.\n",
 				dev_name);
 
+	if (omap_pmu_dev)
+		pm_runtime_enable(&omap_pmu_dev->dev);
+
 	return 0;
 }
 
-- 
1.7.9.5

