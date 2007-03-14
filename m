From: Imre Deak <imre.deak@solidboot.com>
Subject: Re: TSC2101/2102
Date: Wed, 14 Mar 2007 19:09:54 +0200
Message-ID: <20070314170952.GB10230@bitbox.mine.nu>
References: <20070309140650.GC4399@bitbox.mine.nu>
	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
	<45F7F6D4.20203@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45F7F6D4.20203@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2007 at 08:21:24AM -0500, Nishanth Menon wrote:
> andrzej zaborowski stated on 3/9/2007 8:23 AM:
> > On 09/03/07, Imre Deak <imre.deak@solidboot.com> wrote:
> >> I'm wondering about the proper way to convert the existing omap-tsc2101
> >> driver to the SPI framework. Would it make sense to handle it with the
> >> tsc2102 driver? omap-tsc2101 has only the register read / write
> >> interface
> >> which is the same as in tsc2102.
> >
> > How about maybe a header file <linux/spi/tsc2xxx.h> shared between
> > tsc2101/2102 with the register access functions as "static inline"
> > functions?
> Some TODOs:
> 1. should interrupt muxing be done here?
> 2. There are some TSC2005 devices(TS only).. so it will be interesting
> to see xxxx.h scales to all..
> 3. rename this to tsc2xxx_core.[ch]
> 4. use SPI framework (would not break uwire support I believe).

The attached patches try to do #4. Please review it / sign it off as
necessary.

There is an upcoming TSC2301 patch, that should also be taken
into account when creating a tsc2xxx-core.[ch] based on the existing
TSC driver implementations.

--Imre

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-TSC2101-convert-existing-driver-to-use-the-SPI-framework.patch"

>From 3ac516c27d9d8facf1ac925e1444984849208678 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@solidboot.com>
Date: Wed, 14 Mar 2007 18:57:44 +0200
Subject: [PATCH] TSC2101: convert existing driver to use the SPI framework

The new driver is functionally the same as the old
drivers/ssi/omap-tsc2101 driver.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 drivers/spi/Kconfig         |    8 +
 drivers/spi/Makefile        |    1 +
 drivers/spi/tsc2101.c       |  316 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/tsc2101.h |   43 ++++++
 4 files changed, 368 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/tsc2101.c
 create mode 100644 include/linux/spi/tsc2101.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bde6231..e9b871f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -149,6 +149,14 @@ config SPI_OMAP24XX
 comment "SPI Protocol Masters"
 	depends on SPI_MASTER
 
+config TSC2101
+	depends on SPI_MASTER
+	tristate "TSC2101 chip support"
+	---help---
+	  Say Y here if you want support for the TSC2101 chip.
+	  At the moment it provides basic register read / write interface
+	  as well as a way to enable the MCLK clock.
+
 config TSC2102
 	depends on SPI_MASTER
 	tristate "TSC2102 codec support"
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6d84bac..822121a 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SPI_OMAP_UWIRE)		+= omap_uwire.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
+obj-$(CONFIG_TSC2101)			+= tsc2101.o
 obj-$(CONFIG_TSC2102)			+= tsc2102.o
 obj-$(CONFIG_SPI_AT25)		+= at25.o
 # 	... add above this line ...
