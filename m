From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] ARM: OMAP2+: PM: MPU DVFS: use generic CPU device for MPU-SS
Date: Wed,  3 Oct 2012 15:24:15 -0700
Message-ID: <1349303055-27741-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60564 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab2JCWYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 18:24:18 -0400
Received: by padhz1 with SMTP id hz1so6789916pad.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Oct 2012 15:24:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Kevin Hilman <khilman@ti.com>

Currently, a dummy omap_device is created for the MPU sub-system so
that a device node exists for MPU DVFS.  Specifically, for the
association of MPU OPPs to a device node, and so that a voltage
regulator can be mapped to a device node.

For drivers to get a handle to this device node, an OMAP-specific API
has been used.  However, the kernel already has device nodes for the
CPU(s) in the system, so we can use those instead of an OMAP-specific
dummy device and then drivers (like OMAP CPUfreq) can use generic
APIs.

To use the existing CPU device nodes, modify the OPP creation and
regulator registration to use the CPU0 device node for registraion.

NOTE: this patch always uses CPU0 as the device node.  On all
      OMAPs today, MPU DVFS scales all CPUs together, so this will
      not be a problem, but this assumption will need to be changed
      if independently scalable CPUs are introduced.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies on current Linus master.
Targetted for v3.7-rc1 so CPUfreq driver can be cleaned of plat includes
(follow on series)

 arch/arm/mach-omap2/opp.c        |   23 +++++++++++++++++------
 arch/arm/mach-omap2/pm.c         |   11 ++++++++++-
 arch/arm/mach-omap2/twl-common.c |    2 +-
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index 45ad7f7..58e16ae 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -18,6 +18,7 @@
  */
 #include <linux/module.h>
 #include <linux/opp.h>
+#include <linux/cpu.h>
 
 #include <plat/omap_device.h>
 
@@ -62,13 +63,23 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 				__func__, i);
 			return -EINVAL;
 		}
-		oh = omap_hwmod_lookup(opp_def->hwmod_name);
-		if (!oh || !oh->od) {
-			pr_debug("%s: no hwmod or odev for %s, [%d] cannot add OPPs.\n",
-				 __func__, opp_def->hwmod_name, i);
-			continue;
+
+		if (!strncmp(opp_def->hwmod_name, "mpu", 3)) {
+			/* 
+			 * All current OMAPs share voltage rail and
+			 * clock source, so CPU0 is used to represent
+			 * the MPU-SS.
+			 */
+			dev = get_cpu_device(0);
+		} else {
+			oh = omap_hwmod_lookup(opp_def->hwmod_name);
+			if (!oh || !oh->od) {
+				pr_debug("%s: no hwmod or odev for %s, [%d] cannot add OPPs.\n",
+					 __func__, opp_def->hwmod_name, i);
+				continue;
+			}
+			dev = &oh->od->pdev->dev;
 		}
-		dev = &oh->od->pdev->dev;
 
 		r = opp_add(dev, opp_def->freq, opp_def->u_volt);
 		if (r) {
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 939bd6f..173c2be 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -16,6 +16,7 @@
 #include <linux/opp.h>
 #include <linux/export.h>
 #include <linux/suspend.h>
+#include <linux/cpu.h>
 
 #include <asm/system_misc.h>
 
@@ -168,7 +169,15 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 		goto exit;
 	}
 
-	dev = omap_device_get_by_hwmod_name(oh_name);
+	if (!strncmp(oh_name, "mpu", 3))
+		/* 
+		 * All current OMAPs share voltage rail and clock
+		 * source, so CPU0 is used to represent the MPU-SS.
+		 */
+		dev = get_cpu_device(0);
+	else
+		dev = omap_device_get_by_hwmod_name(oh_name);
+
 	if (IS_ERR(dev)) {
 		pr_err("%s: Unable to get dev pointer for hwmod %s\n",
 			__func__, oh_name);
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 45f7741..3f5eacc 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -158,7 +158,7 @@ static struct regulator_init_data omap3_vpll2_idata = {
 };
 
 static struct regulator_consumer_supply omap3_vdd1_supply[] = {
-	REGULATOR_SUPPLY("vcc", "mpu.0"),
+	REGULATOR_SUPPLY("vcc", "cpu0"),
 };
 
 static struct regulator_consumer_supply omap3_vdd2_supply[] = {
-- 
1.7.9.2

