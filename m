From: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/2] rtc: rtc-twl: kill static variables
Date: Wed, 23 Nov 2016 10:55:56 +0200
Message-ID: <20161123085557.5656-2-Nicolae_Rosia@mentor.com>
References: <20161123085557.5656-1-Nicolae_Rosia@mentor.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBAABBLFT2XAQKGQEB5HL3UA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161123085557.5656-1-Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The current code uses static variables which prevent
the use of multiple rtc twl instances.
We also make it clear that this driver supports only
TWL4030 and TWL6030 classes.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/rtc/rtc-twl.c | 190 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 114 insertions(+), 76 deletions(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 176720b..1e41526 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -33,6 +33,10 @@
 
 #include <linux/i2c/twl.h>
 
+enum twl_class {
+	TWL_4030 = 0,
+	TWL_6030,
+};
 
 /*
  * RTC block register offsets (use TWL_MODULE_RTC)
@@ -136,16 +140,30 @@ static const u8 twl6030_rtc_reg_map[] = {
 #define ALL_TIME_REGS		6
 
 /*----------------------------------------------------------------------*/
-static u8  *rtc_reg_map;
+struct twl_rtc {
+	struct device *dev;
+	struct rtc_device *rtc;
+	u8 *reg_map;
+	/*
+	 * Cache the value for timer/alarm interrupts register; this is
+	 * only changed by callers holding rtc ops lock (or resume).
+	 */
+	unsigned char rtc_irq_bits;
+	bool wake_enabled;
+#ifdef CONFIG_PM_SLEEP
+	unsigned char irqstat;
+#endif
+	enum twl_class class;
+};
 
 /*
  * Supports 1 byte read from TWL RTC register.
  */
-static int twl_rtc_read_u8(u8 *data, u8 reg)
+static int twl_rtc_read_u8(struct twl_rtc *twl_rtc, u8 *data, u8 reg)
 {
 	int ret;
 
-	ret = twl_i2c_read_u8(TWL_MODULE_RTC, data, (rtc_reg_map[reg]));
+	ret = twl_i2c_read_u8(TWL_MODULE_RTC, data, (twl_rtc->reg_map[reg]));
 	if (ret < 0)
 		pr_err("Could not read TWL register %X - error %d\n", reg, ret);
 	return ret;
@@ -154,11 +172,11 @@ static int twl_rtc_read_u8(u8 *data, u8 reg)
 /*
  * Supports 1 byte write to TWL RTC registers.
  */
-static int twl_rtc_write_u8(u8 data, u8 reg)
+static int twl_rtc_write_u8(struct twl_rtc *twl_rtc, u8 data, u8 reg)
 {
 	int ret;
 
-	ret = twl_i2c_write_u8(TWL_MODULE_RTC, data, (rtc_reg_map[reg]));
+	ret = twl_i2c_write_u8(TWL_MODULE_RTC, data, (twl_rtc->reg_map[reg]));
 	if (ret < 0)
 		pr_err("Could not write TWL register %X - error %d\n",
 		       reg, ret);
@@ -166,28 +184,22 @@ static int twl_rtc_write_u8(u8 data, u8 reg)
 }
 
 /*
- * Cache the value for timer/alarm interrupts register; this is
- * only changed by callers holding rtc ops lock (or resume).
- */
-static unsigned char rtc_irq_bits;
-
-/*
  * Enable 1/second update and/or alarm interrupts.
  */
-static int set_rtc_irq_bit(unsigned char bit)
+static int set_rtc_irq_bit(struct twl_rtc *twl_rtc, unsigned char bit)
 {
 	unsigned char val;
 	int ret;
 
 	/* if the bit is set, return from here */
-	if (rtc_irq_bits & bit)
+	if (twl_rtc->rtc_irq_bits & bit)
 		return 0;
 
-	val = rtc_irq_bits | bit;
+	val = twl_rtc->rtc_irq_bits | bit;
 	val &= ~BIT_RTC_INTERRUPTS_REG_EVERY_M;
-	ret = twl_rtc_write_u8(val, REG_RTC_INTERRUPTS_REG);
+	ret = twl_rtc_write_u8(twl_rtc, val, REG_RTC_INTERRUPTS_REG);
 	if (ret == 0)
-		rtc_irq_bits = val;
+		twl_rtc->rtc_irq_bits = val;
 
 	return ret;
 }
@@ -195,19 +207,19 @@ static int set_rtc_irq_bit(unsigned char bit)
 /*
  * Disable update and/or alarm interrupts.
  */
-static int mask_rtc_irq_bit(unsigned char bit)
+static int mask_rtc_irq_bit(struct twl_rtc *twl_rtc, unsigned char bit)
 {
 	unsigned char val;
 	int ret;
 
 	/* if the bit is clear, return from here */
-	if (!(rtc_irq_bits & bit))
+	if (!(twl_rtc->rtc_irq_bits & bit))
 		return 0;
 
-	val = rtc_irq_bits & ~bit;
-	ret = twl_rtc_write_u8(val, REG_RTC_INTERRUPTS_REG);
+	val = twl_rtc->rtc_irq_bits & ~bit;
+	ret = twl_rtc_write_u8(twl_rtc, val, REG_RTC_INTERRUPTS_REG);
 	if (ret == 0)
-		rtc_irq_bits = val;
+		twl_rtc->rtc_irq_bits = val;
 
 	return ret;
 }
@@ -215,21 +227,23 @@ static int mask_rtc_irq_bit(unsigned char bit)
 static int twl_rtc_alarm_irq_enable(struct device *dev, unsigned enabled)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	struct twl_rtc *twl_rtc = dev_get_drvdata(dev);
 	int irq = platform_get_irq(pdev, 0);
-	static bool twl_rtc_wake_enabled;
 	int ret;
 
 	if (enabled) {
-		ret = set_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
-		if (device_can_wakeup(dev) && !twl_rtc_wake_enabled) {
+		ret = set_rtc_irq_bit(twl_rtc,
+				      BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
+		if (device_can_wakeup(dev) && !twl_rtc->wake_enabled) {
 			enable_irq_wake(irq);
-			twl_rtc_wake_enabled = true;
+			twl_rtc->wake_enabled = true;
 		}
 	} else {
-		ret = mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
-		if (twl_rtc_wake_enabled) {
+		ret = mask_rtc_irq_bit(twl_rtc,
+				       BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
+		if (twl_rtc->wake_enabled) {
 			disable_irq_wake(irq);
-			twl_rtc_wake_enabled = false;
+			twl_rtc->wake_enabled = false;
 		}
 	}
 
@@ -247,21 +261,23 @@ static int twl_rtc_alarm_irq_enable(struct device *dev, unsigned enabled)
  */
 static int twl_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
+	struct twl_rtc *twl_rtc = dev_get_drvdata(dev);
 	unsigned char rtc_data[ALL_TIME_REGS];
 	int ret;
 	u8 save_control;
 	u8 rtc_control;
 
-	ret = twl_rtc_read_u8(&save_control, REG_RTC_CTRL_REG);
+	ret = twl_rtc_read_u8(twl_rtc, &save_control, REG_RTC_CTRL_REG);
 	if (ret < 0) {
 		dev_err(dev, "%s: reading CTRL_REG, error %d\n", __func__, ret);
 		return ret;
 	}
 	/* for twl6030/32 make sure BIT_RTC_CTRL_REG_GET_TIME_M is clear */
-	if (twl_class_is_6030()) {
+	if (twl_rtc->class == TWL_6030) {
 		if (save_control & BIT_RTC_CTRL_REG_GET_TIME_M) {
 			save_control &= ~BIT_RTC_CTRL_REG_GET_TIME_M;
-			ret = twl_rtc_write_u8(save_control, REG_RTC_CTRL_REG);
+			ret = twl_rtc_write_u8(twl_rtc, save_control,
+					       REG_RTC_CTRL_REG);
 			if (ret < 0) {
 				dev_err(dev, "%s clr GET_TIME, error %d\n",
 					__func__, ret);
@@ -274,17 +290,17 @@ static int twl_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	rtc_control = save_control | BIT_RTC_CTRL_REG_GET_TIME_M;
 
 	/* for twl6030/32 enable read access to static shadowed registers */
-	if (twl_class_is_6030())
+	if (twl_rtc->class == TWL_6030)
 		rtc_control |= BIT_RTC_CTRL_REG_RTC_V_OPT;
 
-	ret = twl_rtc_write_u8(rtc_control, REG_RTC_CTRL_REG);
+	ret = twl_rtc_write_u8(twl_rtc, rtc_control, REG_RTC_CTRL_REG);
 	if (ret < 0) {
 		dev_err(dev, "%s: writing CTRL_REG, error %d\n", __func__, ret);
 		return ret;
 	}
 
 	ret = twl_i2c_read(TWL_MODULE_RTC, rtc_data,
-			(rtc_reg_map[REG_SECONDS_REG]), ALL_TIME_REGS);
+			(twl_rtc->reg_map[REG_SECONDS_REG]), ALL_TIME_REGS);
 
 	if (ret < 0) {
 		dev_err(dev, "%s: reading data, error %d\n", __func__, ret);
@@ -292,8 +308,8 @@ static int twl_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	/* for twl6030 restore original state of rtc control register */
-	if (twl_class_is_6030()) {
-		ret = twl_rtc_write_u8(save_control, REG_RTC_CTRL_REG);
+	if (twl_rtc->class == TWL_6030) {
+		ret = twl_rtc_write_u8(twl_rtc, save_control, REG_RTC_CTRL_REG);
 		if (ret < 0) {
 			dev_err(dev, "%s: restore CTRL_REG, error %d\n",
 				__func__, ret);
@@ -313,6 +329,7 @@ static int twl_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int twl_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct twl_rtc *twl_rtc = dev_get_drvdata(dev);
 	unsigned char save_control;
 	unsigned char rtc_data[ALL_TIME_REGS];
 	int ret;
@@ -325,18 +342,18 @@ static int twl_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	rtc_data[5] = bin2bcd(tm->tm_year - 100);
 
 	/* Stop RTC while updating the TC registers */
-	ret = twl_rtc_read_u8(&save_control, REG_RTC_CTRL_REG);
+	ret = twl_rtc_read_u8(twl_rtc, &save_control, REG_RTC_CTRL_REG);
 	if (ret < 0)
 		goto out;
 
 	save_control &= ~BIT_RTC_CTRL_REG_STOP_RTC_M;
-	ret = twl_rtc_write_u8(save_control, REG_RTC_CTRL_REG);
+	ret = twl_rtc_write_u8(twl_rtc, save_control, REG_RTC_CTRL_REG);
 	if (ret < 0)
 		goto out;
 
 	/* update all the time registers in one shot */
 	ret = twl_i2c_write(TWL_MODULE_RTC, rtc_data,
-		(rtc_reg_map[REG_SECONDS_REG]), ALL_TIME_REGS);
+		(twl_rtc->reg_map[REG_SECONDS_REG]), ALL_TIME_REGS);
 	if (ret < 0) {
 		dev_err(dev, "rtc_set_time error %d\n", ret);
 		goto out;
@@ -344,7 +361,7 @@ static int twl_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	/* Start back RTC */
 	save_control |= BIT_RTC_CTRL_REG_STOP_RTC_M;
-	ret = twl_rtc_write_u8(save_control, REG_RTC_CTRL_REG);
+	ret = twl_rtc_write_u8(twl_rtc, save_control, REG_RTC_CTRL_REG);
 
 out:
 	return ret;
@@ -355,11 +372,12 @@ static int twl_rtc_set_time(struct device *dev, struct rtc_time *tm)
  */
 static int twl_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
+	struct twl_rtc *twl_rtc = dev_get_drvdata(dev);
 	unsigned char rtc_data[ALL_TIME_REGS];
 	int ret;
 
 	ret = twl_i2c_read(TWL_MODULE_RTC, rtc_data,
-			(rtc_reg_map[REG_ALARM_SECONDS_REG]), ALL_TIME_REGS);
+			twl_rtc->reg_map[REG_ALARM_SECONDS_REG], ALL_TIME_REGS);
 	if (ret < 0) {
 		dev_err(dev, "rtc_read_alarm error %d\n", ret);
 		return ret;
@@ -374,7 +392,7 @@ static int twl_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	alm->time.tm_year = bcd2bin(rtc_data[5]) + 100;
 
 	/* report cached alarm enable state */
-	if (rtc_irq_bits & BIT_RTC_INTERRUPTS_REG_IT_ALARM_M)
+	if (twl_rtc->rtc_irq_bits & BIT_RTC_INTERRUPTS_REG_IT_ALARM_M)
 		alm->enabled = 1;
 
 	return ret;
@@ -382,6 +400,8 @@ static int twl_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 static int twl_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
+	struct twl_rtc *twl_rtc = dev_get_drvdata(dev);
+
 	unsigned char alarm_data[ALL_TIME_REGS];
 	int ret;
 
@@ -398,7 +418,7 @@ static int twl_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 	/* update all the alarm registers in one shot */
 	ret = twl_i2c_write(TWL_MODULE_RTC, alarm_data,
-		(rtc_reg_map[REG_ALARM_SECONDS_REG]), ALL_TIME_REGS);
+			twl_rtc->reg_map[REG_ALARM_SECONDS_REG], ALL_TIME_REGS);
 	if (ret) {
 		dev_err(dev, "rtc_set_alarm error %d\n", ret);
 		goto out;
@@ -410,14 +430,15 @@ static int twl_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	return ret;
 }
 
-static irqreturn_t twl_rtc_interrupt(int irq, void *rtc)
+static irqreturn_t twl_rtc_interrupt(int irq, void *data)
 {
+	struct twl_rtc *twl_rtc = data;
 	unsigned long events;
 	int ret = IRQ_NONE;
 	int res;
 	u8 rd_reg;
 
-	res = twl_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
+	res = twl_rtc_read_u8(twl_rtc, &rd_reg, REG_RTC_STATUS_REG);
 	if (res)
 		goto out;
 	/*
@@ -431,12 +452,12 @@ static irqreturn_t twl_rtc_interrupt(int irq, void *rtc)
 	else
 		events = RTC_IRQF | RTC_PF;
 
-	res = twl_rtc_write_u8(BIT_RTC_STATUS_REG_ALARM_M,
-				   REG_RTC_STATUS_REG);
+	res = twl_rtc_write_u8(twl_rtc, BIT_RTC_STATUS_REG_ALARM_M,
+			       REG_RTC_STATUS_REG);
 	if (res)
 		goto out;
 
-	if (twl_class_is_4030()) {
+	if (twl_rtc->class == TWL_4030) {
 		/* Clear on Read enabled. RTC_IT bit of TWL4030_INT_PWR_ISR1
 		 * needs 2 reads to clear the interrupt. One read is done in
 		 * do_twl_pwrirq(). Doing the second read, to clear
@@ -455,7 +476,7 @@ static irqreturn_t twl_rtc_interrupt(int irq, void *rtc)
 	}
 
 	/* Notify RTC core on event */
-	rtc_update_irq(rtc, 1, events);
+	rtc_update_irq(twl_rtc->rtc, 1, events);
 
 	ret = IRQ_HANDLED;
 out:
@@ -474,7 +495,7 @@ static const struct rtc_class_ops twl_rtc_ops = {
 
 static int twl_rtc_probe(struct platform_device *pdev)
 {
-	struct rtc_device *rtc;
+	struct twl_rtc *twl_rtc;
 	int ret = -EINVAL;
 	int irq = platform_get_irq(pdev, 0);
 	u8 rd_reg;
@@ -482,13 +503,22 @@ static int twl_rtc_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return ret;
 
-	/* Initialize the register map */
-	if (twl_class_is_4030())
-		rtc_reg_map = (u8 *)twl4030_rtc_reg_map;
-	else
-		rtc_reg_map = (u8 *)twl6030_rtc_reg_map;
+	twl_rtc = devm_kzalloc(&pdev->dev, sizeof(*twl_rtc), GFP_KERNEL);
+	if (!twl_rtc)
+		return -ENOMEM;
+
+	if (twl_class_is_4030()) {
+		twl_rtc->class = TWL_4030;
+		twl_rtc->reg_map = (u8 *)twl4030_rtc_reg_map;
+	} else if (twl_class_is_6030()) {
+		twl_rtc->class = TWL_6030;
+		twl_rtc->reg_map = (u8 *)twl6030_rtc_reg_map;
+	} else {
+		dev_err(&pdev->dev, "TWL Class not supported.\n");
+		return -EINVAL;
+	}
 
-	ret = twl_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
+	ret = twl_rtc_read_u8(twl_rtc, &rd_reg, REG_RTC_STATUS_REG);
 	if (ret < 0)
 		return ret;
 
@@ -499,11 +529,11 @@ static int twl_rtc_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "Pending Alarm interrupt detected.\n");
 
 	/* Clear RTC Power up reset and pending alarm interrupts */
-	ret = twl_rtc_write_u8(rd_reg, REG_RTC_STATUS_REG);
+	ret = twl_rtc_write_u8(twl_rtc, rd_reg, REG_RTC_STATUS_REG);
 	if (ret < 0)
 		return ret;
 
-	if (twl_class_is_6030()) {
+	if (twl_rtc->class == TWL_6030) {
 		twl6030_interrupt_unmask(TWL6030_RTC_INT_MASK,
 			REG_INT_MSK_LINE_A);
 		twl6030_interrupt_unmask(TWL6030_RTC_INT_MASK,
@@ -511,40 +541,42 @@ static int twl_rtc_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "Enabling TWL-RTC\n");
-	ret = twl_rtc_write_u8(BIT_RTC_CTRL_REG_STOP_RTC_M, REG_RTC_CTRL_REG);
+	ret = twl_rtc_write_u8(twl_rtc, BIT_RTC_CTRL_REG_STOP_RTC_M,
+			       REG_RTC_CTRL_REG);
 	if (ret < 0)
 		return ret;
 
 	/* ensure interrupts are disabled, bootloaders can be strange */
-	ret = twl_rtc_write_u8(0, REG_RTC_INTERRUPTS_REG);
+	ret = twl_rtc_write_u8(twl_rtc, 0, REG_RTC_INTERRUPTS_REG);
 	if (ret < 0)
 		dev_warn(&pdev->dev, "unable to disable interrupt\n");
 
 	/* init cached IRQ enable bits */
-	ret = twl_rtc_read_u8(&rtc_irq_bits, REG_RTC_INTERRUPTS_REG);
+	ret = twl_rtc_read_u8(twl_rtc, &twl_rtc->rtc_irq_bits,
+			      REG_RTC_INTERRUPTS_REG);
 	if (ret < 0)
 		return ret;
 
+	platform_set_drvdata(pdev, twl_rtc);
 	device_init_wakeup(&pdev->dev, 1);
 
-	rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+	twl_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 					&twl_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc)) {
+	if (IS_ERR(twl_rtc->rtc)) {
 		dev_err(&pdev->dev, "can't register RTC device, err %ld\n",
-			PTR_ERR(rtc));
-		return PTR_ERR(rtc);
+			PTR_ERR(twl_rtc->rtc));
+		return PTR_ERR(twl_rtc->rtc);
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					twl_rtc_interrupt,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					dev_name(&rtc->dev), rtc);
+					dev_name(&twl_rtc->rtc->dev), twl_rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, rtc);
 	return 0;
 }
 
@@ -554,10 +586,12 @@ static int twl_rtc_probe(struct platform_device *pdev)
  */
 static int twl_rtc_remove(struct platform_device *pdev)
 {
+	struct twl_rtc *twl_rtc = platform_get_drvdata(pdev);
+
 	/* leave rtc running, but disable irqs */
-	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
-	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
-	if (twl_class_is_6030()) {
+	mask_rtc_irq_bit(twl_rtc, BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
+	mask_rtc_irq_bit(twl_rtc, BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
+	if (twl_rtc->class == TWL_6030) {
 		twl6030_interrupt_mask(TWL6030_RTC_INT_MASK,
 			REG_INT_MSK_LINE_A);
 		twl6030_interrupt_mask(TWL6030_RTC_INT_MASK,
@@ -569,25 +603,29 @@ static int twl_rtc_remove(struct platform_device *pdev)
 
 static void twl_rtc_shutdown(struct platform_device *pdev)
 {
+	struct twl_rtc *twl_rtc = platform_get_drvdata(pdev);
+
 	/* mask timer interrupts, but leave alarm interrupts on to enable
 	   power-on when alarm is triggered */
-	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
+	mask_rtc_irq_bit(twl_rtc, BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
 }
 
 #ifdef CONFIG_PM_SLEEP
-static unsigned char irqstat;
-
 static int twl_rtc_suspend(struct device *dev)
 {
-	irqstat = rtc_irq_bits;
+	struct twl_rtc *twl_rtc = dev_get_drvdata(dev);
 
-	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
+	twl_rtc->irqstat = twl_rtc->rtc_irq_bits;
+
+	mask_rtc_irq_bit(twl_rtc, BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
 	return 0;
 }
 
 static int twl_rtc_resume(struct device *dev)
 {
-	set_rtc_irq_bit(irqstat);
+	struct twl_rtc *twl_rtc = dev_get_drvdata(dev);
+
+	set_rtc_irq_bit(twl_rtc, twl_rtc->irqstat);
 	return 0;
 }
 #endif
-- 
2.9.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
