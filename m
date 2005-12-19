From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] omap24xx spi + touchscreen
Date: Mon, 19 Dec 2005 06:39:48 -0800 (PST)
Message-ID: <20051219143948.46276.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1327825471-1135003188=:44153"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
Cc: sureshr@ti.com
List-Id: linux-omap@vger.kernel.org

--0-1327825471-1135003188=:44153
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached experimental patch for spi driver (driver?) and tsc2101
touchscreen support for 24xx.

Warning:
* No need to integrate this patch to git tree, it is just for
experiments.
* Ported quickly to latest git tree, so no. of bugs are expected from
the spi code.
* I had just tried to play with spi in latest git tree, before starting
for david's spi framework.

Tested touchscreen with tslib utilities
* ts_calibrate - works (cross-hair cursor moves in just one click)
* ts_test - cursor lags behind the stylus position. Decreasing the
conv. delay in tsc2101 might help.

- spi muxing is still not added to muxtable.
- spi code + ts modifications taken from 2.6.9 TI tree.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1327825471-1135003188=:44153
Content-Type: text/plain; name="spi-ts.patch"
Content-Description: 3912312566-spi-ts.patch
Content-Disposition: inline; filename="spi-ts.patch"

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 391070e..950cafe 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -61,6 +61,9 @@ MUX_CFG_24XX("R14_24XX_MCBSP2_FSX",	0x12
 MUX_CFG_24XX("W15_24XX_MCBSP2_DR",	0x126,	1,	1,	0,	1)
 MUX_CFG_24XX("V15_24XX_MCBSP2_DX",	0x127,	1,	1,	0,	1)
 
+/* TSC IRQ */
+MUX_CFG_24XX("P20_24XX_TSC_IRQ",	0x108,	0,	0,	0,	1)
+
 };
 
 int __init omap2_mux_init(void)
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 144f483..8b40316 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -99,7 +99,7 @@ endif
 config TOUCHSCREEN_OMAP
 	tristate "OMAP touchscreen input driver"
 	depends on INPUT && INPUT_TOUCHSCREEN && ARCH_OMAP
-	select OMAP_TSC2101
+#	select OMAP_TSC2101
 	help
 	  Say Y here if you have an OMAP based board with touchscreen
 	  attached to it, e.g. OMAP Innovator, OSK, H2 or H3
diff --git a/drivers/input/touchscreen/omap/Makefile b/drivers/input/touchscreen/omap/Makefile
index 687c068..dd2e502 100644
--- a/drivers/input/touchscreen/omap/Makefile
+++ b/drivers/input/touchscreen/omap/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_TOUCHSCREEN_OMAP) += omapts
 
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_H2) += ts_hx.o
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_H3) += ts_hx.o
+objs-$(CONFIG_ARCH_OMAP24XX)$(CONFIG_MACH_OMAP_H4) += ts_hx.o
 objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += ts_inn1510.o
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_OSK) += ts_osk.o
 
diff --git a/drivers/input/touchscreen/omap/omap_ts.c b/drivers/input/touchscreen/omap/omap_ts.c
index bfc9b59..f422f85 100644
--- a/drivers/input/touchscreen/omap/omap_ts.c
+++ b/drivers/input/touchscreen/omap/omap_ts.c
@@ -39,14 +39,14 @@
 
 #include <asm/mach-types.h>
 
