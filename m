From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/2] ARM: OMAP4: Add local timer support for Device Tree
Date: Mon, 9 Jul 2012 18:41:10 +0530
Message-ID: <1341839470-5586-3-git-send-email-santosh.shilimkar@ti.com>
References: <1341839470-5586-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42577 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab2GINLf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jul 2012 09:11:35 -0400
In-Reply-To: <1341839470-5586-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Add cortex-a9 local timer  support for all OMAP4 based
SOCs using DT.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    6 ++++++
 arch/arm/mach-omap2/timer.c  |   11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 57f7cd4..8504397 100644
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
index 840929b..dbdd9a6 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -36,6 +36,7 @@
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <asm/mach/time.h>
 #include <plat/dmtimer.h>
@@ -384,9 +385,13 @@ static void __init omap4_timer_init(void)
 	if (omap_rev() != OMAP4430_REV_ES1_0) {
 		int err;
 
-		err = twd_local_timer_register(&twd_local_timer);
-		if (err)
-			pr_err("twd_local_timer_register failed %d\n", err);
+		if (of_have_populated_dt()) {
+			twd_local_timer_of_register();
+		} else {
+			err = twd_local_timer_register(&twd_local_timer);
+			if (err)
+				pr_err("twd_local_timer_register failed %d\n", err);
+		}
 	}
 #endif
 }
-- 
1.7.9.5

