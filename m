From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/2] clocksource: timer-dm: Check prescaler value
Date: Mon, 18 Dec 2017 12:31:53 +0100
Message-ID: <20171218113153.GB18637@lenoch>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <20171218111610.GA16906@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171218111610.GA16906@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

Invalid prescaler value is silently ignored. Fix that
by returning -EINVAL in such case. As invalid value
disabled use of the prescaler, use -1 explicitely for
that purpose.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/clocksource/timer-dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
index ec3a28c90c70..95cd98be8541 100644
--- a/drivers/clocksource/timer-dm.c
+++ b/drivers/clocksource/timer-dm.c
@@ -609,6 +609,9 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 	if (prescaler >= 0x00 && prescaler <= 0x07) {
 		l |= OMAP_TIMER_CTRL_PRE;
 		l |= prescaler << 2;
+	} else {
+		if (prescaler != -1)
+			return -EINVAL;
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-- 
2.15.1
