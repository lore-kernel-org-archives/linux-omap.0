From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: [PATCH 1/1] ARM: OMAP2: TWL4030 RTC driver
Date: Thu, 31 May 2007 11:07:08 +0400
Message-ID: <20070531070651.5677.82640.stgit@T60>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch adds TWL4030 Real-Time Clock support for OMAP2430.

Signed-off-by: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
---

 arch/arm/mach-omap2/board-2430sdp.c     |   42 ++
 drivers/rtc/Kconfig                     |    7 
 drivers/rtc/Makefile                    |    1 
 drivers/rtc/rtc-twl4030.c               |  636 +++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/twl4030-rtc.h |  230 +++++++++++
 5 files changed, 916 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index ab9b23b..e1debbf 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -38,6 +38,7 @@
 #include <asm/arch/keypad.h>
 #include <asm/arch/gpmc.h>
 #include <asm/arch/mcspi.h>
+#include <asm/arch/twl4030-rtc.h>
 
 #include <asm/io.h>
 
@@ -50,6 +51,8 @@
  * that driver is used for the touchscreen. */
 #define TS_GPIO                 24
 
+#define TWL4030_MSECURE_GPIO	118
+
 static struct mtd_partition sdp2430_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -183,11 +186,50 @@ static struct platform_device sdp2430_kp
 	},
 };
 
+static int twl4030_rtc_init(void)
+{
+	int ret = 0;
+
+	ret = omap_request_gpio(TWL4030_MSECURE_GPIO);
+	if (ret < 0) {
+		printk(KERN_ERR "twl4030_rtc_init: can't reserve GPIO:%d !\n",
+			TWL4030_MSECURE_GPIO);
+		goto out;
+	}
+	/* TWL4030 will be in secure mode if msecure line from OMAP is low.
+	 * Make msecure line high in order to change the TWL4030 RTC time
+	 * and calender registers.
+	 */
+	omap_set_gpio_direction(TWL4030_MSECURE_GPIO, 0);	/*dir out */
+	omap_set_gpio_dataout(TWL4030_MSECURE_GPIO, 1);
+out:
+	return ret;
+}
+
+static void twl4030_rtc_exit(void)
+{
+	omap_free_gpio(TWL4030_MSECURE_GPIO);
+}
+
+static struct twl4030rtc_platform_data sdp2430_twl4030rtc_data = {
+	.init = &twl4030_rtc_init,
+	.exit = &twl4030_rtc_exit,
+};
+
+static struct platform_device sdp2430_twl4030rtc_device = {
+ 	.name		= "twl4030_rtc",
+ 	.id		= -1,
+	.dev		= {
+		.platform_data	= &sdp2430_twl4030rtc_data,
+	},
+};
+
 static struct platform_device *sdp2430_devices[] __initdata = {
 	&sdp2430_smc91x_device,
 	&sdp2430_flash_device,
 	&sdp2430_kp_device,
 	&sdp2430_lcd_device,
+	&sdp2430_twl4030rtc_device,	
 };
 
 static void ads7846_dev_init(void)
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 4e4c10a..17c0374 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -121,6 +121,13 @@ config RTC_DRV_TEST
 comment "I2C RTC drivers"
 	depends on RTC_CLASS
 
+config RTC_DRV_OMAP2430_TWL4030
+	tristate "OMAP243X TWL4030 Real Time Clock"
+	depends on RTC_CLASS && TWL4030_CORE
+	help
+	  Support for TWL4030 companion chip internal RTC on OMAP2 SDP2430 board
+
+
 config RTC_DRV_DS1307
 	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00"
 	depends on RTC_CLASS && I2C
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index a1afbc2..d6938c2 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
 obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
