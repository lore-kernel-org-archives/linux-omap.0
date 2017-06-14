From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 13/23] clocksource/drivers: Rename clocksource_probe to
 timer_probe
Date: Wed, 14 Jun 2017 14:39:34 +0200
Message-ID: <1497443984-12371-13-git-send-email-daniel.lezcano@linaro.org>
References: <20170614123800.GH2261@mai>
 <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1497443984-12371-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: "open list:MIPS" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "open list:SUPERH" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Noam Camus <noamc-d5a29ZRxExrQT0dZR+AlfA@public.gmane.org>, "moderated list:ARM PORT" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The function name is now renamed to 'timer_probe' for consistency with
the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arc/kernel/setup.c                  |  2 +-
 arch/arm/kernel/time.c                   |  2 +-
 arch/arm/mach-mediatek/mediatek.c        |  2 +-
 arch/arm/mach-omap2/timer.c              | 10 +++++-----
 arch/arm/mach-rockchip/rockchip.c        |  2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  2 +-
 arch/arm/mach-spear/spear13xx.c          |  2 +-
 arch/arm/mach-sunxi/sunxi.c              |  2 +-
 arch/arm/mach-u300/core.c                |  2 +-
 arch/arm/mach-zynq/common.c              |  2 +-
 arch/arm64/kernel/time.c                 |  2 +-
 arch/h8300/kernel/setup.c                |  2 +-
 arch/microblaze/kernel/setup.c           |  2 +-
 arch/mips/generic/init.c                 |  2 +-
 arch/mips/mti-malta/malta-time.c         |  2 +-
 arch/mips/pic32/pic32mzda/time.c         |  2 +-
 arch/mips/pistachio/time.c               |  2 +-
 arch/mips/ralink/clk.c                   |  2 +-
 arch/mips/ralink/timer-gic.c             |  2 +-
 arch/mips/xilfpga/time.c                 |  2 +-
 arch/nios2/kernel/time.c                 |  2 +-
 arch/sh/boards/of-generic.c              |  2 +-
 arch/xtensa/kernel/time.c                |  2 +-
 drivers/clocksource/clksrc-probe.c       |  2 +-
 include/linux/clocksource.h              |  4 ++--
 25 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index fc8211f..666613f 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -470,7 +470,7 @@ void __init setup_arch(char **cmdline_p)
 void __init time_init(void)
 {
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
 
 static int __init customize_machine(void)
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 97b22fa..629f8e9 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -120,6 +120,6 @@ void __init time_init(void)
 #ifdef CONFIG_COMMON_CLK
 		of_clk_init(NULL);
 #endif
-		clocksource_probe();
+		timer_probe();
 	}
 }
diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index a6e3c98..c3cf215 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -41,7 +41,7 @@ static void __init mediatek_timer_init(void)
 	}
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 };
 
 static const char * const mediatek_board_dt_compat[] = {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 07dd692..ae4bb9f 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -497,7 +497,7 @@ void __init omap_init_time(void)
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
 
-	clocksource_probe();
+	timer_probe();
 }
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
@@ -506,7 +506,7 @@ void __init omap3_secure_sync32k_timer_init(void)
 	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
 			2, "timer_sys_ck", NULL, false);
 
-	clocksource_probe();
+	timer_probe();
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
@@ -517,7 +517,7 @@ void __init omap3_gptimer_timer_init(void)
 	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
 			1, "timer_sys_ck", "ti,timer-alwon", true);
 	if (of_have_populated_dt())
-		clocksource_probe();
+		timer_probe();
 }
 #endif
 
@@ -532,7 +532,7 @@ static void __init omap4_sync32k_timer_init(void)
 void __init omap4_local_timer_init(void)
 {
 	omap4_sync32k_timer_init();
-	clocksource_probe();
+	timer_probe();
 }
 #endif
 
@@ -656,7 +656,7 @@ void __init omap5_realtime_timer_init(void)
 	omap4_sync32k_timer_init();
 	realtime_counter_init();
 
-	clocksource_probe();
+	timer_probe();
 }
 #endif /* CONFIG_SOC_OMAP5 || CONFIG_SOC_DRA7XX */
 
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index ef0500a..5ab834e 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -55,7 +55,7 @@ static void __init rockchip_timer_init(void)
 	}
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
 
 static void __init rockchip_dt_init(void)
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 52d466b..a6e74f4 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -113,7 +113,7 @@ void __init rcar_gen2_timer_init(void)
 #endif /* CONFIG_ARM_ARCH_TIMER */
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
 
 struct memory_reserve_config {
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index ca2f6a8..31c43ca 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -124,5 +124,5 @@ void __init spear13xx_timer_init(void)
 	clk_put(pclk);
 
 	spear_setup_of_timer();
-	clocksource_probe();
+	timer_probe();
 }
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index f44e3ac..7ab353f 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -42,7 +42,7 @@ static void __init sun6i_timer_init(void)
 	of_clk_init(NULL);
 	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
 		sun6i_reset_init();
