From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 12/18] ARM: OMAP4: CPUidle: Avoid double idle driver registration
Date: Mon, 25 Mar 2013 15:35:04 +0530
Message-ID: <1364205910-32392-13-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35780 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212Ab3CYKEI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 06:04:08 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP4 CPUidle driver registration call is under a loop which leads
to calling cpuidle_register_driver twice which is not intended.

Fix it by moving the driver registration outside the loop.

Reported-by: Nishanth Menon <nm@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 9de47a7..d00b1ec 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -233,14 +233,14 @@ int __init omap4_idle_init(void)
 	/* Configure the broadcast timer on each cpu */
 	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
 
+	cpuidle_register_driver(&omap4_idle_driver);
+
 	for_each_cpu(cpu_id, cpu_online_mask) {
 		dev = &per_cpu(omap4_idle_dev, cpu_id);
 		dev->cpu = cpu_id;
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 		dev->coupled_cpus = *cpu_online_mask;
 #endif
-		cpuidle_register_driver(&omap4_idle_driver);
-
 		if (cpuidle_register_device(dev)) {
 			pr_err("%s: CPUidle register failed\n", __func__);
 			return -EIO;
-- 
1.7.9.5

