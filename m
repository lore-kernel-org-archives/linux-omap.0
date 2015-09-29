From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 10/11] arm: omap2: timer: limit hwmod usage to non-DT boots
Date: Tue, 29 Sep 2015 15:44:05 -0500
Message-ID: <1443559446-26969-11-git-send-email-balbi@ti.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443559446-26969-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, daniel.lezcano@linaro.org, tglx@linutronix.de, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

now that we have a working 32k clocksource driver,
we can limit HWMOD usage to non-DT boots and rely
on clocksource_of_init() every time we boot
with DT.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 8b3ac8d5d38b..24c5a63c9c6e 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -398,7 +398,6 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 	int ret;
 	struct device_node *np = NULL;
 	struct omap_hwmod *oh;
-	void __iomem *vbase;
 	const char *oh_name = "counter_32k";
 
 	/*
@@ -424,18 +423,6 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 
 	omap_hwmod_setup_one(oh_name);
 
-	if (np) {
-		vbase = of_iomap(np, 0);
-		of_node_put(np);
-	} else {
-		vbase = omap_hwmod_get_mpu_rt_va(oh);
-	}
-
-	if (!vbase) {
-		pr_warn("%s: failed to get counter_32k resource\n", __func__);
-		return -ENXIO;
-	}
-
 	ret = omap_hwmod_enable(oh);
 	if (ret) {
 		pr_warn("%s: failed to enable counter_32k module (%d)\n",
@@ -443,13 +430,18 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 		return ret;
 	}
 
-	ret = omap_init_clocksource_32k(vbase);
-	if (ret) {
-		pr_warn("%s: failed to initialize counter_32k as a clocksource (%d)\n",
-							__func__, ret);
-		omap_hwmod_idle(oh);
-	}
+	if (!of_have_populated_dt()) {
+		void __iomem *vbase;
 
+		vbase = omap_hwmod_get_mpu_rt_va(oh);
+
+		ret = omap_init_clocksource_32k(vbase);
+		if (ret) {
+			pr_warn("%s: failed to initialize counter_32k as a clocksource (%d)\n",
+					__func__, ret);
+			omap_hwmod_idle(oh);
+		}
+	}
 	return ret;
 }
 
-- 
2.5.3
