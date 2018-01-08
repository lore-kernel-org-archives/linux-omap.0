From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 4/5] clocksource: timer-dm: Add event capture
Date: Mon, 8 Jan 2018 16:42:17 +0100
Message-ID: <20180108154217.GD4077@lenoch>
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

Implement event capture functions.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
index bde1014308f9..dbf2b1f6a941 100644
--- a/drivers/clocksource/timer-dm.c
+++ b/drivers/clocksource/timer-dm.c
@@ -633,6 +633,30 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	return 0;
 }
 
+static int omap_dm_timer_set_capture(struct omap_dm_timer *timer,
+				     int captmode, int edges)
+{
+	u32 l;
+
+	if (unlikely(!timer))
+		return -EINVAL;
+
+	omap_dm_timer_enable(timer);
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l &= ~(OMAP_TIMER_CTRL_CAPTMODE | OMAP_TIMER_CTRL_SCPWM |
+	       OMAP_TIMER_CTRL_PT | OMAP_TIMER_CTRL_TCM_BOTHEDGES);
+	l |= OMAP_TIMER_CTRL_GPOCFG;
+	if (captmode)
+		l |= OMAP_TIMER_CTRL_CAPTMODE;
+	l |= edges << 8;
+	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+
+	/* Save the context */
+	timer->context.tclr = l;
+	omap_dm_timer_disable(timer);
+	return 0;
+}
+
 static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 				 int toggle, int trigger)
 {
@@ -791,6 +815,22 @@ int omap_dm_timers_active(void)
 	return 0;
 }
 
+static int omap_dm_timer_read_capture(struct omap_dm_timer *timer,
+					unsigned int *reg,
+					unsigned int *reg2)
+{
+	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+		pr_err("%s: timer not available or enabled.\n", __func__);
+		return -EINVAL;
+	}
+
+	*reg = omap_dm_timer_read_reg(timer, OMAP_TIMER_CAPTURE_REG);
+	if (reg2)
+		*reg2 = omap_dm_timer_read_reg(timer, OMAP_TIMER_CAPTURE2_REG);
+
+	return 0;
+}
+
 static const struct of_device_id omap_timer_match[];
 
 /**
@@ -939,11 +979,14 @@ static struct omap_dm_timer_ops dmtimer_ops = {
 	.start = omap_dm_timer_start,
 	.stop = omap_dm_timer_stop,
 	.set_load = omap_dm_timer_set_load,
+	.set_load_start = omap_dm_timer_set_load_start,
 	.set_match = omap_dm_timer_set_match,
+	.set_capture = omap_dm_timer_set_capture,
 	.set_pwm = omap_dm_timer_set_pwm,
 	.set_prescaler = omap_dm_timer_set_prescaler,
 	.read_counter = omap_dm_timer_read_counter,
 	.write_counter = omap_dm_timer_write_counter,
+	.read_capture = omap_dm_timer_read_capture,
 	.read_status = omap_dm_timer_read_status,
 	.write_status = omap_dm_timer_write_status,
 };
diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
index a3e17945a0e9..ad247d45bc08 100644
--- a/include/linux/platform_data/dmtimer-omap.h
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -43,8 +43,12 @@ struct omap_dm_timer_ops {
 
 	int	(*set_load)(struct omap_dm_timer *timer, int autoreload,
 			    unsigned int value);
+	int	(*set_load_start)(struct omap_dm_timer *timer, int autoreload,
+				  unsigned int value);
 	int	(*set_match)(struct omap_dm_timer *timer, int enable,
 			     unsigned int match);
+	int	(*set_capture)(struct omap_dm_timer *timer, int captmode,
+			       int edges);
 	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger);
 	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
@@ -52,6 +56,10 @@ struct omap_dm_timer_ops {
 	unsigned int (*read_counter)(struct omap_dm_timer *timer);
 	int	(*write_counter)(struct omap_dm_timer *timer,
 				 unsigned int value);
+
+	int	(*read_capture)(struct omap_dm_timer *timer, unsigned int *reg,
+				unsigned int *reg2);
+
 	unsigned int (*read_status)(struct omap_dm_timer *timer);
 	int	(*write_status)(struct omap_dm_timer *timer,
 				unsigned int value);
-- 
2.15.1
