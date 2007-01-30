From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [RFC] TSC2101 support
Date: Tue, 30 Jan 2007 16:20:55 +0900
Message-ID: <004a01c7443f$351b52c0$c7a3580a@swcenter.sec.samsung.co.kr>
References: <15215457.402191169687150749.JavaMail.weblogic@ep_ml23>
	<45B8204C.5060206@cc.jyu.fi>
	<9C23CDD79DA20A479D4615857B2E2C47080FEE@dlee13.ent.ti.com>
	<45F366B1BC4F7C4A895F0F34C41E61A502D1AB55@dbde01.ent.ti.com>
	<45B8A434.5080303@nokia.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <45B8A434.5080303@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Kai Svahn' <kai.svahn@nokia.com>, "'ext Kondaiah G, Manjunath'" <manjugk@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

> 
> I hope we get also some comments from Nokia driver authors 
> about this issue but they have limited network access until 
> 2nd of February.
> 

No problem. Actually I want to co-work with you,

Here's TSC patch for both tsc2101 and tsc2301 (only for core and ts, others
are you can obtain from n800 sources)
Now I don't modify anythings from n800 sources.

In touchscreen source, only 3 parts are different. I marked with 'XXX
tsc2101 specific'
I think we first make common header(include/linux/spi/tsc-common.h) and
common code file (drivers/spi/tsc-common.c with CONFIG_SPI_TSC_COMMON(?))
It means we have to modify tsc2301 releated code. please give some comments

Any comments are welcome

Thank you,
Kyungmin Park

--

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
omap2/board-apollon.c
index 5e1cada..d91d919 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -24,9 +24,10 @@
 #include <linux/mtd/onenand.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2101.h>
 #include <linux/delay.h>
 #include <linux/leds.h>
-#include <linux/irq.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 
@@ -42,6 +43,7 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
 #include <asm/arch/gpmc.h>
+#include <asm/arch/mcspi.h>
 #include "prcm-regs.h"
 
 /* LED & Switch macros */
@@ -51,6 +53,7 @@
 #define SW_ENTER_GPIO16		16
 #define SW_UP_GPIO17		17
 #define SW_DOWN_GPIO58		58
+#define PINTDAV_GPIO85		85
 
 #define APOLLON_FLASH_CS	0
 #define APOLLON_ETH_CS		1
@@ -358,6 +361,30 @@ static void __init apollon_usb_init(void)
 	omap_set_gpio_dataout(12, 0);
 }
 
+static struct omap2_mcspi_device_config tsc2101_mcspi_config = {
+	.turbo_mode		= 0,
+	.single_channel		= 0,
+};
+
+static struct tsc2101_platform_data tsc2101_platform_config = {
+	/* Touchscreen */
+	.dav_gpio		= PINTDAV_GPIO85,
+	.ts_x_plate_ohm		= 200,
+	.ts_stab_time		= 500,		/* 500 usec */
+	.ts_hw_avg		= 16,
+};
+
+static struct spi_board_info apollon_spi_board_info[] __initdata = {
+	[0] = {
+		.modalias		= "tsc2101",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.max_speed_hz		= 6000000,
+		.controller_data	= &tsc2101_mcspi_config,
+		.platform_data		= &tsc2101_platform_config,
+	},
+};
+
 static void __init omap_apollon_init(void)
 {
 	apollon_led_init();
@@ -373,6 +400,8 @@ static void __init omap_apollon_init(void)
 	 * You have to mux them off in device drivers later on
 	 * if not needed.
 	 */
+	spi_register_board_info(apollon_spi_board_info,
+				ARRAY_SIZE(apollon_spi_board_info));
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 948a9dc..4a5dd1b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -135,6 +135,85 @@ config SPI_S3C24XX
 comment "SPI Protocol Masters"
 	depends on SPI_MASTER
 
+config SPI_TSC_COMMON
+	tristate "TSC common driver"
+	depends on SPI_MASTER
+	help
+	  Say Y here if you have a TSC series chip connected to a SPI
+	  bus on your board.
+
+	  The TSC chip is a highly integrated PDA analog interface circuit.
+	  It contains a complete 12-bit A/D resistive touch screen
+	  converter (ADC) including drivers, touch pressure measurement
+	  capability.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsc-common.
+
+config SPI_TSC2101
+	tristate "TSC2101 driver"
+	depends on SPI_MASTER && SPI_TSC_COMMON
+	help
+	  Say Y here if you have a TSC2101 chip connected to a SPI
+	  bus on your board.
+
+	  The TSC2101 is a highly integrated PDA analog interface circuit.
+	  It contains a complete 12-bit A/D resistive touch screen
+	  converter (ADC) including drivers, touch pressure measurement
+	  capability.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsc2101.
+
+config SPI_TSC2101_TOUCHSCREEN
+	boolean "TSC2101 touchscreen support"
+	depends on SPI_TSC2101
+	select INPUT_TOUCHSCREEN
+	help
+	  Say Y here for if you are using the touchscreen features of
TSC2101.
+
+config SPI_TSC2101_AUDIO
+	boolean "TSC2101 audio support"
+	depends on SPI_TSC2101 && SND
+	help
+	  Say Y here for if you are using the audio features of TSC2101.
+
+config SPI_TSC2301
+	tristate "TSC2301 driver"
+	depends on SPI_MASTER && SPI_TSC_COMMON
+	help
+	  Say Y here if you have a TSC2301 chip connected to an SPI
+	  bus on your board.
+
+	  The TSC2301 is a highly integrated PDA analog interface circuit.
+	  It contains a complete 12-bit A/D resistive touch screen
+	  converter (ADC) including drivers, touch pressure measurement
+	  capability, keypad controller, and 8-bit D/A converter (DAC)
output
+	  for LCD contrast control.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsc2301.
+
+config SPI_TSC2301_KEYPAD
+	boolean "TSC2301 keypad support"
+	depends on SPI_TSC2301
+	select INPUT_KEYBOARD
+	help
+	  Say Y here for if you are using the keypad features of TSC2301.
+
+config SPI_TSC2301_TOUCHSCREEN
+	boolean "TSC2301 touchscreen support"
+	depends on SPI_TSC2301
+	select INPUT_TOUCHSCREEN
+	help
+	  Say Y here for if you are using the touchscreen features of
TSC2301.
+
+config SPI_TSC2301_AUDIO
+	boolean "TSC2301 audio support"
+	depends on SPI_TSC2301 && SND
+	help
+	  Say Y here for if you are using the audio features of TSC2301.
+
 config TSC2102
 	depends on SPI_MASTER
 	tristate "TSC2102 codec support"
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 83b3e70..d812927 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -22,6 +22,17 @@ obj-$(CONFIG_SPI_OMAP_UWIRE)		+= omap_uwire.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
+tsc2101-objs				+= tsc2101-core.o
+tsc2101-$(CONFIG_SPI_TSC2101_TOUCHSCREEN)	+= tsc2101-ts.o
+tsc2101-$(CONFIG_SPI_TSC2101_AUDIO)	+= tsc2101-mixer.o
+obj-$(CONFIG_SPI_TSC2101)		+= tsc2101.o
+
+tsc2301-objs				+= tsc2301-core.o
+tsc2301-$(CONFIG_SPI_TSC2301_TOUCHSCREEN)	+= tsc2301-ts.o
+tsc2301-$(CONFIG_SPI_TSC2301_KEYPAD)	+= tsc2301-kp.o
+tsc2301-$(CONFIG_SPI_TSC2301_AUDIO)	+= tsc2301-mixer.o
+obj-$(CONFIG_SPI_TSC2301)		+= tsc2301.o
+
 obj-$(CONFIG_TSC2102)			+= tsc2102.o
 # 	... add above this line ...
 
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index b8d0ec0..e72ef60 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -430,6 +430,7 @@ static void omap2_mcspi_txrx_pio(struct spi_device
*spi, struct spi_transfer *xf
 				dev_dbg(&spi->dev, "write-%d %04x\n",
 						word_len, *tx);
 #endif
+				printk("write-%d %08x\n", word_len, *tx);
 				__raw_writel(*tx++, tx_reg);
 			}
 			if (rx != NULL) {
@@ -441,6 +442,7 @@ static void omap2_mcspi_txrx_pio(struct spi_device
*spi, struct spi_transfer *xf
 				dev_dbg(&spi->dev, "read-%d %04x\n",
 						word_len, *(rx - 1));
 #endif
+				printk("read-%d %08x\n", word_len, *(rx -
1));
 			}
 		}
 	}