-//#define DEBUG
+/*#define DEBUG*/
 
 #include "omap_ts.h"
 
 #define OMAP_TS_NAME	"omap_ts"
 
 static struct ts_device *__initdata ts_devs[] = {
-#if defined(CONFIG_MACH_OMAP_H2) || defined(CONFIG_MACH_OMAP_H3)
+#if defined(CONFIG_MACH_OMAP_H2) || defined(CONFIG_MACH_OMAP_H3) || defined(CONFIG_MACH_OMAP_H4)
 	&hx_ts,
 #endif
 #ifdef CONFIG_MACH_OMAP_OSK
@@ -65,10 +65,10 @@ static int omap_ts_read(void)
 
 	ts_omap.dev->read(data);
 
-	input_report_abs(&(ts_omap.inputdevice), ABS_X, data[0]);
-	input_report_abs(&(ts_omap.inputdevice), ABS_Y, data[1]);
-	input_report_abs(&(ts_omap.inputdevice), ABS_PRESSURE, data[2]);
-	input_sync(&(ts_omap.inputdevice));
+	input_report_abs(ts_omap.inputdevice, ABS_X, data[0]);
+	input_report_abs(ts_omap.inputdevice, ABS_Y, data[1]);
+	input_report_abs(ts_omap.inputdevice, ABS_PRESSURE, data[2]);
+	input_sync(ts_omap.inputdevice);
 
 	DEBUG_TS("omap_ts_read: read x=%d,y=%d,p=%d\n", data[0], data[1],
 		 data[2]);
@@ -95,12 +95,12 @@ static void omap_ts_timer(unsigned long 
 		if (ts_omap.touched) {
 			DEBUG_TS("omap_ts_timer: pen up\n");
 			ts_omap.touched = 0;
-			input_report_abs(&(ts_omap.inputdevice), ABS_X, 0);
-			input_report_abs(&(ts_omap.inputdevice), ABS_Y, 0);
-			input_report_abs(&(ts_omap.inputdevice), ABS_PRESSURE,
+			input_report_abs(ts_omap.inputdevice, ABS_X, 0);
+			input_report_abs(ts_omap.inputdevice, ABS_Y, 0);
+			input_report_abs(ts_omap.inputdevice, ABS_PRESSURE,
 					 0);
-			input_sync(&(ts_omap.inputdevice));
-			input_report_key(&(ts_omap.inputdevice), BTN_TOUCH, 0);
+			input_sync(ts_omap.inputdevice);
+			input_report_key(ts_omap.inputdevice, BTN_TOUCH, 0);
 		}
 		if (!ts_omap.irq_enabled) {
 			ts_omap.irq_enabled = 1;
@@ -119,6 +119,9 @@ static irqreturn_t omap_ts_handler(int i
 		ts_omap.irq_enabled = 0;
 		disable_irq(irq);
 	}
+	// check for still pending timer, delete it if necessary
+	if (timer_pending(&(ts_omap.ts_timer)))
+		del_timer(&(ts_omap.ts_timer));
 	// restart acquire
 	ts_omap.ts_timer.expires = jiffies + HZ / 100;
 	add_timer(&(ts_omap.ts_timer));
@@ -168,14 +171,14 @@ static int __init omap_ts_probe(struct p
 		return -EINVAL;
 	}
 
-	init_input_dev(&(ts_omap.inputdevice));
-	ts_omap.inputdevice.name = OMAP_TS_NAME;
-	ts_omap.inputdevice.dev = &pdev->dev;
-	ts_omap.inputdevice.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	ts_omap.inputdevice.keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
-	ts_omap.inputdevice.absbit[0] =
+	ts_omap.inputdevice = input_allocate_device();
+	ts_omap.inputdevice->name = OMAP_TS_NAME;
+	ts_omap.inputdevice->dev = &pdev->dev;
+	ts_omap.inputdevice->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	ts_omap.inputdevice->keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
+	ts_omap.inputdevice->absbit[0] =
 	    BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
-	input_register_device(&(ts_omap.inputdevice));
+	input_register_device(ts_omap.inputdevice);
 
 	ts_omap.dev->enable();
 
@@ -187,7 +190,7 @@ static int __init omap_ts_probe(struct p
 static int omap_ts_remove(struct platform_device *pdev)
 {
 	ts_omap.dev->disable();
-	input_unregister_device(&ts_omap.inputdevice);
+	input_unregister_device(ts_omap.inputdevice);
 	if (ts_omap.irq != -1)
 		free_irq(ts_omap.irq, &ts_omap);
 
diff --git a/drivers/input/touchscreen/omap/omap_ts.h b/drivers/input/touchscreen/omap/omap_ts.h
index 718b0c7..1cf4c2e 100644
--- a/drivers/input/touchscreen/omap/omap_ts.h
+++ b/drivers/input/touchscreen/omap/omap_ts.h
@@ -42,7 +42,7 @@ struct ts_device {
 };
 
 struct omap_ts_t{
-	struct input_dev inputdevice;
+	struct input_dev *inputdevice;
 	struct timer_list ts_timer;      // Timer for triggering acquisitions
 	int touched;
 	int irq;
diff --git a/drivers/input/touchscreen/omap/ts_hx.c b/drivers/input/touchscreen/omap/ts_hx.c
index fac78da..13174fe 100644
--- a/drivers/input/touchscreen/omap/ts_hx.c
+++ b/drivers/input/touchscreen/omap/ts_hx.c
@@ -39,6 +39,7 @@
 
 #define	H2_GPIO_NUM		4
 #define	H3_GPIO_NUM		48
+#define	H4_GPIO_NUM		93
 
 #define OMAP_TSC2101_XRES		       500
 #define TOUCHSCREEN_DATA_REGISTERS_PAGE	 0x0
@@ -88,6 +89,9 @@ static int __init hx_ts_probe(struct oma
 	} else if (machine_is_omap_h3()) {
 		gpio = H3_GPIO_NUM;
 		omap_cfg_reg(W19_1610_GPIO48);
+ 	} else if (machine_is_omap_h4()) {
+		gpio = H4_GPIO_NUM;
+		omap_cfg_reg(P20_24XX_TSC_IRQ);
 	} else
 		return -ENODEV;
 
@@ -180,5 +184,7 @@ static void __exit hx_ts_remove(void)
 		omap_free_gpio(H2_GPIO_NUM);
 	else if (machine_is_omap_h3())
 		omap_free_gpio(H3_GPIO_NUM);
+	else if (machine_is_omap_h4())
+		omap_free_gpio(H4_GPIO_NUM);
 }
 #endif
diff --git a/drivers/ssi/Kconfig b/drivers/ssi/Kconfig
index e84f9d2..ba43f72 100644
--- a/drivers/ssi/Kconfig
+++ b/drivers/ssi/Kconfig
@@ -7,6 +7,13 @@ config OMAP_UWIRE
 	  Say Y here if you want support for the MicroWire interface
 	  on an OMAP processor.
 
+config OMAP_SPI
+	depends on ARCH_OMAP2
+	tristate "SPI support on OMAP"
+	---help---
+	  Say Y here if you want support for the SPI
+	  on an OMAP2 processor.
+
 config OMAP_TSC2101
 	depends on ARCH_OMAP1 || ARCH_OMAP24XX
 	tristate "TSC2101 codec support for Touchscreen and audio"
diff --git a/drivers/ssi/Makefile b/drivers/ssi/Makefile
index c63cf2b..ddc9e5e 100644
--- a/drivers/ssi/Makefile
+++ b/drivers/ssi/Makefile
@@ -3,4 +3,5 @@
 #
 
 obj-$(CONFIG_OMAP_UWIRE)        += omap-uwire.o
+obj-$(CONFIG_OMAP_SPI)          += omap-spi.o h4-spi.o
 obj-$(CONFIG_OMAP_TSC2101)      += omap-tsc2101.o
diff --git a/drivers/ssi/h4-spi.c b/drivers/ssi/h4-spi.c
new file mode 100644
index 0000000..8d06882
--- /dev/null
+++ b/drivers/ssi/h4-spi.c
@@ -0,0 +1,182 @@
+/*
+ *  SPI control code for OMAP24xx based custom board (TSUNAMI)
+ *  
+ *  Copyright 2005 Komal Shah
+ *  Design derived from Corgi (Richard Purdie)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  License: GPL v2.0
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <asm/hardware.h>
+#include <linux/smp_lock.h>
+
+#include "omap-spi.h"
+#include "h4-spi.h"
+
+#define STARTADDRESS(n)		((n)<<5)
+
+struct spi_channel_config spi1_ch_config[] = {
+    [0] = {	/* TSC2101 - Touchscreen + Audio*/
+		.mode = MCSPI_MODULCTRL_MASTER,
+		.endianess = MCSPI_MODULCTRL_LITTLEEND,
+		.transmitreceive = MCSPI_CHCONF_TRANSRECEIVE,
+		.wordlength = MCSPI_CHCONF_WL32,
+		.spipolarity = MCSPI_CHCONF_EPOL_LOW,
+		.clkphase = MCSPI_CHCONF_PHA_EVEN,
+		.clkpolarity = MCSPI_CHCONF_POL_HIGH,
+		.clkdivisor = MCSPI_CHCONF_CLKD_8
+	  },
+};
+
+static spinlock_t spi1_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t spi2_lock = SPIN_LOCK_UNLOCKED;
+
+struct spi_dev h4_spi_dev[2];
+
+int omap_tsc2101_enable()
+{
+    	spin_lock(&spi1_lock);
+	/* Nothing yet */
+    	spin_unlock(&spi1_lock);
+	return 0;
+}
+void omap_tsc2101_disable()
+{
+    	spin_lock(&spi1_lock);
+	/* Nothing yet */
+    	spin_unlock(&spi1_lock);
+}
+
+void omap_tsc2101_reads(int page, u8 add, u16 *data, int nregs)
+{
+	int i;
+	u32 tmp;
+
+	tmp = (page << 11);
+	spi_enablech(&h4_spi_dev[0],SPI0);
+	/* write command word */
+	for (i = 0; i < nregs; i++) {
+		tmp = tmp | (STARTADDRESS(add + i));
+		tmp = tmp << 16;
+		tmp |= 0x80000000;
+		spi_write(&h4_spi_dev[0], SPI0, tmp);
+		(*data) = spi_read(&h4_spi_dev[0], SPI0) & 0x0000FFFF;
+		data++;
+	}
+	spi_disablech(&h4_spi_dev[0], SPI0);
+}
+
+u16 omap_tsc2101_read(int page, u8 address)
+{	
+    	u16 ret;
+	omap_tsc2101_reads(page, address, &ret, 1);
+	return ret;
+}
+
+void omap_tsc2101_write(int page, u8 address, u16 data)
+{	
+	u32 tmp;
+
+	tmp = (page << 11) | (address << 5);
+	tmp <<= 16;
+	tmp |= data;
+	spi_enablech(&h4_spi_dev[0], SPI0);
+	spi_write(&h4_spi_dev[0], SPI0, tmp);
+	spi_disablech(&h4_spi_dev[0], SPI0);
+}
+
+
+int __init h4_spi_probe(struct device *dev)
+{
+	int ret = 1;
+	int channel;
+
+	ret = spi_init(&h4_spi_dev[0], SPI_MOD_1);
+	if (ret)
+	    printk(KERN_ERR "Unable to register SPI hander!\n");
+	else {
+	    	channel = SPI0;
+	   	spi_configch(&h4_spi_dev[0], channel, &spi1_ch_config[0]);
+	}
+	
+	return ret;
+}
+static int __exit h4_spi_remove(struct device *dev)
+{
+    	spi_exit(&h4_spi_dev[0]);
+
+	return 0;
+}
+static int h4_spi_suspend(struct device *dev, u32 state, u32 level)
+{
+	return 0;
+}
+static int h4_spi_resume(struct device *dev, u32 level)
+{
+	return 0;
+}
+static void omap_spi_device_release(struct device *dev)
+{
+	/* Nothing */
+}
+
+static struct device_driver h4_spi_driver = {
+	.name		= "h4-spi",
+	.bus		= &platform_bus_type,
+	.probe		= h4_spi_probe,
+	.remove		= __exit_p(h4_spi_remove),
+	.suspend	= h4_spi_suspend,
+	.resume		= h4_spi_resume,
+};
+
+static struct platform_device h4_spi_device = {
+	.name 		= "h4-spi",
+	.id 		= -1,
+	.dev = {
+		.release 	= omap_spi_device_release,
+	},
+};
+
+static int __init h4_spi_init(void)
+{
+    	int ret;
+	ret = platform_device_register(&h4_spi_device);
+	if (ret != 0)
+		return -ENODEV;
+
+	ret = driver_register(&h4_spi_driver);
+	if (ret != 0) {
+		platform_device_unregister(&h4_spi_device);
+		return -ENODEV;
+	}
+	return ret;
+}
+static void __exit h4_spi_exit(void)
+{
+	driver_unregister(&h4_spi_driver);
+	platform_device_unregister(&h4_spi_device);
+}
+
+module_init(h4_spi_init);
+module_exit(h4_spi_exit);
+
+EXPORT_SYMBOL(omap_tsc2101_enable);
+EXPORT_SYMBOL(omap_tsc2101_disable);
+EXPORT_SYMBOL(omap_tsc2101_read);
+EXPORT_SYMBOL(omap_tsc2101_reads);
+EXPORT_SYMBOL(omap_tsc2101_write);
+
+MODULE_AUTHOR("Komal Shah");
+MODULE_LICENSE("GPL");
diff --git a/drivers/ssi/h4-spi.h b/drivers/ssi/h4-spi.h
new file mode 100644
index 0000000..3938809
--- /dev/null
+++ b/drivers/ssi/h4-spi.h
@@ -0,0 +1,11 @@
+#ifndef H4_SPI_H
+#define H4_SPI_H
+
+extern int omap_tsc2101_enable();
+extern void omap_tsc2101_disable();
+extern u16 omap_tsc2101_read(int page, u8 address);
+extern void omap_tsc2101_write(int page, u8 address, u16 data);
+extern void omap_tsc2101_reads(int page, u8 add, u16 *data, int
+				 nregs);
+
+#endif
diff --git a/drivers/ssi/omap-spi.c b/drivers/ssi/omap-spi.c
new file mode 100644
index 0000000..f30db36
--- /dev/null
+++ b/drivers/ssi/omap-spi.c
@@ -0,0 +1,503 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ *
+ *	SPI interface driver for the OMAP24XX Platform
+ *
+ * Copyright 2004 Texas Instruments Inc.
+ * Author: Suresh Reddy.
+ *	   sureshr@ti.com
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
+ *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
+ *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *  History:
+ *  ----------
+ *  2004-10-20 Nishanth Menon - removed wrongly used status variable
+ *  				 channel configured
+ */
+
+/* 
+ *  OMAP24xx has two SPI modules.SPI1 supports upto 4 channels and SPI2 
+ *  supports upto 2 channels. Macros are provided in spi.h for module
+ *  and channel numbers. 
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/device.h>
+#include <linux/err.h>
+
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/hardware.h>
+#include <asm/hardware/clock.h>
+#include <asm/io.h>
+
+#include "omap-spi.h"
+
+#define OMAP24XX_SPI_MODULES 2
+
+struct spi_dev *saved_dev[2];
+
+static DECLARE_MUTEX(sem);
+static int init_count[OMAP24XX_SPI_MODULES] = {0, 0};
+static int spi1_ch[4] = {0, 0, 0, 0};
+static int spi2_ch[2] = {0, 0};
+static int *ch_count[2] = {spi1_ch, spi2_ch};
+
+void omap24xx_spi_module_exit(void);
+
+#define SPI_NAME "spi-omap24xx"
+#define NUM_SPI_ADAP 2
+
+/*--------Debug prints--------------*/
+#undef TEST_MCSPI
+//#define TEST_MCSPI
+#ifdef TEST_MCSPI
+#define DPRINTK(fmt, args...) printk(KERN_INFO "\n  %s: %s: " fmt,__FILE__,__FUNCTION__ , ## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+/*----------------------------------*/
+
+static __inline__ u32 spi_reg_in(struct spi_dev *dev,
+				 u32 offset)
+{
+	return readl(dev->mmio_base + offset);
+}
+static __inline__ u32 spi_reg_out(struct spi_dev *dev,
+				  u32 offset, u32 val)
+{
+	return writel(val, dev->mmio_base + offset);
+}
+
+static int
+wait_for_status(struct spi_dev *dev, unsigned long offset,
+		unsigned long mask, unsigned long timeout_ticks)
+{
+
+    	unsigned long timeout;
+    
+	/* wait for reset to complete */
+	timeout = jiffies + timeout_ticks;
+	while (!((spi_reg_in(dev, offset) & mask))
+		&& time_before(jiffies, timeout))
+	{
+		if (!in_interrupt()) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(1);
+		} else
+			udelay(10);
+	}
+	if (!(spi_reg_in(dev, offset) & mask))
+	{
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+int spi_init(struct spi_dev *dev, u32 module)
+{
+    	if(module > OMAP24XX_SPI_MODULES || module == 0)
+	    return -ENODEV;
+
+	down(&sem);
+	if(init_count[module - 1]) {
+	    up(&sem);
+	    return -EBUSY;
+	}
+	init_count[module - 1]++;
+
+	dev->mmio_base_phys = saved_dev[module - 1]->mmio_base_phys;
+	dev->mmio_base = saved_dev[module - 1]->mmio_base;
+	dev->mmio_size = saved_dev[module - 1]->mmio_size;
+	dev->module = module;
+	
+	spi_reg_out(dev, MCSPI_SYSCONFIG,
+		    spi_reg_in(dev,
+			       MCSPI_SYSCONFIG) |
+		    MCSPI_SYSCONFIG_SOFTRESET_START );
+	
+	if (wait_for_status(dev, MCSPI_SYSSTATUS, MCSPI_SYSSTATUS_RESET_DONE,
+			    HZ/5)){
+		printk(KERN_WARNING SPI_NAME ": timeout waiting for SPI-%d to"
+			       "reset\n", module);
+		init_count[module - 1]--;
+		up(&sem);
+		return -ETIMEDOUT;
+	}
+	up(&sem);
+	
+	return 0;	
+}
+int spi_exit(struct spi_dev *dev)
+{
+	down(&sem);
+	init_count[dev->module - 1]--;
+	up(&sem);
+
+	return 0;
+}
+
+int spi_configch(struct spi_dev *dev, int channel, struct spi_channel_config *config)
+{
+	unsigned long offset;
+	unsigned int chconfig = 0x0;
+
+	if((dev->module == 1) && (channel >= 4)){
+		return -ENODEV;
+	}
+
+	if((dev->module == 2) && (channel >= 1)){
+		return -ENODEV;
+	}
+
+	offset = MCSPI_CHCONF + (channel * CHANNEL_OFFSET);	
+	
+	
+	if (!init_count[dev->module - 1]) {
+		printk(KERN_INFO " SPI-%d not initialised \n", dev->module);
+		return -1;
+	}
+	
+	DPRINTK("configuring the channel %d\n", channel);
+	
+	/* clear all regs */
+	spi_reg_out(dev, MCSPI_MODULCTRL, 0);
+	spi_reg_out(dev, offset, 0);
+
+	/* configure SPI mode control */
+	spi_reg_out(dev, MCSPI_MODULCTRL, config->mode | config->endianess);
+
+	/* configure SPI as receive/transmit */
+	if (config->mode == MASTER) {
+	    
+	    chconfig |= MCSPI_CHCONF_IS_DL0RECEIVE | MCSPI_CHCONF_DPE1_TRANSMIT
+			| MCSPI_CHCONF_DPE0_NO_TRANSMIT;
+		
+	} else {
+	    chconfig |= MCSPI_CHCONF_IS_DL1RECEIVE | MCSPI_CHCONF_DPE0_TRANSMIT;
+	}
+
+	chconfig |= config->transmitreceive | config->wordlength |
+		   config->spipolarity | config->clkphase 	|
+		   config->clkpolarity | config->clkdivisor;
+	    	    	
+	spi_reg_out(dev, offset, chconfig);	    
+
+#ifdef TEST_MCSPI	
+	printk(" MCSPI_CHCONF 0x%x\n", spi_reg_in(dev, offset));
+	printk(" MCSPI_MODULCTRL 0x%x\n", spi_reg_in(dev, MCSPI_MODULCTRL));
+#endif
+
+	return 0;
+}
+
+int spi_enablech(struct spi_dev *dev, int channel)
+{
+	unsigned long offset = MCSPI_CHCTRL + (channel * CHANNEL_OFFSET);
+
+	if((dev->module == 1) && (channel >= 4)){
+		return -ENODEV;
+	}
+	
+	if((dev->module == 2) && (channel >= 1)){
+		return -ENODEV;
+	}
+
+	down(&sem);	
+	if(ch_count[dev->module - 1][channel]) {
+		up(&sem);
+		return -EBUSY;
+	}
+	
+	spi_reg_out(dev, offset,
+		    spi_reg_in(dev, offset) |
+		    MCSPI_CHCTRL_ACTIVE);
+	ch_count[dev->module - 1][channel]++;
+	up(&sem);
+	return 0;
+}
+
+int spi_disablech(struct spi_dev *dev, int channel)
+{
+	unsigned long offset;
+	
+	if((dev->module == 1) && (channel >= 4)){
+		return -ENODEV;
+	}
+	
+	if((dev->module == 2) && (channel >= 1)){
+		return -ENODEV;
+	}
+
+	down(&sem);
+
+	offset =  MCSPI_CHSTAT + (channel * CHANNEL_OFFSET);
+
+	if(wait_for_status(dev, offset, MCSPI_CHSTAT_EOT_DONE, HZ/5)){
+		printk(KERN_WARNING SPI_NAME 
+		       ": timeout waiting for EOT on channel %d\n",
+		       channel);
+		up(&sem);
+		return -ETIMEDOUT;
+	}
+
+	offset =  MCSPI_CHCTRL + (channel * CHANNEL_OFFSET);
+	spi_reg_out(dev, offset,
+		    spi_reg_in(dev, offset) &
+		    MCSPI_CHCTRL_NOTACTIVE);
+	ch_count[dev->module -1][channel]--;
+	
+	up(&sem);
+	return 0;
+}
+
+int spi_write(struct spi_dev *dev, int channel, u32 data)
+{
+	unsigned long offset;
+
+	if((dev->module == 1) && (channel >= 4)){
+		return -ENODEV;
+	}
+	
+	if((dev->module == 2) && (channel >= 1)){
+		return -ENODEV;
+	}
+	
+	offset = MCSPI_CHSTAT + (channel * CHANNEL_OFFSET);
+		
+	/* write data */
+	if(wait_for_status(dev, offset, MCSPI_CHSTAT_TXS_EMPTY,
+			   HZ/5)){
+	    printk(KERN_WARNING SPI_NAME
+		   ": timeout waiting for transmit register to empty\n");
+	    return -ETIMEDOUT;
+	}
+	spi_reg_out(dev, MCSPI_TX + (channel * CHANNEL_OFFSET), data);
+	
+	return 0;
+}
+
+u32 spi_read(struct spi_dev *dev, int channel)
+{     
+	unsigned long offset;
+    
+	if((dev->module == 1) && (channel >= 4)){
+		return -ENODEV;
+	}
+	
+	if((dev->module == 2) && (channel >= 1)){
+		return -ENODEV;
+	}
+
+	offset = MCSPI_CHSTAT + (channel * CHANNEL_OFFSET);
+	
+	udelay(10);
+	if(wait_for_status(dev, offset, MCSPI_CHSTAT_RXS_FULL,
+			   HZ/5)){
+    		printk(KERN_WARNING SPI_NAME
+		       ": timeout waiting for receiver register to empty\n");
+		return -ETIMEDOUT;
+	}
+
+	return spi_reg_in(dev,
+			  MCSPI_RX + (channel * CHANNEL_OFFSET));
+}
+
+u32 spi_putget(struct spi_dev *dev, int channel, u32 data)
+{
+	unsigned long offset;
+	u32 val;
+	
+	if((dev->module == 1) && (channel >= 4)){
+		return -ENODEV;
+	}
+	
+	if((dev->module == 2) && (channel >= 1)){
+		return -ENODEV;
+	}
+
+	offset = MCSPI_CHSTAT + (channel * CHANNEL_OFFSET);
+
+	if(wait_for_status(dev, offset, MCSPI_CHSTAT_TXS_EMPTY,
+			   HZ/5)){
+	    printk(KERN_WARNING SPI_NAME
+		   ": timeout waiting for transmit register to empty\n");
+	    return -ETIMEDOUT;
+	}
+	spi_reg_out(dev, MCSPI_TX + (channel * CHANNEL_OFFSET),
+			    data);
+	udelay(10);
+	
+	/*Error: Can't check CHSTAT_RXS_EMPTY as it is of 0 value*/
+	if(wait_for_status(dev, offset, MCSPI_CHSTAT_RXS_FULL,
+			   HZ/5)){
+    		printk(KERN_WARNING SPI_NAME
+		       ": timeout waiting for receiver register to empty\n");
+		return -ETIMEDOUT;
+	}
+	val = spi_reg_in(dev, MCSPI_RX + (channel * CHANNEL_OFFSET));
+	return val;
+}
+
+void 
+omap24xx_spi_module_exit(void)
+{
+	struct spi_dev *dev;
+	int i;
+
+	for (i = NUM_SPI_ADAP - 1; i >= 0; i--) {
+		dev = saved_dev[i];
+		if (!dev)
+			continue;
+		if (dev->mmio_base) {
+			iounmap((void *)dev->mmio_base);
+			dev->mmio_base = 0;
+		}
+		if (dev->mmio_base_phys) {
+			release_mem_region(dev->mmio_base_phys, 
+				dev->mmio_size);
+			dev->mmio_base_phys = 0;
+		}
+		kfree(dev);
+		saved_dev[i] = NULL;
+	}
+}
+
+static struct clk * mcspi1_ick = NULL;
+static struct clk * mcspi1_fck = NULL;
+static struct clk * mcspi2_ick = NULL;
+static struct clk * mcspi2_fck = NULL;
+
+int __init 
+omap24xx_spi_module_init(void)
+{	
+	struct spi_dev *dev;
+	u32 reg_val;
+	int i;
+
+	const static unsigned long reg_addr[] = 
+		{ OMAP24xx_SPI1_BASE, OMAP24xx_SPI2_BASE };
+	const static unsigned long reg_size[] = 
+		{ OMAP24xx_SPI1_SIZE, OMAP24xx_SPI2_SIZE };
+	const static char *spi_name[] = { SPI_NAME "-1", SPI_NAME "-2" };
+
+	if (cpu_is_omap2420())
+    	{
+		mcspi1_ick = clk_get(NULL, "mcspi1_ick");
+		if (IS_ERR(mcspi1_ick))
+			printk("Could not get mcspi1_ick\n");
+		else {
+			clk_use(mcspi1_ick);
+		}
+
+		mcspi1_fck = clk_get(NULL, "mcspi1_fck");
+		if (IS_ERR(mcspi1_fck))
+			printk("Could not get mcspi1_fck\n");
+		else {
+			clk_use(mcspi1_fck);
+		}
+		mcspi2_ick = clk_get(NULL, "mcspi2_ick");
+		if (IS_ERR(mcspi2_ick))
+			printk("Could not get mcspi2_ick\n");
+		else {
+			clk_use(mcspi2_ick);
+		}
+
+		mcspi2_fck = clk_get(NULL, "mcspi2_fck");
+		if (IS_ERR(mcspi2_fck))
+			printk("Could not get mcspi2_fck\n");
+		else {
+			clk_use(mcspi2_fck);
+		}
+	}	    
+
+	/* initialize each I2C controller */
+	for (i = 0; i < NUM_SPI_ADAP; i++) {
+		dev = kmalloc(sizeof(struct spi_dev), 
+				GFP_KERNEL);
+		if (!dev) {
+			printk(KERN_ERR SPI_NAME 
+				": could not allocate memory\n");
+			goto init_error;
+		}
+		memset(dev, 0, sizeof(struct spi_dev));
+		saved_dev[i] = dev;
+
+		/* request the mem region */
+		if (!request_mem_region(reg_addr[i], reg_size[i], 
+			spi_name[i]))
+		{
+			printk(KERN_ERR "%s: cannot reserve MMIO region\n", 
+				spi_name[i]);
+			goto init_error;
+		}
+		dev->mmio_base_phys = reg_addr[i];
+		dev->mmio_size = reg_size[i];
+
+		/* map the region */
+		dev->mmio_base = (unsigned long) 
+			ioremap(dev->mmio_base_phys, dev->mmio_size);
+		if (!dev->mmio_base) {
+			printk(KERN_ERR "%s: cannot map MMIO\n", 
+				spi_name[i]);
+			goto init_error;
+		}
+		printk(KERN_INFO "%s: SPI bus controller at 0x%08lx \n",
+			spi_name[i], dev->mmio_base_phys);
+		
+	}
+	return 0;
+init_error:
+	/* call our exit routine to cleanup */
+	omap24xx_spi_module_exit();
+	for (i = 0; i < NUM_SPI_ADAP; i++) {
+		printk(KERN_ERR "%s: SPI driver installation failed!\n", 
+			spi_name[i]);
+	}
+	return -ENODEV;
+}
+
+arch_initcall(omap24xx_spi_module_init);
+
+#ifdef MODULE
+module_exit(omap24xx_spi_module_exit);
+#endif
+
+EXPORT_SYMBOL(spi_putget);
+EXPORT_SYMBOL(spi_configch);
+EXPORT_SYMBOL(spi_enablech);
+EXPORT_SYMBOL(spi_disablech);
+EXPORT_SYMBOL(spi_write);
+EXPORT_SYMBOL(spi_read);
+EXPORT_SYMBOL(spi_init);
+EXPORT_SYMBOL(spi_exit);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("OMAP24xx SPI Driver");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/ssi/omap-spi.h b/drivers/ssi/omap-spi.h
new file mode 100644
index 0000000..7c6e38e
--- /dev/null
+++ b/drivers/ssi/omap-spi.h
@@ -0,0 +1,274 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ *
+ *	SPI interface driver for the OMAP24XX Platform
+ *
+ * Copyright 2004 Texas Instruments Inc.
+ * Author: Suresh Reddy.
+ *	   sureshr@ti.com
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
+ *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
+ *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef OMAP24XX_SPI_H
+#define OMAP24XX_SPI_H
+
+/* SPI1 Register Definitions */
+#define	OMAP24xx_SPI1_BASE	0x48098000
+#define OMAP24xx_SPI1_SIZE	0x00001000
+
+#define	OMAP24xx_SPI2_BASE	0x4809A000
+#define OMAP24xx_SPI2_SIZE	0x00001000
+
+/* offsets of SPI Registers */
+#define	MCSPI_REVISION		0x00
+#define	MCSPI_SYSCONFIG		0x10
+#define MCSPI_SYSSTATUS		0x14
+#define	MCSPI_IRQSTATUS		0x18
+#define MCSPI_IRQENABLE		0x1C
+#define	MCSPI_SYST		0x24
+#define MCSPI_MODULCTRL		0x28
+#define MCSPI_CHCONF0		0x2C
+#define MCSPI_CHSTAT0		0x30
+
+#define MCSPI_CHCTRL0		0x34
+#define MCSPI_TX0		0x38
+#define MCSPI_RX0		0x3C
+#define MCSPI_CHCONF1		0x40
+#define MCSPI_CHSTAT1		0x44
+#define MCSPI_CHCTRL1		0x48
+#define MCSPI_TX1		0x4C
+#define MCSPI_RX1		0x50
+
+/* offsets of registers which are specific to SPI1 */
+
+#define MCSPI_CHCONF2		0x54
+#define MCSPI_CHSTAT2		0x58
+#define MCSPI_CHCTRL2		0x5C
+#define MCSPI_TX2		0x60
+#define MCSPI_RX2		0x64
+#define MCSPI_CHCONF3		0x68
+#define MCSPI_CHSTAT3		0x6C
+#define MCSPI_CHCTRL3		0x70
+#define MCSPI_TX3		0x74
+#define MCSPI_RX3		0x78
+
+/* define bitfeilds in selected registers */
+#define MCSPI_SYSCONFIG_FCLKON_OCPCLKOFF	(1 << 8)
+#define MCSPI_SYSCONFIG_FCLKOFF_OCPCLKON	(2 << 8)
+#define MCSPI_SYSCONFIG_FCLKOFF_OCPCLKOFF	(3 << 8)
+#define MCSPI_SYSCONFIG_ENAWAKEUP_ENABLE	(1 << 2)
+#define MCSPI_SYSCONFIG_ENAWAKEUP_DISABLE	(0 << 2)
+#define MCSPI_SYSCONFIG_SOFTRESET_START		(1 << 1)
+
+#define MCSPI_SYSSTATUS_RESET_DONE		(1 << 0)
+
+#define MCSPI_IRQSTATUS_WKS_PENDING		(1 << 16)
+#define MCSPI_IRQSTATUS_WKS_RESET		(1 << 16)
+#define MCSPI_IRQSTATUS_RX3FULL			(1 << 14)
+#define MCSPI_IRQSTATUS_RX3FULL_CLEAR		(1 << 14)
+#define MCSPI_IRQSTATUS_TX3UNDERFLOW		(1 << 13)
+#define MCSPI_IRQSTATUS_TX3UNDERFLOW_CLEAR	(1 << 13)
+#define MCSPI_IRQSTATUS_TX3EMPTY		(1 << 12)
+#define MCSPI_IRQSTATUS_TX3EMPTY_CLEAR		(1 << 12)
+#define MCSPI_IRQSTATUS_RX2FULL			(1 << 10)
+#define MCSPI_IRQSTATUS_RX2FULL_CLEAR		(1 << 10)
+#define MCSPI_IRQSTATUS_TX2UNDERFLOW		(1 << 9)
+#define MCSPI_IRQSTATUS_TX2UNDERFLOW_CLEAR	(1 << 9)
+#define MCSPI_IRQSTATUS_TX2EMPTY		(1 << 8)
+#define MCSPI_IRQSTATUS_TX2EMPTY_CLEAR		(1 << 8)
+#define MCSPI_IRQSTATUS_RX1FULL			(1 << 6)
+#define MCSPI_IRQSTATUS_RX1FULL_CLEAR		(1 << 6)
+#define MCSPI_IRQSTATUS_TX1UNDERFLOW		(1 << 5)
+#define MCSPI_IRQSTATUS_TX1UNDERFLOW_CLEAR	(1 << 5)
+#define MCSPI_IRQSTATUS_TX1EMPTY		(1 << 4)
+#define MCSPI_IRQSTATUS_TX1EMPTY_CLEAR		(1 << 4)
+#define MCSPI_IRQSTATUS_RX0OVERFLOW		(1 << 3)
+#define MCSPI_IRQSTATUS_RX0OVERFLOW_CLEAR	(1 << 3)
+#define MCSPI_IRQSTATUS_RX0FULL			(1 << 2)
+#define MCSPI_IRQSTATUS_RX0FULL_CLEAR		(1 << 2)
+#define MCSPI_IRQSTATUS_TX0UNDERFLOW		(1 << 1)
+#define MCSPI_IRQSTATUS_TX0UNDERFLOW_CLEAR	(1 << 1)
+#define MCSPI_IRQSTATUS_TX0EMPTY		(1 << 0)
+#define MCSPI_IRQSTATUS_TX0EMPTY_CLEAR		(1 << 0)
+
+#define MCSPI_IRQENABLE_WKE_ENABLE		(1 << 16)
+#define MCSPI_IRQENABLE_WKE_DISABLE		(0 << 16)
+#define MCSPI_IRQENABLE_RX3FULL_ENABLE		(1 << 14)
+#define MCSPI_IRQENABLE_RX3FULL_DISABLE		(0 << 14)
+#define MCSPI_IRQENABLE_TX3UNDERFLOW_ENABLE	(1 << 13)
+#define MCSPI_IRQENABLE_TX3UNDERFLOW_DISABLE	(0 << 13)
+#define MCSPI_IRQENABLE_TX3EMPTY_ENABLE 	(1 << 12)
+#define MCSPI_IRQENABLE_TX3EMPTY_DISABLE	(0 << 12)
+#define MCSPI_IRQENABLE_RX2FULL_ENABLE		(1 << 10)
+#define MCSPI_IRQENABLE_RX2FULL_DISABLE		(0 << 10)
+#define MCSPI_IRQENABLE_TX2UNDERFLOW_ENABLE	(1 << 9)
+#define MCSPI_IRQENABLE_TX2UNDERFLOW_DISABLE	(0 << 9)
+#define MCSPI_IRQENABLE_TX2EMPTY_ENABLE 	(1 << 8)
+#define MCSPI_IRQENABLE_TX2EMPTY_DISABLE	(0 << 8)
+#define MCSPI_IRQENABLE_RX1FULL_ENABLE		(1 << 6)
+#define MCSPI_IRQENABLE_RX1FULL_DISABLE		(0 << 6)
+#define MCSPI_IRQENABLE_TX1UNDERFLOW_ENABLE	(1 << 5)
+#define MCSPI_IRQENABLE_TX1UNDERFLOW_DISABLE	(0 << 5)
+#define MCSPI_IRQENABLE_TX1EMPTY_ENABLE 	(1 << 4)
+#define MCSPI_IRQENABLE_TX1EMPTY_DISABLE	(0 << 4)
+#define MCSPI_IRQENABLE_RX0OVERFLOW_ENABLE	(1 << 3)
+#define MCSPI_IRQENABLE_RX0OVERFLOW_DISABLE	(0 << 3)
+#define MCSPI_IRQENABLE_RX0FULL_ENABLE		(1 << 2)
+#define MCSPI_IRQENABLE_RX0FULL_DISABLE		(0 << 2)
+#define MCSPI_IRQENABLE_TX0UNDERFLOW_ENABLE	(1 << 1)
+#define MCSPI_IRQENABLE_TX0UNDERFLOW_DISABLE	(0 << 1)
+#define MCSPI_IRQENABLE_TX0EMPTY_ENABLE 	(1 << 0)
+#define MCSPI_IRQENABLE_TX0EMPTY_DISABLE	(0 << 0)
+
+#define MCSPI_MODULCTRL_SYSTEST_DISABLE		(0 << 3)
+#define MCSPI_MODULCTRL_SYSTEST_ENABLE		(1 << 3)
+#define MCSPI_MODULCTRL_MASTER			(0 << 2)
+#define MCSPI_MODULCTRL_SLAVE			(1 << 2)
+#define MCSPI_MODULCTRL_LITTLEEND		(0 << 1)
+#define MCSPI_MODULCTRL_BIGEND			(1 << 1)
+
+#define MCSPI_CHCONF_SPIENSLV_CS0		(0 << 19)
+#define MCSPI_CHCONF_SPIENSLV_CS1		(1 << 19)
+#define MCSPI_CHCONF_SPIENSLV_CS2		(2 << 19)
+#define MCSPI_CHCONF_SPIENSLV_CS3		(3 << 19)
+#define MCSPI_CHCONF_IS_DL0RECEIVE		(0 << 18)
+#define MCSPI_CHCONF_IS_DL1RECEIVE		(1 << 18)
+#define MCSPI_CHCONF_DPE1_TRANSMIT		(0 << 17)
+#define MCSPI_CHCONF_DPE1_NO_TRANSMIT		(1 << 17)
+#define MCSPI_CHCONF_DPE0_TRANSMIT		(0 << 16)
+#define MCSPI_CHCONF_DPE0_NO_TRANSMIT		(1 << 16)
+#define MCSPI_CHCONF_DMAR_DISABLE		(0 << 15)
+#define MCSPI_CHCONF_DMAR_ENABLE		(1 << 15)
+#define MCSPI_CHCONF_DMAW_DISABLE		(0 << 14)
+#define MCSPI_CHCONF_DMAW_ENABLE		(1 << 14)
+#define MCSPI_CHCONF_TRANSRECEIVE		(0 << 12)
+#define MCSPI_CHCONF_RECEIVEONLY		(1 << 12)
+#define MCSPI_CHCONF_TRANSONLY			(2 << 12)
+#define MCSPI_CHCONF_WL4			(3 << 7)
+#define MCSPI_CHCONF_WL5			(4 << 7)
+#define MCSPI_CHCONF_WL6			(5 << 7)
+#define MCSPI_CHCONF_WL7			(6 << 7)
+#define MCSPI_CHCONF_WL8			(7 << 7)
+#define MCSPI_CHCONF_WL9			(8 << 7)
+#define MCSPI_CHCONF_WL10			(9 << 7)
+#define MCSPI_CHCONF_WL11			(10 << 7)
+#define MCSPI_CHCONF_WL12			(11 << 7)
+#define MCSPI_CHCONF_WL13			(12 << 7)
+#define MCSPI_CHCONF_WL14			(13 << 7)
+#define MCSPI_CHCONF_WL15			(14 << 7)
+#define MCSPI_CHCONF_WL16			(15 << 7)
+#define MCSPI_CHCONF_WL17			(16 << 7)
+#define MCSPI_CHCONF_WL18			(17 << 7)
+#define MCSPI_CHCONF_WL19			(18 << 7)
+#define MCSPI_CHCONF_WL20			(19 << 7)
+#define MCSPI_CHCONF_WL21			(20 << 7)
+#define MCSPI_CHCONF_WL22			(21 << 7)
+#define MCSPI_CHCONF_WL23			(22 << 7)
+#define MCSPI_CHCONF_WL24			(23 << 7)
+#define MCSPI_CHCONF_WL25			(24 << 7)
+#define MCSPI_CHCONF_WL26			(25 << 7)
+#define MCSPI_CHCONF_WL27			(26 << 7)
+#define MCSPI_CHCONF_WL28			(27 << 7)
+#define MCSPI_CHCONF_WL29			(28 << 7)
+#define MCSPI_CHCONF_WL30			(29 << 7)
+#define MCSPI_CHCONF_WL31			(30 << 7)
+#define MCSPI_CHCONF_WL32			(31 << 7)
+#define MCSPI_CHCONF_EPOL_HIGH			(0 << 6)
+#define MCSPI_CHCONF_EPOL_LOW			(1 << 6)
+#define MCSPI_CHCONF_CLKD_1			(0 << 2)
+#define MCSPI_CHCONF_CLKD_2			(1 << 2)
+#define MCSPI_CHCONF_CLKD_4			(2 << 2)
+#define MCSPI_CHCONF_CLKD_8			(3 << 2)
+#define MCSPI_CHCONF_CLKD_16			(4 << 2)
+#define MCSPI_CHCONF_CLKD_32			(5 << 2)
+#define MCSPI_CHCONF_CLKD_64			(6 << 2)
+#define MCSPI_CHCONF_CLKD_128			(7 << 2)
+#define MCSPI_CHCONF_CLKD_256			(8 << 2)
+#define MCSPI_CHCONF_CLKD_512			(9 << 2)
+#define MCSPI_CHCONF_CLKD_1024			(10 << 2)
+#define MCSPI_CHCONF_CLKD_2048			(11 << 2)
+#define MCSPI_CHCONF_CLKD_4096			(12 << 2)
+#define MCSPI_CHCONF_CLKD_8192			(13 << 2)
+#define MCSPI_CHCONF_CLKD_16384			(14 << 2)
+#define MCSPI_CHCONF_CLKD_32768			(15 << 2)
+#define MCSPI_CHCONF_POL_HIGH			(0 << 1)
+#define MCSPI_CHCONF_POL_LOW			(1 << 1)
+#define MCSPI_CHCONF_PHA_ODD			(0 << 0)
+#define MCSPI_CHCONF_PHA_EVEN			(1 << 0)
+
+#define MCSPI_CHSTAT_TXS_FULL			(0 << 1)
+#define MCSPI_CHSTAT_TXS_EMPTY			(1 << 1)
+#define MCSPI_CHSTAT_RXS_EMPTY			(0 << 0)
+#define MCSPI_CHSTAT_RXS_FULL			(1 << 0)
+#define MCSPI_CHSTAT_EOT_DONE			(1 << 2)
+
+#define MCSPI_CHCTRL_ACTIVE			(1 << 0)
+#define MCSPI_CHCTRL_NOTACTIVE			(0 << 0)
+
+#define MCSPI_CHCONF		0x2C
+#define MCSPI_CHSTAT		0x30
+#define MCSPI_CHCTRL		0x34
+#define MCSPI_TX		0x38
+#define MCSPI_RX		0x3C
+
+struct spi_channel_config {
+	u32 mode;		/* MAster/Slave */
+	u32 endianess;		/* Little/Big */
+	u32 transmitreceive;	/*Receive/transmit/both */
+	u32 wordlength;		/* Length of the word to be transmitted */
+	u32 spipolarity;	/* Polaroty of SPIEN */
+	u32 clkphase;		/* clock phase */
+	u32 clkpolarity;	/* clock polaroty */
+	u32 clkdivisor;		/* clock divisor */
+};
+struct spi_dev {
+	unsigned long mmio_base_phys;
+	unsigned long mmio_base;
+	unsigned long mmio_size;
+
+	int module;
+};
+
+#define MASTER          0
+#define CHANNEL_OFFSET  0x14
+#define TX_STARTBIT     0x00
+#define RX_STARTBIT     0x02
+#define TX_OFFSET	0x04
+#define RX_OFFSET 	0x04
+
+#define SPI0            0		
+#define SPI1 		1	
+
+#define SPI_MOD_1 	1	
+#define SPI_MOD_2 	2	
+
+u32 spi_putget(struct spi_dev *dev, int channel, u32 data);
+int spi_configch(struct spi_dev *dev, int channel, struct spi_channel_config
+		  *chconfig);
+int spi_enablech(struct spi_dev *dev, int channel);
+int spi_disablech(struct spi_dev *dev, int channel);
+int spi_write(struct spi_dev *dev, int channel, u32 data);
+u32 spi_read(struct spi_dev *dev, int channel);
+int spi_init(struct spi_dev *dev, u32 module);
+int spi_exit(struct spi_dev *dev);
+
+#endif
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index 28e5e23..1799022 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -418,6 +418,9 @@ enum omap24xx_index {
 	V15_24XX_MCBSP2_DX,
 	R14_24XX_MCBSP2_FSX,
 
+	/* TSC IRQ*/
+	P20_24XX_TSC_IRQ,
+
 };
 
 #ifdef	CONFIG_OMAP_MUX

--0-1327825471-1135003188=:44153
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1327825471-1135003188=:44153--
