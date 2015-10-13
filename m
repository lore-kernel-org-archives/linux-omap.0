From: Joel Porquet <joel@porquet.org>
Subject: [PATCH v2 1/3] arm:exynos: IRQCHIP_DECLARE macro is now accessible
Date: Tue, 13 Oct 2015 14:56:13 +0200
Message-ID: <1444740975-31948-2-git-send-email-joel@porquet.org>
References: <1444740975-31948-1-git-send-email-joel@porquet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444740975-31948-1-git-send-email-joel@porquet.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, kgene@kernel.org, k.kozlowski@samsung.com, shawnguo@kernel.org, kernel@pengutronix.de, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Joel Porquet <joel@porquet.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', making it
globally accessible.

See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d ("irqchip: Move
IRQCHIP_DECLARE macro to include/linux/irqchip.h").

This patch adds the inclusion of 'include/linux/irqchip.h' and replaces the
use of OF_DECLARE_2 with IRQCHIP_DECLARE.

Signed-off-by: Joel Porquet <joel@porquet.org>
---
 arch/arm/mach-exynos/suspend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index e00eb39..dfb1fcf 100644
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
@@ -262,7 +263,7 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
 	return 0;
 }
 
-#define EXYNOS_PMU_IRQ(symbol, name)	OF_DECLARE_2(irqchip, symbol, name, exynos_pmu_irq_init)
+#define EXYNOS_PMU_IRQ(symbol, name)	IRQCHIP_DECLARE(symbol, name, exynos_pmu_irq_init)
 
 EXYNOS_PMU_IRQ(exynos3250_pmu_irq, "samsung,exynos3250-pmu");
 EXYNOS_PMU_IRQ(exynos4210_pmu_irq, "samsung,exynos4210-pmu");
-- 
2.6.1
