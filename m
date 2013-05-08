From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 5/6] ARM: OMAP2+: AM33XX: add lateinit hook for calling pm
 late init
Date: Wed, 8 May 2013 14:06:15 -0500
Message-ID: <1368039976-29648-6-git-send-email-nm@ti.com>
References: <1368039976-29648-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1368039976-29648-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Call OMAP2+ generic lateinit hook from AM specific late init hook.
This allows the generic late initializations such as cpufreq hooks
to be active.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Change in this revision compared to previous revision:
	- rebase, no functional change.
Previous version: http://marc.info/?l=linux-kernel&m=136580760924258&w=2

 arch/arm/mach-omap2/board-generic.c |    1 +
 arch/arm/mach-omap2/common.h        |    1 +
 arch/arm/mach-omap2/io.c            |    6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 88aa6b1..2c5c67c 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -141,6 +141,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
+	.init_late	= am33xx_init_late,
 	.init_time	= omap3_gptimer_timer_init,
 	.dt_compat	= am33xx_boards_compat,
 	.restart	= am33xx_restart,
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index d555cf2..e2d7ecf 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -107,6 +107,7 @@ void omap35xx_init_late(void);
 void omap3630_init_late(void);
 void am35xx_init_late(void);
 void ti81xx_init_late(void);
+void am33xx_init_late(void);
 int omap2_common_pm_late_init(void);
 
 #ifdef CONFIG_SOC_BUS
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 09abf99..401e268 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -584,6 +584,12 @@ void __init am33xx_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap_clk_init = am33xx_clk_init;
 }
+
+void __init am33xx_init_late(void)
+{
+	omap2_common_pm_late_init();
+}
+
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-- 
1.7.9.5
