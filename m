From: Joel Porquet <joel@porquet.org>
Subject: [PATCH] arm:irqchip: IRQCHIP_DECLARE macro is now accessible
Date: Tue,  7 Jul 2015 16:02:53 -0400
Message-ID: <1436299411-12329-1-git-send-email-joel@porquet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Joel Porquet <joel@porquet.org>, Kukjin Kim <kgene@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', making it
globally accessible.

See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d
("irqchip: Move IRQCHIP_DECLARE macro to include/linux/irqchip.h").

This patch adds inclusions of 'include/linux/irqchip.h' and replaces uses of
macro OF_DECLARE_2 with IRQCHIP_DECLARE.

Signed-off-by: Joel Porquet <joel@porquet.org>
---
 arch/arm/mach-exynos/suspend.c       | 3 ++-
 arch/arm/mach-imx/gpc.c              | 7 ++-----
 arch/arm/mach-omap2/omap-wakeupgen.c | 7 ++-----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index f572219..78484ab 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -19,6 +19,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/err.h>
@@ -264,7 +265,7 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
 	return 0;
 }
 
-#define EXYNOS_PMU_IRQ(symbol, name)	OF_DECLARE_2(irqchip, symbol, name, exynos_pmu_irq_init)
+#define EXYNOS_PMU_IRQ(symbol, name)	IRQCHIP_DECLARE(symbol, name, exynos_pmu_irq_init)
 
 EXYNOS_PMU_IRQ(exynos3250_pmu_irq, "samsung,exynos3250-pmu");
 EXYNOS_PMU_IRQ(exynos4210_pmu_irq, "samsung,exynos4210-pmu");
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 80bad29..32c26f5 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -269,11 +270,7 @@ static int __init imx_gpc_init(struct device_node *node,
 	return 0;
 }
 
-/*
- * We cannot use the IRQCHIP_DECLARE macro that lives in
- * drivers/irqchip, so we're forced to roll our own. Not very nice.
- */
-OF_DECLARE_2(irqchip, imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
+IRQCHIP_DECLARE(imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
 
 void __init imx_gpc_check_dt(void)
 {
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 8e52621..e6a889f 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -537,8 +538,4 @@ static int __init wakeupgen_init(struct device_node *node,
 	return 0;
 }
 
-/*
- * We cannot use the IRQCHIP_DECLARE macro that lives in
- * drivers/irqchip, so we're forced to roll our own. Not very nice.
- */
-OF_DECLARE_2(irqchip, ti_wakeupgen, "ti,omap4-wugen-mpu", wakeupgen_init);
+IRQCHIP_DECLARE(ti_wakeupgen, "ti,omap4-wugen-mpu", wakeupgen_init);
-- 
2.4.5
