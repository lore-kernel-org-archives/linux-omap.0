From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/9] cpufreq: omap: Use generic platdev driver
Date: Fri, 22 Apr 2016 16:58:42 +0530
Message-ID: <a9cadb022a3be97ec43983d524a6ab0378829441.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/pm.c             | 7 ++-----
 drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 58920bc8807b..2f7b11da7d5d 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -277,13 +277,10 @@ static void __init omap4_init_voltages(void)
 
 static inline void omap_init_cpufreq(void)
 {
-	struct platform_device_info devinfo = { };
+	struct platform_device_info devinfo = { .name = "omap-cpufreq" };
 
 	if (!of_have_populated_dt())
-		devinfo.name = "omap-cpufreq";
-	else
-		devinfo.name = "cpufreq-dt";
-	platform_device_register_full(&devinfo);
+		platform_device_register_full(&devinfo);
 }
 
 static int __init omap2_common_pm_init(void)
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 3843314389c7..4e525f6ec59f 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -28,6 +28,11 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "samsung,exynos5420", },
 	{ .compatible = "samsung,exynos5800", },
 #endif
+
+	{ .compatible = "ti,omap2", },
+	{ .compatible = "ti,omap3", },
+	{ .compatible = "ti,omap4", },
+	{ .compatible = "ti,omap5", },
 };
 
 static int __init cpufreq_dt_platdev_init(void)
-- 
2.7.1.410.g6faf27b

