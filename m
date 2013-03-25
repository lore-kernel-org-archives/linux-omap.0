From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 13/18] ARM: OMAP: CPUidle: Unregister drivere on device registration failure
Date: Mon, 25 Mar 2013 15:35:05 +0530
Message-ID: <1364205910-32392-14-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50678 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755302Ab3CYKEK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:04:10 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

If the CPUidle device registration fails for some reason, we should
unregister the driver on error path.

Fix the code accordingly. Also when at it, check of the driver registration
failure too.

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    6 +++++-
 arch/arm/mach-omap2/cpuidle44xx.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 06f567f..e193ea2 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -355,7 +355,10 @@ int __init omap3_idle_init(void)
 	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
 		return -ENODEV;
 
-	cpuidle_register_driver(&omap3_idle_driver);
+	if (cpuidle_register_driver(&omap3_idle_driver)) {
+		pr_err("%s: CPUidle driver register failed\n", __func__);
+		return -EIO;
+	}
 
 	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
 	dev->cpu = 0;
@@ -363,6 +366,7 @@ int __init omap3_idle_init(void)
 	if (cpuidle_register_device(dev)) {
 		printk(KERN_ERR "%s: CPUidle register device failed\n",
 		       __func__);
+		cpuidle_unregister_driver(&omap3_idle_driver);
 		return -EIO;
 	}
 
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index d00b1ec..908114d 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -233,7 +233,10 @@ int __init omap4_idle_init(void)
 	/* Configure the broadcast timer on each cpu */
 	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
 
-	cpuidle_register_driver(&omap4_idle_driver);
+	if (cpuidle_register_driver(&omap4_idle_driver)) {
+		pr_err("%s: CPUidle driver register failed\n", __func__);
+		return -EIO;
+	}
 
 	for_each_cpu(cpu_id, cpu_online_mask) {
 		dev = &per_cpu(omap4_idle_dev, cpu_id);
@@ -243,6 +246,7 @@ int __init omap4_idle_init(void)
 #endif
 		if (cpuidle_register_device(dev)) {
 			pr_err("%s: CPUidle register failed\n", __func__);
+			cpuidle_unregister_driver(&omap4_idle_driver);
 			return -EIO;
 		}
 	}
-- 
1.7.9.5