+obj-$(CONFIG_RTC_DRV_OMAP2430_TWL4030)	+= rtc-twl4030.o
diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
new file mode 100644
index 0000000..9811586
--- /dev/null
+++ b/drivers/rtc/rtc-twl4030.c
@@ -0,0 +1,636 @@
+/*
+ * drivers/rtc/rtc-twl4030.c
+ * 
+ * TWL4030 Real Time Clock interface for Linux
+ * 
+ * Copyright (C) 2007 MontaVista Software, Inc
+ * Author: Alexandre Rusev <source@mvista.com>
+ *
+ * Based on original TI driver twl4030-rtc.c
+ *   Copyright (C) 2006 Texas Instruments, Inc.
+ * 
+ * Based on rtc-omap.c
+ *   Copyright (C) 2003 MontaVista Software, Inc.
+ *   Author: George G. Davis <gdavis@mvista.com> or <source@mvista.com>
+ *
+ *   Copyright (C) 2006 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ * 
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+
+#include <asm/io.h>
+#include <asm/mach/time.h>
+#include <asm/system.h>
+#include <asm/hardware.h>
+#include <asm/irq.h>
+#include <asm/arch/twl4030.h>
+#include <asm/arch/twl4030-rtc.h>
+
+#define ALL_TIME_REGS		6
+
+/*
+ * If this driver ever becomes modularised, it will be really nice
+ * to make the epoch retain its value across module reload...
+ */
+static int epoch = 1900;	/* year corresponding to 0x00   */
+
+/* 
+ * Supports 1 byte read from TWL4030 RTC register. 
+ */
+static int twl4030_rtc_read_u8(u8 * data, u8 reg)
+{
+	int ret;
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_RTC, data, reg);
+	if (ret < 0) {
+		printk(KERN_WARNING "twl4030_rtc: Could not read TWL4030"
+		       "register %X - returned %d[%x]\n", reg, ret, ret);
+	}
+	return ret;
+}
+
+/* 
+ * Supports 1 byte write to TWL4030 RTC registers.
+ */
+static int twl4030_rtc_write_u8(u8 data, u8 reg)
+{
+	int ret;
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_RTC, data, reg);
+	if (ret < 0) {
+		printk(KERN_WARNING "twl4030_rtc: Could not write TWL4030" 
+		       "register %X - returned %d[%x]\n", reg, ret, ret);
+	}
+	return ret;
+}
+
+/* 
+ * Enables timer or alarm interrupts.
+ */
+static int set_rtc_irq_bit(unsigned char bit)
+{
+	unsigned char val;
+	int ret;
+
+	ret = twl4030_rtc_read_u8(&val, REG_RTC_INTERRUPTS_REG);
+	if (ret < 0)
+		goto set_irq_out;
+
+	val |= bit;
+	ret = twl4030_rtc_write_u8(val, REG_RTC_INTERRUPTS_REG);
+
+set_irq_out:
+	return ret;
+}
+
+#ifdef CONFIG_PM
+/* 
+ * Read timer or alarm interrupts register.
+ */
+static int get_rtc_irq_bit(unsigned char *val)
+{
+	int ret;
+
+	ret = twl4030_rtc_read_u8(val, REG_RTC_INTERRUPTS_REG);
+	return ret;
+}
+#endif
+/* 
+ * Disables timer or alarm interrupts.
+ */
+static int mask_rtc_irq_bit(unsigned char bit)
+{
+	unsigned char val;
+	int ret;
+
+	ret = twl4030_rtc_read_u8(&val, REG_RTC_INTERRUPTS_REG);
+	if (ret < 0)
+		goto mask_irq_out;
+	
+	val &= ~bit;
+	ret = twl4030_rtc_write_u8(val, REG_RTC_INTERRUPTS_REG);
+
+mask_irq_out:
+	return ret;
+}
+
+static int twl4030_rtc_alarm_irq_set_state(struct device *dev, int enabled)
+{
+	int ret;
+	/* Allow ints for RTC ALARM updates.  */
+	if (enabled) 
+		ret = set_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
+	else 
+		ret = mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
+
+	return ret;
+}
+
+/* 
+ * Gets current TWL4030 RTC time and date parameters.
+ */
+static int get_rtc_time(struct rtc_time *rtc_tm)
+{
+	unsigned char rtc_data[ALL_TIME_REGS + 1];
+	int ret;
+	u8 save_control;
+
+	ret = twl4030_rtc_read_u8(&save_control, REG_RTC_CTRL_REG);
+	if (ret < 0)
+    		return ret;
+
+	save_control |= BIT_RTC_CTRL_REG_GET_TIME_M;
+
+	ret = twl4030_rtc_write_u8(save_control, REG_RTC_CTRL_REG);
+	if (ret < 0)
+		return ret;
+
+	ret = twl4030_i2c_read(TWL4030_MODULE_RTC, rtc_data,
+			       REG_SECONDS_REG, ALL_TIME_REGS);
+
+	if (ret < 0) {
+		printk(KERN_ERR "twl4030_rtc: twl4030_i2c_read error.\n");
+		return ret;
+	}
+
+	rtc_tm->tm_sec = BCD2BIN(rtc_data[0]);
+	rtc_tm->tm_min = BCD2BIN(rtc_data[1]);
+	rtc_tm->tm_hour = BCD2BIN(rtc_data[2]);
+	rtc_tm->tm_mday = BCD2BIN(rtc_data[3]);
+	rtc_tm->tm_mon = BCD2BIN(rtc_data[4]);
+	rtc_tm->tm_year = BCD2BIN(rtc_data[5]);
+
+	/*
+	 * Account for differences between how the RTC uses the values
+	 * and how they are defined in a struct rtc_time;
+	 */
+	if ((rtc_tm->tm_year += (epoch - 1900)) <= 69)
+		rtc_tm->tm_year += 100;
+
+	rtc_tm->tm_mon--;
+
+	return ret;
+}
+
+static int twl4030_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char save_control;
+	unsigned char rtc_data[ALL_TIME_REGS + 1];
+	int ret;
+
+	/* Month range is 01..12 */
+	tm->tm_mon++;
+
+	rtc_data[1] = BIN2BCD(tm->tm_sec);
+	rtc_data[2] = BIN2BCD(tm->tm_min);
+	rtc_data[3] = BIN2BCD(tm->tm_hour);
+	rtc_data[4] = BIN2BCD(tm->tm_mday);
+	rtc_data[5] = BIN2BCD(tm->tm_mon);
+	rtc_data[6] = BIN2BCD(tm->tm_year);
+
+	/* Stop RTC while updating the TC registers */
+	ret = twl4030_rtc_read_u8(&save_control, REG_RTC_CTRL_REG);
+	if (ret < 0)
+		goto out;
+
+	save_control &= ~BIT_RTC_CTRL_REG_STOP_RTC_M;
+	twl4030_rtc_write_u8(save_control, REG_RTC_CTRL_REG);
+	if (ret < 0)
+		goto out;
+
+	/* update all the alarm registers in one shot */
+	ret = twl4030_i2c_write(TWL4030_MODULE_RTC, rtc_data,
+			        REG_SECONDS_REG, ALL_TIME_REGS);
+	if (ret < 0) {
+		printk(KERN_ERR "twl4030: twl4030_i2c_write error.\n");
+		goto out;
+	}
+
+	/* Start back RTC */
+	save_control |= BIT_RTC_CTRL_REG_STOP_RTC_M;
+	ret = twl4030_rtc_write_u8(save_control, REG_RTC_CTRL_REG);
+
+out:
+	return ret;
+}
+
+/* 
+ * Gets current TWL4030 RTC alarm time.
+ */
+static int get_rtc_alm_time(struct rtc_time *alm_tm)
+{
+	unsigned char rtc_data[ALL_TIME_REGS + 1];
+	int ret;
+
+	ret = twl4030_i2c_read(TWL4030_MODULE_RTC, rtc_data,
+			       REG_ALARM_SECONDS_REG, ALL_TIME_REGS);
+	if (ret < 0) {
+		printk(KERN_ERR "twl4030_rtc: twl4030_i2c_read error.\n");
+		return ret;
+	}
+
+	alm_tm->tm_sec = BCD2BIN(rtc_data[0]);
+	alm_tm->tm_min = BCD2BIN(rtc_data[1]);
+	alm_tm->tm_hour = BCD2BIN(rtc_data[2]);
+	alm_tm->tm_mday = BCD2BIN(rtc_data[3]);
+	alm_tm->tm_mon = BCD2BIN(rtc_data[4]);
+	alm_tm->tm_year = BCD2BIN(rtc_data[5]);
+
+	/*
+	 * Account for differences between how the RTC uses the values
+	 * and how they are defined in a struct rtc_time;
+	 */
+	if ((alm_tm->tm_year += (epoch - 1900)) <= 69)
+		alm_tm->tm_year += 100;
+
+	alm_tm->tm_mon--;
+
+	return ret;
+}
+
+static int twl4030_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	int ret;
+
+	memset(tm, 0, sizeof(struct rtc_time));
+	ret = get_rtc_time(tm);
+
+	return ret;
+}
+
+/* 
+ * Gets current TWL4030 RTC alarm time.
+ */
+static int twl4030_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	int ret;
+	u8 rtc_interrupts_reg = 0;
+	/*
+	 * This returns a struct rtc_time. Reading >= 0xc0
+	 * means "don't care" or "match all". Only the tm_hour,
+	 * tm_min, and tm_sec values are filled in.
+	 */
+	memset(&alm->time, 0, sizeof(struct rtc_time));
+	ret = get_rtc_alm_time(&alm->time);
+
+	if (ret)
+		goto out;
+
+	/* Check alarm enabled flag state */
+	ret =
+	    ret | twl4030_i2c_read_u8(TWL4030_MODULE_RTC, &rtc_interrupts_reg,
+				      REG_RTC_INTERRUPTS_REG);
+
+	if (ret)
+		goto out;
+
+	if ((rtc_interrupts_reg & BIT_RTC_INTERRUPTS_REG_IT_ALARM_M) != 0)
+		alm->enabled = 1;
+	else
+		alm->enabled = 0;
+
+out:
+	return ret;
+}
+
+static int twl4030_rtc_irq_set_state(struct device *dev, int enabled)
+{
+	int ret;
+	/* Allow ints for RTC updates.  */
+	if (enabled) 
+		ret = set_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
+	else 
+		ret = mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
+	
+	return ret;
+}
+
+static int twl4030_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	unsigned char alarm_data[ALL_TIME_REGS + 1];
+	int ret;
+
+	/* Month range is 01..12 */
+	alm->time.tm_mon++;
+
+	alarm_data[1] = BIN2BCD(alm->time.tm_sec);
+	alarm_data[2] = BIN2BCD(alm->time.tm_min);
+	alarm_data[3] = BIN2BCD(alm->time.tm_hour);
+	alarm_data[4] = BIN2BCD(alm->time.tm_mday);
+	alarm_data[5] = BIN2BCD(alm->time.tm_mon);
+	alarm_data[6] = BIN2BCD(alm->time.tm_year);
+
+	/* update all the alarm registers in one shot */
+	ret = twl4030_i2c_write(TWL4030_MODULE_RTC, alarm_data,
+			        REG_ALARM_SECONDS_REG, ALL_TIME_REGS);
+	if (ret) {
+		printk(KERN_ERR "twl4030: twl4030_i2c_write error.\n");
+		goto out;
+	}
+
+	ret = twl4030_rtc_alarm_irq_set_state(dev, alm->enabled);
+out:
+	return ret;
+}
+
+#ifdef	CONFIG_RTC_INTF_DEV
+
+static int twl4030_rtc_ioctl(struct device *dev, unsigned int cmd,
+			     unsigned long arg)
+{
+
+	switch (cmd) {
+	case RTC_AIE_OFF:
+		return twl4030_rtc_alarm_irq_set_state(dev, 0);
+	case RTC_AIE_ON:
+		return twl4030_rtc_alarm_irq_set_state(dev, 1);
+	case RTC_UIE_OFF:
+		/* Mask ints from RTC updates.  */
+		return twl4030_rtc_irq_set_state(dev, 0);
+	case RTC_UIE_ON:
+		/* Allow ints for RTC updates.  */
+		return twl4030_rtc_irq_set_state(dev, 1);
+	case RTC_EPOCH_READ:
+		return put_user(epoch, (unsigned long *)arg);
+	case RTC_EPOCH_SET:	
+		/*
+		 * There were no RTC clocks before 1900.
+		 */
+		if (arg < 1900)
+			return -EINVAL;
+
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		epoch = arg;
+		return 0;
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+#else
+#define	omap_rtc_ioctl	NULL
+#endif
+
+static irqreturn_t twl4030_rtc_interrupt(int irq, void *rtc)
+{
+	unsigned long events = 0;
+	int ret = IRQ_NONE;
+	int res;
+	u8 rd_reg;
+	
+	/* clear the RTC interrupt in TWL4030 power module */
+	res = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &rd_reg, REG_PWR_ISR1);
+	if (res)
+		goto out;
+
+	/* Check if interrupt is sourced by RTC */
+	if (!(rd_reg & PWR_RTC_INT_CLR))
+		goto out;
+
+	rd_reg |= PWR_RTC_INT_CLR;
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT, rd_reg, REG_PWR_ISR1);
+	if (res)
+		goto out;
+
+	res = twl4030_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
+	if (res)
+		goto out;
+	/*
+	 * Figure out source of interrupt: ALARM or TIMER in RTC_STATUS_REG.
+	 * only one (ALARM or RTC) interrupt source may be enabled
+	 * at time, we also could check our results
+	 * by reading RTS_INTERRUPTS_REGISTER[IT_TIMER,IT_ALARM]
+	 */
+	if (rd_reg & BIT_RTC_STATUS_REG_ALARM_M)
+		events |= RTC_IRQF | RTC_AF;
+	else
+		events |= RTC_IRQF | RTC_UF;
+
+	res = twl4030_rtc_write_u8(rd_reg | BIT_RTC_STATUS_REG_ALARM_M,
+				   REG_RTC_STATUS_REG);
+	if (res)
+		goto out;
+	/*
+	 * Workaround for strange behaviour with T2. Need to write into ISR 
+	 * register one more time to clear the interrupt. Otherwise, the same
+	 * RTC event generates 2 interrupts in a row.
+	 * (no errata document available)
+	 */
+	res = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &rd_reg, REG_PWR_ISR1);
+	if (res)
+		goto out;
+
+	rd_reg |= PWR_RTC_INT_CLR;
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT, rd_reg, REG_PWR_ISR1);
+	if (res)
+		goto out;
+
+	/* Notify RTC core on event */
+	rtc_update_irq(rtc, 1, events);
+
+	ret = IRQ_HANDLED;
+out:
+	return ret;
+}
+
+static struct rtc_class_ops twl4030_rtc_ops = {
+	.ioctl = twl4030_rtc_ioctl,
+	.read_time = twl4030_rtc_read_time,
+	.set_time = twl4030_rtc_set_time,
+	.read_alarm = twl4030_rtc_read_alarm,
+	.set_alarm = twl4030_rtc_set_alarm,
+};
+
+static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
+{
+	struct twl4030rtc_platform_data *pdata = pdev->dev.platform_data;
+	struct rtc_device *rtc;
+	int ret = 0;
+	u8 rd_reg;
+	
+	if (pdata != NULL && pdata->init != NULL) {
+		ret = pdata->init();
+		if (ret < 0)
+			goto out;
+	}
+
+	rtc = rtc_device_register(pdev->name,
+				  &pdev->dev, &twl4030_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		ret = -EINVAL;
+		dev_err(&pdev->dev, "can't register RTC device, err %ld\n",
+			PTR_ERR(rtc));
+		goto out0;
+
+	}
+
+	platform_set_drvdata(pdev, rtc);
+
+	ret = twl4030_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
+
+	if (ret < 0)
+		goto out1;
+
+	if (rd_reg & BIT_RTC_STATUS_REG_POWER_UP_M)
+		dev_warn(&pdev->dev, "Power up reset detected.\n");
+
+	if (rd_reg & BIT_RTC_STATUS_REG_ALARM_M)
+		dev_warn(&pdev->dev, "Pending Alarm interrupt detected.\n");
+
+	/* Clear RTC Power up reset and pending alarm interrupts */
+	ret = twl4030_rtc_write_u8(rd_reg, REG_RTC_STATUS_REG);
+	if (ret < 0)
+		goto out1;
+
+	ret = request_irq(TWL4030_MODIRQ_PWR, twl4030_rtc_interrupt,
+			  IRQF_DISABLED | IRQF_SHARED, rtc->dev.bus_id, rtc);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "IRQ is not free.\n");
+		goto out1;
+	} 
+
+	/* Check RTC module status, Enable if it is off */
+	ret = twl4030_rtc_read_u8(&rd_reg, REG_RTC_CTRL_REG);
+	if (ret < 0)
+		goto out2;
+
+	if (!(rd_reg & BIT_RTC_CTRL_REG_STOP_RTC_M)) {
+		dev_info(&pdev->dev, "Enabling TWL4030-RTC.\n");
+		rd_reg = BIT_RTC_CTRL_REG_STOP_RTC_M;
+		ret = twl4030_rtc_write_u8(rd_reg, REG_RTC_CTRL_REG);
+		if (ret < 0)
+			goto out2;
+	}
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &rd_reg, REG_PWR_IMR1);
+	if (ret < 0)
+		goto out2;
+
+	rd_reg &= PWR_RTC_IT_UNMASK;
+	/* MASK PWR - we will need this */
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_INT, rd_reg, REG_PWR_IMR1);
+	if (ret < 0)
+		goto out2;
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &rd_reg, REG_PWR_EDR1);
+	if (ret < 0)
+		goto out2;
+
+	/* Rising edge detection enabled, needed for RTC alarm */
+	rd_reg |= 0x80;		
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_INT, rd_reg, REG_PWR_EDR1);
+	if (ret < 0)
+		goto out2;
+
+	return ret;
+
+
+out2:
+	free_irq(TWL4030_MODIRQ_PWR, rtc);
+out1:
+	rtc_device_unregister(rtc);
+out0:
+	if (pdata != NULL && pdata->exit != NULL)
+		pdata->exit();
+out:
+	return ret;
+}
+
+/*
+ * Disable all TWL4030 RTC module interrupts.
+ * Sets status flag to free.
+ */
+static int __devexit twl4030_rtc_remove(struct platform_device *pdev)
+{
+	/* leave rtc running, but disable irqs */
+	struct twl4030rtc_platform_data *pdata = pdev->dev.platform_data;
+	struct rtc_device *rtc = platform_get_drvdata(pdev);
+
+	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
+	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
+
+	free_irq(TWL4030_MODIRQ_PWR, rtc);
+
+	if (pdata != NULL && pdata->exit != NULL) 
+		pdata->exit();
+
+	rtc_device_unregister(rtc);
+	return 0;
+}
+
+static void twl4030_rtc_shutdown(struct platform_device *pdev)
+{
+	twl4030_rtc_alarm_irq_set_state(&pdev->dev, 0);
+	twl4030_rtc_irq_set_state(&pdev->dev, 0);
+}
+
+#ifdef CONFIG_PM
+
+static unsigned char irqstat = 0;
+
+static int twl4030_rtc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	get_rtc_irq_bit(&irqstat);
+
+	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M |
+			 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
+	return 0;
+}
+
+static int twl4030_rtc_resume(struct platform_device *pdev)
+{
+	set_rtc_irq_bit(irqstat);
+	return 0;
+}
+#else
+#define twl4030_rtc_suspend NULL
+#define twl4030_rtc_resume  NULL
+#endif
+
+MODULE_ALIAS("twl4030_rtc");
+static struct platform_driver twl4030rtc_driver = {
+	.probe = twl4030_rtc_probe,
+	.remove = __devexit_p(twl4030_rtc_remove),
+	.shutdown = twl4030_rtc_shutdown,
+	.suspend = twl4030_rtc_suspend,
+	.resume = twl4030_rtc_resume,
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = "twl4030_rtc",
+		   },
+};
+
+static int __init twl4030_rtc_init(void)
+{
+	return platform_driver_register(&twl4030rtc_driver);
+}
+
+static void __exit twl4030_rtc_exit(void)
+{
+	platform_driver_unregister(&twl4030rtc_driver);
+}
+
+MODULE_AUTHOR("Texas Instruments, MontaVista Software");
+MODULE_LICENSE("GPL");;
+
+module_init(twl4030_rtc_init);
+module_exit(twl4030_rtc_exit);
diff --git a/include/asm-arm/arch-omap/twl4030-rtc.h b/include/asm-arm/arch-omap/twl4030-rtc.h
new file mode 100644
index 0000000..f3d96b3
--- /dev/null
+++ b/include/asm-arm/arch-omap/twl4030-rtc.h
@@ -0,0 +1,230 @@
+/*
+ * include/asm-arm/arch-omap/twl4030-rtc.h
+ *
+ * Copyright (C) 2006 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __TWL4030_RTC_H__
+#define __TWL4030_RTC_H__
+
+#define REG_SECONDS_REG                          (0x0)
+#define REG_MINUTES_REG                          (0x1)
+#define REG_HOURS_REG                            (0x2)
+#define REG_DAYS_REG                             (0x3)
+#define REG_MONTHS_REG                           (0x4)
+#define REG_YEARS_REG                            (0x5)
+#define REG_WEEKS_REG                            (0x6)
+#define REG_ALARM_SECONDS_REG                    (0x7)
+#define REG_ALARM_MINUTES_REG                    (0x8)
+#define REG_ALARM_HOURS_REG                      (0x9)
+#define REG_ALARM_DAYS_REG                       (0xA)
+#define REG_ALARM_MONTHS_REG                     (0xB)
+#define REG_ALARM_YEARS_REG                      (0xC)
+#define REG_RTC_CTRL_REG                         (0xD)
+#define REG_RTC_STATUS_REG                       (0xE)
+#define REG_RTC_INTERRUPTS_REG                   (0xF)
+#define REG_RTC_COMP_LSB_REG                     (0x10)
+#define REG_RTC_COMP_MSB_REG                     (0x11)
+
+/* REVISIT: these TWL4030 power registers are only used
+ * by rtc-twl4030 driver, move to an appropriate header
+ * if other drivers need the registers
+ */
+/* Power registers */
+#define REG_PWR_ISR1		0x00
+#define REG_PWR_IMR1		0x01
+#define REG_PWR_EDR1		0x05
+
+#define PWR_RTC_IT_UNMASK	 ~(0x08)
+#define PWR_RTC_INT_CLR          0x08
+
+/**** BitField Definitions */
+/* SECONDS_REG Fields */
+#define BIT_SECONDS_REG_SEC0                     (0x000)
+#define BIT_SECONDS_REG_SEC0_M                   (0x0000000F)
+#define BIT_SECONDS_REG_SEC1                     (0x004)
+#define BIT_SECONDS_REG_SEC1_M                   (0x00000070)
+/* MINUTES_REG Fields */
+#define BIT_MINUTES_REG_MIN0                     (0x000)
+#define BIT_MINUTES_REG_MIN0_M                   (0x0000000F)
+#define BIT_MINUTES_REG_MIN1                     (0x004)
+#define BIT_MINUTES_REG_MIN1_M                   (0x00000070)
+/* HOURS_REG Fields */
+#define BIT_HOURS_REG_HOUR0                      (0x000)
+#define BIT_HOURS_REG_HOUR0_M                    (0x0000000F)
+#define BIT_HOURS_REG_HOUR1                      (0x004)
+#define BIT_HOURS_REG_HOUR1_M                    (0x00000030)
+#define BIT_HOURS_REG_PM_NAM                     (0x007)
+#define BIT_HOURS_REG_PM_NAM_M                   (0x00000080)
+/* DAYS_REG Fields */
+#define BIT_DAYS_REG_DAY0                        (0x000)
+#define BIT_DAYS_REG_DAY0_M                      (0x0000000F)
+#define BIT_DAYS_REG_DAY1                        (0x004)
+#define BIT_DAYS_REG_DAY1_M                      (0x00000030)
+/* MONTHS_REG Fields */
+#define BIT_MONTHS_REG_MONTH0                    (0x000)
+#define BIT_MONTHS_REG_MONTH0_M                  (0x0000000F)
+#define BIT_MONTHS_REG_MONTH1                    (0x004)
+#define BIT_MONTHS_REG_MONTH1_M                  (0x00000010)
+/* YEARS_REG Fields */
+#define BIT_YEARS_REG_YEAR0                      (0x000)
+#define BIT_YEARS_REG_YEAR0_M                    (0x0000000F)
+#define BIT_YEARS_REG_YEAR1                      (0x004)
+#define BIT_YEARS_REG_YEAR1_M                    (0x000000F0)
+/* WEEKS_REG Fields */
+#define BIT_WEEKS_REG_WEEK                       (0x000)
+#define BIT_WEEKS_REG_WEEK_M                     (0x00000007)
+/* ALARM_SECONDS_REG Fields */
+#define BIT_ALARM_SECONDS_REG_ALARM_SEC0         (0x000)
+#define BIT_ALARM_SECONDS_REG_ALARM_SEC0_M       (0x0000000F)
+#define BIT_ALARM_SECONDS_REG_ALARM_SEC1         (0x004)
+#define BIT_ALARM_SECONDS_REG_ALARM_SEC1_M       (0x00000070)
+/* ALARM_MINUTES_REG Fields */
+#define BIT_ALARM_MINUTES_REG_ALARM_MIN0         (0x000)
+#define BIT_ALARM_MINUTES_REG_ALARM_MIN0_M       (0x0000000F)
+#define BIT_ALARM_MINUTES_REG_ALARM_MIN1         (0x004)
+#define BIT_ALARM_MINUTES_REG_ALARM_MIN1_M       (0x00000070)
+/* ALARM_HOURS_REG Fields */
+#define BIT_ALARM_HOURS_REG_ALARM_HOUR0          (0x000)
+#define BIT_ALARM_HOURS_REG_ALARM_HOUR0_M        (0x0000000F)
+#define BIT_ALARM_HOURS_REG_ALARM_HOUR1          (0x004)
+#define BIT_ALARM_HOURS_REG_ALARM_HOUR1_M        (0x00000030)
+#define BIT_ALARM_HOURS_REG_ALARM_PM_NAM         (0x007)
+#define BIT_ALARM_HOURS_REG_ALARM_PM_NAM_M       (0x00000080)
+/* ALARM_DAYS_REG Fields */
+#define BIT_ALARM_DAYS_REG_ALARM_DAY0            (0x000)
+#define BIT_ALARM_DAYS_REG_ALARM_DAY0_M          (0x0000000F)
+#define BIT_ALARM_DAYS_REG_ALARM_DAY1            (0x004)
+#define BIT_ALARM_DAYS_REG_ALARM_DAY1_M          (0x00000030)
+/* ALARM_MONTHS_REG Fields */
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0        (0x000)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0_M      (0x0000000F)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1        (0x004)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1_M      (0x00000010)
+/* ALARM_YEARS_REG Fields */
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR0          (0x000)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR0_M        (0x0000000F)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR1          (0x004)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR1_M        (0x000000F0)
+/* RTC_CTRL_REG Fields */
+#define BIT_RTC_CTRL_REG_STOP_RTC                (0x000)
+#define BIT_RTC_CTRL_REG_STOP_RTC_M              (0x00000001)
+#define BIT_RTC_CTRL_REG_ROUND_30S               (0x001)
+#define BIT_RTC_CTRL_REG_ROUND_30S_M             (0x00000002)
+#define BIT_RTC_CTRL_REG_AUTO_COMP               (0x002)
+#define BIT_RTC_CTRL_REG_AUTO_COMP_M             (0x00000004)
+#define BIT_RTC_CTRL_REG_MODE_12_24              (0x003)
+#define BIT_RTC_CTRL_REG_MODE_12_24_M            (0x00000008)
+#define BIT_RTC_CTRL_REG_TEST_MODE               (0x004)
+#define BIT_RTC_CTRL_REG_TEST_MODE_M             (0x00000010)
+#define BIT_RTC_CTRL_REG_SET_32_COUNTER          (0x005)
+#define BIT_RTC_CTRL_REG_SET_32_COUNTER_M        (0x00000020)
+#define BIT_RTC_CTRL_REG_GET_TIME                (0x006)
+#define BIT_RTC_CTRL_REG_GET_TIME_M              (0x00000040)
+/* RTC_STATUS_REG Fields */
+#define BIT_RTC_STATUS_REG_RUN                   (0x001)
+#define BIT_RTC_STATUS_REG_RUN_M                 (0x00000002)
+#define BIT_RTC_STATUS_REG_1S_EVENT              (0x002)
+#define BIT_RTC_STATUS_REG_1S_EVENT_M            (0x00000004)
+#define BIT_RTC_STATUS_REG_1M_EVENT              (0x003)
+#define BIT_RTC_STATUS_REG_1M_EVENT_M            (0x00000008)
+#define BIT_RTC_STATUS_REG_1H_EVENT              (0x004)
+#define BIT_RTC_STATUS_REG_1H_EVENT_M            (0x00000010)
+#define BIT_RTC_STATUS_REG_1D_EVENT              (0x005)
+#define BIT_RTC_STATUS_REG_1D_EVENT_M            (0x00000020)
+#define BIT_RTC_STATUS_REG_ALARM                 (0x006)
+#define BIT_RTC_STATUS_REG_ALARM_M               (0x00000040)
+#define BIT_RTC_STATUS_REG_POWER_UP              (0x007)
+#define BIT_RTC_STATUS_REG_POWER_UP_M            (0x00000080)
+
+/* RTC_INTERRUPTS_REG Fields */
+#define BIT_RTC_INTERRUPTS_REG_EVERY             (0x000)
+#define BIT_RTC_INTERRUPTS_REG_EVERY_M           (0x00000003)
+#define BIT_RTC_INTERRUPTS_REG_IT_TIMER          (0x002)
+#define BIT_RTC_INTERRUPTS_REG_IT_TIMER_M        (0x00000004)
+#define BIT_RTC_INTERRUPTS_REG_IT_ALARM          (0x003)
+#define BIT_RTC_INTERRUPTS_REG_IT_ALARM_M        (0x00000008)
+/* RTC_COMP_LSB_REG Fields */
+#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB        (0x000)
+#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB_M      (0x000000FF)
+/* RTC_COMP_MSB_REG Fields */
+#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB        (0x000)
+#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB_M      (0x000000FF)
+
+/* ALARM_DAYS_REG Fields */
+#define BIT_ALARM_DAYS_REG_ALARM_DAY1            (0x004)
+#define BIT_ALARM_DAYS_REG_ALARM_DAY1_M          (0x00000030)
+/* ALARM_MONTHS_REG Fields */
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0        (0x000)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0_M      (0x0000000F)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1        (0x004)
+#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1_M      (0x00000010)
+/* ALARM_YEARS_REG Fields */
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR0          (0x000)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR0_M        (0x0000000F)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR1          (0x004)
+#define BIT_ALARM_YEARS_REG_ALARM_YEAR1_M        (0x000000F0)
+/* RTC_CTRL_REG Fields */
+#define BIT_RTC_CTRL_REG_STOP_RTC                (0x000)
+#define BIT_RTC_CTRL_REG_STOP_RTC_M              (0x00000001)
+#define BIT_RTC_CTRL_REG_ROUND_30S               (0x001)
+#define BIT_RTC_CTRL_REG_ROUND_30S_M             (0x00000002)
+#define BIT_RTC_CTRL_REG_AUTO_COMP               (0x002)
+#define BIT_RTC_CTRL_REG_AUTO_COMP_M             (0x00000004)
+#define BIT_RTC_CTRL_REG_MODE_12_24              (0x003)
+#define BIT_RTC_CTRL_REG_MODE_12_24_M            (0x00000008)
+#define BIT_RTC_CTRL_REG_TEST_MODE               (0x004)
+#define BIT_RTC_CTRL_REG_TEST_MODE_M             (0x00000010)
+#define BIT_RTC_CTRL_REG_SET_32_COUNTER          (0x005)
+#define BIT_RTC_CTRL_REG_SET_32_COUNTER_M        (0x00000020)
+#define BIT_RTC_CTRL_REG_GET_TIME                (0x006)
+#define BIT_RTC_CTRL_REG_GET_TIME_M              (0x00000040)
+/* RTC_STATUS_REG Fields */
+#define BIT_RTC_STATUS_REG_RUN                   (0x001)
+#define BIT_RTC_STATUS_REG_RUN_M                 (0x00000002)
+#define BIT_RTC_STATUS_REG_1S_EVENT              (0x002)
+#define BIT_RTC_STATUS_REG_1S_EVENT_M            (0x00000004)
+#define BIT_RTC_STATUS_REG_1M_EVENT              (0x003)
+#define BIT_RTC_STATUS_REG_1M_EVENT_M            (0x00000008)
+#define BIT_RTC_STATUS_REG_1H_EVENT              (0x004)
+#define BIT_RTC_STATUS_REG_1H_EVENT_M            (0x00000010)
+#define BIT_RTC_STATUS_REG_1D_EVENT              (0x005)
+#define BIT_RTC_STATUS_REG_1D_EVENT_M            (0x00000020)
+#define BIT_RTC_STATUS_REG_ALARM                 (0x006)
+#define BIT_RTC_STATUS_REG_ALARM_M               (0x00000040)
+#define BIT_RTC_STATUS_REG_POWER_UP              (0x007)
+#define BIT_RTC_STATUS_REG_POWER_UP_M            (0x00000080)
+/* RTC_INTERRUPTS_REG Fields */
+#define BIT_RTC_INTERRUPTS_REG_EVERY             (0x000)
+#define BIT_RTC_INTERRUPTS_REG_EVERY_M           (0x00000003)
+#define BIT_RTC_INTERRUPTS_REG_IT_TIMER          (0x002)
+#define BIT_RTC_INTERRUPTS_REG_IT_TIMER_M        (0x00000004)
+#define BIT_RTC_INTERRUPTS_REG_IT_ALARM          (0x003)
+#define BIT_RTC_INTERRUPTS_REG_IT_ALARM_M        (0x00000008)
+/* RTC_COMP_LSB_REG Fields */
+#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB        (0x000)
+#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB_M      (0x000000FF)
+/* RTC_COMP_MSB_REG Fields */
+#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB        (0x000)
+#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB_M      (0x000000FF)
+
+
+struct twl4030rtc_platform_data {
+        int (*init)(void);
+        void (*exit)(void);
+};
+
+#endif				/* End of __TWL4030_RTC_H__ */
