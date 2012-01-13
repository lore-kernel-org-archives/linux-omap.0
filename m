From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 03:05:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55708 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627Ab2AMKFE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 05:05:04 -0500
In-Reply-To: <20120112095940.0a54413e@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

cc Tero, Govindraj

On Thu, 12 Jan 2012, NeilBrown wrote:

> On Wed, 11 Jan 2012 06:43:04 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> 
> I spent some time exploring why cpuidle never drops below state 0 and found
> out that the code explicitly disables other states when uart is active - for
> a fairly broad definition of 'active'.
> 
> I found the "sleep_timeout" setting and set them all to 1 second.  This meant
> that cpuidle started working, but I got a lot of garbage characters.
> 

...

> Does this really mean CPU_IDLE cannot be used when you might expect chars
> from a serial port - e.g. GPS or Bluetooth?

Hmmm.  Looking at mach-omap2/pm34xx.c and mach-omap2/cpuidle34xx.c, it 
indeed prevents even the MPU from entering a low-power state when the UART 
is active, as you write.  That doesn't seem correct.

Please try the following patch.  It works fine for me on v3.2 with 
omap2plus_defconfig on a 35xx BeagleBoard.  No dropped or garbled 
characters with console use.  Not too surprising, since the UART has a 
receive FIFO to withstand interrupt servicing delays.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 13 Jan 2012 02:10:30 -0700
Subject: [PATCH] ARM: OMAP3: PM: allow MPU to enter low-power states even
 when the UART is active

For some reason, both the existing OMAP3 PM code and the OMAP3 CPUIdle
driver prevent the MPU powerdomain from entering low-power modes when
any UART isn't asleep.  Possibly it is intended to minimize the ARM
wakeup latency when UART activity arrives, but the UART has a FIFO
that should handle this for most cases, with no dropped characters.  I
may be forgetting something important, though.  And CORE/PER low-power
states are a different matter entirely.

Thanks to NeilBrown <neilb@suse.de> for reporting the problem.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    8 +++-----
 arch/arm/mach-omap2/pm.h          |    1 -
 arch/arm/mach-omap2/pm34xx.c      |   10 ----------
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 942bb4f..4ef32d4 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -183,6 +183,9 @@ static int next_valid_state(struct cpuidle_device *dev,
 			core_deepest_state = PWRDM_POWER_OFF;
 	}
 
+	if (!omap_uart_can_sleep())
+		core_deepest_state = PWRDM_POWER_ON;
+
 	/* Check if current state is valid */
 	if ((cx->valid) &&
 	    (cx->mpu_state >= mpu_deepest_state) &&
@@ -244,11 +247,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	struct omap3_idle_statedata *cx;
 	int ret;
 
-	if (!omap3_can_sleep()) {
-		new_state_idx = drv->safe_state_index;
-		goto select_state;
-	}
-
 	/*
 	 * Prevent idle completely if CAM is active.
 	 * CAM does not have wakeup capability in OMAP3.
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4e166ad..eac6fce 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -18,7 +18,6 @@
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
-extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index efa6649..1c49824 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -484,21 +484,11 @@ console_still_active:
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
-int omap3_can_sleep(void)
-{
-	if (!omap_uart_can_sleep())
-		return 0;
-	return 1;
-}
-
 static void omap3_pm_idle(void)
 {
 	local_irq_disable();
 	local_fiq_disable();
 
-	if (!omap3_can_sleep())
-		goto out;
-
 	if (omap_irq_pending() || need_resched())
 		goto out;
 
-- 
1.7.8.3

