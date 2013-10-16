From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V7 3/8] ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot
Date: Wed, 16 Oct 2013 10:39:03 -0500
Message-ID: <1381937948-27057-4-git-send-email-nm@ti.com>
References: <1381937948-27057-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381937948-27057-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

With OMAP3+ and AM33xx supported SoC having defined CPU device tree
entries with operating-points and clock nodes defined, we can now use
the SoC generic cpufreq-cpu0 driver by registering appropriate device.

Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index e742118..360b2da 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -266,7 +266,12 @@ static void __init omap4_init_voltages(void)
 
 static inline void omap_init_cpufreq(void)
 {
-	struct platform_device_info devinfo = { .name = "omap-cpufreq", };
+	struct platform_device_info devinfo = { };
+
+	if (!of_have_populated_dt())
+		devinfo.name = "omap-cpufreq";
+	else
+		devinfo.name = "cpufreq-cpu0";
 	platform_device_register_full(&devinfo);
 }
 
@@ -300,10 +305,11 @@ int __init omap2_common_pm_late_init(void)
 		/* Smartreflex device init */
 		omap_devinit_smartreflex();
 
-		/* cpufreq dummy device instantiation */
-		omap_init_cpufreq();
 	}
 
+	/* cpufreq dummy device instantiation */
+	omap_init_cpufreq();
+
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
 #endif
-- 
1.7.9.5
