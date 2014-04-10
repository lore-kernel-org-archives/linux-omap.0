From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/11] ARM: OMAP2+: Fix voltage scaling init for device tree
Date: Thu, 10 Apr 2014 16:47:14 -0700
Message-ID: <1397173639-29587-7-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-omap@vger.kernel.org

We are currently disabling the init of voltage scaling
for device tree. With the voltage scaling problems fixed
for omap3 in general, there's no need to disable the voltage
scaling init for device tree based booting.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index e1b4141..ccefd11 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -287,25 +287,21 @@ omap_postcore_initcall(omap2_common_pm_init);
 
 int __init omap2_common_pm_late_init(void)
 {
-	/*
-	 * In the case of DT, the PMIC and SR initialization will be done using
-	 * a completely different mechanism.
-	 * Disable this part if a DT blob is available.
-	 */
-	if (!of_have_populated_dt()) {
-
-		/* Init the voltage layer */
-		omap_pmic_late_init();
-		omap_voltage_late_init();
+	if (of_have_populated_dt()) {
+		omap3_twl_init();
+		omap4_twl_init();
+	}
 
-		/* Initialize the voltages */
-		omap3_init_voltages();
-		omap4_init_voltages();
+	/* Init the voltage layer */
+	omap_pmic_late_init();
+	omap_voltage_late_init();
 
-		/* Smartreflex device init */
-		omap_devinit_smartreflex();
+	/* Initialize the voltages */
+	omap3_init_voltages();
+	omap4_init_voltages();
 
-	}
+	/* Smartreflex device init */
+	omap_devinit_smartreflex();
 
 	/* cpufreq dummy device instantiation */
 	omap_init_cpufreq();
-- 
1.8.1.1
