From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] SPI: OMAP2 Driver (David Brownell's fwk)
Date: Fri, 6 Jan 2006 03:40:15 -0800 (PST)
Message-ID: <20060106114015.58015.qmail@web32910.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-933043383-1136547615=:56685"
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
List-Id: linux-omap@vger.kernel.org

--0-933043383-1136547615=:56685
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by reloaded.ext.ti.com id k06Bf8H9015213

Tony,

Attached patch is my first attempt to follow David Brownell's SPI fwk
(as per 2.6.15-rc5-mm3 SPI fwk patches) to implement SPI master
controller driver for OMAP2.

o Also includes tsc2101 driver - Derived from ads7846 patch by David
Brownell.

Status:
- OMAP2 SPI master controller tries to do interrupt based txrx, but I
am trying to test tx only with first tweleve 16 bit configuration
commands of tsc2101. It stops after 8th message as of now..and I don't
know the reason yet..You can see that Interrupt routine is also in bad
shape :).

I am posting it on mailing list as to reduce duplicate work!!!. Hoping
that everyone sees my patches.

- It will not apply cleanly to the latest git head. I will rebase once
clock fwk changes are pushed.

I will appreciate all the review comments. Thanx.

---Komal Shah
http://komalshah.blogspot.com/


	=09
__________________________________________=20
Yahoo! DSL =96 Something to write home about.=20
Just $16.99/mo. or less.=20
dsl.yahoo.com=20

--0-933043383-1136547615=:56685
Content-Type: text/plain; name="spi2.1.patch"
Content-Description: 1047801828-spi2.1.patch
Content-Disposition: inline; filename="spi2.1.patch"

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7181edb..917f20e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,6 +15,9 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2101.h>
+
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
@@ -24,6 +27,7 @@
 #include <asm/arch/board.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
+#include <asm/arch/spi.h>
 
 extern void omap_nop_release(struct device *dev);
 
@@ -74,6 +78,116 @@ static void omap_init_i2c(void) {}
 
 #endif
 
