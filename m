From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/18] ARM/omap1/time: Migrate to new 'set-state' interface
Date: Fri, 17 Jul 2015 10:41:06 +0530
Message-ID: <29105e102085a9c1a1eea4f634db2890aca884b8.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org, olof@lixom.net
Cc: linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, open list <linux-kernel@vger.kernel.org>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

Migrate omap driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-omap1/time.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index a7588cfd0286..524977a31a49 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -124,29 +124,26 @@ static int omap_mpu_set_next_event(unsigned long cycles,
 	return 0;
 }
 
-static void omap_mpu_set_mode(enum clock_event_mode mode,
-			      struct clock_event_device *evt)
+static int omap_mpu_set_oneshot(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		omap_mpu_set_autoreset(0);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		omap_mpu_timer_stop(0);
-		omap_mpu_remove_autoreset(0);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+	omap_mpu_timer_stop(0);
+	omap_mpu_remove_autoreset(0);
+	return 0;
+}
+
+static int omap_mpu_set_periodic(struct clock_event_device *evt)
+{
+	omap_mpu_set_autoreset(0);
+	return 0;
 }
 
 static struct clock_event_device clockevent_mpu_timer1 = {
-	.name		= "mpu_timer1",
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_next_event	= omap_mpu_set_next_event,
-	.set_mode	= omap_mpu_set_mode,
+	.name			= "mpu_timer1",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_next_event		= omap_mpu_set_next_event,
+	.set_state_periodic	= omap_mpu_set_periodic,
+	.set_state_oneshot	= omap_mpu_set_oneshot,
 };
 
 static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
-- 
2.4.0
