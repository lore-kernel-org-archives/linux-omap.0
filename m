From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 4/4] ARM: BCM5301X: remove workaround imprecise abort fault
 handler
Date: Wed, 14 Oct 2015 16:48:33 +0200
Message-ID: <1444834113-18122-5-git-send-email-l.stach@pengutronix.de>
References: <1444834113-18122-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444834113-18122-1-git-send-email-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, Hauke Mehrtens <hauke@hauke-m.de>, patchwork-lst@pengutronix.de, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is not needed anymore. Handling a potentially pending imprecise external
abort left behind by the bootloader is now done in a slightly safer way inside
the common ARM startup code.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-bcm/bcm_5301x.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
index 5478fe6bcce6..c8830a2b0d60 100644
--- a/arch/arm/mach-bcm/bcm_5301x.c
+++ b/arch/arm/mach-bcm/bcm_5301x.c
@@ -9,40 +9,6 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include <asm/mach/arch.h>
-#include <asm/siginfo.h>
-#include <asm/signal.h>
-
-
-static bool first_fault = true;
-
-static int bcm5301x_abort_handler(unsigned long addr, unsigned int fsr,
-				 struct pt_regs *regs)
-{
-	if ((fsr == 0x1406 || fsr == 0x1c06) && first_fault) {
-		first_fault = false;
-
-		/*
-		 * These faults with codes 0x1406 (BCM4709) or 0x1c06 happens
-		 * for no good reason, possibly left over from the CFE boot
-		 * loader.
-		 */
-		pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
-			addr, fsr);
-
-		/* Returning non-zero causes fault display and panic */
-		return 0;
-	}
-
-	/* Others should cause a fault */
-	return 1;
-}
-
-static void __init bcm5301x_init_early(void)
-{
-	/* Install our hook */
-	hook_fault_code(16 + 6, bcm5301x_abort_handler, SIGBUS, BUS_OBJERR,
-			"imprecise external abort");
-}
 
 static const char *const bcm5301x_dt_compat[] __initconst = {
 	"brcm,bcm4708",
@@ -52,6 +18,5 @@ static const char *const bcm5301x_dt_compat[] __initconst = {
 DT_MACHINE_START(BCM5301X, "BCM5301X")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.init_early	= bcm5301x_init_early,
 	.dt_compat	= bcm5301x_dt_compat,
 MACHINE_END
-- 
2.6.1
