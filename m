From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 11/11] arm: omap2: timer: limit hwmod usage to non-DT boots
Date: Fri, 16 Oct 2015 11:22:10 -0500
Message-ID: <1445012530-14126-12-git-send-email-balbi@ti.com>
References: <1445012530-14126-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445012530-14126-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

now that we have a working 32k clocksource driver,
we can limit HWMOD usage to non-DT boots and rely
on clocksource_of_init() every time we boot
with DT.

While at that, also make sure that we don't disable
the 32-counter device so it gets probed by its driver.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index d024b2bb5c4c..05c17eb2f2d9 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -183,7 +183,8 @@ static struct device_node * __init omap_get_timer_dt(const struct of_device_id *
 				  of_get_property(np, "ti,timer-secure", NULL)))
 			continue;
 
-		of_add_property(np, &device_disabled);
+		if (!of_device_is_compatible(np, "ti,omap-counter32k"))
+			of_add_property(np, &device_disabled);
 		return np;
 	}
 
@@ -394,7 +395,6 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 	int ret;
 	struct device_node *np = NULL;
 	struct omap_hwmod *oh;
-	void __iomem *vbase;
 	const char *oh_name = "counter_32k";
 
 	/*
@@ -420,18 +420,6 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 
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
@@ -439,13 +427,18 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
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
