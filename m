From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 03/19] ARM: omap1: delete useless interrupt handler
Date: Mon, 16 May 2011 18:26:34 +0100
Message-ID: <E1QM1Yw-0003DR-Lx@rmk-PC.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The OMAP1 clocksource interrupt handler just increments a variable
which otherwise isn't used, so this seems to be unnecessary.  Tony
Lindgren confirms, so lets remove it.

Acked-by: Kevin Hilman <khilman@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/time.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 6885d2f..e2c29b4 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -189,20 +189,6 @@ static __init void omap_init_mpu_timer(unsigned long rate)
  * ---------------------------------------------------------------------------
  */
 
-static unsigned long omap_mpu_timer2_overflows;
-
-static irqreturn_t omap_mpu_timer2_interrupt(int irq, void *dev_id)
-{
-	omap_mpu_timer2_overflows++;
-	return IRQ_HANDLED;
-}
-
-static struct irqaction omap_mpu_timer2_irq = {
-	.name		= "mpu_timer2",
-	.flags		= IRQF_DISABLED,
-	.handler	= omap_mpu_timer2_interrupt,
-};
-
 static cycle_t mpu_read(struct clocksource *cs)
 {
 	return ~omap_mpu_timer_read(1);
@@ -247,7 +233,6 @@ static void __init omap_init_clocksource(unsigned long rate)
 	static char err[] __initdata = KERN_ERR
 			"%s: can't register clocksource!\n";
 
-	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
 	omap_mpu_timer_start(1, ~0, 1);
 	init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
 
-- 
1.7.4.4
