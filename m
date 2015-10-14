From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 3/4] ARM: mvebu: remove the workaround imprecise abort fault
 handler
Date: Wed, 14 Oct 2015 16:48:32 +0200
Message-ID: <1444834113-18122-4-git-send-email-l.stach@pengutronix.de>
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
 arch/arm/mach-mvebu/board-v7.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 9f739f3cad4c..1648edd515a2 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -22,7 +22,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/memblock.h>
 #include <linux/mbus.h>
-#include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/irqchip.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -105,27 +104,6 @@ static void __init mvebu_memblock_reserve(void)
 static void __init mvebu_memblock_reserve(void) {}
 #endif
 
-/*
- * Early versions of Armada 375 SoC have a bug where the BootROM
- * leaves an external data abort pending. The kernel is hit by this
- * data abort as soon as it enters userspace, because it unmasks the
- * data aborts at this moment. We register a custom abort handler
- * below to ignore the first data abort to work around this
- * problem.
- */
-static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
-					struct pt_regs *regs)
-{
-	static int ignore_first;
-
-	if (!ignore_first && fsr == 0x1406) {
-		ignore_first = 1;
-		return 0;
-	}
-
-	return 1;
-}
-
 static void __init mvebu_init_irq(void)
 {
 	irqchip_init();
@@ -134,17 +112,6 @@ static void __init mvebu_init_irq(void)
 	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
 }
 
-static void __init external_abort_quirk(void)
-{
-	u32 dev, rev;
-
-	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > ARMADA_375_Z1_REV)
-		return;
-
-	hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
-			"imprecise external abort");
-}
-
 static void __init i2c_quirk(void)
 {
 	struct device_node *np;
@@ -177,8 +144,6 @@ static void __init mvebu_dt_init(void)
 {
 	if (of_machine_is_compatible("marvell,armadaxp"))
 		i2c_quirk();
-	if (of_machine_is_compatible("marvell,a375-db"))
-		external_abort_quirk();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
2.6.1
