From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC v2 13/18] ARM: OMAP2+: AM33XX: timer: Interchance clkevt and clksrc timers
Date: Mon, 31 Dec 2012 18:37:06 +0530
Message-ID: <1356959231-17335-14-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59690 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab2LaNIe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Dec 2012 08:08:34 -0500
In-Reply-To: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Jon Hunter <jon-hunter@ti.com>

AM33XX has two timers (DTIMER0/1) in the WKUP domain.
On GP devices the source of DMTIMER0 is fixed to an
inaccurate internal 32k RC oscillator and this makes
the DMTIMER0 practically either as a clocksource or
as clockevent.

Currently the timer instance in WKUP domain is used
as the clockevent and the timer in non-WKUP domain
as the clocksource. DMTIMER1 in WKUP domain can keep
running in suspend from a 32K clock fed from external
OSC and can serve as the persistent clock for the kernel.
To enable this, interchange the timers used as clocksource
and clockevent for AM33XX.

For now a new DT property has been added to allow the timer code
to select the timer with the right property.

It has been pointed out by Santosh Shilimkar and Kevin Hilman
that such a change will result in soc-idle never being achieved
on AM33XX. There are other reasons why soc-idle does not look
feasible on AM33XX so for now we go ahead with the interchange
of the the timers. If at a later point of time we do come up
with an approach which makes soc-idle possible on AM33XX, this
can be revisited.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lingren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jon Hunter <jon-hunter@ti.com>

---
v1->v2:
	Use DT properties for changing the timers

 .../devicetree/bindings/arm/omap/timer.txt         |    2 ++
 arch/arm/boot/dts/am33xx.dtsi                      |    1 +
 arch/arm/mach-omap2/timer.c                        |    6 +++---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/timer.txt b/Documentation/devicetree/bindings/arm/omap/timer.txt
index 8732d4d..62d4f2c 100644
--- a/Documentation/devicetree/bindings/arm/omap/timer.txt
+++ b/Documentation/devicetree/bindings/arm/omap/timer.txt
@@ -18,6 +18,8 @@ Optional properties:
 - ti,timer-pwm: 	Indicates the timer can generate a PWM output.
 - ti,timer-secure: 	Indicates the timer is reserved on a secure OMAP device
 			and therefore cannot be used by the kernel.
+- ti,timer-non-wkup	Indicates the timer is in non-wkup power domain and hence
+			will lose register context when the power domain transitions
 
 Example:
 
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4731748..b4e8bf7 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -251,6 +251,7 @@
 			reg = <0x48040000 0x400>;
 			interrupts = <68>;
 			ti,hwmods = "timer2";
+			ti,timer-non-wkup;
 		};
 
 		timer3: timer@48042000 {
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 38f9cbc..cfb3413 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -264,7 +264,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	int r = 0;
 
 	if (of_have_populated_dt()) {
-		np = omap_get_timer_dt(omap_timer_match, NULL);
+		np = omap_get_timer_dt(omap_timer_match, property);
 		if (!np)
 			return -ENODEV;
 
@@ -633,8 +633,8 @@ OMAP_SYS_TIMER(3_gp, gptimer);
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_SOC_AM33XX
-OMAP_SYS_GP_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, "ti,timer-alwon",
-		       2, OMAP4_MPU_SOURCE);
+OMAP_SYS_GP_TIMER_INIT(3_am33xx, 2, OMAP4_MPU_SOURCE, "ti,timer-non-wkup",
+		       1, OMAP4_MPU_SOURCE);
 OMAP_SYS_TIMER(3_am33xx, gptimer);
 #endif /* CONFIG_SOC_AM33XX */
 
-- 
1.7.0.4

