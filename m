From: Robert Lee <rob.lee@linaro.org>
Subject: [PATCH v7 8/9] ARM: shmobile: Consolidate time keeping and irq enable
Date: Wed, 29 Feb 2012 18:42:57 -0600
Message-ID: <1330562578-3410-9-git-send-email-rob.lee@linaro.org>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55582 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965862Ab2CAAnh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 19:43:37 -0500
Received: by mail-gy0-f174.google.com with SMTP id r11so14643ghr.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 16:43:37 -0800 (PST)
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rjw@sisk.pl, len.brown@intel.com
Cc: khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

Enable core cpuidle timekeeping and irq enabling and remove that
handling from this code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-shmobile/cpuidle.c |   31 +++++++------------------------
 1 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 1b23342..ca23b20 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <asm/system.h>
+#include <asm/cpuidle.h>
 #include <asm/io.h>
 
 static void shmobile_enter_wfi(void)
@@ -29,37 +30,19 @@ static int shmobile_cpuidle_enter(struct cpuidle_device *dev,
 				  struct cpuidle_driver *drv,
 				  int index)
 {
-	ktime_t before, after;
-
-	before = ktime_get();
-
-	local_irq_disable();
-	local_fiq_disable();
-
 	shmobile_cpuidle_modes[index]();
 
-	local_irq_enable();
-	local_fiq_enable();
-
-	after = ktime_get();
-	dev->last_residency = ktime_to_ns(ktime_sub(after, before)) >> 10;
-
 	return index;
 }
 
 static struct cpuidle_device shmobile_cpuidle_dev;
 static struct cpuidle_driver shmobile_cpuidle_driver = {
-	.name =		"shmobile_cpuidle",
-	.owner =	THIS_MODULE,
-	.states[0] = {
-		.name = "C1",
-		.desc = "WFI",
-		.exit_latency = 1,
-		.target_residency = 1 * 2,
-		.flags = CPUIDLE_FLAG_TIME_VALID,
-	},
-	.safe_state_index = 0, /* C1 */
-	.state_count = 1,
+	.name			= "shmobile_cpuidle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.safe_state_index	= 0, /* C1 */
+	.state_count		= 1,
 };
 
 void (*shmobile_cpuidle_setup)(struct cpuidle_driver *drv);
-- 
1.7.1