diff --git a/drivers/spi/tsc2101.c b/drivers/spi/tsc2101.c
new file mode 100644
index 0000000..258d856
--- /dev/null
+++ b/drivers/spi/tsc2101.c
@@ -0,0 +1,316 @@
+/*
+ * linux/drivers/spi/tsc2101.c
+ *
+ * TSC2101 codec interface driver for the OMAP platform
+ *
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * History:
+ *
+ * 2004/11/07   Nishanth Menon - Modified for common hooks for Audio and Touchscreen
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2101.h>
+
+struct tsc2101_device {
+	struct mutex		mutex;
+	int			mclk_enabled;
+	struct clock		*mclk_ck;
+	struct spi_message	message;
+	struct spi_transfer	transfer[2];
+	u16			command;
+	void			(*enable_mclk)(struct spi_device *spi);
+	void			(*disable_mclk)(struct spi_device *spi);
+};
+
+int tsc2101_enable_mclk(struct spi_device *spi)
+{
+	struct tsc2101_device *tsc2101;
+
+	tsc2101 = spi_get_drvdata(spi);
+
+	mutex_lock(&tsc2101->mutex);
+
+	if (spi->dev.power.power_state.event != PM_EVENT_ON) {
+		mutex_unlock(&tsc2101->mutex);
+		return -ENODEV;
+	}
+
+	if (tsc2101->mclk_enabled++ == 0) {
+		if (tsc2101->enable_mclk != NULL)
+			tsc2101->enable_mclk(spi);
+	}
+
+	mutex_unlock(&tsc2101->mutex);
+	return 0;
+}
+EXPORT_SYMBOL(tsc2101_enable_mclk);
+
+void tsc2101_disable_mclk(struct spi_device *spi)
+{
+	struct tsc2101_device *tsc2101;
+
+	tsc2101 = spi_get_drvdata(spi);
+
+	mutex_lock(&tsc2101->mutex);
+
+	if (--tsc2101->mclk_enabled == 0) {
+		if (tsc2101->disable_mclk != NULL &&
+		    spi->dev.power.power_state.event == PM_EVENT_ON)
+			tsc2101->disable_mclk(spi);
+	}
+
+	mutex_lock(&tsc2101->mutex);
+}
+EXPORT_SYMBOL(tsc2101_disable_mclk);
+
+int tsc2101_write_sync(struct spi_device *spi, int page, u8 address, u16 data)
+{
+	struct tsc2101_device *tsc2101;
+	struct spi_message *m;
+	struct spi_transfer *t;
+	int ret;
+
+	tsc2101 = spi_get_drvdata(spi);
+
+	mutex_lock(&tsc2101->mutex);
+	if (spi->dev.power.power_state.event != PM_EVENT_ON) {
+		mutex_unlock(&tsc2101->mutex);
+		return -ENODEV;
+	}
+
+	m = &tsc2101->message;
+	spi_message_init(m);
+	t = &tsc2101->transfer[0];
+	memset(t, 0, sizeof(tsc2101->transfer));
+
+	/* Address */
+	tsc2101->command = (page << 11) | (address << 5);
+	t->tx_buf = &tsc2101->command;
+	t->len = 2;
+	spi_message_add_tail(t, m);
+
+	/* Data */
+	t++;
+	t->tx_buf = &data;
+	t->len = 2;
+	spi_message_add_tail(t, m);
+
+	ret = spi_sync(spi, m);
+	if (!ret)
+		ret = tsc2101->message.status;
+	mutex_unlock(&tsc2101->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(tsc2101_write_sync);
+
+int tsc2101_reads_sync(struct spi_device *spi,
+		       int page, u8 startaddress, u16 *data, int numregs)
+{
+	struct tsc2101_device *tsc2101;
+	struct spi_message *m;
+	struct spi_transfer *t;
+	int ret;
+
+	tsc2101 = spi_get_drvdata(spi);
+
+	mutex_lock(&tsc2101->mutex);
+	if (spi->dev.power.power_state.event != PM_EVENT_ON) {
+		mutex_unlock(&tsc2101->mutex);
+		return -ENODEV;
+	}
+
+	m = &tsc2101->message;
+	spi_message_init(m);
+	t = &tsc2101->transfer[0];
+	memset(t, 0, sizeof(tsc2101->transfer));
+
+	/* Address */
+	tsc2101->command = 0x8000 | (page << 11) | (startaddress << 5);
+	t->tx_buf = &tsc2101->command;
+	t->len = 2;
+	spi_message_add_tail(t, m);
+
+	/* Data */
+	t++;
+	t->rx_buf = data;
+	t->len = numregs << 1;
+	spi_message_add_tail(t, m);
+
+	ret = spi_sync(spi, m);
+	if (!ret)
+		ret = tsc2101->message.status;
+
+	mutex_unlock(&tsc2101->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(tsc2101_reads_sync);
+
+int tsc2101_read_sync(struct spi_device *spi, int page, u8 address)
+{
+	int err;
+	u16 val;
+
+	err = tsc2101_reads_sync(spi, page, address, &val, 1);
+	if (err)
+		return err;
+	return val;
+}
+EXPORT_SYMBOL(tsc2101_read_sync);
+
+static int tsc2101_suspend(struct spi_device *spi, pm_message_t state)
+{
+	struct tsc2101_device *tsc2101;
+
+	tsc2101 = spi_get_drvdata(spi);
+
+	if (tsc2101 == NULL)
+		return 0;
+
+	mutex_lock(&tsc2101->mutex);
+
+	spi->dev.power.power_state = state;
+	if (tsc2101->mclk_enabled && tsc2101->disable_mclk != NULL)
+		tsc2101->disable_mclk(spi);
+
+	mutex_unlock(&tsc2101->mutex);
+
+	return 0;
+}
+
+static int tsc2101_resume(struct spi_device *spi)
+{
+	struct tsc2101_device *tsc2101;
+
+	tsc2101 = spi_get_drvdata(spi);
+
+	if (tsc2101 == NULL)
+		return 0;
+
+	mutex_lock(&tsc2101->mutex);
+
+	spi->dev.power.power_state = PMSG_ON;
+	if (tsc2101->mclk_enabled && tsc2101->enable_mclk != NULL)
+		tsc2101->enable_mclk(spi);
+
+	mutex_unlock(&tsc2101->mutex);
+
+	return 0;
+}
+
+static int tsc2101_probe(struct spi_device *spi)
+{
+	struct tsc2101_platform_data *pdata;
+	struct tsc2101_device *tsc2101;
+	u16 w;
+	int r;
+
+	pdata = spi->dev.platform_data;
+	if (pdata == NULL) {
+		dev_err(&spi->dev, "no platform data\n");
+		return -ENODEV;
+	}
+
+	tsc2101 = kzalloc(sizeof(*tsc2101), GFP_KERNEL);
+	if (tsc2101 == NULL) {
+		dev_err(&spi->dev, "out of mem\n");
+		return -ENOMEM;
+	}
+
+	spi_set_drvdata(spi, tsc2101);
+	tsc2101->enable_mclk = pdata->enable_mclk;
+	tsc2101->disable_mclk = pdata->disable_mclk;
+
+	mutex_init(&tsc2101->mutex);
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 16;
+	if ((r = spi_setup(spi)) < 0) {
+		dev_err(&spi->dev, "SPI setup failed\n");
+		goto err;
+	}
+
+	w = tsc2101_read_sync(spi, 1, 0);
+	if (!(w & (1 << 14))) {
+		dev_err(&spi->dev, "invalid ADC register value %04x\n", w);
+		goto err;
+	}
+
+	if (pdata->init != NULL) {
+		if ((r = pdata->init(spi)) < 0) {
+			dev_err(&spi->dev, "platform init failed\n");
+			goto err;
+		}
+	}
+
+	dev_info(&spi->dev, "initialized\n");
+
+	return 0;
+err:
+	kfree(tsc2101);
+	return r;
+}
+
+static int tsc2101_remove(struct spi_device *spi)
+{
+	struct tsc2101_platform_data *pdata;
+	struct tsc2101_device *tsc2101;
+
+	pdata = spi->dev.platform_data;
+	tsc2101 = spi_get_drvdata(spi);
+
+	/* We assume that this can't race with the rest of the driver. */
+	if (tsc2101->mclk_enabled && tsc2101->disable_mclk != NULL)
+		tsc2101->disable_mclk(spi);
+
+	if (pdata->cleanup != NULL)
+		pdata->cleanup(spi);
+
+	spi_set_drvdata(spi, NULL);
+	kfree(tsc2101);
+
+	return 0;
+}
+
+static struct spi_driver tsc2101_driver = {
+	.probe		= tsc2101_probe,
+	.remove		= tsc2101_remove,
+	.suspend	= tsc2101_suspend,
+	.resume		= tsc2101_resume,
+	.driver		= {
+		.name	= "tsc2101",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int tsc2101_init(void)
+{
+	return spi_register_driver(&tsc2101_driver);
+}
+
+static void tsc2101_exit(void)
+{
+	spi_unregister_driver(&tsc2101_driver);
+}
+
+module_init(tsc2101_init);
+module_exit(tsc2101_exit);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION
+    ("Glue audio driver for the TI OMAP1610/OMAP1710 TSC2101 codec.");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/spi/tsc2101.h b/include/linux/spi/tsc2101.h
new file mode 100644
index 0000000..01e6d23
--- /dev/null
+++ b/include/linux/spi/tsc2101.h
@@ -0,0 +1,43 @@
+/*
+ * include/linux/spi/tsc2101.h
+ *
+ * TSC2101 codec interface driver for the OMAP platform
+ *
+ * Copyright (C) 2004 Texas Instruments, Inc.
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * History:
+ *
+ * 2004/11/07   Nishanth Menon - Provided common hooks for Audio and Touchscreen
+ */
+
+#ifndef __OMAP_TSC2101_H
+#define __OMAP_TSC2101_H
+
+#include <linux/spi/spi.h>
+
+struct tsc2101_platform_data {
+	int	(*init)(struct spi_device *spi);
+	void	(*cleanup)(struct spi_device *spi);
+	void	(*enable_mclk)(struct spi_device *spi);
+	void	(*disable_mclk)(struct spi_device *spi);
+};
+
+extern int tsc2101_read_sync(struct spi_device *spi, int page, u8 address);
+extern int tsc2101_reads_sync(struct spi_device *spi, int page,
+			       u8 startaddress, u16 * data, int numregs);
+extern int tsc2101_write_sync(struct spi_device *spi, int page, u8 address,
+			       u16 data);
+
+extern int tsc2101_enable_mclk(struct spi_device *spi);
+extern void tsc2101_disable_mclk(struct spi_device *spi);
+
+#endif
+
-- 
1.5.0.rc3


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-ARM-OMAP-TSC2101-add-platform-init-registration-to-board-files.patch"

>From 9c10561f8acef67715e635842bd06e189607c5d2 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@solidboot.com>
Date: Wed, 14 Mar 2007 17:52:42 +0200
Subject: [PATCH] ARM: OMAP: TSC2101: add platform init / registration to board files

H2 / H3 boards use this chip, update their board files.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 arch/arm/mach-omap1/board-h2.c |   77 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/board-h3.c |   88 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index f1a824e..bf8511f 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -28,6 +28,9 @@
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
 #include <linux/workqueue.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2101.h>
+#include <linux/clk.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -294,6 +297,78 @@ static struct platform_device h2_lcd_device = {
 	.id		= -1,
 };
 
+struct {
+	struct clk	*mclk;
+	int		initialized;
+} h2_tsc2101;
+
+#define TSC2101_MUX_MCLK_ON	R10_1610_MCLK_ON
+#define TSC2101_MUX_MCLK_OFF	R10_1610_MCLK_OFF
+
+static int h2_tsc2101_init(struct spi_device *spi)
+{
+	int r;
+
+	if (h2_tsc2101.initialized) {
+		printk(KERN_ERR "tsc2101: already initialized\n");
+		return -ENODEV;
+	}
+
+	/* Get the MCLK */
+	h2_tsc2101.mclk = clk_get(&spi->dev, "mclk");
+	if (IS_ERR(h2_tsc2101.mclk)) {
+		dev_err(&spi->dev, "unable to get the clock MCLK\n");
+		return PTR_ERR(h2_tsc2101.mclk);
+	}
+	if ((r = clk_set_rate(h2_tsc2101.mclk, 12000000)) < 0) {
+		dev_err(&spi->dev, "unable to set rate to the MCLK\n");
+		goto err;
+	}
+
+	omap_cfg_reg(TSC2101_MUX_MCLK_OFF);
+	omap_cfg_reg(N15_1610_UWIRE_CS1);
+
+	return 0;
+err:
+	clk_put(h2_tsc2101.mclk);
+	return r;
+}
+
+static void h2_tsc2101_cleanup(struct spi_device *spi)
+{
+	clk_put(h2_tsc2101.mclk);
+	omap_cfg_reg(TSC2101_MUX_MCLK_OFF);
+}
+
+static void h2_tsc2101_enable_mclk(struct spi_device *spi)
+{
+	omap_cfg_reg(TSC2101_MUX_MCLK_ON);
+	clk_enable(h2_tsc2101.mclk);
+}
+
+static void h2_tsc2101_disable_mclk(struct spi_device *spi)
+{
+	clk_disable(h2_tsc2101.mclk);
+	omap_cfg_reg(R10_1610_MCLK_OFF);
+}
+
+static struct tsc2101_platform_data h2_tsc2101_platform_data = {
+	.init		= h2_tsc2101_init,
+	.cleanup	= h2_tsc2101_cleanup,
+	.enable_mclk	= h2_tsc2101_enable_mclk,
+	.disable_mclk	= h2_tsc2101_disable_mclk,
+};
+
+static struct spi_board_info h2_spi_board_info[] __initdata = {
+	[0] = {
+		.modalias	= "tsc2101",
+		.bus_num	= 2,
+		.chip_select	= 1,
+		.max_speed_hz	= 16000000,
+		.platform_data	= &h2_tsc2101_platform_data,
+	},
+};
+
 static struct omap_mcbsp_reg_cfg mcbsp_regs = {
 	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
 	.spcr1 = RINTM(3) | RRST,
@@ -438,6 +513,8 @@ static void __init h2_init(void)
 #endif
 
 	platform_add_devices(h2_devices, ARRAY_SIZE(h2_devices));
+	spi_register_board_info(h2_spi_board_info,
+				ARRAY_SIZE(h2_spi_board_info));
 	omap_board_config = h2_config;
 	omap_board_config_size = ARRAY_SIZE(h2_config);
 	omap_serial_init();
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 4167f34..5ff9037 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -25,6 +25,9 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
+#include <linux/clk.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2101.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -371,6 +374,89 @@ static struct platform_device h3_lcd_device = {
 	.id		= -1,
 };
 
+struct {
+	struct clk	*mclk;
+	int		initialized;
+} h3_tsc2101;
+
+#define TSC2101_MUX_MCLK_ON	V5_1710_MCLK_ON
+#define TSC2101_MUX_MCLK_OFF	V5_1710_MCLK_OFF
+
+static int h3_tsc2101_init(struct spi_device *spi)
+{
+	u8 io_exp_val;
+	int r;
+
+	if (h3_tsc2101.initialized) {
+		printk(KERN_ERR "tsc2101: already initialized\n");
+		return -ENODEV;
+	}
+
+	/* Get the MCLK */
+	h3_tsc2101.mclk = clk_get(&spi->dev, "mclk");
+	if (IS_ERR(h3_tsc2101.mclk)) {
+		dev_err(&spi->dev, "unable to get the clock MCLK\n");
+		return PTR_ERR(h3_tsc2101.mclk);
+	}
+	if ((r = clk_set_rate(h3_tsc2101.mclk, 12000000)) < 0) {
+		dev_err(&spi->dev, "unable to set rate to the MCLK\n");
+		goto err;
+	}
+
+	if ((r = read_gpio_expa(&io_exp_val, 0x24))) {
+		dev_err(&spi->dev, "error reading from I/O EXPANDER\n");
+		goto err;
+	}
+	io_exp_val |= 0x8;
+	if ((r = write_gpio_expa(io_exp_val, 0x24))) {
+		dev_err(&spi->dev, "error writing to I/O EXPANDER\n");
+		goto err;
+	}
+
+	omap_cfg_reg(N14_1610_UWIRE_CS0);
+	omap_cfg_reg(TSC2101_MUX_MCLK_OFF);
+
+	return 0;
+err:
+	clk_put(h3_tsc2101.mclk);
+	return r;
+}
+
+static void h3_tsc2101_cleanup(struct spi_device *spi)
+{
+	clk_put(h3_tsc2101.mclk);
+	omap_cfg_reg(TSC2101_MUX_MCLK_OFF);
+}
+
+static void h3_tsc2101_enable_mclk(struct spi_device *spi)
+{
+	omap_cfg_reg(TSC2101_MUX_MCLK_ON);
+	clk_enable(h3_tsc2101.mclk);
+}
+
+static void h3_tsc2101_disable_mclk(struct spi_device *spi)
+{
+	clk_disable(h3_tsc2101.mclk);
+	omap_cfg_reg(R10_1610_MCLK_OFF);
+}
+
+static struct tsc2101_platform_data h3_tsc2101_platform_data = {
+	.init		= h3_tsc2101_init,
+	.cleanup	= h3_tsc2101_cleanup,
+	.enable_mclk	= h3_tsc2101_enable_mclk,
+	.disable_mclk	= h3_tsc2101_disable_mclk,
+};
+
+static struct spi_board_info h3_spi_board_info[] __initdata = {
+	[0] = {
+		.modalias	= "tsc2101",
+		.bus_num	= 2,
+		.chip_select	= 0,
+		.max_speed_hz	= 16000000,
+		.platform_data	= &h3_tsc2101_platform_data,
+	},
+};
+
 static struct omap_mcbsp_reg_cfg mcbsp_regs = {
 	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
 	.spcr1 = RINTM(3) | RRST,
@@ -484,6 +570,8 @@ static void __init h3_init(void)
 	omap_cfg_reg(V2_1710_GPIO10);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
+	spi_register_board_info(h3_spi_board_info,
+				ARRAY_SIZE(h3_spi_board_info));
 	omap_board_config = h3_config;
 	omap_board_config_size = ARRAY_SIZE(h3_config);
 	omap_serial_init();
-- 
1.5.0.rc3


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-ARM-OMAP-update-H2-H3-defconfig.patch"

>From 6c5d62dc669071afb2f4a7e8d1514c13ddc8a7b9 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@solidboot.com>
Date: Wed, 14 Mar 2007 18:06:26 +0200
Subject: [PATCH] ARM: OMAP: update H2 / H3 defconfig

Enable the new TSC2101 driver.

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 arch/arm/configs/omap_h2_1610_defconfig |   86 +++++--
 arch/arm/configs/omap_h3_1710_defconfig |  410 +++++++++++++++++++++++--------
 2 files changed, 372 insertions(+), 124 deletions(-)

diff --git a/arch/arm/configs/omap_h2_1610_defconfig b/arch/arm/configs/omap_h2_1610_defconfig
index 65be6fb..7c246b9 100644
--- a/arch/arm/configs/omap_h2_1610_defconfig
+++ b/arch/arm/configs/omap_h2_1610_defconfig
@@ -1,11 +1,14 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc3-omap1
-# Thu Jan  4 16:07:28 2007
+# Linux kernel version: 2.6.21-rc3-omap1
+# Wed Mar 14 18:03:53 2007
 #
 CONFIG_ARM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
 # CONFIG_GENERIC_TIME is not set
 CONFIG_MMU=y
+# CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
@@ -15,6 +18,7 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ZONE_DMA=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
@@ -33,6 +37,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -41,6 +46,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_IKCONFIG is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
@@ -120,6 +126,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ARCH_IXP2000 is not set
 # CONFIG_ARCH_IXP23XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -149,6 +156,8 @@ CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_OMAP_MUX_WARNINGS=y
 # CONFIG_OMAP_STI is not set
 CONFIG_OMAP_MCBSP=y
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
 # CONFIG_OMAP_DM_TIMER is not set
@@ -207,6 +216,7 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_WRITETHROUGH is not set
 # CONFIG_CPU_CACHE_ROUND_ROBIN is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
@@ -234,6 +244,7 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4096
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_LEDS=y
 # CONFIG_LEDS_TIMER is not set
 # CONFIG_LEDS_CPU is not set
@@ -246,6 +257,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=32M console=ttyS0,115200n8 root=/dev/ram0 rw initrd=0x10600000,8M ramdisk_size=8192"
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
 # CPU Frequency scaling
@@ -279,7 +291,7 @@ CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
 # CONFIG_PM_SYSFS_DEPRECATED is not set
-# CONFIG_APM is not set
+# CONFIG_APM_EMULATION is not set
 
 #
 # Networking
@@ -296,6 +308,7 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
@@ -380,6 +393,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 CONFIG_DEBUG_DRIVER=y
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
@@ -403,6 +417,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
@@ -448,6 +463,8 @@ CONFIG_MTD_CFI_UTIL=y
 #
 # Self-contained MTD device drivers
 #
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -478,6 +495,7 @@ CONFIG_MTD_CFI_UTIL=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -491,7 +509,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -677,7 +694,6 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 # CONFIG_USBPCWATCHDOG is not set
 CONFIG_HW_RANDOM=m
 CONFIG_HW_RANDOM_OMAP=m
-# CONFIG_OMAP_RNG is not set
 # CONFIG_NVRAM is not set
 CONFIG_OMAP_RTC=y
 # CONFIG_DTLK is not set
@@ -733,8 +749,22 @@ CONFIG_TPS65010=y
 #
 # SPI support
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_OMAP_UWIRE=y
+
+#
+# SPI Protocol Masters
+#
+CONFIG_TSC2101=y
+# CONFIG_TSC2102 is not set
+# CONFIG_SPI_AT25 is not set
 
 #
 # Dallas's 1-wire bus
@@ -750,6 +780,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
@@ -762,6 +793,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM70 is not set
 # CONFIG_SENSORS_LM75 is not set
 # CONFIG_SENSORS_LM77 is not set
 # CONFIG_SENSORS_LM78 is not set
@@ -790,7 +822,11 @@ CONFIG_HWMON=y
 #
 # Misc devices
 #
-# CONFIG_TIFM_CORE is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
 
 #
 # LED devices
@@ -819,23 +855,30 @@ CONFIG_HWMON=y
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
 CONFIG_FB_MODE_HELPERS=y
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frambuffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
-# CONFIG_FB_VIRTUAL is not set
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
 # CONFIG_FB_OMAP_LCD_MIPID is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_OMAP_DMA_TUNE is not set
+# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
@@ -855,7 +898,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -866,6 +908,7 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
 # USB support
@@ -880,10 +923,8 @@ CONFIG_USB=y
 # Miscellaneous USB options
 #
 CONFIG_USB_DEVICEFS=y
-# CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
 CONFIG_USB_SUSPEND=y
-# CONFIG_USB_MULTITHREAD_PROBE is not set
 CONFIG_USB_OTG=y
 CONFIG_USB_OTG_WHITELIST=y
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
@@ -893,7 +934,8 @@ CONFIG_USB_OTG_WHITELIST=y
 #
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=y
-# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_SL811_HCD is not set
 # CONFIG_USB_MUSB_HDRC is not set
@@ -936,6 +978,7 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 # CONFIG_USB_APPLETOUCH is not set
+# CONFIG_USB_GTCO is not set
 
 #
 # USB Imaging devices
@@ -972,6 +1015,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
@@ -981,6 +1025,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
 CONFIG_USB_TEST=y
 
 #
@@ -1022,12 +1067,6 @@ CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 
 #
-# Synchronous Serial Interfaces (SSI)
-#
-CONFIG_OMAP_UWIRE=y
-# CONFIG_OMAP_TSC2101 is not set
-
-#
 # CBUS support
 #
 # CONFIG_CBUS is not set
@@ -1199,15 +1238,16 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1218,6 +1258,7 @@ CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_POINTER=y
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
 # CONFIG_DEBUG_LL is not set
@@ -1244,4 +1285,5 @@ CONFIG_CRC32=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
diff --git a/arch/arm/configs/omap_h3_1710_defconfig b/arch/arm/configs/omap_h3_1710_defconfig
index 5e2c5b1..307277c 100644
--- a/arch/arm/configs/omap_h3_1710_defconfig
+++ b/arch/arm/configs/omap_h3_1710_defconfig
@@ -1,19 +1,31 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.14-rc4-omap1
-# Tue Oct 18 17:58:27 2005
+# Linux kernel version: 2.6.21-rc3-omap1
+# Wed Mar 14 18:04:35 2007
 #
 CONFIG_ARM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
+# CONFIG_GENERIC_TIME is not set
 CONFIG_MMU=y
-CONFIG_UID16=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_HARDIRQS_SW_RESEND=y
+CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ZONE_DMA=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
@@ -24,31 +36,40 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
-# CONFIG_HOTPLUG is not set
-CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_UID16=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
+CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
 
 #
 # Loadable module support
@@ -56,25 +77,57 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 # CONFIG_KMOD is not set
 
 #
+# Block layer
+#
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="cfq"
+
+#
 # System Type
 #
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
 # CONFIG_ARCH_CLPS7500 is not set
 # CONFIG_ARCH_CLPS711X is not set
 # CONFIG_ARCH_CO285 is not set
 # CONFIG_ARCH_EBSA110 is not set
-# CONFIG_ARCH_CAMELOT is not set
+# CONFIG_ARCH_EP93XX is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
-# CONFIG_ARCH_INTEGRATOR is not set
-# CONFIG_ARCH_IOP3XX is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP23XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
 # CONFIG_ARCH_SA1100 is not set
@@ -82,10 +135,6 @@ CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
 CONFIG_ARCH_OMAP=y
-# CONFIG_ARCH_VERSATILE is not set
-# CONFIG_ARCH_IMX is not set
-# CONFIG_ARCH_H720X is not set
-# CONFIG_ARCH_AAEC2000 is not set
 
 #
 # TI OMAP Implementations
@@ -99,9 +148,14 @@ CONFIG_ARCH_OMAP1=y
 #
 # CONFIG_OMAP_RESET_CLOCKS is not set
 # CONFIG_OMAP_BOOT_TAG is not set
+# CONFIG_OMAP_GPIO_SWITCH is not set
 CONFIG_OMAP_MUX=y
 # CONFIG_OMAP_MUX_DEBUG is not set
 CONFIG_OMAP_MUX_WARNINGS=y
+# CONFIG_OMAP_STI is not set
+CONFIG_OMAP_MCBSP=y
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
 # CONFIG_OMAP_DM_TIMER is not set
@@ -109,6 +163,7 @@ CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
 CONFIG_OMAP_SERIAL_WAKE=y
+# CONFIG_OMAP_DSP is not set
 
 #
 # OMAP Core Type
@@ -124,6 +179,7 @@ CONFIG_ARCH_OMAP16XX=y
 # CONFIG_MACH_OMAP_H2 is not set
 CONFIG_MACH_OMAP_H3=y
 # CONFIG_MACH_OMAP_OSK is not set
+# CONFIG_MACH_NOKIA770 is not set
 # CONFIG_MACH_OMAP_GENERIC is not set
 
 #
@@ -136,7 +192,6 @@ CONFIG_OMAP_ARM_168MHZ=y
 # CONFIG_OMAP_ARM_120MHZ is not set
 # CONFIG_OMAP_ARM_60MHZ is not set
 # CONFIG_OMAP_ARM_30MHZ is not set
-# CONFIG_OMAP_DSP is not set
 
 #
 # Processor Type
@@ -148,6 +203,8 @@ CONFIG_CPU_ABRT_EV5TJ=y
 CONFIG_CPU_CACHE_VIVT=y
 CONFIG_CPU_COPY_V4WB=y
 CONFIG_CPU_TLB_V4WBI=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
 
 #
 # Processor Features
@@ -157,11 +214,11 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_WRITETHROUGH is not set
 # CONFIG_CPU_CACHE_ROUND_ROBIN is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
-CONFIG_ISA_DMA_API=y
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -173,6 +230,8 @@ CONFIG_ISA_DMA_API=y
 #
 # CONFIG_PREEMPT is not set
 # CONFIG_NO_IDLE_HZ is not set
+CONFIG_HZ=100
+# CONFIG_AEABI is not set
 # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
@@ -181,9 +240,10 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4096
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_LEDS=y
-# CONFIG_LEDS_TIMER is not set
-# CONFIG_LEDS_CPU is not set
 CONFIG_ALIGNMENT_TRAP=y
 
 #
@@ -194,6 +254,7 @@ CONFIG_ZBOOT_ROM_BSS=0x10200000
 # CONFIG_ZBOOT_ROM is not set
 CONFIG_CMDLINE="mem=32M console=ttyS0,115200n8 initrd=0x10A00000,8M root=/dev/ram0 rw ip=dhcp devfs=mount"
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
 # CPU Frequency scaling
@@ -224,6 +285,10 @@ CONFIG_BINFMT_AOUT=y
 # Power management options
 #
 CONFIG_PM=y
+# CONFIG_PM_LEGACY is not set
+# CONFIG_PM_DEBUG is not set
+# CONFIG_PM_SYSFS_DEPRECATED is not set
+# CONFIG_APM_EMULATION is not set
 
 #
 # Networking
@@ -233,9 +298,14 @@ CONFIG_NET=y
 #
 # Networking options
 #
+# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -253,12 +323,21 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 
 #
@@ -270,6 +349,11 @@ CONFIG_TCP_CONG_BIC=y
 # SCTP Configuration (EXPERIMENTAL)
 #
 # CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
@@ -279,11 +363,13 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
 # CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
@@ -334,12 +420,8 @@ CONFIG_IRDA=y
 #
 # CONFIG_USB_IRDA is not set
 # CONFIG_SIGMATEL_FIR is not set
-# CONFIG_NSC_FIR is not set
-# CONFIG_WINBOND_FIR is not set
-CONFIG_OMAP1610_IR=y
-# CONFIG_SMC_IRCC_FIR is not set
-# CONFIG_ALI_FIR is not set
-# CONFIG_VIA_FIR is not set
+# CONFIG_MCS_FIR is not set
+# CONFIG_OMAP_IR is not set
 # CONFIG_BT is not set
 # CONFIG_IEEE80211 is not set
 
@@ -354,6 +436,13 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
 
 #
 # Memory Technology Devices (MTD)
@@ -368,6 +457,7 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -379,16 +469,8 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
-
-#
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
@@ -396,6 +478,12 @@ CONFIG_IOSCHED_CFQ=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -465,9 +553,11 @@ CONFIG_PPP=y
 # CONFIG_PPP_SYNC_TTY is not set
 # CONFIG_PPP_DEFLATE is not set
 # CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPP_MPPE is not set
 # CONFIG_PPPOE is not set
 CONFIG_SLIP=y
 CONFIG_SLIP_COMPRESSED=y
+CONFIG_SLHC=y
 # CONFIG_SLIP_SMART is not set
 # CONFIG_SLIP_MODE_SLIP6 is not set
 # CONFIG_SHAPER is not set
@@ -484,6 +574,7 @@ CONFIG_SLIP_COMPRESSED=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -506,7 +597,9 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_KEYBOARD_OMAP=y
+# CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
@@ -526,6 +619,7 @@ CONFIG_SERIO_SERPORT=y
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -534,6 +628,7 @@ CONFIG_HW_CONSOLE=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
@@ -559,27 +654,24 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_OMAP_WATCHDOG is not set
 
 #
 # USB-based Watchdog Cards
 #
 # CONFIG_USBPCWATCHDOG is not set
-# CONFIG_OMAP_WATCHDOG is not set
-# CONFIG_OMAP_RNG is not set
+CONFIG_HW_RANDOM=m
+CONFIG_HW_RANDOM_OMAP=m
 # CONFIG_NVRAM is not set
-# CONFIG_RTC is not set
 CONFIG_OMAP_RTC=y
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_RAW_DRIVER is not set
 
 #
 # TPM devices
 #
+# CONFIG_TCG_TPM is not set
 
 #
 # I2C support
@@ -597,10 +689,11 @@ CONFIG_I2C=y
 #
 # I2C Hardware Bus support
 #
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_OMAP=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_STUB is not set
 # CONFIG_I2C_PCA_ISA is not set
-CONFIG_I2C_OMAP=y
 
 #
 # Miscellaneous I2C Chip support
@@ -611,7 +704,6 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_RTC8564 is not set
 CONFIG_ISP1301_OMAP=m
 CONFIG_TPS65010=y
 # CONFIG_SENSORS_TLV320AIC23 is not set
@@ -623,24 +715,53 @@ CONFIG_GPIOEXPANDER_OMAP=y
 # CONFIG_I2C_DEBUG_CHIP is not set
 
 #
+# SPI support
+#
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_OMAP_UWIRE=y
+
+#
+# SPI Protocol Masters
+#
+CONFIG_TSC2101=y
+# CONFIG_TSC2102 is not set
+# CONFIG_SPI_AT25 is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
 # Hardware Monitoring support
 #
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_ABITUGURU is not set
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
 # CONFIG_SENSORS_ATXP1 is not set
 # CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_F71805F is not set
 # CONFIG_SENSORS_FSCHER is not set
 # CONFIG_SENSORS_FSCPOS is not set
 # CONFIG_SENSORS_GL518SM is not set
 # CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM70 is not set
 # CONFIG_SENSORS_LM75 is not set
 # CONFIG_SENSORS_LM77 is not set
 # CONFIG_SENSORS_LM78 is not set
@@ -652,10 +773,15 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_LM92 is not set
 # CONFIG_SENSORS_MAX1619 is not set
 # CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_VT1211 is not set
 # CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
 # CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
 # CONFIG_SENSORS_W83L785TS is not set
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
@@ -666,53 +792,104 @@ CONFIG_HWMON=y
 #
 
 #
-# Multimedia Capabilities Port drivers
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
 #
 
 #
 # Multimedia devices
 #
 CONFIG_VIDEO_DEV=y
+CONFIG_VIDEO_V4L1=y
+CONFIG_VIDEO_V4L1_COMPAT=y
+CONFIG_VIDEO_V4L2=y
 
 #
-# Video For Linux
+# Video Capture Adapters
 #
 
 #
-# Video Adapters
+# Video Capture Adapters
 #
+# CONFIG_VIDEO_ADV_DEBUG is not set
+CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
 # CONFIG_VIDEO_CPIA is not set
+# CONFIG_VIDEO_CPIA2 is not set
 # CONFIG_VIDEO_SAA5246A is not set
 # CONFIG_VIDEO_SAA5249 is not set
 # CONFIG_TUNER_3036 is not set
+
+#
+# V4L USB devices
+#
+# CONFIG_VIDEO_PVRUSB2 is not set
+# CONFIG_VIDEO_EM28XX is not set
+# CONFIG_VIDEO_USBVISION is not set
+# CONFIG_USB_VICAM is not set
+# CONFIG_USB_IBMCAM is not set
+# CONFIG_USB_KONICAWC is not set
+# CONFIG_USB_QUICKCAM_MESSENGER is not set
+# CONFIG_USB_ET61X251 is not set
 # CONFIG_VIDEO_OVCAMCHIP is not set
+# CONFIG_USB_W9968CF is not set
+# CONFIG_USB_OV511 is not set
+# CONFIG_USB_SE401 is not set
+# CONFIG_USB_SN9C102 is not set
+# CONFIG_USB_STV680 is not set
+# CONFIG_USB_ZC0301 is not set
+# CONFIG_USB_PWC is not set
 # CONFIG_VIDEO_OMAP_CAMERA is not set
 
 #
 # Radio Adapters
 #
-# CONFIG_RADIO_MAESTRO is not set
+# CONFIG_RADIO_TEA5761 is not set
+# CONFIG_USB_DSBR is not set
 
 #
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
 #
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
-CONFIG_FB_SOFT_CURSOR=y
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
 CONFIG_FB_MODE_HELPERS=y
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frambuffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
 CONFIG_FB_OMAP=y
-CONFIG_FB_OMAP_LCDC_INTERNAL=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_OMAP_LCD_MIPID is not set
+# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_OMAP_DMA_TUNE is not set
 # CONFIG_FB_VIRTUAL is not set
 
@@ -722,6 +899,7 @@ CONFIG_FB_OMAP_LCDC_INTERNAL=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
@@ -733,7 +911,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -749,18 +926,23 @@ CONFIG_SOUND=y
 # Open Sound System
 #
 CONFIG_SOUND_PRIME=y
-# CONFIG_SOUND_OMAP is not set
+# CONFIG_OBSOLETE_OSS is not set
 # CONFIG_SOUND_MSNDCLAS is not set
 # CONFIG_SOUND_MSNDPIN is not set
-# CONFIG_SOUND_OSS is not set
 # CONFIG_SOUND_TVMIXER is not set
-# CONFIG_SOUND_AD1980 is not set
+
+#
+# HID Devices
+#
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB_ARCH_HAS_EHCI is not set
 CONFIG_USB=m
 # CONFIG_USB_DEBUG is not set
 
@@ -768,8 +950,8 @@ CONFIG_USB=m
 # Miscellaneous USB options
 #
 # CONFIG_USB_DEVICEFS is not set
-# CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_SUSPEND is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -777,22 +959,30 @@ CONFIG_USB=m
 #
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_OHCI_HCD=m
-# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_SL811_HCD is not set
 
 #
+# Enable Host or Gadget support to see Inventra options
+#
+# CONFIG_USB_MUSB_HDRC is not set
+
+#
 # USB Device Class drivers
 #
-# CONFIG_OBSOLETE_OSS_USB_DRIVER is not set
-# CONFIG_USB_BLUETOOTH_TTY is not set
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
-# CONFIG_USB_STORAGE is not set
+
+#
+# may also be needed; see USB_STORAGE Help for more information
+#
+# CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Input Devices
@@ -809,14 +999,14 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_ACECAD is not set
 # CONFIG_USB_KBTAB is not set
 # CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_MTOUCH is not set
-# CONFIG_USB_ITMTOUCH is not set
-# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_TOUCHSCREEN is not set
 # CONFIG_USB_YEALINK is not set
 # CONFIG_USB_XPAD is not set
 # CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 # CONFIG_USB_APPLETOUCH is not set
+# CONFIG_USB_GTCO is not set
 
 #
 # USB Imaging devices
@@ -824,26 +1014,13 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_MDC800 is not set
 
 #
-# USB Multimedia devices
-#
-# CONFIG_USB_DABUSB is not set
-# CONFIG_USB_VICAM is not set
-# CONFIG_USB_DSBR is not set
-# CONFIG_USB_IBMCAM is not set
-# CONFIG_USB_KONICAWC is not set
-# CONFIG_USB_OV511 is not set
-# CONFIG_USB_SE401 is not set
-# CONFIG_USB_SN9C102 is not set
-# CONFIG_USB_STV680 is not set
-# CONFIG_USB_PWC is not set
-
-#
 # USB Network Adapters
 #
 # CONFIG_USB_CATC is not set
 # CONFIG_USB_KAWETH is not set
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
 # CONFIG_USB_USBNET is not set
 CONFIG_USB_MON=y
 
@@ -861,16 +1038,22 @@ CONFIG_USB_MON=y
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
 # CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
 
 #
 # USB DSL modem support
@@ -887,16 +1070,18 @@ CONFIG_USB_MON=y
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 CONFIG_MMC_BLOCK=y
-# CONFIG_MMC_BLOCK_BROKEN_RFD is not set
-# CONFIG_MMC_BULKTRANSFER is not set
 CONFIG_MMC_OMAP=y
-# CONFIG_MMC_WBSD is not set
 
 #
-# Synchronous Serial Interfaces (SSI)
+# Real Time Clock
+#
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
+
+#
+# CBUS support
 #
-CONFIG_OMAP_UWIRE=y
-# CONFIG_OMAP_TSC2101 is not set
+# CONFIG_CBUS is not set
 
 #
 # File systems
@@ -907,15 +1092,18 @@ CONFIG_EXT2_FS_XATTR=y
 # CONFIG_EXT2_FS_SECURITY is not set
 # CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 CONFIG_ROMFS_FS=y
 CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
@@ -939,11 +1127,12 @@ CONFIG_DNOTIFY=y
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 # CONFIG_TMPFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_RELAYFS_FS is not set
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -997,6 +1186,11 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Profiling support
 #
 # CONFIG_PROFILING is not set
@@ -1005,24 +1199,36 @@ CONFIG_MSDOS_PARTITION=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
-CONFIG_DEBUG_KERNEL=y
+CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FRAME_POINTER=y
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 CONFIG_DEBUG_USER=y
-# CONFIG_DEBUG_WAITQ is not set
 CONFIG_DEBUG_ERRORS=y
 # CONFIG_DEBUG_LL is not set
-# CONFIG_DEBUG_ICEDCC is not set
 
 #
 # Security options
@@ -1036,13 +1242,13 @@ CONFIG_DEBUG_ERRORS=y
 # CONFIG_CRYPTO is not set
 
 #
-# Hardware crypto devices
-#
-
-#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
-- 
1.5.0.rc3


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--RnlQjJ0d97Da+TV1--
