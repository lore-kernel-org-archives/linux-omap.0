From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/3] Update menelaus chip driver to new I2C core changes
Date: Sat, 26 May 2007 19:55:09 -0700
Message-ID: <200705261955.12602.david-b@pacbell.net>
References: <5d5443650705260125r2d424136g51f68f1d0d107a39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650705260125r2d424136g51f68f1d0d107a39@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Saturday 26 May 2007, Trilok Soni wrote:
> Tony/David,
> 
> First two patches are same as the patch I have sent earlier as WIP.
> Third patch has changes related to n800 board and it is compile-tested
> only. Please see that I have removed board-n800-pm.c in the 3rd patch,
> if not accepted then please suggest better way to integrate with
> menelaus-i2c changes.

Style-wise, I prefer one source file per board (along the lines of
your change).  That's one vote ... :)

Related, see the appended patch exposing the RTC, and bugfixing the
IRQ handling ... it goes on top of yours.

- Dave


=============	CUT HERE
Add RTC support to the (new style) Menelaus driver.

This involved several bugfixes and cleanups to the IRQ handling logic.
Code for the second register bank never worked, and even clobbered
non-RTC registers; and the handler enabled IRQs for interrupts that
should have stayed masked...

Passes 'rtctest' on H4, other than lack of "periodic" (1/N second) IRQs.
System wakeup alarms (from suspend-to-RAM) work too.

The battery keeps the RTC active over power off, so once you set clock
(rdate/ntpdate/etc, then "hwclock -w") then RTC_HCTOSYS at boot time
will behave as expected.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/i2c/chips/menelaus.c |  428 +++++++++++++++++++++++++++++++++++++++----
 drivers/rtc/Kconfig          |    9 
 2 files changed, 400 insertions(+), 37 deletions(-)

--- h4.orig/drivers/rtc/Kconfig	2007-05-25 11:19:07.000000000 -0700
+++ h4/drivers/rtc/Kconfig	2007-05-26 12:06:42.000000000 -0700
@@ -213,6 +213,15 @@ config RTC_DRV_PCF8583
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-pcf8583.
 
+config RTC_DRV_TWL92330
+	boolean "TI TWL92330/Menelaus"
+	depends on RTC_CLASS && I2C && MENELAUS
+	help
+	  If you say yes here you get support for the RTC on the
+	  TWL92330 "Menelaus" power mangement chip, used with OMAP2
+	  platforms.  The support is integrated with the rest of
+	  the Menelaus driver; it's not separate module.
+
 comment "SPI RTC drivers"
 	depends on RTC_CLASS
 
--- h4.orig/drivers/i2c/chips/menelaus.c	2007-05-26 12:00:58.000000000 -0700
+++ h4/drivers/i2c/chips/menelaus.c	2007-05-26 19:21:12.000000000 -0700
@@ -1,3 +1,4 @@
+#define DEBUG
 /*
  * drivers/i2c/chips/menelaus.c
  *
@@ -39,6 +40,8 @@
 #include <linux/sched.h>
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/irq.h>
@@ -135,8 +138,14 @@ struct menelaus_chip {
 	struct mutex		lock;
 	struct i2c_client	*client;
 	struct work_struct	work;
+#ifdef CONFIG_RTC_DRV_TWL92330
+	struct rtc_device	*rtc;
+	u8			rtc_control;
+	unsigned		uie:1;
+#endif
 	unsigned		vcore_hw_mode:1;
-	void			*handlers[16];
+	u8			mask1, mask2;
+	void			(*handlers[16])(struct menelaus_chip *);
 	void			(*mmc_callback)(void *data, u8 mask);
 	void			*mmc_callback_data;
 };
@@ -167,26 +176,30 @@ static int menelaus_read_reg(int reg)
 
 static int menelaus_enable_irq(int irq)
 {
-	if (irq > 7)
+	if (irq > 7) {
+		irq -= 8;
+		the_menelaus->mask2 &= ~(1 << irq);
 		return menelaus_write_reg(MENELAUS_INT_MASK2,
-					  menelaus_read_reg(MENELAUS_INT_MASK2)
-					  & ~(1 << (irq - 8)));
-	else
+				the_menelaus->mask2);
+	} else {
+		the_menelaus->mask1 &= ~(1 << irq);
 		return menelaus_write_reg(MENELAUS_INT_MASK1,
-					  menelaus_read_reg(MENELAUS_INT_MASK1)
-					  & ~(1 << irq));
+				the_menelaus->mask1);
+	}
 }
 
 static int menelaus_disable_irq(int irq)
 {
-	if (irq > 7)
-		return menelaus_write_reg(menelaus_read_reg(MENELAUS_INT_MASK2)
-					  | (1 << (irq - 8)),
-					  MENELAUS_INT_MASK2);
-	else
+	if (irq > 7) {
+		irq -= 8;
+		the_menelaus->mask2 |= (1 << irq);
+		return menelaus_write_reg(MENELAUS_INT_MASK2,
+				the_menelaus->mask2);
+	} else {
+		the_menelaus->mask1 |= (1 << irq);
 		return menelaus_write_reg(MENELAUS_INT_MASK1,
-					  menelaus_read_reg(MENELAUS_INT_MASK1)
-					  | (1 << irq));
+				the_menelaus->mask1);
+	}
 }
 
 static int menelaus_ack_irq(int irq)
@@ -198,7 +211,8 @@ static int menelaus_ack_irq(int irq)
 }
 
 /* Adds a handler for an interrupt. Does not run in interrupt context */