+#if 	defined(CONFIG_SPI_OMAP2) || defined(CONFIG_SPI_OMAP2_MODULE)
+
+#define OMAP2_SPI_BASE1		0x48098000
+#define OMAP2_SPI_INT1		65
+
+#define OMAP2_SPI_BASE2		0x4809A000
+#define OMAP2_SPI_INT2		66
+
+static struct resource spi_resources1[] = {
+	{
+		.start		= OMAP2_SPI_BASE1,
+		.end		= OMAP2_SPI_BASE1 + 0x3f,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_SPI_INT1,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_spi_platform_info spi1_info = {
+	.bus_num 	= 1,
+	.num_chipselect = 4,
+};
+
+static struct platform_device omap_spi_device1 = {
+	.name           = "spi_omap",
+	.id             = 1,
+	.dev = {
+		.release        = omap_nop_release,
+		.platform_data	= &spi1_info,
+	},
+	.num_resources	= ARRAY_SIZE(spi_resources1),
+	.resource	= spi_resources1,
+};
+
+static struct resource spi_resources2[] = {
+	{
+		.start		= OMAP2_SPI_BASE2,
+		.end		= OMAP2_SPI_BASE2 + 0x3f,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_SPI_INT2,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_spi_platform_info spi2_info = {
+	.bus_num 	= 2,
+	.num_chipselect = 2,
+};
+
+static struct platform_device omap_spi_device2 = {
+	.name           = "spi_omap",
+	.id             = 2,
+	.dev = {
+		.release        = omap_nop_release,
+		.platform_data	= &spi2_info,
+	},
+	.num_resources	= ARRAY_SIZE(spi_resources2),
+	.resource	= spi_resources2,
+};
+
+/* REVISIT This should be moved to board-h4.c */
+static struct tsc2101_platform_data tsc2101_platform_info = {
+	.x_plate_ohms = 500,	
+};
+
+/* Chip connected to OMAP spi bus - controller data */
+static struct omap_spi_chip tsc2101_chip_info = {
+	.mode		= SPI_MODE_1,
+	.master		= 0,
+	.txrx		= OMAP_MCSPI_TXRX,
+	.bits_per_word	= 16,
+	.clkdiv		= 3,
+	.cspol		= SPI_CS_HIGH,
+	.endianess	= 0,
+};
+
+static struct spi_board_info h4_spi_board_info[] __initdata = {
+	{
+		.modalias	= "tsc2101",
+		.platform_data	= &tsc2101_platform_info,
+		.controller_data= &tsc2101_chip_info,
+		.irq		= OMAP_GPIO_IRQ(93), /*PENIRQ*/
+		.max_speed_hz 	= 48000000,
+		.bus_num	= 1,
+		.chip_select	= 0,
+	},
+};
+
+/* See also arch/arm/plat-omap/devices.c for first SPI on 24xx */
+static void omap_init_spi(void)
+{
+	/* TODO: Add mux tables for H4 SPI*/
+	if (machine_is_omap_h4()) {
+		omap_cfg_reg(P20_24XX_TSC_IRQ);
+	}
+	(void) platform_device_register(&omap_spi_device1);
+	(void) platform_device_register(&omap_spi_device2);
+	spi_register_board_info(h4_spi_board_info, ARRAY_SIZE(h4_spi_board_info));
+}
+
+#else
+
+static void omap_init_spi(void) {}
+
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int __init omap2_init_devices(void)
@@ -82,6 +196,7 @@ static int __init omap2_init_devices(voi
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_init_i2c();
+	omap_init_spi();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index ea46548..ede2c93 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -54,6 +54,9 @@ MUX_CFG_24XX("W19_24XX_SYS_NIRQ",	0x12c,
 MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,	1)
 MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,	1)
 
+/* TSC IRQ */
+MUX_CFG_24XX("P20_24XX_TSC_IRQ",	0x108,	0,	0,	0,	1)
+
 };
 
 int __init omap2_mux_init(void)
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 68d0440..05901e6 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -24,6 +24,20 @@ config TOUCHSCREEN_ADS7846
 	  To compile this driver as a module, choose M here: the
 	  module will be called ads7846.
 
+config TOUCHSCREEN_TSC2101
+	tristate "TSC 2101 based touchscreens"
+	depends on SPI_MASTER
+	help
+	  Say Y here if you have a touchscreen interface using the
+	  TSC2101 controller, and your board-specific initialization
+	  code includes that in its table of SPI devices.
+
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ads7846.
+
+
 config TOUCHSCREEN_BITSY
 	tristate "Compaq iPAQ H3600 (Bitsy) touchscreen"
 	depends on SA1100_BITSY
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index b5866f9..bf28fd0 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -5,6 +5,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
+obj-$(CONFIG_TOUCHSCREEN_TSC2101)	+= tsc2101.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
diff --git a/drivers/input/touchscreen/tsc2101.c b/drivers/input/touchscreen/tsc2101.c
new file mode 100644
index 0000000..e42e3be
--- /dev/null
+++ b/drivers/input/touchscreen/tsc2101.c
@@ -0,0 +1,429 @@
+/*
+ * TSC2101 based touchscreen driver
+ *
+ * Copyright (C) 2005 Komal Shah <komal_shah802003@yahoo.com>
+ *
+ * Using code from:
+ *  - ads7846.c 
+ *  	Copyright (C) David Brownell
+ *  - ts_hx.[hc], omap_ts.[ch]
+ *	Copyright (C) 2002 MontaVista Software
+ *	Copyright (C) 2004 Texas Instruments
+ *	Copyright (C) 2004 Srinath
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2101.h>
+
+#include <asm/mach-types.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/hardware.h>
+
+#include <asm/hardware/tsc2101.h>
+
+#ifdef	CONFIG_ARM
+#include <asm/mach-types.h>
+#ifdef	CONFIG_ARCH_OMAP
+#include <asm/arch/gpio.h>
+#endif
+
+#else
+#define	set_irq_type(irq,type)	do{}while(0)
+#endif
+
+#define ts_ctrl_pg_w(addr)	((0x1 << 11) | (addr << 5))
+#define ts_ctrl_pg_data(data)	(data & 0xffff)
+#define ts_ctrl_pg_r(addr)	(0x8000 | (0x1 << 11) | (addr << 5))
+
+#define ts_data_pg_r(addr)	(0x8000 | (0x0 << 11) | (addr << 5))
+
+static const u16 read_x 	= ts_data_pg_r(TSC2101_TS_X);
+static const u16 read_y 	= ts_data_pg_r(TSC2101_TS_Y);
+static const u16 read_z1 	= ts_data_pg_r(TSC2101_TS_Z1);
+static const u16 read_z2 	= ts_data_pg_r(TSC2101_TS_Z2);
+
+#define TSC2101_GETSTATUS(x)			(((x) >> 11) & 0x1)
+
+#define	MAX_12BIT	((1<<12)-1)
+#define	TS_POLL_PERIOD	msecs_to_jiffies(10)
+
+struct ts_event {
+	__be16 x;
+	__be16 y;
+	__be16 z1, z2;
+};
+
+struct tsc2101 {
+	struct input_dev	*input;
+	char			phys[32];
+
+	struct spi_device	*spi;
+	u16			model;
+	u16			vref_delay_usecs;
+	u16			x_plate_ohms;
+
+	struct ts_event		tc;
+
+	struct spi_transfer	xfer[8];
+	struct spi_message	msg;
+
+	spinlock_t		lock;
+	struct timer_list	timer;		/* P: lock */
+	unsigned		pendown:1;	/* P: lock */
+	unsigned		pending:1;	/* P: lock */
+// FIXME remove "irq_disabled"
+	unsigned		irq_disabled:1;	/* P: lock */
+};
+
+/*
+ * PENIRQ only kicks the timer.  The timer only reissues the SPI transfer,
+ * to retrieve touchscreen status.
+ *
+ * The SPI transfer completion callback does the real work.  It reports
+ * touchscreen events and reactivates the timer (or IRQ) as appropriate.
+ */
+
+static void tsc2101_rx(void *tsc)
+{
+	struct tsc2101	*ts = tsc;
+	unsigned	Rt;
+	unsigned	sync = 0;
+	u16		x, y, z1, z2;
+	unsigned long	flags;
+
+	/* adjust:  12 bit samples (left aligned), built from
+	 * two 8 bit values writen msb-first.
+	 */
+	x = be16_to_cpu(ts->tc.x) >> 4;
+	y = be16_to_cpu(ts->tc.y) >> 4;
+	z1 = be16_to_cpu(ts->tc.z1) >> 4;
+	z2 = be16_to_cpu(ts->tc.z2) >> 4;
+
+	/* range filtering */
+	if (x == MAX_12BIT)
+		x = 0;
+
+	if (x && z1 && ts->spi->dev.power.power_state.event == PM_EVENT_ON) {
+		/* compute touch pressure resistance using equation #1 */
+		Rt = z2;
+		Rt -= z1;
+		Rt *= x;
+		Rt *= ts->x_plate_ohms;
+		Rt /= z1;
+		Rt = (Rt + 2047) >> 12;	/* Komal: May be adding 2047 not
+					   required...but let's see*/
+	} else
+		Rt = 0;
+
+	/* NOTE:  "pendown" is inferred from pressure; we don't rely on
+	 * being able to check nPENIRQ status, or "friendly" trigger modes
+	 * (both-edges is much better than just-falling or low-level).
+	 *
+	 * REVISIT:  some boards may require reading nPENIRQ; it's
+	 * needed on 7843.  and 7845 reads pressure differently...
+	 *
+	 * REVISIT:  the touchscreen might not be connected; this code
+	 * won't notice that, even if nPENIRQ never fires ...
+	 */
+	if (!ts->pendown && Rt != 0) {
+		input_report_key(ts->input, BTN_TOUCH, 1);
+		sync = 1;
+	} else if (ts->pendown && Rt == 0) {
+		input_report_key(ts->input, BTN_TOUCH, 0);
+		sync = 1;
+	}
+
+	if (Rt) {
+		input_report_abs(ts->input, ABS_X, x);
+		input_report_abs(ts->input, ABS_Y, y);
+		input_report_abs(ts->input, ABS_PRESSURE, Rt);
+		sync = 1;
+	}
+	if (sync)
+		input_sync(ts->input);
+#define VERBOSE
+#ifdef	VERBOSE
+	if (Rt || ts->pendown)
+		pr_debug("%s: %d/%d/%d%s\n", ts->spi->dev.bus_id,
+			x, y, Rt, Rt ? "" : " UP");
+#endif
+
+	/* don't retrigger while we're suspended */
+	spin_lock_irqsave(&ts->lock, flags);
+
+	ts->pendown = (Rt != 0);
+	ts->pending = 0;
+
+	if (ts->spi->dev.power.power_state.event == PM_EVENT_ON) { 
+		if (ts->pendown)
+			mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
+		else if (ts->irq_disabled) {
+			ts->irq_disabled = 0;
+			enable_irq(ts->spi->irq);
+		}
+	}
+
+	spin_unlock_irqrestore(&ts->lock, flags);
+}
+
+static void tsc2101_timer(unsigned long handle)
+{
+	struct tsc2101	*ts = (void *)handle;
+	int		status = 0;
+	unsigned long	flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	if (!ts->pending) {
+		ts->pending = 1;
+		if (!ts->irq_disabled) {
+			ts->irq_disabled = 1;
+			disable_irq(ts->spi->irq);
+		}
+		status = spi_async(ts->spi, &ts->msg);
+		if (status)
+			dev_err(&ts->spi->dev, "spi_async --> %d\n",
+					status);
+	}
+	spin_unlock_irqrestore(&ts->lock, flags);
+}
+
+static irqreturn_t tsc2101_irq(int irq, void *handle, struct pt_regs *regs)
+{
+	tsc2101_timer((unsigned long) handle);
+	return IRQ_HANDLED;
+}
+
+static inline int ts_penup(struct spi_device *spi)
+{
+	int ret = 0;
+	struct	spi_transfer	x[2];
+	struct	spi_message	msg;
+	u16			command[1];
+	u16			status;
+
+	command[0]	= ts_ctrl_pg_r(TSC2101_TS_STATUS);
+
+	x[0].tx_buf	= command;
+	x[0].len	= 2;
+	x[1].rx_buf	= &status;
+	x[1].len	= 2;
+
+	msg.transfers	= x;
+	msg.n_transfer	= 2;
+
+	spi_sync(spi,	&msg); 
+
+	ret = TSC2101_GETSTATUS(be16_to_cpu(status));
+	return !ret;
+}
+
+static int __devinit tsc2101_probe(struct spi_device *spi)
+{
+	struct tsc2101			*ts;
+	struct tsc2101_platform_data	*pdata = spi->dev.platform_data;
+	struct spi_transfer		x[12]; /* one time control conf.*/
+	struct spi_message		msg;
+	struct spi_transfer		*y;
+	int 	i;
+	u16 	command[12];
+
+	if (!spi->irq) {
+		dev_dbg(&spi->dev, "no IRQ?\n");
+		return -ENODEV;
+	}
+
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data?\n");
+		return -ENODEV;
+	}
+
+	if (!(ts = kzalloc(sizeof(struct tsc2101), GFP_KERNEL)))
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, ts);
+	
+	ts->spi = spi;
+	spi->dev.power.power_state = PMSG_ON;
+
+	init_timer(&ts->timer);
+	ts->timer.data = (unsigned long) ts;
+	ts->timer.function = tsc2101_timer;
+
+	ts->x_plate_ohms = pdata->x_plate_ohms ? : 500;
+	
+	ts->input	= input_allocate_device();	
+	ts->input->dev	= &spi->dev;
+	ts->input->name	= "TSC2101 Touchscreen";
+	snprintf(ts->phys, sizeof ts->phys, "%s/input0", spi->dev.bus_id);
+	ts->input->phys = ts->phys;
+
+	ts->input->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	ts->input->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(ts->input, ABS_X,
+			pdata->x_min ? : 0,
+			pdata->x_max ? : MAX_12BIT,
+			0, 0);
+	input_set_abs_params(ts->input, ABS_Y,
+			pdata->y_min ? : 0,
+			pdata->y_max ? : MAX_12BIT,
+			0, 0);
+	input_set_abs_params(ts->input, ABS_PRESSURE,
+			pdata->pressure_min, pdata->pressure_max, 0, 0);
+
+	input_register_device(ts->input);
+
+	command[0] = ts_ctrl_pg_w(TSC2101_TS_STATUS);
+	command[1] = ts_ctrl_pg_data(TSC2101_DATA_AVAILABLE);
+	
+	command[2] = ts_ctrl_pg_w(TSC2101_TS_BUFFER_CTRL);
+	command[3] = ts_ctrl_pg_data(TSC2101_BUFFERMODE_DISABLE);
+	
+	command[4] = ts_ctrl_pg_w(TSC2101_TS_REF_CTRL);
+	command[5] = ts_ctrl_pg_data(TSC2101_REF_POWERUP);
+
+	command[6] = ts_ctrl_pg_w(TSC2101_TS_CONFIG_CTRL);
+	command[7] = ts_ctrl_pg_data(TSC2101_ENABLE_TOUCHDETECT);
+	
+	command[8] = ts_ctrl_pg_w(TSC2101_TS_PROG_DELAY);
+	command[9] = ts_ctrl_pg_data(TSC2101_PRG_DELAY);
+
+	command[10] = ts_ctrl_pg_w(TSC2101_TS_ADC_CTRL);
+	command[11] = ts_ctrl_pg_data(TSC2101_ADC_CONTROL);
+
+	for (i = 0; i < 12; i++) {
+		x[i].tx_buf	 = command + i;
+		x[i].len	 = 2;
+		x[i].rx_buf	 = NULL;
+	}
+	
+	msg.transfers = x;
+	msg.n_transfer = 12;
+
+	spi_async(spi, &msg);
+
+	y = ts->xfer;
+
+	/* PINTDAV is data available only */
+	y->tx_buf	= &read_x; 
+	y->len		= 2;
+	y++;
+	y->rx_buf	= &ts->tc.x;
+	y->len		= 2;
+	y++;
+
+	y->tx_buf	= &read_y; 
+	y->len		= 2;
+	y++;
+	y->rx_buf	= &ts->tc.y;
+	y->len		= 2;
+	y++;
+
+	y->tx_buf	= &read_z1; 
+	y->len		= 2;
+	y++;
+	y->rx_buf	= &ts->tc.z1;
+	y->len		= 2;
+	y++;
+
+	y->tx_buf	= &read_z2; 
+	y->len		= 2;
+	y++;
+	y->rx_buf	= &ts->tc.z2;
+	y->len		= 2;
+	y++;
+
+	ts->msg.transfers 	= ts->xfer;
+	ts->msg.n_transfer	= y - ts->xfer;
+	ts->msg.context		= ts;
+	ts->msg.complete	= tsc2101_rx;
+
+	if (request_irq(spi->irq, tsc2101_irq, SA_SAMPLE_RANDOM,
+				spi->dev.bus_id, ts)) {
+		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
+		input_unregister_device(ts->input);
+		kfree(ts);
+		return -EBUSY;
+	}
+	set_irq_type(spi->irq, IRQT_FALLING);
+
+	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
+
+	return 0;
+}
+
+static int __devexit tsc2101_remove(struct spi_device *spi)
+{
+	struct tsc2101		*ts = dev_get_drvdata(&spi->dev);
+	struct	spi_transfer	x[2];
+	struct	spi_message	msg;
+	u16			command[2];
+
+	command[0]	= ts_ctrl_pg_data(TSC2101_TS_ADC_CTRL);
+	command[1]	= ts_ctrl_pg_data(TSC2101_ADC_POWERDOWN);
+
+	x[0].tx_buf	= command;
+	x[0].len	= 2;
+	x[1].tx_buf	= command + 1; 
+	x[1].len	= 2;
+
+	msg.transfers	= x;
+	msg.n_transfer	= 2;
+
+	spi_async(spi,	&msg); 
+
+	free_irq(ts->spi->irq, ts);
+	if (ts->irq_disabled)
+		enable_irq(ts->spi->irq);
+
+	input_unregister_device(ts->input);
+	kfree(ts);
+
+	dev_dbg(&spi->dev, "unregistered touchscreen\n");
+	return 0;
+}
+
+static struct spi_driver tsc2101_driver = {
+	.driver = {
+		.name	= "tsc2101",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= tsc2101_probe,
+	.remove		= __devexit_p(tsc2101_remove),
+};
+
+static int __init tsc2101_init(void)
+{
+#ifdef	CONFIG_ARCH_OMAP
+	if (machine_is_omap_h4()) {
+		/* GPIO93 = PENIRQ; */
+		omap_request_gpio(93);
+		omap_set_gpio_direction(93, 1);
+	}
+#endif
+	return spi_register_driver(&tsc2101_driver);
+}
+module_init(tsc2101_init);
+
+static void __exit tsc2101_exit(void)
+{
+	spi_unregister_driver(&tsc2101_driver);
+
+#ifdef	CONFIG_ARCH_OMAP
+	if (machine_is_omap_h4()) {
+		omap_free_gpio(93);
+	}
+#endif
+
+}
+module_exit(tsc2101_exit);
+
+MODULE_DESCRIPTION("TSC2101 TouchScreen Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 022446c..f6ac536 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -90,6 +90,12 @@ config SPI_BUTTERFLY
 	  inexpensive battery powered microcontroller evaluation board.
 	  This same cable can be used to flash new firmware.
 
+config SPI_OMAP2
+	tristate "OMAP2 SPI master"
+	depends on SPI_MASTER && EXPERIMENTAL
+	help
+	  OMAP2 SPI master driver. More help later.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index c2c87e8..443f7be 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SPI_MASTER)		+= spi.o
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
+obj-$(CONFIG_SPI_OMAP2)			+= spi_omap2.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
diff --git a/drivers/spi/spi_butterfly.c b/drivers/spi/spi_butterfly.c
diff --git a/drivers/spi/spi_omap2.c b/drivers/spi/spi_omap2.c
new file mode 100644
index 0000000..353691f
--- /dev/null
+++ b/drivers/spi/spi_omap2.c
@@ -0,0 +1,806 @@
+/*
+ * spi_omap2.c - SPI master controller driver for OMAP2
+ *
+ * Copyright(C) 2005  Komal Shah <komal_shah802003@yahoo.com>
+ *
+ * Original code for OMAP2 SPI by 
+ * Copyright(C) 2004 Texas Instruments 
+ * Author: Suresh Reddy <sureshr@ti.com>
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
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+
+#include <asm/io.h>
+#include <asm/hardware/clock.h>
+#include <asm/arch/spi.h>
+
+#define DRIVER_NAME "spi_omap"
+
+/* offsets of SPI Registers */
+#define	OMAP_MCSPI_REVISION		0x00
+#define	OMAP_MCSPI_SYSCONFIG		0x10
+#define OMAP_MCSPI_SYSS			0x14
+#define	OMAP_MCSPI_IRQSTATUS		0x18
+#define OMAP_MCSPI_IRQENABLE		0x1C
+#define	OMAP_MCSPI_SYST			0x24
+#define OMAP_MCSPI_MODULCTRL		0x28
+#define OMAP_MCSPI_CHCONF0		0x2C
+#define OMAP_MCSPI_CHSTAT0		0x30
+
+#define OMAP_MCSPI_CHCTRL0		0x34
+#define OMAP_MCSPI_TX0			0x38
+#define OMAP_MCSPI_RX0			0x3C
+#define OMAP_MCSPI_CHCONF1		0x40
+#define OMAP_MCSPI_CHSTAT1		0x44
+#define OMAP_MCSPI_CHCTRL1		0x48
+#define OMAP_MCSPI_TX1			0x4C
+#define OMAP_MCSPI_RX1			0x50
+
+/* offsets of registers which are specific to SPI1 */
+#define OMAP_MCSPI_CHCONF2		0x54
+#define OMAP_MCSPI_CHSTAT2		0x58
+#define OMAP_MCSPI_CHCTRL2		0x5C
+#define OMAP_MCSPI_TX2			0x60
+#define OMAP_MCSPI_RX2			0x64
+#define OMAP_MCSPI_CHCONF3		0x68
+#define OMAP_MCSPI_CHSTAT3		0x6C
+#define OMAP_MCSPI_CHCTRL3		0x70
+#define OMAP_MCSPI_TX3			0x74
+#define OMAP_MCSPI_RX3			0x78
+
+/* define bitfeilds in selected registers */
+#define OMAP_MCSPI_SYSCONFIG_FCLKON_OCPCLKOFF	(1 << 8)
+#define OMAP_MCSPI_SYSCONFIG_FCLKOFF_OCPCLKON	(2 << 8)
+#define OMAP_MCSPI_SYSCONFIG_FCLKOFF_OCPCLKOFF	(3 << 8)
+#define OMAP_MCSPI_SYSCONFIG_ENAWAKEUP_ENABLE	(1 << 2)
+#define OMAP_MCSPI_SYSCONFIG_ENAWAKEUP_DISABLE	(0 << 2)
+
+#define OMAP_MCSPI_RESET			(1 << 1)
+#define OMAP_MCSPI_SYSS_RDONE			(1 << 0)
+
+#define OMAP_MCSPI_IRQSTATUS_WKS_PENDING	(1 << 16)
+#define OMAP_MCSPI_IRQSTATUS_WKS_RESET		(1 << 16)
+#define OMAP_MCSPI_IRQENABLE_WKE_ENABLE		(1 << 16)
+#define OMAP_MCSPI_IRQENABLE_WKE_DISABLE	(0 << 16)
+
+#define OMAP_MCSPI_IE_TXEMPTY(x)		(1 << (x << 2))
+#define OMAP_MCSPI_IE_TXUNDERFLOW(x)		(1 << ((x << 2)+1))
+#define OMAP_MCSPI_IE_RXFULL(x)			(1 << ((x << 2)+2))
+/* Note: As per TRM only RX0 overflow bit is available */
+#define OMAP_MCSPI_IE_RXOVERFLOW(x)		(1 << ((x << 2)+3))
+
+#define OMAP_MCSPI_IRQSTAT_TXEMPTY(x)		(1 << (x << 2))
+#define OMAP_MCSPI_IRQSTAT_TXUNDERFLOW(x)	(1 << ((x << 2)+1))
+#define OMAP_MCSPI_IRQSTAT_RXFULL(x)		(1 << ((x << 2)+2))
+/* Note: As per TRM only RX0 overflow bit is available */
+#define OMAP_MCSPI_IRQSTAT_RXOVERFLOW(x) 	(1 << ((x << 2)+3))
+
+#define OMAP_MCSPI_MODULCTRL_SYSTEST_ENABLE	(1 << 3)
+#define OMAP_MCSPI_MODULCTRL_MODE(x)		((x) << 2)
+#define OMAP_MCSPI_MODULCTRL_ENDIANESS(x)	((x) << 1)
+
+#define OMAP_MCSPI_CHCONF_IS_DL0RECEIVE		(0 << 18)
+#define OMAP_MCSPI_CHCONF_IS_DL1RECEIVE		(1 << 18)
+#define OMAP_MCSPI_CHCONF_DPE1_TRANSMIT		(0 << 17)
+#define OMAP_MCSPI_CHCONF_DPE1_NO_TRANSMIT	(1 << 17)
+#define OMAP_MCSPI_CHCONF_DPE0_TRANSMIT		(0 << 16)
+#define OMAP_MCSPI_CHCONF_DPE0_NO_TRANSMIT	(1 << 16)
+#define OMAP_MCSPI_CHCONF_DMAR_DISABLE		(0 << 15)
+#define OMAP_MCSPI_CHCONF_DMAR_ENABLE		(1 << 15)
+#define OMAP_MCSPI_CHCONF_DMAW_DISABLE		(0 << 14)
+#define OMAP_MCSPI_CHCONF_DMAW_ENABLE		(1 << 14)
+
+#define OMAP_MCSPI_CHCONF_TXRX(x)		((x) << 12)
+#define OMAP_MCSPI_CHCONF_WL(x)			((x-1) << 7)
+#define OMAP_MCSPI_CHCONF_CSPOL(x)		((x) << 6)
+/* 'x' is a logarithmic base 2 value. e.g '0' means 1 as divisor value*/
+#define OMAP_MCSPI_CHCONF_CLKD(x)		((x) << 2)
+#define OMAP_MCSPI_CHCONF_POL(x)		((x) << 1)
+#define OMAP_MCSPI_CHCONF_PHA(x)		((x) << 0)
+
+#define OMAP_MCSPI_CHSTAT_TXS_FULL		(0 << 1)
+#define OMAP_MCSPI_CHSTAT_TXS_EMPTY		(1 << 1)
+#define OMAP_MCSPI_CHSTAT_RXS_EMPTY		(0 << 0)
+#define OMAP_MCSPI_CHSTAT_RXS_FULL		(1 << 0)
+#define OMAP_MCSPI_CHSTAT_EOT_DONE		(1 << 2)
+
+#define OMAP_MCSPI_CHCTRL_ACTIVE		(1 << 0)
+#define OMAP_MCSPI_CHCTRL_NOTACTIVE		(0 << 0)
+
+#define OMAP_MCSPI_CHOFFSET			0x14
+#define OMAP_MCSPI_CHCONF_0			0x2C
+#define OMAP_MCSPI_CHCONF(x) 				\
+	(OMAP_MCSPI_CHCONF_0 + (x * OMAP_MCSPI_CHOFFSET)) 
+#define OMAP_MCSPI_CHSTAT_0			0x30
+#define OMAP_MCSPI_CHSTAT(x) 				\
+	(OMAP_MCSPI_CHSTAT_0 + (x * OMAP_MCSPI_CHOFFSET)) 
+#define OMAP_MCSPI_CHCTRL_0			0x34
+#define OMAP_MCSPI_CHCTRL(x) 				\
+	(OMAP_MCSPI_CHCTRL_0 + (x * OMAP_MCSPI_CHOFFSET))
+#define OMAP_MCSPI_TX_0				0x38
+#define OMAP_MCSPI_TX(x) 				\
+	(OMAP_MCSPI_TX_0 + (x * OMAP_MCSPI_CHOFFSET)) 	
+#define OMAP_MCSPI_RX_0				0x3C
+#define OMAP_MCSPI_RX(x)				\
+	(OMAP_MCSPI_RX_0 + (x * OMAP_MCSPI_CHOFFSET))	
+
+
+struct transfer_state {
+	int index;
+	int len;
+	void *tx;
+	void *tx_end;
+	void *rx;
+	void *rx_end;
+	void (*write)(struct spi_device *spi, struct transfer_state *state);
+	void (*read)(struct spi_device *spi, struct transfer_state *state);
+};
+
+struct omap_spi_dev {
+	struct spi_master 		*master;
+	void __iomem			*base;		/* virtual */
+	int				irq;
+	struct clk			*iclk;		/* Interface clock */
+	struct clk			*fclk;		/* Functional clock */
+	struct omap_spi_platform_info	*pdata;
+	struct list_head 		queue;
+	spinlock_t			lock;
+	struct tasklet_struct 		spi_xfer_msgs;
+	struct tasklet_struct 		spi_xfers;
+	struct spi_message		*msg;
+	struct transfer_state		state;
+};
+
+struct chip_data {
+	int nbytes;
+	void (*write)(struct spi_device *spi, struct transfer_state *state);
+	void (*read)(struct spi_device *spi, struct transfer_state *state);
+};
+
+static __inline__ u32 omap_spi_read(struct omap_spi_dev *spi_dev,
+				 int reg)
+{
+	return __raw_readw(spi_dev->base + reg);
+}
+static __inline__ void omap_spi_write(struct omap_spi_dev *spi_dev,
+				  int val, int reg)
+{
+	__raw_writew(val, spi_dev->base + reg);
+}
+
+static void omap_spi_dump(struct spi_device *spi) {	
+
+	struct omap_spi_dev *omap_spi_dev =  spi_master_get_devdata(spi->master);
+	int	cs = spi->chip_select;
+
+	printk("MCSPI_CHCONF[0x%08X]\n", omap_spi_read(omap_spi_dev,
+						       OMAP_MCSPI_CHCONF(cs))); 
+	printk("MCSPI_CHSTAT[0x%08X]\n", omap_spi_read(omap_spi_dev,
+						       OMAP_MCSPI_CHSTAT(cs))); 
+	printk("MCSPI_CHCTRL[0x%08X]\n", omap_spi_read(omap_spi_dev,
+						       OMAP_MCSPI_CHCTRL(cs))); 
+	printk("MCSPI_IRQSTAT[0x%08X]\n", omap_spi_read(omap_spi_dev,
+							OMAP_MCSPI_IRQSTATUS)); 
+	printk("MCSPI_IRQENABLE[0x%08X]\n", omap_spi_read(omap_spi_dev,
+							OMAP_MCSPI_IRQENABLE)); 
+	printk("MCSPI_MODULCTRL[0x%08X]\n", omap_spi_read(omap_spi_dev,
+							OMAP_MCSPI_MODULCTRL)); 
+}
+
+static void null_writer(struct spi_device *spi, struct transfer_state *state)
+{
+	struct omap_spi_dev *omap_spi_dev = spi_master_get_devdata(spi->master);
+	int    cs = spi->chip_select;
+	
+	printk("null writer\n");
+	while ((omap_spi_read(omap_spi_dev, OMAP_MCSPI_CHSTAT(cs)) &
+		OMAP_MCSPI_CHSTAT_TXS_EMPTY) &&
+	       (state->tx < state->tx_end)) {
+
+		omap_spi_write(omap_spi_dev, 0,
+			       OMAP_MCSPI_TX(cs));
+		++state->tx;
+	}
+}
+
+static void null_reader(struct spi_device *spi, struct transfer_state *state)
+{
+	struct omap_spi_dev *omap_spi_dev = spi_master_get_devdata(spi->master);
+	int    cs = spi->chip_select;
+
+	printk("null reader\n");
+	while ((omap_spi_read(omap_spi_dev, OMAP_MCSPI_CHSTAT(cs)) &
+		OMAP_MCSPI_CHSTAT_RXS_FULL) &&
+		(state->rx < state->rx_end)) {
+
+		omap_spi_read(omap_spi_dev, OMAP_MCSPI_RX(cs));
+		++state->rx;
+	}
+}
+
+static void tx_8(struct spi_device *spi, struct transfer_state *state)
+{
+	struct omap_spi_dev *omap_spi_dev = spi_master_get_devdata(spi->master);
+	int    cs = spi->chip_select;
+
+	while (state->tx < state->tx_end) {	/* REVISIT */
+		omap_spi_write(omap_spi_dev, *(u8 *)(state->tx),
+			       OMAP_MCSPI_TX(cs));
+		++state->tx;
+	}
+}
+
+static void rx_8(struct spi_device *spi, struct transfer_state *state)
+{
+	struct omap_spi_dev *omap_spi_dev = spi_master_get_devdata(spi->master);
+	int    cs = spi->chip_select;
+
+	while (state->rx < state->rx_end) {	/* REVISIT */
+		*(u8 *)(state->rx) = omap_spi_read(omap_spi_dev,
+						   OMAP_MCSPI_RX(cs));
+		++state->rx;
+	}
+}
+
+static void tx_16(struct spi_device *spi, struct transfer_state *state)
+{
+	struct	omap_spi_dev *omap_spi_dev = spi_master_get_devdata(spi->master);
+	int	cs = spi->chip_select;
+
+	while ((omap_spi_read(omap_spi_dev, OMAP_MCSPI_CHSTAT(cs)) &
+		OMAP_MCSPI_CHSTAT_TXS_EMPTY) &&
+	       (state->tx < state->tx_end)) {	/* REVISIT */
+
+		omap_spi_write(omap_spi_dev, *(u16 *)(state->tx),
+			       OMAP_MCSPI_TX(cs));
+		state->tx += 2;
+	}
+}
+
+static void rx_16(struct spi_device *spi, struct transfer_state *state)
+{
+	struct omap_spi_dev *omap_spi_dev = spi_master_get_devdata(spi->master);
+	int	cs = spi->chip_select;
+
+	while ((omap_spi_read(omap_spi_dev, OMAP_MCSPI_CHSTAT(cs)) &
+		OMAP_MCSPI_CHSTAT_RXS_FULL) &&
+	       (state->rx < state->rx_end)) {	/* REVISIT */
+
+		*(u16 *)(state->rx) = omap_spi_read(omap_spi_dev,
+						    OMAP_MCSPI_RX(cs));
+		state->rx += 2;
+	}
+}
+
+#define OMAP_MCSPI_TIMEOUT (1*HZ)
+
+static void omap_spi_reset(struct omap_spi_dev *omap_spi_dev) 
+{
+	unsigned long timeout;
+
+	/* Take the SPI module out of reset */
+	omap_spi_write(omap_spi_dev, OMAP_MCSPI_RESET,
+		       OMAP_MCSPI_SYSCONFIG);
+
+	timeout = jiffies + OMAP_MCSPI_TIMEOUT;
+	while (!(omap_spi_read(omap_spi_dev, OMAP_MCSPI_SYSS) &
+				OMAP_MCSPI_SYSS_RDONE)) {
+		if (time_after(jiffies, timeout)) {
+			printk(KERN_ERR "timeout waiting for SPI reset");
+			break;
+		}
+		msleep(1);
+	}
+}
+
+static irqreturn_t
+omap_spi_isr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct omap_spi_dev *omap_spi_dev = (struct omap_spi_dev *)dev_id;
+	struct spi_message *msg = omap_spi_dev->msg;
+	struct spi_device *spi	= msg->spi;
+	int    irq_status, bits;
+	struct transfer_state *state = (struct transfer_state
+					*)omap_spi_dev->msg->state;
+	if (!msg || !state) {
+		return IRQ_NONE;
+	}
+
+	bits = omap_spi_read(omap_spi_dev, OMAP_MCSPI_IRQENABLE);
+	while ((irq_status = omap_spi_read(omap_spi_dev,
+				       OMAP_MCSPI_IRQSTATUS)) & bits){
+		
+		omap_spi_write(omap_spi_dev, irq_status, OMAP_MCSPI_IRQSTATUS);
+
+		if (irq_status & OMAP_MCSPI_IRQSTAT_RXFULL(spi->chip_select)) {
+			/* REVISIT */	
+			state->read(spi, state);
+			omap_spi_write(omap_spi_dev,
+				       OMAP_MCSPI_IRQSTAT_RXFULL(spi->chip_select),
+				       OMAP_MCSPI_IRQSTATUS);
+			/*if (state->rx <= state->rx_end) {
+			    	printk("c\n");
+				msg->actual_length += msg->transfers[state->index].len;
+				++state->index;
+				tasklet_schedule(&omap_spi_dev->spi_xfers);
+			}*/
+			continue;
+		}
+
+		if (irq_status & OMAP_MCSPI_IRQSTAT_TXEMPTY(spi->chip_select)) {
+			/* REVISIT */	
+			state->write(spi, state);
+			omap_spi_write(omap_spi_dev,
+				       OMAP_MCSPI_IRQSTAT_TXEMPTY(spi->chip_select),
+				       OMAP_MCSPI_IRQSTATUS);
+
+			if (state->tx <= state->tx_end) {
+				msg->actual_length += msg->transfers[state->index].len;
+				++state->index;
+				/* Disable channel ? */
+				omap_spi_write(omap_spi_dev,
+					       OMAP_MCSPI_CHCTRL_NOTACTIVE,
+			       		OMAP_MCSPI_CHCTRL(spi->chip_select));
+				tasklet_schedule(&omap_spi_dev->spi_xfers);
+				return IRQ_HANDLED;			
+			}
+			continue;
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static void omap_spi_cleanup(const struct spi_device *spi)
+{
+	struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);
+	
+	if (chip)
+		kfree(chip);
+}
+
+static void spi_xfers(unsigned long data)
+{
+	struct omap_spi_dev *omap_spi_dev = (struct omap_spi_dev *)data;
+	struct spi_message *msg = omap_spi_dev->msg;
+	struct spi_device *spi	= msg->spi;
+	struct transfer_state	*state;
+	struct chip_data	*chip;
+	struct spi_transfer	*transfer;
+	int	irq_enable;
+
+	if (!msg) {
+		printk(KERN_ERR "bad pump_transfers "
+				"schedule\n");
+		tasklet_schedule(&omap_spi_dev->spi_xfer_msgs);
+		return;
+	}
+	
+	state = (struct transfer_state *)msg->state;
+	if (!state) {
+		printk(KERN_ERR "bad message state\n");
+		omap_spi_dev->msg = NULL;
+		tasklet_schedule(&omap_spi_dev->spi_xfer_msgs);
+		return;
+	}
+	
+	chip = spi_get_ctldata(spi);
+	if (!chip) {
+		printk(KERN_ERR "bad chip data\n");
+		omap_spi_dev->msg = NULL;
+		tasklet_schedule(&omap_spi_dev->spi_xfer_msgs);
+		return;
+	}
+
+	/* last message */
+	if (state->index == msg->n_transfer) {
+		msg->status = 0;
+		if (msg->complete)
+			msg->complete(msg->context);
+		omap_spi_dev->msg = NULL;
+		tasklet_schedule(&omap_spi_dev->spi_xfer_msgs);
+		return;
+	}
+
+	/* start of message */	
+	if (state->index == -1) {
+		++state->index;
+	}
+	
+	/* Delay if requested at end of transfer*/
+	if (state->index > 1) {
+		transfer = msg->transfers + (state->index - 1);
+		if (transfer->delay_usecs)
+			udelay(transfer->delay_usecs);
+	}
+
+	/* Setup the transfer state */	
+	transfer 	= msg->transfers + state->index;
+	state->tx	= (void *)transfer->tx_buf;
+	state->tx_end	= state->tx + (transfer->len * chip->nbytes);
+	state->rx	= (void *)transfer->rx_buf;
+	state->rx_end	= state->rx + (transfer->len * chip->nbytes);
+	state->write	= state->tx ? chip->write :null_writer;
+	state->read	= state->rx ? chip->read :null_reader;
+
+	printk(KERN_INFO "info:"
+	       		 "index=%d tx_len =%d rx_len =%d\n",
+			 state->index, (state->tx_end - state->tx),
+			 (state->rx_end - state->rx));
+
+	/* Activate channel ? */
+	omap_spi_write(omap_spi_dev,
+		       OMAP_MCSPI_CHCTRL_ACTIVE,
+	     		OMAP_MCSPI_CHCTRL(spi->chip_select));
+
+	/* I am still finding right place for this...*/
+	irq_enable = OMAP_MCSPI_IE_TXEMPTY(spi->chip_select) |
+	    		OMAP_MCSPI_IE_RXFULL(spi->chip_select);
+
+	omap_spi_write(omap_spi_dev, irq_enable, OMAP_MCSPI_IRQENABLE);
+}
+
+static void spi_xfer_msgs(unsigned long data)
+{
+	struct omap_spi_dev *omap_spi_dev = (struct omap_spi_dev *)data;
+
+	spin_lock(&omap_spi_dev->lock);
+
+	/* message queue empty? */
+	if (list_empty(&omap_spi_dev->queue)) {
+		printk (KERN_ERR "empty message queue\n");
+		spin_unlock(&omap_spi_dev->lock);
+		return;
+	}
+
+	if (omap_spi_dev->msg) {
+		printk (KERN_ERR "we are running already\n");
+		spin_unlock(&omap_spi_dev->lock);
+		return;
+	}
+
+	omap_spi_dev->msg = container_of(omap_spi_dev->queue.next,
+					 struct spi_message, queue);
+
+	list_del_init(&omap_spi_dev->msg->queue);
+
+	omap_spi_dev->msg->state	= &omap_spi_dev->state;
+	omap_spi_dev->state.index	= -1;
+	omap_spi_dev->state.len		= 0;
+
+	tasklet_schedule(&omap_spi_dev->spi_xfers);
+
+	spin_unlock(&omap_spi_dev->lock);
+}
+
+static int omap_spi_transfer(struct spi_device *spi, struct spi_message *m)
+{
+	struct omap_spi_dev *omap_spi_dev;
+	unsigned long flags;
+	
+	m->actual_length = 0;
+	m->status = -EINPROGRESS;
+
+	omap_spi_dev = spi_master_get_devdata(spi->master);
+	/* Just add to the message queue */
+	spin_lock_irqsave(&omap_spi_dev->lock, flags);
+	list_add_tail(&m->queue, &omap_spi_dev->queue);
+	
+	/* Dump the tx_buf...Debug purpose only REMOVE LATER*/
+	list_for_each_entry(m, &omap_spi_dev->queue, queue) {
+		struct spi_transfer *t = m->transfers;
+		unsigned n;
+		for (n = m->n_transfer; n > 0 ; n--, t++) {
+			printk(KERN_INFO "tx_buf [0x%08x]\n", *(u16*)(t->tx_buf));
+		}
+	} 
+	
+	spin_unlock_irqrestore(&omap_spi_dev->lock, flags);
+
+	tasklet_schedule(&omap_spi_dev->spi_xfer_msgs);
+	return 0;
+}
+
+static int omap_spi_setup(struct spi_device *spi)
+{
+	struct omap_spi_chip *chip_info = (struct omap_spi_chip
+					   *)spi->controller_data;
+	struct omap_spi_dev *omap_spi_dev =
+				spi_master_get_devdata(spi->master);
+	struct chip_data *chip;
+	unsigned long irq_status;
+	unsigned int chconfig = 0x0;
+	int cs = spi->chip_select;
+
+	/* Only alloc on first setup */
+	chip = spi_get_ctldata(spi);
+	if (chip == NULL) {
+		chip = kcalloc(1, sizeof(struct chip_data), GFP_KERNEL);
+		if (!chip)
+			return -ENOMEM;
+		spi->mode = chip_info->mode;
+		spi->bits_per_word = chip_info->bits_per_word;
+	}
+	
+	/* clear all regs */
+	omap_spi_write(omap_spi_dev, 0, OMAP_MCSPI_MODULCTRL);
+	omap_spi_write(omap_spi_dev, 0, OMAP_MCSPI_CHCONF(cs));
+
+	/* configure SPI mode control */
+	omap_spi_write(omap_spi_dev,
+		       OMAP_MCSPI_MODULCTRL_MODE(chip_info->master) |
+		       OMAP_MCSPI_MODULCTRL_ENDIANESS(chip_info->endianess),
+		       OMAP_MCSPI_MODULCTRL);
+
+	/* TRM:
+	* Interrupt status bit must always be reset after channel enabling
+ 	* and before events are enabled as interrupt sources.
+	*
+	* Note: We may not need TX underflow and RX overflow handling in
+	* master mode.
+	*/
+	irq_status = OMAP_MCSPI_IRQSTAT_TXEMPTY(spi->chip_select) |
+	    		OMAP_MCSPI_IRQSTAT_RXFULL(spi->chip_select);
+
+	/* configure SPI as receive/transmit */
+	/* Note: We do not have SLAVE support yet*/
+	if (chip_info->master) 
+		chconfig |=	OMAP_MCSPI_CHCONF_IS_DL0RECEIVE |
+		   		OMAP_MCSPI_CHCONF_DPE1_TRANSMIT	|
+			       	OMAP_MCSPI_CHCONF_DPE0_NO_TRANSMIT;
+	else 
+		chconfig |= 	OMAP_MCSPI_CHCONF_IS_DL1RECEIVE | 
+		    		OMAP_MCSPI_CHCONF_DPE0_TRANSMIT;
+
+	chconfig |= OMAP_MCSPI_CHCONF_TXRX(chip_info->txrx)	 	|
+		    OMAP_MCSPI_CHCONF_WL(chip_info->bits_per_word)	|
+		    OMAP_MCSPI_CHCONF_CLKD(chip_info->clkdiv) 		|
+		    OMAP_MCSPI_CHCONF_PHA((spi->mode & SPI_CPHA) != 0) 	|
+		    OMAP_MCSPI_CHCONF_POL((spi->mode & SPI_CPOL) != 0) 	|
+		    OMAP_MCSPI_CHCONF_CSPOL((chip_info->cspol &
+					    SPI_CS_HIGH) != 0);
+	    	    	
+	omap_spi_write(omap_spi_dev, chconfig, OMAP_MCSPI_CHCONF(cs));
+
+	omap_spi_write(omap_spi_dev, irq_status, OMAP_MCSPI_IRQSTATUS);
+
+	/* Activate channel */
+	omap_spi_write(omap_spi_dev, OMAP_MCSPI_CHCTRL_ACTIVE,
+		       OMAP_MCSPI_CHCTRL(cs));
+
+	if (spi->bits_per_word <= 8) {
+		chip->nbytes	= 1;
+		chip->write	= tx_8;
+		chip->read	= rx_8;
+	}
+	else if (spi->bits_per_word <= 16) {
+		chip->nbytes	= 2;
+		chip->write	= tx_16;
+		chip->read	= rx_16;
+	}
+	else if (spi->bits_per_word <= 32) {
+		chip->nbytes 	= 4;
+		/* REVISIT assign read-write function pointers */
+	}
+	else {
+		printk(KERN_ERR "invalid wordsize\n");
+		kfree(chip);
+		return -ENODEV;
+	}
+		
+	spi_set_ctldata(spi, chip);
+	
+	return 0;
+}
+
+static int omap_spi_get_clocks(struct omap_spi_dev *omap_spi_dev, int bus)
+{
+	omap_spi_dev->iclk = clk_get(NULL,
+		bus == 1 ? "mcspi1_ick" : "mcspi2_ick");
+	if (IS_ERR(omap_spi_dev->iclk)) {
+		return -ENODEV;
+	}
+
+	omap_spi_dev->fclk = clk_get(NULL,
+		bus == 1 ? "mcspi1_fck" : "mcspi2_fck");
+	if (IS_ERR(omap_spi_dev->fclk)) {
+		clk_put(omap_spi_dev->fclk);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static void omap_spi_put_clocks(struct omap_spi_dev *omap_spi_dev)
+{
+	clk_put(omap_spi_dev->fclk);
+	clk_put(omap_spi_dev->iclk);
+}
+
+static void omap_spi_enable_clocks(struct omap_spi_dev *omap_spi_dev,
+					int enable)
+{
+	if (enable) {
+		clk_use(omap_spi_dev->iclk);
+		clk_use(omap_spi_dev->fclk);
+	} else {
+		clk_unuse(omap_spi_dev->iclk);
+		clk_unuse(omap_spi_dev->fclk);
+	}
+}
+
+static int __init omap_spi_probe(struct platform_device *pdev)
+{
+	struct resource 	*mem;
+	struct omap_spi_dev 	*omap_spi_dev;
+	struct spi_master 	*master;
+	int irq = NO_IRQ;
+	int status;
+
+	if (!pdev->dev.platform_data) {
+		printk(KERN_ERR "No platform data!\n");
+		return -ENOENT;
+	}
+
+	master = spi_alloc_master(&pdev->dev, sizeof *omap_spi_dev);
+	if (!master)
+		return -ENOMEM;
+
+	omap_spi_dev		= spi_master_get_devdata(master);
+	omap_spi_dev->master	= master;
+	omap_spi_dev->pdata	= pdev->dev.platform_data;
+
+	INIT_LIST_HEAD(&omap_spi_dev->queue);
+	spin_lock_init(&omap_spi_dev->lock);
+
+	tasklet_init(&omap_spi_dev->spi_xfer_msgs,
+			spi_xfer_msgs,
+   			(unsigned long)omap_spi_dev);
+
+	tasklet_init(&omap_spi_dev->spi_xfers,
+			spi_xfers,
+   			(unsigned long)omap_spi_dev);
+
+	/*
+	 * SPI hookup
+	 */
+	master->bus_num 	= omap_spi_dev->pdata->bus_num;
+	master->num_chipselect	= omap_spi_dev->pdata->num_chipselect;
+	master->cleanup		= omap_spi_cleanup;
+	master->setup		= omap_spi_setup;
+	master->transfer	= omap_spi_transfer;
+
+	/* Setup register addresses */
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		printk(KERN_ERR "can not find platform io memory\n");
+		status = -ENODEV;
+		goto err1;
+	}
+
+	status = (int) request_mem_region(mem->start, (mem->end - mem->start) + 1,
+			DRIVER_NAME);
+	if (!status) {
+		printk(KERN_ERR "%s: SPI region already claimed\n", DRIVER_NAME);
+		status = -EBUSY;
+		goto err1;
+	}
+
+	omap_spi_dev->base = (void __iomem*)IO_ADDRESS(mem->start);
+
+	/* Attach to IRQ */
+	irq = platform_get_irq(pdev, 0);
+	if (!irq) {
+		printk(KERN_ERR "no irq for resource\n");
+		status = -ENODEV;
+		goto err2;
+	}
+
+	if ((status = omap_spi_get_clocks(omap_spi_dev, pdev->id)) != 0) {
+		printk(KERN_ERR "Can't get spi%d clocks\n", pdev->id);
+		goto err2;
+	}
+
+	omap_spi_enable_clocks(omap_spi_dev, 1);
+
+	omap_spi_reset(omap_spi_dev);
+	
+	omap_spi_dev->irq = irq;
+
+	
+	status = request_irq(omap_spi_dev->irq, omap_spi_isr, 0,
+			DRIVER_NAME, omap_spi_dev);
+	if (status) {
+		printk(KERN_ERR "%s: failure requesting irq %i\n",
+			 DRIVER_NAME, omap_spi_dev->irq);
+		goto do_unuse_clocks;
+	}
+
+	platform_set_drvdata(pdev, master);
+	status = spi_register_master(master);
+	if (status != 0) {
+		printk(KERN_ERR "Unable to register spi master\n");
+		goto do_free_irq;
+	}
+	printk(KERN_INFO "omap_spi_probe\n");
+	return 0;
+
+do_free_irq:
+	free_irq(omap_spi_dev->irq, omap_spi_dev);
+do_unuse_clocks:
+	omap_spi_enable_clocks(omap_spi_dev, 0);
+	omap_spi_put_clocks(omap_spi_dev);
+err2:
+	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+err1:
+	spi_master_put(master); /*REVISIT*/
+	return status;
+}
+
+static int omap_spi_remove(struct platform_device *pdev)
+{
+	struct resource *mem;
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct omap_spi_dev *omap_spi_dev = spi_master_get_devdata(master);
+
+	free_irq(omap_spi_dev->irq, omap_spi_dev);
+	omap_spi_enable_clocks(omap_spi_dev, 0);
+	omap_spi_put_clocks(omap_spi_dev);
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, (mem->end - mem->start) + 1);
+	spi_unregister_master(master);
+	printk(KERN_INFO "omap_spi_remove\n");
+	return 0;
+}
+
+static struct platform_driver spi_driver = {
+	.probe 	= omap_spi_probe,
+	.remove = omap_spi_remove,
+	.driver	= {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static char __initdata banner[] = KERN_INFO "OMAP2 SPI Driver\n";
+
+static int __init omap2_spi_init(void)
+{
+	printk(banner);
+	platform_driver_register(&spi_driver);
+	return 0;
+}
+
+static void __exit omap2_spi_exit(void)
+{
+	platform_driver_unregister(&spi_driver);
+}
+
+module_init(omap2_spi_init);
+module_exit(omap2_spi_exit);
+
+MODULE_DESCRIPTION("OMAP2 SPI driver");
+MODULE_AUTHOR("Komal Shah");
+MODULE_LICENSE("GPL");
+
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index 8d1c62e..b12b8f2 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -410,6 +410,9 @@ enum omap24xx_index {
 	/* 24xx GPIO */
 	Y20_24XX_GPIO60,
 	M15_24XX_GPIO92,
+	
+	/* TSC IRQ*/
+	P20_24XX_TSC_IRQ,
 };
 
 #ifdef	CONFIG_OMAP_MUX
diff --git a/include/asm-arm/arch-omap/spi.h b/include/asm-arm/arch-omap/spi.h
new file mode 100644
index 0000000..e594c4f
--- /dev/null
+++ b/include/asm-arm/arch-omap/spi.h
@@ -0,0 +1,43 @@
+/*
+ * File: include/asm-arm/arch-omap/spi.h
+ *
+ * Copyright (C) 2005 Komal Shah <komal_shah802003@yahoo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#ifndef _OMAPSPI_H
+#define _OMAPSPI_H
+
+struct omap_spi_platform_info {
+	int bus_num;
+	int num_chipselect;
+};
+
+struct omap_spi_chip {
+	int mode;			/* clk phase and polarity */
+	int master:1;			/* master(1)/slave(0) */
+#define OMAP_MCSPI_TXRX		0
+#define OMAP_MCSPI_TXONLY	1
+#define OMAP_MCSPI_RXONLY	2
+	int txrx;
+	int bits_per_word;		/* word length */
+	int clkdiv;			/* clock divisor, it is a logarithmic base 2
+					   number*/
+	int cspol;			/* SPI CS polarity */
+	int endianess:1;		/* little or big endian*/
+};
+
+#endif /* _OMAPSPI_H */
diff --git a/include/asm-arm/hardware/tsc2101.h b/include/asm-arm/hardware/tsc2101.h
diff --git a/include/linux/list.h b/include/linux/list.h
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
diff --git a/include/linux/spi/tsc2101.h b/include/linux/spi/tsc2101.h
new file mode 100644
index 0000000..f483b07
--- /dev/null
+++ b/include/linux/spi/tsc2101.h
@@ -0,0 +1,18 @@
+/* linux/spi/tsc2101.h */
+
+/* Touchscreen characteristics vary between boards and models.  The
+ * platform_data for the device's "struct device" holds this information.
+ *
+ * It's OK if the min/max values are zero.
+ */
+struct tsc2101_platform_data {
+	u16	model;			/* 7843, 7845, 7846. */
+	u16	vref_delay_usecs;	/* 0 for external vref; etc */
+	u16	x_plate_ohms;
+	u16	y_plate_ohms;
+
+	u16	x_min, x_max;
+	u16	y_min, y_max;
+	u16	pressure_min, pressure_max;
+};
+

--0-933043383-1136547615=:56685
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--0-933043383-1136547615=:56685--
