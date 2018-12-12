From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH RFC] ARM: omap2: fix lack of timer interrupts on CPU1 after
 hotplug
Date: Wed, 12 Dec 2018 11:49:47 +0000
Message-ID: <E1gX31P-0004wA-Eq@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

If we have a kernel configured for periodic timer interrupts, and we
have cpuidle enabled, then we end up with CPU1 losing timer interupts
after a hotplug.

This can manifest itself in RCU stall warnings, or userspace becoming
unresponsive.

The problem is that the kernel initially wants to use the TWD timer
for interrupts, but the TWD loses context when we enter the C3 cpuidle
state.  Nothing reprograms the TWD after idle.

We have solved this in the past by switching to broadcast timer ticks,
and cpuidle44xx switches to that mode at boot time.  However, there is
nothing to switch from periodic mode local timers after a hotplug
operation.

We call tick_broadcast_enter() in omap_enter_idle_coupled(), which one
would expect would take care of the issue, but internally this only
deals with one-shot local timers - tick_broadcast_enable() on the other
hand only deals with periodic local timers.  So, we need to call both.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-omap2/cpuidle44xx.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index a8b291f00109..dae514c8276a 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -152,6 +152,10 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 	mpuss_can_lose_context = (cx->mpu_state == PWRDM_POWER_RET) &&
 				 (cx->mpu_logic_state == PWRDM_POWER_OFF);
 
+	/* Enter broadcast mode for periodic timers */
+	tick_broadcast_enable();
+
+	/* Enter broadcast mode for one-shot timers */
 	tick_broadcast_enter();
 
 	/*
@@ -218,15 +222,6 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 	return index;
 }
 
-/*
- * For each cpu, setup the broadcast timer because local timers
- * stops for the states above C1.
- */
-static void omap_setup_broadcast_timer(void *arg)
-{
-	tick_broadcast_enable();
-}
-
 static struct cpuidle_driver omap4_idle_driver = {
 	.name				= "omap4_idle",
 	.owner				= THIS_MODULE,
@@ -319,8 +314,5 @@ int __init omap4_idle_init(void)
 	if (!cpu_clkdm[0] || !cpu_clkdm[1])
 		return -ENODEV;
 
-	/* Configure the broadcast timer on each cpu */
-	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
-
 	return cpuidle_register(idle_driver, cpu_online_mask);
 }
-- 
2.7.4
