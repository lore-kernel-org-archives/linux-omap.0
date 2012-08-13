From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/5] ARM: OMAP4: Add local timer support for Device Tree
Date: Mon, 13 Aug 2012 16:30:23 +0530
Message-ID: <1344855623-14879-6-git-send-email-santosh.shilimkar@ti.com>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55901 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab2HMLAe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 07:00:34 -0400
In-Reply-To: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.or, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Add cortex-a9 local timer  support for all OMAP4 based
SOCs using DT.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    6 ++++++
 arch/arm/mach-omap2/timer.c  |    6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index cf1efb6..640d807 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -43,6 +43,12 @@
 		cache-level = <2>;
 	};
 
+	local-timer {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x48240600 0x20>;
+		interrupts = <1 13 0x304>;
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2ff6d41..31f9c93 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -36,6 +36,7 @@
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <asm/mach/time.h>
 #include <plat/dmtimer.h>
@@ -386,6 +387,11 @@ static void __init omap4_timer_init(void)
 	if (omap_rev() != OMAP4430_REV_ES1_0) {
 		int err;
 
+		if (of_have_populated_dt()) {
+			twd_local_timer_of_register();
+			return;
+		}
+
 		err = twd_local_timer_register(&twd_local_timer);
 		if (err)
 			pr_err("twd_local_timer_register failed %d\n", err);
-- 
1.7.9.5

