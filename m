From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/8] cpufreq: omap: Use generic platdev driver
Date: Thu, 21 Apr 2016 14:13:49 +0530
Message-ID: <52b6fd32c3542d908e20301e276ca4347dfa1560.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
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
index ac12c4a02964..3d7d459aed25 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -28,6 +28,11 @@ static const struct of_device_id machines[] = {
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