-static int menelaus_add_irq_work(int irq, void * handler)
+static int menelaus_add_irq_work(int irq,
+		void (*handler)(struct menelaus_chip *))
 {
 	int ret = 0;
 
@@ -229,14 +243,14 @@ static int menelaus_remove_irq_work(int 
  * in each slot. In this case the cards are not seen by menelaus.
  * FIXME: Add handling for D1 too
  */
-static int menelaus_mmc_cd_work(struct menelaus_chip * menelaus_hw)
+static void menelaus_mmc_cd_work(struct menelaus_chip * menelaus_hw)
 {
 	int reg;
 	unsigned char card_mask = 0;
 
 	reg = menelaus_read_reg(MENELAUS_MCT_PIN_ST);
 	if (reg < 0)
-		return reg;
+		return;
 
 	if (!(reg & 0x1))
 		card_mask |= (1 << 0);
@@ -247,8 +261,6 @@ static int menelaus_mmc_cd_work(struct m
 	if (menelaus_hw->mmc_callback)
 		menelaus_hw->mmc_callback(menelaus_hw->mmc_callback_data,
 					  card_mask);
-
-	return 0;
 }
 
 /*
@@ -759,30 +771,30 @@ static void menelaus_work(struct work_st
 {
 	struct menelaus_chip *menelaus =
 			container_of(_menelaus, struct menelaus_chip, work);
-	int (*handler)(struct menelaus_chip *menelaus);
+	void (*handler)(struct menelaus_chip *menelaus);
 
 	while (1) {
-		int i;
-		unsigned char isr;
-
-		isr = menelaus_read_reg(MENELAUS_INT_STATUS1) |
-		      (menelaus_read_reg(MENELAUS_INT_STATUS2) << 8);
+		unsigned isr;
 
+		isr = (menelaus_read_reg(MENELAUS_INT_STATUS2)
+				& ~menelaus->mask2) << 8;
+		isr |= menelaus_read_reg(MENELAUS_INT_STATUS1)
+				& ~menelaus->mask1;
 		if (!isr)
 			break;
 
-		for (i = 0; i < IH_MENELAUS_IRQS; i++) {
-			if (isr & (1 << i)) {
-				mutex_lock(&menelaus->lock);
-				menelaus_disable_irq(i);
-				menelaus_ack_irq(i);
-				if (menelaus->handlers[i]) {
-					handler = menelaus->handlers[i];
-					handler(menelaus);
-				}
-				menelaus_enable_irq(i);
-				mutex_unlock(&menelaus->lock);
-			}
+		while (isr) {
+			int irq = fls(isr) - 1;
+			isr &= ~(1 << irq);
+
+			mutex_lock(&menelaus->lock);
+			menelaus_disable_irq(irq);
+			menelaus_ack_irq(irq);
+			handler = menelaus->handlers[irq];
+			if (handler)
+				handler(menelaus);
+			menelaus_enable_irq(irq);
+			mutex_unlock(&menelaus->lock);
 		}
 	}
 	enable_irq(menelaus->client->irq);
@@ -801,6 +813,344 @@ static irqreturn_t menelaus_irq(int irq,
 	return IRQ_HANDLED;
 }
 
+/*-----------------------------------------------------------------------*/
+
+/*
+ * The RTC needs to be set once, then it runs on backup battery power.
+ * It supports alarms, including system wake alarms (from some modes);
+ * and 1/second IRQs if requested.
+ */
+#ifdef CONFIG_RTC_DRV_TWL92330
+
+#define RTC_CTRL_RTC_EN		(1 << 0)
+#define RTC_CTRL_AL_EN		(1 << 1)
+#define RTC_CTRL_MODE12		(1 << 2)
+#define RTC_CTRL_EVERY_MASK	(3 << 3)
+#define RTC_CTRL_EVERY_SEC	(0 << 3)
+#define RTC_CTRL_EVERY_MIN	(1 << 3)
+#define RTC_CTRL_EVERY_HR	(2 << 3)
+#define RTC_CTRL_EVERY_DAY	(3 << 3)
+
+#define RTC_UPDATE_EVERY	0x08
+
+#define RTC_HR_PM		(1 << 7)
+
+static void menelaus_to_time(char *regs, struct rtc_time *t)
+{
+	t->tm_sec = BCD2BIN(regs[0]);
+	t->tm_min = BCD2BIN(regs[1]);
+	if (the_menelaus->rtc_control & RTC_CTRL_MODE12) {
+		t->tm_hour = BCD2BIN(regs[2] & 0x1f) - 1;
+		if (regs[2] & RTC_HR_PM)
+			t->tm_hour += 12;
+	} else
+		t->tm_hour = BCD2BIN(regs[2] & 0x3f);
+	t->tm_mday = BCD2BIN(regs[3]);
+	t->tm_mon = BCD2BIN(regs[4]) - 1;
+	t->tm_year = BCD2BIN(regs[5]) + 100;
+}
+
+static int time_to_menelaus(struct rtc_time *t, int regnum)
+{
+	int	hour, status;
+
+	status = menelaus_write_reg(regnum++, BIN2BCD(t->tm_sec));
+	if (status < 0)
+		goto fail;
+
+	status = menelaus_write_reg(regnum++, BIN2BCD(t->tm_min));
+	if (status < 0)
+		goto fail;
+
+	if (the_menelaus->rtc_control & RTC_CTRL_MODE12) {
+		hour = t->tm_hour + 1;
+		if (hour > 12)
+			hour = RTC_HR_PM | BIN2BCD(hour - 12);
+		else
+			hour = BIN2BCD(hour);
+	} else
+		hour = BIN2BCD(t->tm_hour);
+	status = menelaus_write_reg(regnum++, hour);
+	if (status < 0)
+		goto fail;
+
+	status = menelaus_write_reg(regnum++, BIN2BCD(t->tm_mday));
+	if (status < 0)
+		goto fail;
+
+	status = menelaus_write_reg(regnum++, BIN2BCD(t->tm_mon + 1));
+	if (status < 0)
+		goto fail;
+
+	status = menelaus_write_reg(regnum++, BIN2BCD(t->tm_year - 100));
+	if (status < 0)
+		goto fail;
+
+	return 0;
+fail:
+	dev_err(&the_menelaus->client->dev, "rtc write reg %02x, err %d\n",
+			--regnum, status);
+	return status;
+}
+
+static int menelaus_read_time(struct device *dev, struct rtc_time *t)
+{
+	struct i2c_msg	msg[2];
+	char		regs[7];
+	int		status;
+
+	/* block read date and time registers */
+	regs[0] = MENELAUS_RTC_SEC;
+
+	msg[0].addr = MENELAUS_I2C_ADDRESS;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	msg[0].buf = regs;
+
+	msg[1].addr = MENELAUS_I2C_ADDRESS;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = sizeof(regs);
+	msg[1].buf = regs;
+
+	status = i2c_transfer(the_menelaus->client->adapter, msg, 2);
+	if (status != 2) {
+		dev_err(dev, "%s error %d\n", "read", status);
+		return -EIO;
+	}
+
+	menelaus_to_time(regs, t);
+	t->tm_wday = BCD2BIN(regs[6]);
+
+	return 0;
+}
+
+static int menelaus_set_time(struct device *dev, struct rtc_time *t)
+{
+	int		status;
+
+	/* write date and time registers */
+	status = time_to_menelaus(t, MENELAUS_RTC_SEC);
+	if (status < 0)
+		return status;
+	status = menelaus_write_reg(MENELAUS_RTC_WKDAY, BIN2BCD(t->tm_wday));
+	if (status < 0) {
+		dev_err(&the_menelaus->client->dev, "rtc write reg %02x, err %d\n",
+				MENELAUS_RTC_WKDAY, status);
+		return status;
+	}
+
+	/* now commit the write */
+	status = menelaus_write_reg(MENELAUS_RTC_UPDATE, RTC_UPDATE_EVERY);
+	if (status < 0)
+		dev_err(&the_menelaus->client->dev, "rtc commit time, err %d\n",
+				status);
+
+	return 0;
+}
+
+static int menelaus_read_alarm(struct device *dev, struct rtc_wkalrm *w)
+{
+	struct i2c_msg	msg[2];
+	char		regs[6];
+	int		status;
+
+	/* block read alarm registers */
+	regs[0] = MENELAUS_RTC_AL_SEC;
+
+	msg[0].addr = MENELAUS_I2C_ADDRESS;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	msg[0].buf = regs;
+
+	msg[1].addr = MENELAUS_I2C_ADDRESS;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = sizeof(regs);
+	msg[1].buf = regs;
+
+	status = i2c_transfer(the_menelaus->client->adapter, msg, 2);
+	if (status != 2) {
+		dev_err(dev, "%s error %d\n", "alarm read", status);
+		return -EIO;
+	}
+
+	menelaus_to_time(regs, &w->time);
+
+	w->enabled = !!(the_menelaus->rtc_control & RTC_CTRL_AL_EN);
+
+	/* NOTE we *could* check if actually pending... */
+	w->pending = 0;
+
+	return 0;
+}
+
+static int menelaus_set_alarm(struct device *dev, struct rtc_wkalrm *w)
+{
+	int		status;
+
+	if (the_menelaus->client->irq <= 0 && w->enabled)
+		return -ENODEV;
+
+	/* clear previous alarm enable */
+	if (the_menelaus->rtc_control & RTC_CTRL_AL_EN) {
+		the_menelaus->rtc_control &= ~RTC_CTRL_AL_EN;
+		status = menelaus_write_reg(MENELAUS_RTC_CTRL,
+				the_menelaus->rtc_control);
+		if (status < 0)
+			return status;
+	}
+
+	/* write alarm registers */
+	status = time_to_menelaus(&w->time, MENELAUS_RTC_AL_SEC);
+	if (status < 0)
+		return status;
+
+	/* enable alarm if requested */
+	if (w->enabled) {
+		the_menelaus->rtc_control |= RTC_CTRL_AL_EN;
+		status = menelaus_write_reg(MENELAUS_RTC_CTRL,
+				the_menelaus->rtc_control);
+	}
+
+	return status;
+}
+
+#ifdef CONFIG_RTC_INTF_DEV
+
+static void menelaus_rtc_update_work(struct menelaus_chip *m)
+{
+	/* report 1/sec update */
+	local_irq_disable();
+	rtc_update_irq(m->rtc, 1, RTC_IRQF | RTC_UF);
+	local_irq_enable();
+}
+
+static int menelaus_ioctl(struct device *dev, unsigned cmd, unsigned long arg)
+{
+	int	status;
+
+	if (the_menelaus->client->irq <= 0)
+		return -ENOIOCTLCMD;
+
+	switch (cmd) {
+	/* alarm IRQ */
+	case RTC_AIE_ON:
+		if (the_menelaus->rtc_control & RTC_CTRL_AL_EN)
+			return 0;
+		the_menelaus->rtc_control |= RTC_CTRL_AL_EN;
+		break;
+	case RTC_AIE_OFF:
+		if (!(the_menelaus->rtc_control & RTC_CTRL_AL_EN))
+			return 0;
+		the_menelaus->rtc_control &= ~RTC_CTRL_AL_EN;
+		break;
+	/* 1/second "update" IRQ */
+	case RTC_UIE_ON:
+		if (the_menelaus->uie)
+			return 0;
+		status = menelaus_remove_irq_work(MENELAUS_RTCTMR_IRQ);
+		status = menelaus_add_irq_work(MENELAUS_RTCTMR_IRQ,
+				menelaus_rtc_update_work);
+		if (status == 0)
+			the_menelaus->uie = 1;
+		return status;
+	case RTC_UIE_OFF:
+		if (!the_menelaus->uie)
+			return 0;
+		status = menelaus_remove_irq_work(MENELAUS_RTCTMR_IRQ);
+		if (status == 0)
+			the_menelaus->uie = 0;
+		return status;
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return menelaus_write_reg(MENELAUS_RTC_CTRL, the_menelaus->rtc_control);
+}
+
+#else
+#define menelaus_ioctl	NULL
+#endif
+
+/* REVISIT no compensation register support ... */
+
+static const struct rtc_class_ops menelaus_rtc_ops = {
+	.ioctl			= menelaus_ioctl,
+	.read_time		= menelaus_read_time,
+	.set_time		= menelaus_set_time,
+	.read_alarm		= menelaus_read_alarm,
+	.set_alarm		= menelaus_set_alarm,
+};
+
+static void menelaus_rtc_alarm_work(struct menelaus_chip *m)
+{
+	/* report alarm */
+	local_irq_disable();
+	rtc_update_irq(m->rtc, 1, RTC_IRQF | RTC_AF);
+	local_irq_enable();
+
+	/* then disable it; alarms are oneshot */
+	the_menelaus->rtc_control &= ~RTC_CTRL_AL_EN;
+	menelaus_write_reg(MENELAUS_RTC_CTRL, the_menelaus->rtc_control);
+}
+
+static inline void menelaus_rtc_init(struct menelaus_chip *m)
+{
+	int	alarm = (m->client->irq > 0);
+
+	/* assume 32KDETEN pin is pulled high */
+	if (!(menelaus_read_reg(MENELAUS_OSC_CTRL) & 0x80)) {
+		dev_dbg(&m->client->dev, "no 32k oscillator\n");
+		return;
+	}
+
+	/* support RTC alarm; it can issue wakeups */
+	if (alarm) {
+		if (menelaus_add_irq_work(MENELAUS_RTCALM_IRQ,
+				menelaus_rtc_alarm_work) < 0) {
+			dev_err(&m->client->dev, "can't handle RTC alarm\n");
+			return;
+		}
+		device_init_wakeup(&m->client->dev, 1);
+	}
+
+	/* be sure RTC is enabled; allow 1/sec irqs; leave 12hr mode alone */
+	m->rtc_control = menelaus_read_reg(MENELAUS_RTC_CTRL);
+	if (!(m->rtc_control & RTC_CTRL_RTC_EN)
+			|| (m->rtc_control & RTC_CTRL_AL_EN)
+			|| (m->rtc_control & RTC_CTRL_EVERY_MASK)) {
+		if (!(m->rtc_control & RTC_CTRL_RTC_EN)) {
+			dev_warn(&m->client->dev, "rtc clock needs setting\n");
+			m->rtc_control |= RTC_CTRL_RTC_EN;
+		}
+		m->rtc_control &= ~RTC_CTRL_EVERY_MASK;
+		m->rtc_control &= ~RTC_CTRL_AL_EN;
+		menelaus_write_reg(MENELAUS_RTC_CTRL, m->rtc_control);
+	}
+
+	m->rtc = rtc_device_register(DRIVER_NAME,
+			&m->client->dev,
+			&menelaus_rtc_ops, THIS_MODULE);
+	if (IS_ERR(m->rtc)) {
+		if (alarm) {
+			menelaus_remove_irq_work(MENELAUS_RTCALM_IRQ);
+			device_init_wakeup(&m->client->dev, 0);
+		}
+		dev_err(&m->client->dev, "can't register RTC: %d\n",
+				(int) PTR_ERR(m->rtc));
+		the_menelaus->rtc = NULL;
+	}
+}
+
+#else
+
+static inline void menelaus_rtc_init(struct menelaus_chip *m)
+{
+	/* nothing */
+}
+
+#endif
+
+/*-----------------------------------------------------------------------*/
+
 static struct i2c_driver menelaus_i2c_driver;
 
 static int menelaus_probe(struct i2c_client *client)
@@ -838,6 +1188,8 @@ static int menelaus_probe(struct i2c_cli
 	menelaus_write_reg(MENELAUS_INT_ACK2, 0xff);
 	menelaus_write_reg(MENELAUS_INT_MASK1, 0xff);
 	menelaus_write_reg(MENELAUS_INT_MASK2, 0xff);
+	menelaus->mask1 = 0xff;
+	menelaus->mask2 = 0xff;
 
 	/* Set output buffer strengths */
 	menelaus_write_reg(MENELAUS_MCT_CTRL1, 0x73);
@@ -871,6 +1223,8 @@ static int menelaus_probe(struct i2c_cli
 			goto fail2;
 	}
 
+	menelaus_rtc_init(menelaus);
+
 	return 0;
 fail2:
 	free_irq(client->irq, menelaus);
