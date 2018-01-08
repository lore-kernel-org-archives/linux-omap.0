From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/5] clocksource: timer-dm: Check prescaler value
Date: Mon, 8 Jan 2018 16:41:04 +0100
Message-ID: <20180108154104.GB4077@lenoch>
References: <20180108153926.GA3916@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180108153926.GA3916@lenoch>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, daniel.lezcano@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Invalid value silently disables use of the prescaler.
Use -1 explicitely for that purpose and error out on
invalid value.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
index 43531eecbe54..bde1014308f9 100644
--- a/drivers/clocksource/timer-dm.c
+++ b/drivers/clocksource/timer-dm.c
@@ -663,13 +663,13 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 {
 	u32 l;
 
-	if (unlikely(!timer))
+	if (unlikely(!timer) || prescaler < -1 || prescaler > 7)
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
-	if (prescaler >= 0x00 && prescaler <= 0x07) {
+	if (prescaler >= 0) {
 		l |= OMAP_TIMER_CTRL_PRE;
 		l |= prescaler << 2;
 	}
-- 
2.15.1
