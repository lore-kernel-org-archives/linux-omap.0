From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v10 1/8] ARM: OMAP2+: use common l2cache initialization code
Date: Tue, 23 Dec 2014 11:48:29 +0100
Message-ID: <1419331716-8972-2-git-send-email-m.szyprowski@samsung.com>
References: <1419331716-8972-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1419331716-8972-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, nm@ti.com, linux-samsung-soc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, tony@atomide.com, linus.walleij@linaro.org, Tomasz Figa <tomasz.figa@gmail.com>, drake@endlessm.com, loeliger@gmail.com, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, lauraa@codeaurora.org, linux-omap@vger.kernel.org, khilman@linaro.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch implements generic DT L2C initialisation (the one from
init_IRQ in arch/arm/kernel/irq.c) for Omap4 and AM43 platforms and
kills the SoC specific stuff in arch/arm/mach-omap2/omap4-common.c.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-omap2/board-generic.c |  6 ++++++
 arch/arm/mach-omap2/common.h        |  7 +++++++
 arch/arm/mach-omap2/omap4-common.c  | 16 +---------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 608079a1aba6..c5c480b76da5 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -171,6 +171,9 @@ static const char *const omap4_boards_compat[] __initconst = {
 };
 
 DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
+	.l2c_aux_val	= OMAP_L2C_AUX_CTRL,
+	.l2c_aux_mask	= 0xcf9fffff,
+	.l2c_write_sec	= omap4_l2c310_write_sec,
 	.reserve	= omap_reserve,
 	.smp		= smp_ops(omap4_smp_ops),
 	.map_io		= omap4_map_io,
@@ -214,6 +217,9 @@ static const char *const am43_boards_compat[] __initconst = {
 };
 
 DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
+	.l2c_aux_val	= OMAP_L2C_AUX_CTRL,
+	.l2c_aux_mask	= 0xcf9fffff,
+	.l2c_write_sec	= omap4_l2c310_write_sec,
 	.map_io		= am33xx_map_io,
 	.init_early	= am43xx_init_early,
 	.init_late	= am43xx_init_late,
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 377eea849e7b..19c9144d8b38 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -35,6 +35,7 @@
 #include <linux/irqchip/irq-omap-intc.h>
 
 #include <asm/proc-fns.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #include "i2c.h"
 #include "serial.h"
@@ -94,11 +95,17 @@ extern void omap3_gptimer_timer_init(void);
 extern void omap4_local_timer_init(void);
 #ifdef CONFIG_CACHE_L2X0
 int omap_l2_cache_init(void);
+#define OMAP_L2C_AUX_CTRL	(L2C_AUX_CTRL_SHARED_OVERRIDE | \
+				 L310_AUX_CTRL_DATA_PREFETCH | \
+				 L310_AUX_CTRL_INSTR_PREFETCH)
+void omap4_l2c310_write_sec(unsigned long val, unsigned reg);
 #else
 static inline int omap_l2_cache_init(void)
 {
 	return 0;
 }
+#define OMAP_L2C_AUX_CTRL	0
+#define omap4_l2c310_write_sec	NULL
 #endif
 extern void omap5_realtime_timer_init(void);
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index b7cb44abe49b..fe99ceff2e2d 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -166,7 +166,7 @@ void __iomem *omap4_get_l2cache_base(void)
 	return l2cache_base;
 }
 
-static void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
+void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
 {
 	unsigned smc_op;
 
@@ -201,24 +201,10 @@ static void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
 
 int __init omap_l2_cache_init(void)
 {
-	u32 aux_ctrl;
-
 	/* Static mapping, never released */
 	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
 	if (WARN_ON(!l2cache_base))
 		return -ENOMEM;
-
-	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
-	aux_ctrl = L2C_AUX_CTRL_SHARED_OVERRIDE |
-		   L310_AUX_CTRL_DATA_PREFETCH |
-		   L310_AUX_CTRL_INSTR_PREFETCH;
-
-	outer_cache.write_sec = omap4_l2c310_write_sec;
-	if (of_have_populated_dt())
-		l2x0_of_init(aux_ctrl, 0xcf9fffff);
-	else
-		l2x0_init(l2cache_base, aux_ctrl, 0xcf9fffff);
-
 	return 0;
 }
 #endif
-- 
1.9.2
