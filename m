From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH 08/17] OMAP7XX: Clocks: Add omap850 support
Date: Wed, 14 Oct 2009 20:51:10 +0100
Message-ID: <3d374d00910141251j7cd18b62ua6304259f23cffe9@mail.gmail.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch is part of a series which unifies all duplicated code between
omap730 and omap850. All cpu checks are converted to cpu_is_omap7xx() and
CONFIG_ARCH_OMAP850 is added to all CONFIG_ARCH_OMAP730 checks.

This file had no omap850 specific code. Initial clock support was done in
the Linwizard tree by Zebediah C. McClure.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/mach-omap1/clock.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 436eed2..fcbea61 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -398,7 +398,7 @@ static int omap1_select_table_rate(struct clk *
clk, unsigned long rate)
 	 * Reprogramming the DPLL is tricky, it must be done from SRAM.
 	 * (on 730, bit 13 must always be 1)
 	 */
-	if (cpu_is_omap730())
+	if (cpu_is_omap7xx())
 		omap_sram_reprogram_clock(ptr->dpllctl_val, ptr->ckctl_val | 0x2000);
 	else
 		omap_sram_reprogram_clock(ptr->dpllctl_val, ptr->ckctl_val);
@@ -783,7 +783,7 @@ int __init omap1_clk_init(void)
 		cpu_mask |= CK_16XX;
 	if (cpu_is_omap1510())
 		cpu_mask |= CK_1510;
-	if (cpu_is_omap730())
+	if (cpu_is_omap7xx())
 		cpu_mask |= CK_730;
 	if (cpu_is_omap310())
 		cpu_mask |= CK_310;
@@ -800,7 +800,7 @@ int __init omap1_clk_init(void)
 			crystal_type = info->system_clock_type;
 	}

-#if defined(CONFIG_ARCH_OMAP730)
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	ck_ref.rate = 13000000;
 #elif defined(CONFIG_ARCH_OMAP16XX)
 	if (crystal_type == 2)
@@ -847,7 +847,7 @@ int __init omap1_clk_init(void)
 		printk(KERN_ERR "System frequencies not set. Check your config.\n");
 		/* Guess sane values (60MHz) */
 		omap_writew(0x2290, DPLL_CTL);
-		omap_writew(cpu_is_omap730() ? 0x3005 : 0x1005, ARM_CKCTL);
+		omap_writew(cpu_is_omap7xx() ? 0x3005 : 0x1005, ARM_CKCTL);
 		ck_dpll1.rate = 60000000;
 	}
 #endif
@@ -873,7 +873,7 @@ int __init omap1_clk_init(void)

 	/* Turn off DSP and ARM_TIMXO. Make sure ARM_INTHCK is not divided */
 	/* (on 730, bit 13 must not be cleared) */
-	if (cpu_is_omap730())
+	if (cpu_is_omap7xx())
 		omap_writew(omap_readw(ARM_CKCTL) & 0x2fff, ARM_CKCTL);
 	else
 		omap_writew(omap_readw(ARM_CKCTL) & 0x0fff, ARM_CKCTL);
-- 
1.6.5
