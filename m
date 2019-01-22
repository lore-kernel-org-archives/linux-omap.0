From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] bus: ti-sysc: Fix timer handling with drop pm_runtime_irq_safe()
Date: Tue, 22 Jan 2019 09:57:16 -0800
Message-ID: <20190122175717.13428-3-tony@atomide.com>
References: <20190122175717.13428-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122175717.13428-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "H . Nikolaus Schaller" <hns@goldelico.com>, Keerthy <j-keerthy@ti.com>, Ladislav Michl <ladis@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc") started producing a warning for pwm-omap-dmtimer:

WARNING: CPU: 0 PID: 77 at drivers/bus/omap_l3_noc.c:147
l3_interrupt_handler+0x2f8/0x388
44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Idle):
Data Access in Supervisor mode during Functional access
...
__pm_runtime_idle
omap_dm_timer_disable
pwm_omap_dmtimer_start
pwm_omap_dmtimer_enable
pwm_apply_state
pwm_vibrator_start
pwm_vibrator_play_work

This is because the timer that pwm-omap-dmtimer is using is now being
probed with ti-sysc interconnect target module instead of omap_device
and the ti-sysc quirk for SYSC_QUIRK_LEGACY_IDLE is not fully
compatible with what omap_device has been doing.

We could fix this by reverting the timer changes and have the timer
probe again with omap_device. Or we could add more quirk handling to
ti-sysc driver. But as these options don't work nicely as longer term
solutions, let's just make timers probe with ti-sysc without any
quirks.

To do this, all we need to do is remove quirks for timers for ti-sysc,
and drop the bogus pm_runtime_irq_safe() flag for timer-ti-dm.

We should not use pm_runtime_irq_safe() anyways for drivers as it will
take a permanent use count on the parent device blocking the parent
devices from idling and has been forcing ti-sysc driver to use a
quirk flag.

Note that we will move the timer data to DEBUG section later on in
clean-up patches.

Fixes: 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc")
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c             | 4 ++--
 drivers/clocksource/timer-ti-dm.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -879,10 +879,10 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("smartreflex", 0, -1, 0x38, -1, 0x00000000, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("timer", 0, 0, 0x10, 0x14, 0x00000015, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
+		   0),
 	/* Some timers on omap4 and later */
 	SYSC_QUIRK("timer", 0, 0, 0x10, -1, 0x4fff1301, 0xffffffff,
-		   SYSC_QUIRK_LEGACY_IDLE),
+		   0),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 	/* Uarts on omap4 and later */
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -868,7 +868,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	timer->pdev = pdev;
 
 	pm_runtime_enable(dev);
-	pm_runtime_irq_safe(dev);
 
 	if (!timer->reserved) {
 		ret = pm_runtime_get_sync(dev);
-- 
2.20.1
