From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting cpu1 during
 boot
Date: Mon, 13 Feb 2017 13:50:13 -0800
Message-ID: <20170213215013.19929-1-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Commit 3251885285e1 ("ARM: OMAP4+: Reset CPU1 properly for kexec") started
resetting cpu1 because of a kexec boot issue I was seeing earlier in 2016
on omap4 when doing kexec boot between two different kernel versions. The
booted kernel ended up trying to use the old kernel start-up address unless
cpu1 was reset before configuring the cpu1 start-up address.

It seems the reset part was not correct but probably working around some
other issue. I have not been able to reproduce this issue any longer despite
testing with backported patches back to v4.6 kernel. So it is possible this
issue was caused by other work in progress kexec patches I had applied. Or
it is possible some other fixes have made the issue go way.

The unconditional reset of cpu1 can cause issues booting some devices. For
example, bootloader configured secure OS running on cpu1 will fail as the
configuration is not preserved as reported by Andrew F. Davis <afd@ti.com>.

Let's fix the issue by reverting the cpu1 reset parts. If it turns out we
still need to reset cpu1 in some cases, we can add it back and do it
conditionally.

Fixes: 3251885285e1 ("ARM: OMAP4+: Reset CPU1 properly for kexec")
Cc: Keerthy <j-keerthy@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Reported-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap-smp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -300,16 +300,6 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 		scu_enable(cfg.scu_base);
 
 	/*
-	 * Reset CPU1 before configuring, otherwise kexec will
-	 * end up trying to use old kernel startup address.
-	 */
-	if (cfg.cpu1_rstctrl_va) {
-		writel_relaxed(1, cfg.cpu1_rstctrl_va);
-		readl_relaxed(cfg.cpu1_rstctrl_va);
-		writel_relaxed(0, cfg.cpu1_rstctrl_va);
-	}
-
-	/*
 	 * Write the address of secondary startup routine into the
 	 * AuxCoreBoot1 where ROM code will jump and start executing
 	 * on secondary core once out of WFE
-- 
2.11.1