diff --git a/drivers/spi/tsc2101-core.c b/drivers/spi/tsc2101-core.c
new file mode 100644
index 0000000..5b109f5
--- /dev/null
+++ b/drivers/spi/tsc2101-core.c
@@ -0,0 +1,246 @@
+/*
+ * TSC2101 driver
+ *
+ * Copyright (C) 2005, 2006 Nokia Corporation
+ *
+ * Modified for 32-bit SPI bus by Kyungmin Park
+ *
+ * Derived from TSC2301 written by Juha Yrjola
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2101.h>
+
+#ifdef CONFIG_ARCH_OMAP
+#include <asm/arch/gpio.h>
+#endif
+
+u16 tsc2101_read_reg(struct tsc2101 *tsc, int reg)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	u32 data = 0, cmd;
+
+	cmd = reg;
+	cmd |= 0x8000;
+	cmd <<= 16;
+
+	memset(&t, 0, sizeof(t));
+	spi_message_init(&m);
+	m.spi = tsc->spi;
+
+	t.tx_buf = &cmd;
+	t.rx_buf = &data;
+	t.len = 4;
+	spi_message_add_tail(&t, &m);
+
+	spi_sync(m.spi, &m);
+
+	return (data & 0xffff);
+}
+
+void tsc2101_write_reg(struct tsc2101 *tsc, int reg, u16 val)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	u32 data;
+
+	/* Now we prepare the command for transferring */
+	data = (reg << 16) | val;
+
+	spi_message_init(&m);
+	m.spi = tsc->spi;
+
+	memset(&t, 0, sizeof(t));
+	t.tx_buf = &data;
+	t.rx_buf = NULL;
+	t.len = 4;
+	spi_message_add_tail(&t, &m);
+
+	spi_sync(m.spi, &m);
+}
+
+void tsc2101_read_buf(struct tsc2101 *tsc, int reg, u16 *rx_buf, int len)
+{
+	/* Not yet implemented... */
+}
+
+void tsc2101_enable_mclk(struct device *dev)
+{
+	struct tsc2101 *tsc = dev_get_drvdata(dev);
+
+	if (tsc->enable_clock == NULL)
+		return;
+
+	tsc->enable_clock(dev);
+}
+
+void tsc2101_disable_mclk(struct device *dev)
+{
+	struct tsc2101 *tsc = dev_get_drvdata(dev);
+
+	might_sleep();
+	if (tsc->disable_clock == NULL)
+		return;
+
+	/* Submodules might need to take action before stopping the
+	 * clock. Keypad scanning needs to be stopped / restarted for one.
+	 */
+	if (tsc->ts != NULL)
+		tsc2101_ts_prep_for_clk_stop(tsc);
+	if (tsc->mixer != NULL)
+		tsc2101_mixer_prep_for_clk_stop(tsc);
+
+	tsc->disable_clock(dev);
+
+	if (tsc->mixer != NULL)
+		tsc2101_mixer_cont_after_clk_stop(tsc);
+	if (tsc->ts != NULL)
+		tsc2101_ts_cont_after_clk_stop(tsc);
+}
+
+static int __devinit tsc2101_probe(struct spi_device *spi)
+{
+	struct tsc2101			*tsc;
+	struct tsc2101_platform_data	*pdata = spi->dev.platform_data;
+	int r;
+
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data?\n");
+		return -ENODEV;
+	}
+
+	printk("TSC2101 driver initializing\n");
+
+	tsc = kzalloc(sizeof(*tsc), GFP_KERNEL);
+	if (tsc == NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, tsc);
+	tsc->spi = spi;
+	spi->dev.power.power_state = PMSG_ON;
+
+	tsc->enable_clock = pdata->enable_clock;
+	tsc->disable_clock = pdata->disable_clock;
+
+	if (pdata->reset_gpio >= 0) {
+		tsc->reset_gpio = pdata->reset_gpio;
+#ifdef CONFIG_ARCH_OMAP
+		r = omap_request_gpio(tsc->reset_gpio);
+		if (r < 0)
+			goto err1;
+		omap_set_gpio_dataout(tsc->reset_gpio, 1);
+		omap_set_gpio_direction(tsc->reset_gpio, 0);
+		mdelay(1);
+		omap_set_gpio_dataout(tsc->reset_gpio, 0);
+#endif
+	} else
+		tsc->reset_gpio = -1;
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 32;
+	/* The max speed might've been defined by the board-specific
+	 * struct */
+	if (!spi->max_speed_hz)
+		spi->max_speed_hz = TSC2101_HZ;
+	spi_setup(spi);
+
+	r = tsc2101_ts_init(tsc, pdata);
+	if (r)
+		goto err1;
+	r = tsc2101_mixer_init(tsc, pdata);
+	if (r)
+		goto err2;
+	return 0;
+
+err2:
+	tsc2101_ts_exit(tsc);
+err1:
+	kfree(tsc);
+	return r;
+}
+
+static int __devexit tsc2101_remove(struct spi_device *spi)
+{
+	struct tsc2101 *tsc = dev_get_drvdata(&spi->dev);
+
+	tsc2101_mixer_exit(tsc);
+        tsc2101_ts_exit(tsc);
+	kfree(tsc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tsc2101_suspend(struct spi_device *spi, pm_message_t mesg)
+{
+	struct tsc2101 *tsc = dev_get_drvdata(&spi->dev);
+	int r;
+
+	if ((r = tsc2101_mixer_suspend(tsc)) < 0)
+		return r;
+	if ((r = tsc2101_ts_suspend(tsc)) < 0)
+		goto err1;
+
+	return 0;
+err1:
+	tsc2101_mixer_resume(tsc);
+	return r;
+}
+
+static int tsc2101_resume(struct spi_device *spi)
+{
+	struct tsc2101 *tsc = dev_get_drvdata(&spi->dev);
+
+	tsc2101_ts_resume(tsc);
+	tsc2101_mixer_resume(tsc);
+	return 0;
+}
+#endif
+
+static struct spi_driver tsc2101_driver = {
+	.driver = {
+		   .name = "tsc2101",
+		   .bus = &spi_bus_type,
+		   .owner = THIS_MODULE,
+	},
+#ifdef CONFIG_PM
+	.suspend = tsc2101_suspend,
+	.resume = tsc2101_resume,
+#endif
+	.probe = tsc2101_probe,
+	.remove = __devexit_p(tsc2101_remove),
+};
+
+static int __init tsc2101_init(void)
+{
+	return spi_register_driver(&tsc2101_driver);
+}
+module_init(tsc2101_init);
+
+static void __exit tsc2101_exit(void)
+{
+	spi_unregister_driver(&tsc2101_driver);
+}
+module_exit(tsc2101_exit);
+
+MODULE_AUTHOR("Kyungmin Park <kyungmin.park@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/tsc2101-ts.c b/drivers/spi/tsc2101-ts.c
new file mode 100644
index 0000000..bb798bc
--- /dev/null
+++ b/drivers/spi/tsc2101-ts.c
@@ -0,0 +1,718 @@
+/*
+ * TSC2101 touchscreen driver
+ *
+ * Copyright (C) 2005-2006 Nokia Corporation
+ *
+ * Modified for 32-bit SPI by Kyungmin Park
+ *
+ * Derived from TSC2301 written by Jarkko Oikarinen, Imre Deak and Juha
Yrjola
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+
+#ifdef CONFIG_ARCH_OMAP
+#include <asm/arch/gpio.h>
+#endif
+
+#include <linux/spi/tsc2101.h>
+
+/**
+ * The touchscreen interface operates as follows:
+ *
+ * Initialize:
+ *    Request access to GPIO (DAV)
+ *    tsc2101_dav_irq_handler will trigger when DAV line goes down
+ *
+ *  1) Pen is pressed against touchscreeen
+ *  2) TSC2101 performs AD conversion
+ *  3) After the conversion is done TSC2101 drives DAV line down
+ *  4) GPIO IRQ is received and tsc2101_dav_irq_handler is called
+ *  5) tsc2101_dav_irq_handler sets up tsc2101_ts_timer in
TSC2101_TS_SCAN_TIME
+ *  6) tsc2101_ts_timer disables the irq and requests spi driver
+ *     to read X, Y, Z1 and Z2
+ *  7) SPI framework calls tsc2101_ts_rx after the coordinates are read
+ *  8) tsc2101_ts_rx reports coordinates to input layer and
+ *     sets up tsc2101_ts_timer to be called after TSC2101_TS_SCAN_TIME
+ *  9) if tsc2101_tx_timer notices that the pen has been lifted, the lift
event
+ *     is sent, and irq is again enabled.
+ */
+
+
+#define TSC2101_TOUCHSCREEN_PRODUCT_ID      		0x0052
+#define TSC2101_TOUCHSCREEN_PRODUCT_VERSION 		0x0001
+
+#define TSC2101_TS_SCAN_TIME		     		1
+
+#define TSC2101_ADCREG_CONVERSION_CTRL_BY_TSC2101	0x8000
+#define TSC2101_ADCREG_CONVERSION_CTRL_BY_HOST		0x0000
+
+#define TSC2101_ADCREG_FUNCTION_NONE			0x0000
+#define TSC2101_ADCREG_FUNCTION_XY			0x0400
+#define TSC2101_ADCREG_FUNCTION_XYZ			0x0800
+#define TSC2101_ADCREG_FUNCTION_X			0x0C00
+#define TSC2101_ADCREG_FUNCTION_Y			0x1000
+#define TSC2101_ADCREG_FUNCTION_Z			0x1400
+#define TSC2101_ADCREG_FUNCTION_DAT1			0x1800
+#define TSC2101_ADCREG_FUNCTION_DAT2			0x1C00
+#define TSC2101_ADCREG_FUNCTION_AUX1			0x2000
+#define TSC2101_ADCREG_FUNCTION_AUX2			0x2400
+#define TSC2101_ADCREG_FUNCTION_TEMP			0x2800
+
+#define TSC2101_ADCREG_RESOLUTION_8BIT			0x0100
+#define TSC2101_ADCREG_RESOLUTION_10BIT			0x0200
+#define TSC2101_ADCREG_RESOLUTION_12BIT			0x0300
+
+#define TSC2101_ADCREG_AVERAGING_NONE			0x0000
+#define TSC2101_ADCREG_AVERAGING_4AVG			0x0040
+#define TSC2101_ADCREG_AVERAGING_8AVG			0x0080
+#define TSC2101_ADCREG_AVERAGING_16AVG			0x00C0
+
+#define TSC2101_ADCREG_CLOCK_8MHZ			0x0000
+#define TSC2101_ADCREG_CLOCK_4MHZ			0x0010
+#define TSC2101_ADCREG_CLOCK_2MHZ			0x0020
+#define TSC2101_ADCREG_CLOCK_1MHZ			0x0030
+
+#define TSC2101_ADCREG_VOLTAGE_STAB_0US			0x0000
+#define TSC2101_ADCREG_VOLTAGE_STAB_100US		0x0002
+#define TSC2101_ADCREG_VOLTAGE_STAB_500US		0x0004
+#define TSC2101_ADCREG_VOLTAGE_STAB_1MS			0x0006
+#define TSC2101_ADCREG_VOLTAGE_STAB_5MS			0x0008
+#define TSC2101_ADCREG_VOLTAGE_STAB_10MS		0x000A
+#define TSC2101_ADCREG_VOLTAGE_STAB_50MS		0x000C
+#define TSC2101_ADCREG_VOLTAGE_STAB_100MS		0x000E
+
+#define TSC2101_ADCREG_STOP_CONVERSION			0x4000
+
+#define TSC2101_STATUSREG_DAV				0x4000
+#define TSC2101_PROGREG_DELAY				0x0900
+
+#define MAX_12BIT					((1 << 12) - 1)
+
+struct tsc2101_ts {
+	struct input_dev	*idev;
+	char			phys[32];
+	struct timer_list	timer;
+	spinlock_t		lock;
+
+	struct spi_transfer	read_xfer[2];
+	struct spi_message	read_msg;
+#ifdef CONFIG_SPI_TSC2101
+	u32                     data[4];
+#else
+	u16                     data[4];
+#endif
+
+	int			hw_avg_max;
+	u16			x;
+	u16			y;
+	u16			p;
+	int			sample_cnt;
+
+	int			ignore_last : 1;
+	u16			x_plate_ohm;
+	int			stab_time;
+	int			max_pressure;
+	int			touch_pressure;
+	int			pressure_limit;
+
+	u16			irq_enabled:1;
+	u16			pen_down:1;
+	u16			disabled:1;
+	u16			pending:1;
+
+	int			hw_flags;
+
+	s16			dav_gpio;
+	int			irq;
+};
+
+static int tsc2101_ts_check_config(struct tsc2101_ts *ts, int *hw_flags)
+{
+	int flags;
+
+	flags = 0;
+	switch (ts->hw_avg_max) {
+	case 0:
+		flags |= TSC2101_ADCREG_AVERAGING_NONE;
+		break;
+	case 4:
+		flags |= TSC2101_ADCREG_AVERAGING_4AVG;
+		break;
+	case 8:
+		flags |= TSC2101_ADCREG_AVERAGING_8AVG;
+		break;
+	case 16:
+		flags |= TSC2101_ADCREG_AVERAGING_16AVG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (ts->stab_time) {
+	case 0:
+		flags |= TSC2101_ADCREG_VOLTAGE_STAB_0US;
+		break;
+	case 100:
+		flags |= TSC2101_ADCREG_VOLTAGE_STAB_100US;
+		break;
+	case 500:
+		flags |= TSC2101_ADCREG_VOLTAGE_STAB_500US;
+		break;
+	case 1000:
+		flags |= TSC2101_ADCREG_VOLTAGE_STAB_1MS;
+		break;
+	case 5000:
+		flags |= TSC2101_ADCREG_VOLTAGE_STAB_5MS;
+		break;
+	case 10000:
+		flags |= TSC2101_ADCREG_VOLTAGE_STAB_10MS;
+		break;
+	case 50000:
+		flags |= TSC2101_ADCREG_VOLTAGE_STAB_50MS;
+		break;
+	case 100000:
+		flags |= TSC2101_ADCREG_VOLTAGE_STAB_100MS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*hw_flags = flags;
+	return 0;
+}
+
+/* XXX: tsc2101 specific */
+static int tsc2101_ts_configure(struct tsc2101 *tsc, int flags)
+{
+	struct spi_transfer xfer[6];
+	struct spi_transfer *x;
+	struct spi_message m;
+	int reg;
+	u32 val, adc_val;
+	u32 data[6];
+
+	/*
+	 * TSC2101-controlled conversions
+	 * 12-bit samples
+	 * continuous X,Y,Z1,Z2 scan mode
+	 * average (mean) 16 samples per coordinate
+	 * 1 MHz internal conversion clock
+	 * 500 usec panel voltage stabilization delay
+	 * => 0x8bf4
+	 */
+	/* Averaging and voltage stabilization settings in flags */
+	adc_val = TSC2101_ADCREG_CONVERSION_CTRL_BY_TSC2101 |
+		TSC2101_ADCREG_FUNCTION_XYZ |
+		TSC2101_ADCREG_RESOLUTION_12BIT |
+		TSC2101_ADCREG_CLOCK_1MHZ |
+		flags;
+	printk("adc val = 0x%08x\n", adc_val);
+
+	/* Now we prepare the command for transferring */
+	/* Use internal reference clock */
+	reg = TSC2101_REG_REF;
+	val = 0x0016;
+	data[0] = (reg << 16) | val;
+
+	reg = TSC2101_REG_CONFIG;
+	val = 0x0008;
+	data[1] = (reg << 16) | val;
+
+	reg = TSC2101_REG_BUFFER;
+	val = 0x0;
+	data[2] = (reg << 16) | val;
+
+	reg = TSC2101_REG_PROG_DELAY;
+	val = 0x0900;
+	data[3] = (reg << 16) | val;
+
+	reg = TSC2101_REG_STATUS;
+	val = TSC2101_STATUSREG_DAV;
+	data[4] = (reg << 16) | val;
+
+	reg = TSC2101_REG_ADC;
+	data[5] = (reg << 16) | adc_val;
+
+	spi_message_init(&m);
+	m.spi = tsc->spi;
+
+	memset(xfer, 0, sizeof(xfer));
+	x = &xfer[0];
+
+	x->tx_buf = &data[0];
+	x->len = 4;
+	x->cs_change = 1;
+	spi_message_add_tail(x, &m);
+
+	x++;
+	x->tx_buf = &data[1];
+	x->len = 4;
+	x->cs_change = 1;
+	spi_message_add_tail(x, &m);
+
+	x++;
+	x->tx_buf = &data[2];
+	x->len = 4;
+	spi_message_add_tail(x, &m);
+
+	x++;
+	x->tx_buf = &data[3];
+	x->len = 4;
+	spi_message_add_tail(x, &m);
+
+	x++;
+	x->tx_buf = &data[4];
+	x->len = 4;
+	spi_message_add_tail(x, &m);
+
+	x++;
+	x->tx_buf = &data[5];
+	x->len = 4;
+	spi_message_add_tail(x, &m);
+
+	spi_sync(m.spi, &m);
+
+	return 0;
+}
+
+static void tsc2101_ts_start_scan(struct tsc2101 *tsc)
+{
+	tsc2101_ts_configure(tsc, tsc->ts->hw_flags);
+}
+
+static void tsc2101_ts_stop_scan(struct tsc2101 *tsc)
+{
+	tsc2101_ts_configure(tsc, TSC2101_ADCREG_STOP_CONVERSION);
+}
+
+static int device_suspended(struct device *dev)
+{
+	struct tsc2101 *tsc = dev_get_drvdata(dev);
+	return dev->power.power_state.event != PM_EVENT_ON || tsc->ts-
>disabled;
+}
+
+static void update_pen_state(struct tsc2101_ts *ts, int x, int y, int
pressure)
+{
+	int sync = 0;
+
+	if (pressure) {
+		input_report_abs(ts->idev, ABS_X, x);
+		input_report_abs(ts->idev, ABS_Y, y);
+		input_report_abs(ts->idev, ABS_PRESSURE, pressure);
+		if (!ts->pen_down)
+			input_report_key(ts->idev, BTN_TOUCH, 1);
+		sync = 1;
+	} else if (ts->pen_down) {
+		input_report_abs(ts->idev, ABS_PRESSURE, 0);
+		input_report_key(ts->idev, BTN_TOUCH, 0);
+		sync = 1;
+	}
+
+	if (sync)
+		input_sync(ts->idev);
+
+	ts->pen_down = pressure ? 1 : 0;
+#ifdef VERBOSE
+	dev_dbg(&tsc->spi->dev, "x %4d y %4d p %4d\n", x, y, pressure);
+#endif
+}
+
+/* XXX: TSC2101 specific */
+/*
+ * This procedure is called by the SPI framework after the coordinates
+ * have been read from TSC2101
+ */
+static void tsc2101_ts_rx(void *arg)
+{
+	struct tsc2101 *tsc = arg;
+	struct tsc2101_ts *ts = tsc->ts;
+	unsigned int x, y, z1, z2, pressure;
+
+	x  = ts->data[0] & 0xffff;
+	y  = ts->data[1] & 0xffff;
+	z1 = ts->data[2] & 0xffff;
+	z2 = ts->data[3] & 0xffff;
+
+	if (z1) {
+		pressure = ts->x_plate_ohm * x;
+		pressure /= 4096;
+		pressure *= z2 - z1;
+		pressure /= z1;
+	} else
+		pressure = 0;
+
+	/* If pressure value is above a preset limit (pen is barely
+	 * touching the screen) we can't trust the coordinate values.
+	 */
+	if (pressure < ts->pressure_limit && x < MAX_12BIT && y <
MAX_12BIT) {
+		ts->pressure_limit = ts->max_pressure;
+		if (ts->ignore_last) {
+			if (ts->sample_cnt)
+				update_pen_state(ts, ts->x, ts->y, ts->p);
+			ts->x = x;
+			ts->y = y;
+			ts->p = pressure;
+		} else
+			update_pen_state(ts, x, y, pressure);
+		ts->sample_cnt++;
+	}
+
+	mod_timer(&ts->timer,
+		  jiffies + msecs_to_jiffies(TSC2101_TS_SCAN_TIME));
+}
+
+static int is_pen_down(struct tsc2101_ts *ts)
+{
+	return ts->pen_down;
+}
+
+/*
+ * Timer is called every TSC2101_TS_SCAN_TIME when the pen is down
+ */
+static void tsc2101_ts_timer(unsigned long arg)
+{
+	struct tsc2101 *tsc = (void *) arg;
+	struct tsc2101_ts *ts = tsc->ts;
+	unsigned long flags;
+	int ndav;
+	int r;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	ndav = omap_get_gpio_datain(ts->dav_gpio);
+	if (ndav || device_suspended(&tsc->spi->dev)) {
+		/* Pen has been lifted */
+		if (!device_suspended(&tsc->spi->dev)) {
+			ts->irq_enabled = 1;
+			enable_irq(ts->irq);
+		}
+		update_pen_state(ts, 0, 0, 0);
+		ts->pending = 0;
+		spin_unlock_irqrestore(&ts->lock, flags);
+
+	} else {
+		ts->pen_down = 1;
+		spin_unlock_irqrestore(&ts->lock, flags);
+
+		r = spi_async(tsc->spi, &ts->read_msg);
+		if (r)
+			dev_err(&tsc->spi->dev, "ts: spi_async() failed");
+	}
+}
+
+/*
+ * This interrupt is called when pen is down and first coordinates are
+ * available. That is indicated by a falling edge on DEV line.  IRQ is
+ * disabled here because while the pen is down the coordinates are
+ * read by a timer.
+ */
+static irqreturn_t tsc2101_ts_irq_handler(int irq, void *dev_id)
+{
+	struct tsc2101 *tsc = dev_id;
+	struct tsc2101_ts *ts = tsc->ts;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	if (ts->irq_enabled) {
+		ts->irq_enabled = 0;
+		disable_irq(ts->irq);
+		ts->pending = 1;
+		ts->pressure_limit = ts->touch_pressure;
+		ts->sample_cnt = 0;
+		mod_timer(&ts->timer,
+			  jiffies + msecs_to_jiffies(TSC2101_TS_SCAN_TIME));
+	}
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+/* Must be called with ts->lock held */
+static void tsc2101_ts_disable(struct tsc2101 *tsc)
+{
+	struct tsc2101_ts *ts = tsc->ts;
+
+	if (ts->disabled)
+		return;
+
+	ts->disabled = 1;
+	if (!ts->pending) {
+		ts->irq_enabled = 0;
+		disable_irq(ts->irq);
+	} else {
+		while (ts->pending) {
+			spin_unlock_irq(&ts->lock);
+			msleep(1);
+			spin_lock_irq(&ts->lock);
+		}
+	}
+
+	spin_unlock_irq(&ts->lock);
+	tsc2101_ts_stop_scan(tsc);
+	spin_lock_irq(&ts->lock);
+}
+
+static void tsc2101_ts_enable(struct tsc2101 *tsc)
+{
+	struct tsc2101_ts *ts = tsc->ts;
+
+	if (!ts->disabled)
+		return;
+
+	ts->disabled = 0;
+	ts->irq_enabled = 1;
+	enable_irq(ts->irq);
+
+	spin_unlock_irq(&ts->lock);
+	tsc2101_ts_start_scan(tsc);
+	spin_lock_irq(&ts->lock);
+}
+
+#ifdef CONFIG_PM
+int tsc2101_ts_suspend(struct tsc2101 *tsc)
+{
+	struct tsc2101_ts *ts = tsc->ts;
+
+	spin_lock_irq(&ts->lock);
+	tsc2101_ts_disable(tsc);
+	spin_unlock_irq(&ts->lock);
+
+	return 0;
+}
+
+void tsc2101_ts_resume(struct tsc2101 *tsc)
+{
+	struct tsc2101_ts *ts = tsc->ts;
+
+	spin_lock_irq(&ts->lock);
+	tsc2101_ts_enable(tsc);
+	spin_unlock_irq(&ts->lock);
+}
+#endif
+
+void tsc2101_ts_prep_for_clk_stop(struct tsc2101 *tsc)
+{
+}
+
+void tsc2101_ts_cont_after_clk_stop(struct tsc2101 *tsc)
+{
+}
+
+/* XXX: tsc2101 specific */
+static const u32 tsc2101_ts_read_data[4] = {
+	(0x8000 | TSC2101_REG_X) << 16,
+	(0x8000 | TSC2101_REG_Y) << 16,
+	(0x8000 | TSC2101_REG_Z1) << 16,
+	(0x8000 | TSC2101_REG_Z2) << 16,
+};
+
+static void tsc2101_ts_setup_spi_xfer(struct tsc2101 *tsc)
+{
+	struct tsc2101_ts *ts = tsc->ts;
+	struct spi_message *m = &ts->read_msg;
+	struct spi_transfer *x = &ts->read_xfer[0];
+
+	spi_message_init(m);
+
+	x->tx_buf = &tsc2101_ts_read_data;
+	x->rx_buf = &ts->data;
+	x->len = 16;
+	spi_message_add_tail(x, m);
+
+	m->complete = tsc2101_ts_rx;
+	m->context = tsc;
+}
+
+static ssize_t tsc2101_ts_pen_down_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tsc2101 *tsc = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", is_pen_down(tsc->ts));
+}
+
+static DEVICE_ATTR(pen_down, S_IRUGO, tsc2101_ts_pen_down_show, NULL);
+
+static ssize_t tsc2101_ts_disable_show(struct device *dev,
+				       struct device_attribute *attr, char
*buf)
+{
+	struct tsc2101		*tsc = dev_get_drvdata(dev);
+	struct tsc2101_ts	*ts = tsc->ts;
+
+	return sprintf(buf, "%u\n", ts->disabled);
+}
+
+static ssize_t tsc2101_ts_disable_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct tsc2101		*tsc = dev_get_drvdata(dev);
+	struct tsc2101_ts	*ts = tsc->ts;
+	char *endp;
+	int i;
+
+	i = simple_strtoul(buf, &endp, 10);
+	spin_lock_irq(&ts->lock);
+
+	if (i)
+		tsc2101_ts_disable(tsc);
+	else
+		tsc2101_ts_enable(tsc);
+
+	spin_unlock_irq(&ts->lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(disable_ts, 0664, tsc2101_ts_disable_show,
+		   tsc2101_ts_disable_store);
+
+int __devinit tsc2101_ts_init(struct tsc2101 *tsc,
+			      struct tsc2101_platform_data *pdata)
+{
+	struct tsc2101_ts *ts;
+	struct input_dev *idev;
+	int dav_gpio, r;
+
+	if (pdata->dav_gpio < 0) {
+		dev_err(&tsc->spi->dev, "need DAV GPIO");
+		return -EINVAL;
+	}
+	dav_gpio = pdata->dav_gpio;
+
+	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+	if (ts == NULL)
+		return -ENOMEM;
+	tsc->ts = ts;
+
+	ts->dav_gpio = dav_gpio;
+#ifdef CONFIG_ARCH_OMAP
+	r = omap_request_gpio(dav_gpio);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "unable to get DAV GPIO");
+		goto err1;
+	}
+	omap_set_gpio_direction(dav_gpio, 1);
+	ts->irq = OMAP_GPIO_IRQ(dav_gpio);
+#endif
+	init_timer(&ts->timer);
+	ts->timer.data = (unsigned long) tsc;
+	ts->timer.function = tsc2101_ts_timer;
+
+	spin_lock_init(&ts->lock);
+
+	ts->x_plate_ohm	= pdata->ts_x_plate_ohm ? : 280;
+	ts->hw_avg_max	= pdata->ts_hw_avg;
+	ts->max_pressure= pdata->ts_max_pressure ? : MAX_12BIT;
+	ts->touch_pressure = pdata->ts_touch_pressure ? : ts->max_pressure;
+	ts->ignore_last	= pdata->ts_ignore_last;
+	ts->stab_time	= pdata->ts_stab_time;
+
+	if ((r = tsc2101_ts_check_config(ts, &ts->hw_flags))) {
+		dev_err(&tsc->spi->dev, "invalid configuration\n");
+		goto err2;
+	}
+
+	idev = input_allocate_device();
+	if (idev == NULL) {
+		r = -ENOMEM;
+		goto err2;
+	}
+	idev->cdev.dev = &tsc->spi->dev;
+	idev->name = "TSC2101 touchscreen";
+	snprintf(ts->phys, sizeof(ts->phys),
+		 "%s/input-ts", tsc->spi->dev.bus_id);
+	idev->phys = ts->phys;
+
+	idev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
+	idev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	ts->idev = idev;
+
+	tsc2101_ts_setup_spi_xfer(tsc);
+
+	/* These parameters should perhaps be configurable? */
+	input_set_abs_params(idev, ABS_X, 0, 4096, 0, 0);
+	input_set_abs_params(idev, ABS_Y, 0, 4096, 0, 0);
+	input_set_abs_params(idev, ABS_PRESSURE, 0, 1024, 0, 0);
+
+	tsc2101_ts_start_scan(tsc);
+
+	ts->irq_enabled = 1;
+	r = request_irq(ts->irq, tsc2101_ts_irq_handler,
+			SA_SAMPLE_RANDOM | SA_TRIGGER_FALLING,
+			"tsc2101-ts", tsc);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "unable to get DAV IRQ");
+		goto err3;
+	}
+	set_irq_wake(ts->irq, 1);
+
+	r = device_create_file(&tsc->spi->dev, &dev_attr_pen_down);
+	r = device_create_file(&tsc->spi->dev, &dev_attr_disable_ts);
+
+	r = input_register_device(idev);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "can't register touchscreen
device\n");
+		goto err4;
+	}
+
+	return 0;
+err4:
+	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
+	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
+	free_irq(ts->irq, tsc);
+err3:
+	tsc2101_ts_stop_scan(tsc);
+	input_free_device(idev);
+err2:
+#ifdef CONFIG_ARCH_OMAP
+	omap_free_gpio(dav_gpio);
+#endif
+err1:
+	kfree(ts);
+	return r;
+}
+
+void __devexit tsc2101_ts_exit(struct tsc2101 *tsc)
+{
+	struct tsc2101_ts *ts = tsc->ts;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	tsc2101_ts_disable(tsc);
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
+	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
+
+	free_irq(ts->irq, tsc);
+	input_unregister_device(ts->idev);
+
+#ifdef CONFIG_ARCH_OMAP
+	omap_free_gpio(ts->dav_gpio);
+#endif
+	kfree(ts);
+}
+
+MODULE_AUTHOR("Kyungmin Park <kyungmin.park@samsung.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/tsc2301-core.c b/drivers/spi/tsc2301-core.c
new file mode 100644
index 0000000..cbad286
--- /dev/null
+++ b/drivers/spi/tsc2301-core.c
@@ -0,0 +1,336 @@
+/*
+ * TSC2301 driver
+ *
+ * Copyright (C) 2005, 2006 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2301.h>
+
+#ifdef CONFIG_ARCH_OMAP
+#include <asm/arch/gpio.h>
+#endif
+
+u16 tsc2301_read_reg(struct tsc2301 *tsc, int reg)
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 data = 0, cmd;
+
+	cmd = reg;
+	cmd |= 0x8000;
+
+	memset(t, 0, sizeof(t));
+	spi_message_init(&m);
+	m.spi = tsc->spi;
+
+	t[0].tx_buf = &cmd;
+	t[0].rx_buf = NULL;
+	t[0].len = 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf = NULL;
+	t[1].rx_buf = &data;
+	t[1].len = 2;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_sync(m.spi, &m);
+
+	return data;
+}
+
+void tsc2301_write_reg(struct tsc2301 *tsc, int reg, u16 val)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	u16 data[2];
+
+	/* Now we prepare the command for transferring */
+	data[0] = reg;
+	data[1] = val;
+
+	spi_message_init(&m);
+	m.spi = tsc->spi;
+
+	memset(&t, 0, sizeof(t));
+	t.tx_buf = data;
+	t.rx_buf = NULL;
+	t.len = 4;
+	spi_message_add_tail(&t, &m);
+
+	spi_sync(m.spi, &m);
+}
+
+void tsc2301_write_kbc(struct tsc2301 *tsc, int val)
+{
+	u16 w;
+
+	w = tsc->config2_shadow;
+	w &= ~(0x03 << 14);
+	w |= (val & 0x03) << 14;
+	tsc2301_write_reg(tsc, TSC2301_REG_CONFIG2, w);
+	tsc->config2_shadow = w;
+}
+
+void tsc2301_write_pll(struct tsc2301 *tsc,
+		       int pll_n, int pll_a, int pll_pdc, int pct_e, int
pll_o)
+{
+	u16 w;
+
+	w = tsc->config2_shadow;
+	w &= ~0x3fff;
+	w |= (pll_n & 0x0f) | ((pll_a & 0x0f) << 4) | ((pll_pdc & 0x0f) <<
8);
+	w |= pct_e ? (1 << 12) : 0;
+	w |= pll_o ? (1 << 13) : 0;
+	tsc2301_write_reg(tsc, TSC2301_REG_CONFIG2, w);
+	tsc->config2_shadow = w;
+}
+
+void tsc2301_read_buf(struct tsc2301 *tsc, int reg, u16 *rx_buf, int len)
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 cmd, i;
+
+	cmd = reg;
+	cmd |= 0x8000;
+
+	spi_message_init(&m);
+	m.spi = tsc->spi;
+
+	memset(t, 0, sizeof(t));
+	t[0].tx_buf = &cmd;
+	t[0].rx_buf = NULL;
+	t[0].len = 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf = NULL;
+	t[1].rx_buf = rx_buf;
+	t[1].len = 2 * len;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_sync(m.spi, &m);
+
+	for (i = 0; i < len; i++)
+		printk(KERN_DEBUG "rx_buf[%d]: %04x\n", i, rx_buf[i]);
+}
+
+void tsc2301_enable_mclk(struct device *dev)
+{
+	struct tsc2301 *tsc = dev_get_drvdata(dev);
+
+	if (tsc->enable_clock == NULL)
+		return;
+
+	tsc->enable_clock(dev);
+}
+
+void tsc2301_disable_mclk(struct device *dev)
+{
+	struct tsc2301 *tsc = dev_get_drvdata(dev);
+
+	might_sleep();
+	if (tsc->disable_clock == NULL)
+		return;
+
+	/* Submodules might need to take action before stopping the
+	 * clock. Keypad scanning needs to be stopped / restarted for one.
+	 */
+	if (tsc->kp != NULL)
+		tsc2301_kp_prep_for_clk_stop(tsc);
+	if (tsc->ts != NULL)
+		tsc2301_ts_prep_for_clk_stop(tsc);
+	if (tsc->mixer != NULL)
+		tsc2301_mixer_prep_for_clk_stop(tsc);
+
+	tsc->disable_clock(dev);
+
+	if (tsc->mixer != NULL)
+		tsc2301_mixer_cont_after_clk_stop(tsc);
+	if (tsc->ts != NULL)
+		tsc2301_ts_cont_after_clk_stop(tsc);
+	if (tsc->kp != NULL)
+		tsc2301_kp_cont_after_clk_stop(tsc);
+}
+
+static int __devinit tsc2301_probe(struct spi_device *spi)
+{
+	struct tsc2301			*tsc;
+	struct tsc2301_platform_data	*pdata = spi->dev.platform_data;
+	int r;
+	u16 w;
+
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data?\n");
+		return -ENODEV;
+	}
+
+	printk("TSC2301 driver initializing\n");
+
+	tsc = kzalloc(sizeof(*tsc), GFP_KERNEL);
+	if (tsc == NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, tsc);
+	tsc->spi = spi;
+	spi->dev.power.power_state = PMSG_ON;
+
+	tsc->enable_clock = pdata->enable_clock;
+	tsc->disable_clock = pdata->disable_clock;
+
+	if (pdata->reset_gpio >= 0) {
+		tsc->reset_gpio = pdata->reset_gpio;
+#ifdef CONFIG_ARCH_OMAP
+		r = omap_request_gpio(tsc->reset_gpio);
+		if (r < 0)
+			goto err1;
+		omap_set_gpio_dataout(tsc->reset_gpio, 1);
+		omap_set_gpio_direction(tsc->reset_gpio, 0);
+		mdelay(1);
+		omap_set_gpio_dataout(tsc->reset_gpio, 0);
+#endif
+	} else
+		tsc->reset_gpio = -1;
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 16;
+	/* The max speed might've been defined by the board-specific
+	 * struct */
+	if (!spi->max_speed_hz)
+		spi->max_speed_hz = TSC2301_HZ;
+	spi_setup(spi);
+
+	w = tsc2301_read_reg(tsc, TSC2301_REG_ADC);
+	if (!(w & (1 << 14))) {
+		dev_err(&spi->dev, "invalid ADC reg value: %04x\n", w);
+		r = -ENODEV;
+		goto err1;
+	}
+
+	w = tsc2301_read_reg(tsc, TSC2301_REG_DAC);
+	if (!(w & (1 << 15))) {
+		dev_err(&spi->dev, "invalid DAC reg value: %04x\n", w);
+		r = -ENODEV;
+		goto err1;
+	}
+
+	/* Stop keypad scanning */
+	tsc2301_write_reg(tsc, TSC2301_REG_KEY, 0x4000);
+
+	/* We have to cache this for read-modify-write, since we can't
+	 * read back BIT15 */
+	w = tsc2301_read_reg(tsc, TSC2301_REG_CONFIG2);
+	/* By default BIT15 is set */
+	w |= 1 << 15;
+	tsc->config2_shadow = w;
+
+	r = tsc2301_kp_init(tsc, pdata);
+	if (r)
+		goto err1;
+	r = tsc2301_ts_init(tsc, pdata);
+	if (r)
+		goto err2;
+	r = tsc2301_mixer_init(tsc, pdata);
+	if (r)
+		goto err3;
+	return 0;
+
+err3:
+	tsc2301_ts_exit(tsc);
+err2:
+	tsc2301_kp_exit(tsc);
+err1:
+	kfree(tsc);
+	return r;
+}
+
+static int __devexit tsc2301_remove(struct spi_device *spi)
+{
+	struct tsc2301 *tsc = dev_get_drvdata(&spi->dev);
+
+	tsc2301_mixer_exit(tsc);
+        tsc2301_ts_exit(tsc);
+        tsc2301_kp_exit(tsc);
+	kfree(tsc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tsc2301_suspend(struct spi_device *spi, pm_message_t mesg)
+{
+	struct tsc2301 *tsc = dev_get_drvdata(&spi->dev);
+	int r;
+
+	if ((r = tsc2301_mixer_suspend(tsc)) < 0)
+		return r;
+	if ((r = tsc2301_kp_suspend(tsc)) < 0)
+		goto err1;
+	if ((r = tsc2301_ts_suspend(tsc)) < 0)
+		goto err2;
+
+	return 0;
+err2:
+	tsc2301_kp_resume(tsc);
+err1:
+	tsc2301_mixer_resume(tsc);
+	return r;
+}
+
+static int tsc2301_resume(struct spi_device *spi)
+{
+	struct tsc2301 *tsc = dev_get_drvdata(&spi->dev);
+
+	tsc2301_ts_resume(tsc);
+	tsc2301_kp_resume(tsc);
+	tsc2301_mixer_resume(tsc);
+	return 0;
+}
+#endif
+
+static struct spi_driver tsc2301_driver = {
+	.driver = {
+		   .name = "tsc2301",
+		   .bus = &spi_bus_type,
+		   .owner = THIS_MODULE,
+	},
+#ifdef CONFIG_PM
+	.suspend = tsc2301_suspend,
+	.resume = tsc2301_resume,
+#endif
+	.probe = tsc2301_probe,
+	.remove = __devexit_p(tsc2301_remove),
+};
+
+static int __init tsc2301_init(void)
+{
+	return spi_register_driver(&tsc2301_driver);
+}
+module_init(tsc2301_init);
+
+static void __exit tsc2301_exit(void)
+{
+	spi_unregister_driver(&tsc2301_driver);
+}
+module_exit(tsc2301_exit);
+
+MODULE_AUTHOR("Juha Yrj l  <juha.yrjola@nokia.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/tsc2301-ts.c b/drivers/spi/tsc2301-ts.c
new file mode 100644
index 0000000..f1a74d7
--- /dev/null
+++ b/drivers/spi/tsc2301-ts.c
@@ -0,0 +1,682 @@
+/*
+ * TSC2301 touchscreen driver
+ *
+ * Copyright (C) 2005-2006 Nokia Corporation
+ *
+ * Written by Jarkko Oikarinen, Imre Deak and Juha Yrjola
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+
+#ifdef CONFIG_ARCH_OMAP
+#include <asm/arch/gpio.h>
+#endif
+
+#include <linux/spi/tsc2301.h>
+
+/**
+ * The touchscreen interface operates as follows:
+ *
+ * Initialize:
+ *    Request access to GPIO103 (DAV)
+ *    tsc2301_dav_irq_handler will trigger when DAV line goes down
+ *
+ *  1) Pen is pressed against touchscreeen
+ *  2) TSC2301 performs AD conversion
+ *  3) After the conversion is done TSC2301 drives DAV line down
+ *  4) GPIO IRQ is received and tsc2301_dav_irq_handler is called
+ *  5) tsc2301_dav_irq_handler sets up tsc2301_ts_timer in
TSC2301_TS_SCAN_TIME
+ *  6) tsc2301_ts_timer disables the irq and requests spi driver
+ *     to read X, Y, Z1 and Z2
+ *  7) SPI framework calls tsc2301_ts_rx after the coordinates are read
+ *  8) tsc2301_ts_rx reports coordinates to input layer and
+ *     sets up tsc2301_ts_timer to be called after TSC2301_TS_SCAN_TIME
+ *  9) if tsc2301_tx_timer notices that the pen has been lifted, the lift
event
+ *     is sent, and irq is again enabled.
+ */
+
+
+#define TSC2301_TOUCHSCREEN_PRODUCT_ID      		0x0052
+#define TSC2301_TOUCHSCREEN_PRODUCT_VERSION 		0x0001
+
+#define TSC2301_TS_SCAN_TIME		     		1
+
+#define TSC2301_ADCREG_CONVERSION_CTRL_BY_TSC2301	0x8000
+#define TSC2301_ADCREG_CONVERSION_CTRL_BY_HOST		0x0000
+
+#define TSC2301_ADCREG_FUNCTION_NONE			0x0000
+#define TSC2301_ADCREG_FUNCTION_XY			0x0400
+#define TSC2301_ADCREG_FUNCTION_XYZ			0x0800
+#define TSC2301_ADCREG_FUNCTION_X			0x0C00
+#define TSC2301_ADCREG_FUNCTION_Y			0x1000
+#define TSC2301_ADCREG_FUNCTION_Z			0x1400
+#define TSC2301_ADCREG_FUNCTION_DAT1			0x1800
+#define TSC2301_ADCREG_FUNCTION_DAT2			0x1C00
+#define TSC2301_ADCREG_FUNCTION_AUX1			0x2000
+#define TSC2301_ADCREG_FUNCTION_AUX2			0x2400
+#define TSC2301_ADCREG_FUNCTION_TEMP			0x2800
+
+#define TSC2301_ADCREG_RESOLUTION_8BIT			0x0100
+#define TSC2301_ADCREG_RESOLUTION_10BIT			0x0200
+#define TSC2301_ADCREG_RESOLUTION_12BIT			0x0300
+
+#define TSC2301_ADCREG_AVERAGING_NONE			0x0000
+#define TSC2301_ADCREG_AVERAGING_4AVG			0x0040
+#define TSC2301_ADCREG_AVERAGING_8AVG			0x0080
+#define TSC2301_ADCREG_AVERAGING_16AVG			0x00C0
+
+#define TSC2301_ADCREG_CLOCK_8MHZ			0x0000
+#define TSC2301_ADCREG_CLOCK_4MHZ			0x0010
+#define TSC2301_ADCREG_CLOCK_2MHZ			0x0020
+#define TSC2301_ADCREG_CLOCK_1MHZ			0x0030
+
+#define TSC2301_ADCREG_VOLTAGE_STAB_0US			0x0000
+#define TSC2301_ADCREG_VOLTAGE_STAB_100US		0x0002
+#define TSC2301_ADCREG_VOLTAGE_STAB_500US		0x0004
+#define TSC2301_ADCREG_VOLTAGE_STAB_1MS			0x0006
+#define TSC2301_ADCREG_VOLTAGE_STAB_5MS			0x0008
+#define TSC2301_ADCREG_VOLTAGE_STAB_10MS		0x000A
+#define TSC2301_ADCREG_VOLTAGE_STAB_50MS		0x000C
+#define TSC2301_ADCREG_VOLTAGE_STAB_100MS		0x000E
+
+#define TSC2301_ADCREG_STOP_CONVERSION			0x4000
+
+#define MAX_12BIT					((1 << 12) - 1)
+
+struct tsc2301_ts {
+	struct input_dev	*idev;
+	char			phys[32];
+	struct timer_list	timer;
+	spinlock_t		lock;
+
+	struct spi_transfer	read_xfer[2];
+	struct spi_message	read_msg;
+	u16                     data[4];
+
+	int			hw_avg_max;
+	u16			x;
+	u16			y;
+	u16			p;
+	int			sample_cnt;
+
+	int			ignore_last : 1;
+	u16			x_plate_ohm;
+	int			stab_time;
+	int			max_pressure;
+	int			touch_pressure;
+	int			pressure_limit;
+
+	u16			irq_enabled:1;
+	u16			pen_down:1;
+	u16			disabled:1;
+	u16			pending:1;
+
+	int			hw_flags;
+
+	s16			dav_gpio;
+	int			irq;
+};
+
+
+static const u16 tsc2301_ts_read_data = 0x8000 | TSC2301_REG_X;
+
+static int tsc2301_ts_check_config(struct tsc2301_ts *ts, int *hw_flags)
+{
+	int flags;
+
+	flags = 0;
+	switch (ts->hw_avg_max) {
+	case 0:
+		flags |= TSC2301_ADCREG_AVERAGING_NONE;
+		break;
+	case 4:
+		flags |= TSC2301_ADCREG_AVERAGING_4AVG;
+		break;
+	case 8:
+		flags |= TSC2301_ADCREG_AVERAGING_8AVG;
+		break;
+	case 16:
+		flags |= TSC2301_ADCREG_AVERAGING_16AVG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (ts->stab_time) {
+	case 0:
+		flags |= TSC2301_ADCREG_VOLTAGE_STAB_0US;
+		break;
+	case 100:
+		flags |= TSC2301_ADCREG_VOLTAGE_STAB_100US;
+		break;
+	case 500:
+		flags |= TSC2301_ADCREG_VOLTAGE_STAB_500US;
+		break;
+	case 1000:
+		flags |= TSC2301_ADCREG_VOLTAGE_STAB_1MS;
+		break;
+	case 5000:
+		flags |= TSC2301_ADCREG_VOLTAGE_STAB_5MS;
+		break;
+	case 10000:
+		flags |= TSC2301_ADCREG_VOLTAGE_STAB_10MS;
+		break;
+	case 50000:
+		flags |= TSC2301_ADCREG_VOLTAGE_STAB_50MS;
+		break;
+	case 100000:
+		flags |= TSC2301_ADCREG_VOLTAGE_STAB_100MS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*hw_flags = flags;
+	return 0;
+}
+
+/*
+ * This odd three-time initialization is to work around a bug in TSC2301.
+ * See TSC2301 errata for details.
+ */
+static int tsc2301_ts_configure(struct tsc2301 *tsc, int flags)
+{
+	struct spi_transfer xfer[3];
+	struct spi_transfer *x;
+	struct spi_message m;
+	int reg = TSC2301_REG_ADC;
+	u16 val1, val2, val3;
+	u16 data[6];
+
+	val1 = TSC2301_ADCREG_CONVERSION_CTRL_BY_HOST |
+		TSC2301_ADCREG_STOP_CONVERSION |
+		TSC2301_ADCREG_FUNCTION_NONE |
+		TSC2301_ADCREG_RESOLUTION_12BIT |
+		TSC2301_ADCREG_AVERAGING_NONE |
+		TSC2301_ADCREG_CLOCK_2MHZ |
+		TSC2301_ADCREG_VOLTAGE_STAB_100MS;
+
+	val2 = TSC2301_ADCREG_CONVERSION_CTRL_BY_HOST |
+		TSC2301_ADCREG_FUNCTION_XYZ |
+		TSC2301_ADCREG_RESOLUTION_12BIT |
+		TSC2301_ADCREG_AVERAGING_16AVG |
+		TSC2301_ADCREG_CLOCK_1MHZ |
+		TSC2301_ADCREG_VOLTAGE_STAB_100MS;
+
+	/* Averaging and voltage stabilization settings in flags */
+	val3 = TSC2301_ADCREG_CONVERSION_CTRL_BY_TSC2301 |
+		TSC2301_ADCREG_FUNCTION_XYZ |
+		TSC2301_ADCREG_RESOLUTION_12BIT |
+		TSC2301_ADCREG_CLOCK_1MHZ |
+		flags;
+
+	/* Now we prepare the command for transferring */
+	data[0] = reg;
+	data[1] = val1;
+	data[2] = reg;
+	data[3] = val2;
+	data[4] = reg;
+	data[5] = val3;
+
+	spi_message_init(&m);
+	m.spi = tsc->spi;
+
+	memset(xfer, 0, sizeof(xfer));
+	x = &xfer[0];
+
+	x->tx_buf = &data[0];
+	x->len = 4;
+	x->cs_change = 1;
+	spi_message_add_tail(x, &m);
+
+	x++;
+	x->tx_buf = &data[2];
+	x->len = 4;
+	x->cs_change = 1;
+	spi_message_add_tail(x, &m);
+
+	x++;
+	x->tx_buf = &data[4];
+	x->len = 4;
+	spi_message_add_tail(x, &m);
+
+	spi_sync(m.spi, &m);
+
+	return 0;
+}
+
+static void tsc2301_ts_start_scan(struct tsc2301 *tsc)
+{
+	tsc2301_ts_configure(tsc, tsc->ts->hw_flags);
+}
+
+static void tsc2301_ts_stop_scan(struct tsc2301 *tsc)
+{
+	tsc2301_ts_configure(tsc, TSC2301_ADCREG_STOP_CONVERSION);
+}
+
+static int device_suspended(struct device *dev)
+{
+	struct tsc2301 *tsc = dev_get_drvdata(dev);
+	return dev->power.power_state.event != PM_EVENT_ON || tsc->ts-
>disabled;
+}
+
+static void update_pen_state(struct tsc2301_ts *ts, int x, int y, int
pressure)
+{
+	int sync = 0;
+
+	if (pressure) {
+		input_report_abs(ts->idev, ABS_X, x);
+		input_report_abs(ts->idev, ABS_Y, y);
+		input_report_abs(ts->idev, ABS_PRESSURE, pressure);
+		if (!ts->pen_down)
+			input_report_key(ts->idev, BTN_TOUCH, 1);
+		sync = 1;
+	} else if (ts->pen_down) {
+		input_report_abs(ts->idev, ABS_PRESSURE, 0);
+		input_report_key(ts->idev, BTN_TOUCH, 0);
+		sync = 1;
+	}
+
+	if (sync)
+		input_sync(ts->idev);
+
+	ts->pen_down = pressure ? 1 : 0;
+#ifdef VERBOSE
+	dev_dbg(&tsc->spi->dev, "x %4d y %4d p %4d\n", x, y, pressure);
+#endif
+}
+
+/*
+ * This procedure is called by the SPI framework after the coordinates
+ * have been read from TSC2301
+ */
+static void tsc2301_ts_rx(void *arg)
+{
+	struct tsc2301 *tsc = arg;
+	struct tsc2301_ts *ts = tsc->ts;
+	unsigned int x, y, z1, z2, pressure;
+
+	x  = ts->data[0];
+	y  = ts->data[1];
+	z1 = ts->data[2];
+	z2 = ts->data[3];
+
+	if (z1) {
+		pressure = ts->x_plate_ohm * x;
+		pressure /= 4096;
+		pressure *= z2 - z1;
+		pressure /= z1;
+	} else
+		pressure = 0;
+
+	/* If pressure value is above a preset limit (pen is barely
+	 * touching the screen) we can't trust the coordinate values.
+	 */
+	if (pressure < ts->pressure_limit && x < MAX_12BIT && y <
MAX_12BIT) {
+		ts->pressure_limit = ts->max_pressure;
+		if (ts->ignore_last) {
+			if (ts->sample_cnt)
+				update_pen_state(ts, ts->x, ts->y, ts->p);
+			ts->x = x;
+			ts->y = y;
+			ts->p = pressure;
+		} else
+			update_pen_state(ts, x, y, pressure);
+		ts->sample_cnt++;
+	}
+
+	mod_timer(&ts->timer,
+		  jiffies + msecs_to_jiffies(TSC2301_TS_SCAN_TIME));
+}
+
+static int is_pen_down(struct tsc2301_ts *ts)
+{
+	return ts->pen_down;
+}
+
+/*
+ * Timer is called every TSC2301_TS_SCAN_TIME when the pen is down
+ */
+static void tsc2301_ts_timer(unsigned long arg)
+{
+	struct tsc2301 *tsc = (void *) arg;
+	struct tsc2301_ts *ts = tsc->ts;
+	unsigned long flags;
+	int ndav;
+	int r;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	ndav = omap_get_gpio_datain(ts->dav_gpio);
+	if (ndav || device_suspended(&tsc->spi->dev)) {
+		/* Pen has been lifted */
+		if (!device_suspended(&tsc->spi->dev)) {
+			ts->irq_enabled = 1;
+			enable_irq(ts->irq);
+		}
+		update_pen_state(ts, 0, 0, 0);
+		ts->pending = 0;
+		spin_unlock_irqrestore(&ts->lock, flags);
+
+	} else {
+		ts->pen_down = 1;
+		spin_unlock_irqrestore(&ts->lock, flags);
+
+		r = spi_async(tsc->spi, &ts->read_msg);
+		if (r)
+			dev_err(&tsc->spi->dev, "ts: spi_async() failed");
+	}
+}
+
+/*
+ * This interrupt is called when pen is down and first coordinates are
+ * available. That is indicated by a falling edge on DEV line.  IRQ is
+ * disabled here because while the pen is down the coordinates are
+ * read by a timer.
+ */
+static irqreturn_t tsc2301_ts_irq_handler(int irq, void *dev_id)
+{
+	struct tsc2301 *tsc = dev_id;
+	struct tsc2301_ts *ts = tsc->ts;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	if (ts->irq_enabled) {
+		ts->irq_enabled = 0;
+		disable_irq(ts->irq);
+		ts->pending = 1;
+		ts->pressure_limit = ts->touch_pressure;
+		ts->sample_cnt = 0;
+		mod_timer(&ts->timer,
+			  jiffies + msecs_to_jiffies(TSC2301_TS_SCAN_TIME));
+	}
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+/* Must be called with ts->lock held */
+static void tsc2301_ts_disable(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts = tsc->ts;
+
+	if (ts->disabled)
+		return;
+
+	ts->disabled = 1;
+	if (!ts->pending) {
+		ts->irq_enabled = 0;
+		disable_irq(ts->irq);
+	} else {
+		while (ts->pending) {
+			spin_unlock_irq(&ts->lock);
+			msleep(1);
+			spin_lock_irq(&ts->lock);
+		}
+	}
+
+	spin_unlock_irq(&ts->lock);
+	tsc2301_ts_stop_scan(tsc);
+	spin_lock_irq(&ts->lock);
+}
+
+static void tsc2301_ts_enable(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts = tsc->ts;
+
+	if (!ts->disabled)
+		return;
+
+	ts->disabled = 0;
+	ts->irq_enabled = 1;
+	enable_irq(ts->irq);
+
+	spin_unlock_irq(&ts->lock);
+	tsc2301_ts_start_scan(tsc);
+	spin_lock_irq(&ts->lock);
+}
+
+#ifdef CONFIG_PM
+int tsc2301_ts_suspend(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts = tsc->ts;
+
+	spin_lock_irq(&ts->lock);
+	tsc2301_ts_disable(tsc);
+	spin_unlock_irq(&ts->lock);
+
+	return 0;
+}
+
+void tsc2301_ts_resume(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts = tsc->ts;
+
+	spin_lock_irq(&ts->lock);
+	tsc2301_ts_enable(tsc);
+	spin_unlock_irq(&ts->lock);
+}
+#endif
+
+void tsc2301_ts_prep_for_clk_stop(struct tsc2301 *tsc)
+{
+}
+
+void tsc2301_ts_cont_after_clk_stop(struct tsc2301 *tsc)
+{
+}
+
+static void tsc2301_ts_setup_spi_xfer(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts = tsc->ts;
+	struct spi_message *m = &ts->read_msg;
+	struct spi_transfer *x = &ts->read_xfer[0];
+
+	spi_message_init(m);
+
+	x->tx_buf = &tsc2301_ts_read_data;
+	x->len = 2;
+	spi_message_add_tail(x, m);
+
+	x++;
+	x->rx_buf = &ts->data;
+	x->len = 8;
+	spi_message_add_tail(x, m);
+
+	m->complete = tsc2301_ts_rx;
+	m->context = tsc;
+}
+
+static ssize_t tsc2301_ts_pen_down_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tsc2301 *tsc = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", is_pen_down(tsc->ts));
+}
+
+static DEVICE_ATTR(pen_down, S_IRUGO, tsc2301_ts_pen_down_show, NULL);
+
+static ssize_t tsc2301_ts_disable_show(struct device *dev,
+				       struct device_attribute *attr, char
*buf)
+{
+	struct tsc2301		*tsc = dev_get_drvdata(dev);
+	struct tsc2301_ts	*ts = tsc->ts;
+
+	return sprintf(buf, "%u\n", ts->disabled);
+}
+
+static ssize_t tsc2301_ts_disable_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct tsc2301		*tsc = dev_get_drvdata(dev);
+	struct tsc2301_ts	*ts = tsc->ts;
+	char *endp;
+	int i;
+
+	i = simple_strtoul(buf, &endp, 10);
+	spin_lock_irq(&ts->lock);
+
+	if (i)
+		tsc2301_ts_disable(tsc);
+	else
+		tsc2301_ts_enable(tsc);
+
+	spin_unlock_irq(&ts->lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(disable_ts, 0664, tsc2301_ts_disable_show,
+		   tsc2301_ts_disable_store);
+
+int __devinit tsc2301_ts_init(struct tsc2301 *tsc,
+			      struct tsc2301_platform_data *pdata)
+{
+	struct tsc2301_ts *ts;
+	struct input_dev *idev;
+	int dav_gpio, r;
+
+	if (pdata->dav_gpio < 0) {
+		dev_err(&tsc->spi->dev, "need DAV GPIO");
+		return -EINVAL;
+	}
+	dav_gpio = pdata->dav_gpio;
+
+	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+	if (ts == NULL)
+		return -ENOMEM;
+	tsc->ts = ts;
+
+	ts->dav_gpio = dav_gpio;
+#ifdef CONFIG_ARCH_OMAP
+	r = omap_request_gpio(dav_gpio);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "unable to get DAV GPIO");
+		goto err1;
+	}
+	omap_set_gpio_direction(dav_gpio, 1);
+	ts->irq = OMAP_GPIO_IRQ(dav_gpio);
+#endif
+	init_timer(&ts->timer);
+	ts->timer.data = (unsigned long) tsc;
+	ts->timer.function = tsc2301_ts_timer;
+
+	spin_lock_init(&ts->lock);
+
+	ts->x_plate_ohm	= pdata->ts_x_plate_ohm ? : 280;
+	ts->hw_avg_max	= pdata->ts_hw_avg;
+	ts->max_pressure= pdata->ts_max_pressure ? : MAX_12BIT;
+	ts->touch_pressure = pdata->ts_touch_pressure ? : ts->max_pressure;
+	ts->ignore_last	= pdata->ts_ignore_last;
+	ts->stab_time	= pdata->ts_stab_time;
+
+	if ((r = tsc2301_ts_check_config(ts, &ts->hw_flags))) {
+		dev_err(&tsc->spi->dev, "invalid configuration\n");
+		goto err2;
+	}
+
+	idev = input_allocate_device();
+	if (idev == NULL) {
+		r = -ENOMEM;
+		goto err2;
+	}
+	idev->cdev.dev = &tsc->spi->dev;
+	idev->name = "TSC2301 touchscreen";
+	snprintf(ts->phys, sizeof(ts->phys),
+		 "%s/input-ts", tsc->spi->dev.bus_id);
+	idev->phys = ts->phys;
+
+	idev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
+	idev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	ts->idev = idev;
+
+	tsc2301_ts_setup_spi_xfer(tsc);
+
+	/* These parameters should perhaps be configurable? */
+	input_set_abs_params(idev, ABS_X, 0, 4096, 0, 0);
+	input_set_abs_params(idev, ABS_Y, 0, 4096, 0, 0);
+	input_set_abs_params(idev, ABS_PRESSURE, 0, 1024, 0, 0);
+
+	tsc2301_ts_start_scan(tsc);
+
+	ts->irq_enabled = 1;
+	r = request_irq(ts->irq, tsc2301_ts_irq_handler,
+			SA_SAMPLE_RANDOM | SA_TRIGGER_FALLING,
+			"tsc2301-ts", tsc);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "unable to get DAV IRQ");
+		goto err3;
+	}
+	set_irq_wake(ts->irq, 1);
+
+	r = device_create_file(&tsc->spi->dev, &dev_attr_pen_down);
+	r = device_create_file(&tsc->spi->dev, &dev_attr_disable_ts);
+
+	r = input_register_device(idev);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "can't register touchscreen
device\n");
+		goto err4;
+	}
+
+	return 0;
+err4:
+	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
+	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
+	free_irq(ts->irq, tsc);
+err3:
+	tsc2301_ts_stop_scan(tsc);
+	input_free_device(idev);
+err2:
+#ifdef CONFIG_ARCH_OMAP
+	omap_free_gpio(dav_gpio);
+#endif
+err1:
+	kfree(ts);
+	return r;
+}
+
+void __devexit tsc2301_ts_exit(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts = tsc->ts;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	tsc2301_ts_disable(tsc);
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
+	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
+
+	free_irq(ts->irq, tsc);
+	input_unregister_device(ts->idev);
+
+#ifdef CONFIG_ARCH_OMAP
+	omap_free_gpio(ts->dav_gpio);
+#endif
+	kfree(ts);
+}
+MODULE_AUTHOR("Jarkko Oikarinen <jarkko.oikarinen@nokia.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/spi/tsc2101.h b/include/linux/spi/tsc2101.h
new file mode 100644
index 0000000..efb4437
--- /dev/null
+++ b/include/linux/spi/tsc2101.h
@@ -0,0 +1,199 @@
+#ifndef _LINUX_SPI_TSC2101_H
+#define _LINUX_SPI_TSC2101_H
+
+#include <linux/types.h>
+#include <linux/timer.h>
+
+struct tsc2101_platform_data {
+	/*
+	 * Keypad
+	 */
+	s16	reset_gpio;
+	s16	keyb_int;
+	s16	keymap[16];	/* Set a key to a negative value if not
used */
+	unsigned kp_rep:1;	/* Enable keypad repeating */
+
+	/*
+	 * Touchscreen
+	 */
+	s16	dav_gpio;
+	s16	pen_int_gpio;
+	u16	ts_x_plate_ohm;
+	u32	ts_stab_time;	/* voltage settling time */
+	u8	ts_hw_avg;	/* HW assiseted averaging. Can be
+				   0, 4, 8, 16 samples per reading */
+	u32	ts_max_pressure;/* Samples with bigger pressure value will
+				   be ignored, since the corresponding X, Y
+				   values are unreliable */
+	u32	ts_touch_pressure;	/* Pressure limit until we report a
+					   touch event. After that we switch
+					   to ts_max_pressure. */
+	unsigned ts_ignore_last : 1;
+
+	/*
+	 * Audio
+	 */
+	unsigned	pll_pdc:4;
+	unsigned	pll_a:4;
+	unsigned	pll_n:4;
+	unsigned	pll_output:1; /* Output PLL on GPIO_0 */
+
+	unsigned	mclk_ratio:2;
+	unsigned	i2s_sample_rate:4;
+	unsigned	i2s_format:2;
+	/* Mask for audio blocks to be powered down */
+	u16		power_down_blocks;
+
+	/* Called after codec has been initialized, can be NULL */
+	int (* codec_init)(struct device *tsc2101_dev);
+	/* Called when codec is being removed, can be NULL */
+	void (* codec_cleanup)(struct device *tsc2101_dev);
+	int	(*enable_clock)(struct device *dev);
+	void	(*disable_clock)(struct device *dev);
+	int	(*get_keyb_irq_state)(struct device *dev);
+
+	const struct tsc2101_mixer_gpio {
+		const char	*name;
+		unsigned	gpio:4;
+		unsigned	inverted:1;
+		unsigned	def_enable:1; /* enable by default */
+		unsigned	deactivate_on_pd:1; /* power-down flag */
+	} *mixer_gpios;
+	int	n_mixer_gpios;
+};
+
+struct tsc2101_kp;
+struct tsc2101_ts;
+struct tsc2101_mixer;
+
+struct tsc2101 {
+	struct spi_device	*spi;
+
+	s16			reset_gpio;
+	u16			config2_shadow;
+
+        struct tsc2101_kp	*kp;
+	struct tsc2101_ts	*ts;
+	struct tsc2101_mixer	*mixer;
+
+	int			(*enable_clock)(struct device *dev);
+	void			(*disable_clock)(struct device *dev);
+};
+
+
+#define TSC2101_HZ	33000000
+
+#define TSC2101_REG(page, addr)  (((page) << 11) | ((addr) << 5))
+#define TSC2101_REG_TO_PAGE(reg) (((reg) >> 11) & 0x03)
+#define TSC2101_REG_TO_ADDR(reg) (((reg) >> 5)  & 0x1f)
+
+#define TSC2101_REG_X		TSC2101_REG(0, 0)
+#define TSC2101_REG_Y		TSC2101_REG(0, 1)
+#define TSC2101_REG_Z1		TSC2101_REG(0, 2)
+#define TSC2101_REG_Z2		TSC2101_REG(0, 3)
+
+#define TSC2101_REG_ADC		TSC2101_REG(1, 0)
+#define TSC2101_REG_STATUS	TSC2101_REG(1, 1)
+#define TSC2101_REG_BUFFER	TSC2101_REG(1, 2)
+#define TSC2101_REG_REF		TSC2101_REG(1, 3)
+#define TSC2101_REG_CONFIG	TSC2101_REG(1, 5)
+#define TSC2101_REG_PROG_DELAY	TSC2101_REG(1, 13)
+
+#define TSC2101_REG_AUDIO1	TSC2101_REG(2, 0)
+#define TSC2101_REG_DAC_GAIN	TSC2101_REG(2, 2)
+#define TSC2101_REG_AUDIO2	TSC2101_REG(2, 4)
+#define TSC2101_REG_DAC_POWER	TSC2101_REG(2, 5)
+#define TSC2101_REG_AUDIO3	TSC2101_REG(2, 6)
+#define TSC2101_REG_ADCLKCFG	TSC2101_REG(2, 27)
+
+#define TSC2101_REG_PD_MISC_APD		(1 << 15)
+#define TSC2101_REG_PD_MISC_AVPD	(1 << 14)
+#define TSC2101_REG_PD_MISC_ABPD	(1 << 13)
+#define TSC2101_REG_PD_MISC_HAPD	(1 << 12)
+#define TSC2101_REG_PD_MISC_MOPD	(1 << 11)
+#define TSC2101_REG_PD_MISC_DAPD	(1 << 10)
+#define TSC2101_REG_PD_MISC_ADPDL	(1 << 9)
+#define TSC2101_REG_PD_MISC_ADPDR	(1 << 8)
+#define TSC2101_REG_PD_MISC_PDSTS	(1 << 7)
+#define TSC2101_REG_PD_MISC_MIBPD	(1 << 6)
+
+/* I2S sample rate */
+#define TSC2101_I2S_SR_48000	0x00
+#define TSC2101_I2S_SR_44100	0x01
+#define TSC2101_I2S_SR_32000	0x02
+#define TSC2101_I2S_SR_24000	0x03
+#define TSC2101_I2S_SR_22050	0x04
+#define TSC2101_I2S_SR_16000	0x05
+#define TSC2101_I2S_SR_12000	0x06
+#define TSC2101_I2S_SR_11050	0x07
+#define TSC2101_I2S_SR_8000	0x08
+
+/* 16-bit, MSB-first. DAC Right-Justified, ADC Left-Justified */
+#define TSC2101_I2S_FORMAT0	0x00
+/* 20-bit, MSB-first. DAC Right-Justified, ADC Left-Justified */
+#define TSC2101_I2S_FORMAT1	0x01
+/* 20-bit, MSB-first. DAC Left-Justified, ADC Left-Justified */
+#define TSC2101_I2S_FORMAT2	0x02
+/* 20-bit, MSB-first */
+#define TSC2101_I2S_FORMAT3	0x03
+
+/* Master Clock Ratio */
+#define TSC2101_MCLK_256xFS	0x00 /* default */
+#define TSC2101_MCLK_384xFS	0x01
+#define TSC2101_MCLK_512xFS	0x02
+
+
+extern u16 tsc2101_read_reg(struct tsc2101 *tsc, int reg);
+extern void tsc2101_write_reg(struct tsc2101 *tsc, int reg, u16 val);
+extern void tsc2101_write_kbc(struct tsc2101 *tsc, int val);
+extern void tsc2101_write_pll(struct tsc2101 *tsc, int pll_n, int pll_a,
+			      int pll_pdc, int pct_e, int pll_o);
+extern void tsc2101_read_buf(struct tsc2101 *tsc, int reg, u16 *buf, int
len);
+
+#define TSC2101_DECL_MOD(module)					\
+extern int  tsc2101_##module##_init(struct tsc2101 *tsc,		\
+			   struct tsc2101_platform_data *pdata);	\
+extern void tsc2101_##module##_exit(struct tsc2101 *tsc);		\
+extern void tsc2101_##module##_prep_for_clk_stop(struct tsc2101 *tsc);	\
+extern void tsc2101_##module##_cont_after_clk_stop(struct tsc2101 *tsc);\
+extern int  tsc2101_##module##_suspend(struct tsc2101 *tsc);		\
+extern void tsc2101_##module##_resume(struct tsc2101 *tsc);
+
+#define TSC2101_DECL_EMPTY_MOD(module)					\
+static inline int tsc2101_##module##_init(struct tsc2101 *tsc,		\
+			   struct tsc2101_platform_data *pdata)		\
+{									\
+	return 0;							\
+}									\
+static inline void tsc2101_##module##_exit(struct tsc2101 *tsc) {}	\
+static inline void
tsc2101_##module##_prep_for_clk_stop			\
+					(struct tsc2101 *tsc) {}	\
+static inline void tsc2101_##module##_cont_after_clk_stop		\
+					(struct tsc2101 *tsc) {}	\
+static inline int  tsc2101_##module##_suspend(struct tsc2101 *tsc)	\
+{									\
+	return 0;							\
+}									\
+static inline void tsc2101_##module##_resume(struct tsc2101 *tsc) {}
+
+#ifdef CONFIG_SPI_TSC2101_TOUCHSCREEN
+TSC2101_DECL_MOD(ts)
+#else
+TSC2101_DECL_EMPTY_MOD(ts)
+#endif
+
+#ifdef CONFIG_SPI_TSC2101_AUDIO
+TSC2101_DECL_MOD(mixer)
+extern void tsc2101_mixer_set_power(struct device *tsc_dev, int dac, int
adc);
+
+struct snd_card;
+extern int tsc2101_mixer_register_controls(struct device *tsc_dev,
+					   struct snd_card *card);
+#else
+TSC2101_DECL_EMPTY_MOD(mixer)
+#endif
+
+extern void tsc2101_enable_mclk(struct device *tsc_dev);
+extern void tsc2101_disable_mclk(struct device *tsc_dev);
+
+#endif