-	clocksource_probe();
+	timer_probe();
 }
 
 DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index a4910ea..048f15e 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -407,7 +407,7 @@ static const char * u300_board_compat[] = {
 DT_MACHINE_START(U300_DT, "U300 S335/B335 (Device Tree)")
 	.map_io		= u300_map_io,
 	.init_irq	= u300_init_irq_dt,
-	.init_time	= clocksource_probe,
+	.init_time	= timer_probe,
 	.init_machine	= u300_init_machine_dt,
 	.restart	= u300_restart,
 	.dt_compat      = u300_board_compat,
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index ed11864..6aba9eb 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -150,7 +150,7 @@ static void __init zynq_timer_init(void)
 {
 	zynq_clock_init();
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
 
 static struct map_desc zynq_cortex_a9_scu_map __initdata = {
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 5977969..da33c90 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -70,7 +70,7 @@ void __init time_init(void)
 	u32 arch_timer_rate;
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 
 	tick_setup_hrtimer_broadcast();
 
diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index c8c25a4..6be15d6 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -246,5 +246,5 @@ void __init calibrate_delay(void)
 void __init time_init(void)
 {
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index f31ebb5..be98ffe 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -192,7 +192,7 @@ void __init time_init(void)
 {
 	of_clk_init(NULL);
 	setup_cpuinfo_clk();
-	clocksource_probe();
+	timer_probe();
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 4af6192..1231b5a 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -161,7 +161,7 @@ void __init plat_time_init(void)
 		}
 	}
 
-	clocksource_probe();
+	timer_probe();
 }
 
 void __init arch_init_irq(void)
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 289edcf..cea4ec9 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -265,7 +265,7 @@ void __init plat_time_init(void)
 		       (freq%1000000)*100/1000000);
 #ifdef CONFIG_CLKSRC_MIPS_GIC
 		update_gic_frequency_dt();
-		clocksource_probe();
+		timer_probe();
 #endif
 	}
 #endif
diff --git a/arch/mips/pic32/pic32mzda/time.c b/arch/mips/pic32/pic32mzda/time.c
index 62a0a78..1894e50 100644
--- a/arch/mips/pic32/pic32mzda/time.c
+++ b/arch/mips/pic32/pic32mzda/time.c
@@ -64,5 +64,5 @@ void __init plat_time_init(void)
 	pr_info("CPU Clock: %ldMHz\n", rate / 1000000);
 	mips_hpt_frequency = rate / 2;
 
-	clocksource_probe();
+	timer_probe();
 }
diff --git a/arch/mips/pistachio/time.c b/arch/mips/pistachio/time.c
index 1022201..17a0f1d 100644
--- a/arch/mips/pistachio/time.c
+++ b/arch/mips/pistachio/time.c
@@ -39,7 +39,7 @@ void __init plat_time_init(void)
 	struct clk *clk;
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 
 	np = of_get_cpu_node(0, NULL);
 	if (!np) {
diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index df79588..eb1c619 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -82,5 +82,5 @@ void __init plat_time_init(void)
 	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
 	mips_hpt_frequency = clk_get_rate(clk) / 2;
 	clk_put(clk);
-	clocksource_probe();
+	timer_probe();
 }
diff --git a/arch/mips/ralink/timer-gic.c b/arch/mips/ralink/timer-gic.c
index 069771d..b5f07d2 100644
--- a/arch/mips/ralink/timer-gic.c
+++ b/arch/mips/ralink/timer-gic.c
@@ -20,5 +20,5 @@ void __init plat_time_init(void)
 	ralink_of_remap();
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 }
diff --git a/arch/mips/xilfpga/time.c b/arch/mips/xilfpga/time.c
index cbb3fca..36f3f18 100644
--- a/arch/mips/xilfpga/time.c
+++ b/arch/mips/xilfpga/time.c
@@ -22,7 +22,7 @@ void __init plat_time_init(void)
 	struct clk *clk;
 
 	of_clk_init(NULL);
-	clocksource_probe();
+	timer_probe();
 
 	np = of_get_cpu_node(0, NULL);
 	if (!np) {
diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
index 2954b66..645129a 100644
--- a/arch/nios2/kernel/time.c
+++ b/arch/nios2/kernel/time.c
@@ -350,7 +350,7 @@ void __init time_init(void)
 	if (count < 2)
 		panic("%d timer is found, it needs 2 timers in system\n", count);
 
-	clocksource_probe();
+	timer_probe();
 }
 
 TIMER_OF_DECLARE(nios2_timer, ALTR_TIMER_COMPATIBLE, nios2_time_init);
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 1fb6d57..4feb7c8 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -119,7 +119,7 @@ static void __init sh_of_mem_reserve(void)
 static void __init sh_of_time_init(void)
 {
 	pr_info("SH generic board support: scanning for clocksource devices\n");
-	clocksource_probe();
+	timer_probe();
 }
 
 static void __init sh_of_setup(char **cmdline_p)
diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index 668c105..fd524a5 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -187,7 +187,7 @@ void __init time_init(void)
 	local_timer_setup(0);
 	setup_irq(this_cpu_ptr(&ccount_timer)->evt.irq, &timer_irqaction);
 	sched_clock_register(ccount_sched_clock_read, 32, ccount_freq);
-	clocksource_probe();
+	timer_probe();
 }
 
 /*
diff --git a/drivers/clocksource/clksrc-probe.c b/drivers/clocksource/clksrc-probe.c
index ac701ff..5d549c2 100644
--- a/drivers/clocksource/clksrc-probe.c
+++ b/drivers/clocksource/clksrc-probe.c
@@ -24,7 +24,7 @@ extern struct of_device_id __clksrc_of_table[];
 static const struct of_device_id __clksrc_of_table_sentinel
 	__used __section(__clksrc_of_table_end);
 
-void __init clocksource_probe(void)
+void __init timer_probe(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index a86b65f..010bb9f 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -253,9 +253,9 @@ extern int clocksource_i8253_init(void);
 	OF_DECLARE_1_RET(clksrc, name, compat, fn)
 
 #ifdef CONFIG_CLKSRC_PROBE
-extern void clocksource_probe(void);
+extern void timer_probe(void);
 #else
-static inline void clocksource_probe(void) {}
+static inline void timer_probe(void) {}
 #endif
 
 #define CLOCKSOURCE_ACPI_DECLARE(name, table_id, fn)		\
-- 
2.7.4
