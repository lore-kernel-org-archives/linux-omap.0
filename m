From: Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH] ARM: OMAP3630: Add generic machine descriptor
Date: Fri, 20 Sep 2013 11:08:52 -0500
Message-ID: <1379693332-10585-1-git-send-email-nm@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add generic machine which can handle inits for omap3630.
Currently beagle-xm would matchup with ti,omap3 which invokes
omap3430_init_early instead of omap3630_init_early

This defeats the purpose of having SoC specific init_early handlers,
example: clock nodes are not the same between 3430 and 3630.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

An alternative approach may be to (for all SoCs):
1. define every SoC entry - ti,omap3430 ti,omap3630...
2. have a generic omap3_init which uses "if (of_machine_is_compatible("ti,omap3630"))"
to invoke the appropriate omap3xxx_init_early.

 arch/arm/mach-omap2/board-generic.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 39c7838..cd85b36 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -147,6 +147,24 @@ DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
 	.dt_compat	= omap3_gp_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
+
+static const char *omap3630_gp_boards_compat[] __initdata = {
+	"ti,omap3-beagle-xm",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP3630_GP_DT, "Generic OMAP3630-GP (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3630_init_early,
+	.init_irq	= omap_intc_of_init,
+	.handle_irq	= omap3_intc_handle_irq,
+	.init_machine	= omap_generic_init,
+	.init_late	= omap3_init_late,
+	.init_time	= omap3_secure_sync32k_timer_init,
+	.dt_compat	= omap3630_gp_boards_compat,
+	.restart	= omap3xxx_restart,
+MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_AM33XX
-- 
1.7.9.5
