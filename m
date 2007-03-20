From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: TSC2101/2102
Date: Tue, 20 Mar 2007 10:46:12 +0900
Message-ID: <006e01c76a91$8ee234e0$c7a3580a@swcenter.sec.samsung.co.kr>
References: <20070309140650.GC4399@bitbox.mine.nu>
	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
	<45F7F6D4.20203@gmail.com> <20070314170952.GB10230@bitbox.mine.nu>
	<002801c7669f$d0fe2be0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070315102325.GA4555@bitbox.mine.nu>
	<004901c76762$06d66bc0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070316074157.GA1133@bitbox.mine.nu>
	<004401c767a1$f1489590$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070316094926.GA4519@bitbox.mine.nu>
	<00f201c769ca$a8e022c0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070319093721.bd0df13e.jarkko.nikula@nokia.com>
	<010f01c769fd$4ab24d30$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070319103711.36ffe999.jarkko.nikula@nokia.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_006F_01C76ADC.FEC9DCE0"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20070319103711.36ffe999.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Jarkko Nikula' <jarkko.nikula@nokia.com>
Cc: 'Linux OMAP ML' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_006F_01C76ADC.FEC9DCE0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit

> 
> > I will send the tsc2101 patch based on tsc2301 files. I 
> think it's complicted
> > with Imre's tsc2101 patch. 
> > 
> How about just keeping both of them separated including 
> config names, header files, etc. for awhile until both are 
> pushed & working. Bit easier first step for us I think :-)

I agree.

Here's tsc2101 patch. It includes the tsc2101 spi functions and touchscreen
part.
It's similary with your updated pache style.

I think it's not compatible with OMAP1 touchscreen in touchscreen/omap. But I
added the 16-bit bus handling part. It needs to be check.

Umm the new updated git tree don't have tsc2301 commit. maybe it's missing :)

Here's sample configuration at apollon.

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-
apollon.c
index 5488961..4f2ea29 100644
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
 #define SW_ENTER_GPIO16                16
 #define SW_UP_GPIO17           17
 #define SW_DOWN_GPIO58         58
+#define PINTDAV_GPIO85         85

 #define APOLLON_FLASH_CS       0
 #define APOLLON_ETH_CS         1
@@ -358,6 +361,33 @@ static void __init apollon_usb_init(void)
        omap_set_gpio_dataout(12, 0);
 }

+static struct omap2_mcspi_device_config tsc2101_mcspi_config = {
+       .turbo_mode             = 0,
+       .single_channel         = 0,
+};
+
+static struct tsc2101_platform_data tsc2101_platform_config = {
+       /* Bus */
+       .bits_per_word          = 32,
+
+       /* Touchscreen */
+       .dav_gpio               = PINTDAV_GPIO85,
+       .ts_x_plate_ohm         = 200,
+       .ts_stab_time           = 500,          /* 500 usec */
+       .ts_hw_avg              = 16,
+};
+
+static struct spi_board_info apollon_spi_board_info[] __initdata = {
+       [0] = {
+               .modalias               = "tsc2101",
+               .bus_num                = 1,
+               .chip_select            = 0,
+               .max_speed_hz           = 6000000,
+               .controller_data        = &tsc2101_mcspi_config,
+               .platform_data          = &tsc2101_platform_config,
+       },
+};
+
 static void __init omap_apollon_init(void)
 {
        apollon_led_init();
@@ -373,6 +403,8 @@ static void __init omap_apollon_init(void)
         * You have to mux them off in device drivers later on
         * if not needed.
         */
+       spi_register_board_info(apollon_spi_board_info,
+                               ARRAY_SIZE(apollon_spi_board_info));
        platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
        omap_board_config = apollon_config;
        omap_board_config_size = ARRAY_SIZE(apollon_config);

Thank you,
Kyungmin Park

------=_NextPart_000_006F_01C76ADC.FEC9DCE0
Content-Type: application/octet-stream;
	name="tsc2101.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="tsc2101.patch"

diff --git a/drivers/input/touchscreen/Kconfig =
b/drivers/input/touchscreen/Kconfig=0A=
index 6b46c9b..da5caea 100644=0A=
--- a/drivers/input/touchscreen/Kconfig=0A=
+++ b/drivers/input/touchscreen/Kconfig=0A=
@@ -159,4 +159,17 @@ config TOUCHSCREEN_UCB1400=0A=
 	  To compile this driver as a module, choose M here: the=0A=
 	  module will be called ucb1400_ts.=0A=
 =0A=
+config TOUCHSCREEN_TSC2101=0A=
+	tristate "TSC2101 touchscreen support"=0A=
+	depends on SPI_TSC2101=0A=
+	help=0A=
+	  Say Y here if you have a touchscreen interface using the=0A=
+	  TSC2101 controller, and your board-specific initialization=0A=
+	  code includes that in its table of SPI devices.=0A=
+=0A=
+	  If unsure, say N (but it's safe to say "Y").=0A=
+=0A=
+	  To compile this driver as a module, choose M here: the=0A=
+	  module will be called tsc2101_ts.=0A=
+=0A=
 endif=0A=
diff --git a/drivers/input/touchscreen/Makefile =
b/drivers/input/touchscreen/Makefile=0A=
index 061bc14..973154b 100644=0A=
--- a/drivers/input/touchscreen/Makefile=0A=
+++ b/drivers/input/touchscreen/Makefile=0A=
@@ -16,5 +16,6 @@ obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+=3D penmount.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+=3D touchright.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+=3D touchwin.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+=3D ucb1400_ts.o=0A=
+obj-$(CONFIG_TOUCHSCREEN_TSC2101)	+=3D tsc2101_ts.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_TSC2102)	+=3D tsc2102_ts.o=0A=
 obj-$(CONFIG_TOUCHSCREEN_OMAP)	+=3D omap/=0A=
diff --git a/drivers/input/touchscreen/tsc2101_ts.c =
b/drivers/input/touchscreen/tsc2101_ts.c=0A=
new file mode 100644=0A=
index 0000000..8dc6378=0A=
--- /dev/null=0A=
+++ b/drivers/input/touchscreen/tsc2101_ts.c=0A=
@@ -0,0 +1,715 @@=0A=
+/*=0A=
+ * TSC2101 touchscreen driver=0A=
+ *=0A=
+ * Copyright (C) 2005-2006 Nokia Corporation=0A=
+ *=0A=
+ * Copyright (C) 2007 Samsung Electronics=0A=
+ * Kyungmin Park <kyungmin.park@samsung.com>=0A=
+ *=0A=
+ * Derived from TSC2301 written by Jarkko Oikarinen, Imre Deak and Juha =
Yrjola=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or modify=0A=
+ * it under the terms of the GNU General Public License as published by=0A=
+ * the Free Software Foundation; either version 2 of the License, or=0A=
+ * (at your option) any later version.=0A=
+ *=0A=
+ * This program is distributed in the hope that it will be useful,=0A=
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the=0A=
+ * GNU General Public License for more details.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public License=0A=
+ * along with this program; if not, write to the Free Software=0A=
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 =
USA=0A=
+ */=0A=
+=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/input.h>=0A=
+#include <linux/interrupt.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/spi/spi.h>=0A=
+=0A=
+#ifdef CONFIG_ARCH_OMAP=0A=
+#include <asm/arch/gpio.h>=0A=
+#endif=0A=
+=0A=
+#include <linux/spi/tsc2101.h>=0A=
+=0A=
+/**=0A=
+ * The touchscreen interface operates as follows:=0A=
+ *=0A=
+ * Initialize:=0A=
+ *    Request access to GPIO (DAV)=0A=
+ *    tsc2101_dav_irq_handler will trigger when DAV line goes down=0A=
+ *=0A=
+ *  1) Pen is pressed against touchscreeen=0A=
+ *  2) TSC2101 performs AD conversion=0A=
+ *  3) After the conversion is done TSC2101 drives DAV line down=0A=
+ *  4) GPIO IRQ is received and tsc2101_dav_irq_handler is called=0A=
+ *  5) tsc2101_dav_irq_handler sets up tsc2101_ts_timer in =
TSC2101_TS_SCAN_TIME=0A=
+ *  6) tsc2101_ts_timer disables the irq and requests spi driver=0A=
+ *     to read X, Y, Z1 and Z2=0A=
+ *  7) SPI framework calls tsc2101_ts_rx after the coordinates are read=0A=
+ *  8) tsc2101_ts_rx reports coordinates to input layer and=0A=
+ *     sets up tsc2101_ts_timer to be called after TSC2101_TS_SCAN_TIME=0A=
+ *  9) if tsc2101_tx_timer notices that the pen has been lifted, the =
lift event=0A=
+ *     is sent, and irq is again enabled.=0A=
+ */=0A=
+=0A=
+=0A=
+#define TSC2101_TOUCHSCREEN_PRODUCT_ID      		0x0052=0A=
+#define TSC2101_TOUCHSCREEN_PRODUCT_VERSION 		0x0001=0A=
+=0A=
+#define TSC2101_TS_SCAN_TIME		     		1=0A=
+=0A=
+#define TSC2101_ADCREG_CONVERSION_CTRL_BY_TSC2101	0x8000=0A=
+#define TSC2101_ADCREG_CONVERSION_CTRL_BY_HOST		0x0000=0A=
+=0A=
+#define TSC2101_ADCREG_FUNCTION_NONE			0x0000=0A=
+#define TSC2101_ADCREG_FUNCTION_XY			0x0400=0A=
+#define TSC2101_ADCREG_FUNCTION_XYZ			0x0800=0A=
+#define TSC2101_ADCREG_FUNCTION_X			0x0C00=0A=
+#define TSC2101_ADCREG_FUNCTION_Y			0x1000=0A=
+#define TSC2101_ADCREG_FUNCTION_Z			0x1400=0A=
+#define TSC2101_ADCREG_FUNCTION_DAT1			0x1800=0A=
+#define TSC2101_ADCREG_FUNCTION_DAT2			0x1C00=0A=
+#define TSC2101_ADCREG_FUNCTION_AUX1			0x2000=0A=
+#define TSC2101_ADCREG_FUNCTION_AUX2			0x2400=0A=
+#define TSC2101_ADCREG_FUNCTION_TEMP			0x2800=0A=
+=0A=
+#define TSC2101_ADCREG_RESOLUTION_8BIT			0x0100=0A=
+#define TSC2101_ADCREG_RESOLUTION_10BIT			0x0200=0A=
+#define TSC2101_ADCREG_RESOLUTION_12BIT			0x0300=0A=
+=0A=
+#define TSC2101_ADCREG_AVERAGING_NONE			0x0000=0A=
+#define TSC2101_ADCREG_AVERAGING_4AVG			0x0040=0A=
+#define TSC2101_ADCREG_AVERAGING_8AVG			0x0080=0A=
+#define TSC2101_ADCREG_AVERAGING_16AVG			0x00C0=0A=
+=0A=
+#define TSC2101_ADCREG_CLOCK_8MHZ			0x0000=0A=
+#define TSC2101_ADCREG_CLOCK_4MHZ			0x0010=0A=
+#define TSC2101_ADCREG_CLOCK_2MHZ			0x0020=0A=
+#define TSC2101_ADCREG_CLOCK_1MHZ			0x0030=0A=
+=0A=
+#define TSC2101_ADCREG_VOLTAGE_STAB_0US			0x0000=0A=
+#define TSC2101_ADCREG_VOLTAGE_STAB_100US		0x0002=0A=
+#define TSC2101_ADCREG_VOLTAGE_STAB_500US		0x0004=0A=
+#define TSC2101_ADCREG_VOLTAGE_STAB_1MS			0x0006=0A=
+#define TSC2101_ADCREG_VOLTAGE_STAB_5MS			0x0008=0A=
+#define TSC2101_ADCREG_VOLTAGE_STAB_10MS		0x000A=0A=
+#define TSC2101_ADCREG_VOLTAGE_STAB_50MS		0x000C=0A=
+#define TSC2101_ADCREG_VOLTAGE_STAB_100MS		0x000E=0A=
+=0A=
+#define TSC2101_ADCREG_STOP_CONVERSION			0x4000=0A=
+=0A=
+#define TSC2101_STATUSREG_DAV				0x4000=0A=
+#define TSC2101_PROGREG_DELAY				0x0900=0A=
+=0A=
+#define MAX_12BIT					((1 << 12) - 1)=0A=
+=0A=
+struct tsc2101_ts {=0A=
+	struct input_dev	*idev;=0A=
+	char			phys[32];=0A=
+	struct timer_list	timer;=0A=
+	spinlock_t		lock;=0A=
+=0A=
+	struct spi_transfer	read_xfer[2];=0A=
+	struct spi_message	read_msg;=0A=
+	u32                     data[4];=0A=
+=0A=
+	int			hw_avg_max;=0A=
+	u16			x;=0A=
+	u16			y;=0A=
+	u16			p;=0A=
+	int			sample_cnt;=0A=
+=0A=
+	int			ignore_last : 1;=0A=
+	u16			x_plate_ohm;=0A=
+	int			stab_time;=0A=
+	int			max_pressure;=0A=
+	int			touch_pressure;=0A=
+	int			pressure_limit;=0A=
+=0A=
+	u16			irq_enabled:1;=0A=
+	u16			pen_down:1;=0A=
+	u16			disabled:1;=0A=
+	u16			pending:1;=0A=
+=0A=
+	int			hw_flags;=0A=
+=0A=
+	s16			dav_gpio;=0A=
+	int			irq;=0A=
+};=0A=
+=0A=
+static int tsc2101_ts_check_config(struct tsc2101_ts *ts, int *hw_flags)=0A=
+{=0A=
+	int flags;=0A=
+=0A=
+	flags =3D 0;=0A=
+	switch (ts->hw_avg_max) {=0A=
+	case 0:=0A=
+		flags |=3D TSC2101_ADCREG_AVERAGING_NONE;=0A=
+		break;=0A=
+	case 4:=0A=
+		flags |=3D TSC2101_ADCREG_AVERAGING_4AVG;=0A=
+		break;=0A=
+	case 8:=0A=
+		flags |=3D TSC2101_ADCREG_AVERAGING_8AVG;=0A=
+		break;=0A=
+	case 16:=0A=
+		flags |=3D TSC2101_ADCREG_AVERAGING_16AVG;=0A=
+		break;=0A=
+	default:=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	switch (ts->stab_time) {=0A=
+	case 0:=0A=
+		flags |=3D TSC2101_ADCREG_VOLTAGE_STAB_0US;=0A=
+		break;=0A=
+	case 100:=0A=
+		flags |=3D TSC2101_ADCREG_VOLTAGE_STAB_100US;=0A=
+		break;=0A=
+	case 500:=0A=
+		flags |=3D TSC2101_ADCREG_VOLTAGE_STAB_500US;=0A=
+		break;=0A=
+	case 1000:=0A=
+		flags |=3D TSC2101_ADCREG_VOLTAGE_STAB_1MS;=0A=
+		break;=0A=
+	case 5000:=0A=
+		flags |=3D TSC2101_ADCREG_VOLTAGE_STAB_5MS;=0A=
+		break;=0A=
+	case 10000:=0A=
+		flags |=3D TSC2101_ADCREG_VOLTAGE_STAB_10MS;=0A=
+		break;=0A=
+	case 50000:=0A=
+		flags |=3D TSC2101_ADCREG_VOLTAGE_STAB_50MS;=0A=
+		break;=0A=
+	case 100000:=0A=
+		flags |=3D TSC2101_ADCREG_VOLTAGE_STAB_100MS;=0A=
+		break;=0A=
+	default:=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	*hw_flags =3D flags;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* XXX: tsc2101 specific */=0A=
+static int tsc2101_ts_configure(struct tsc2101 *tsc, int flags)=0A=
+{=0A=
+	struct spi_transfer xfer[6];=0A=
+	struct spi_transfer *x;=0A=
+	struct spi_message m;=0A=
+	int reg;=0A=
+	u32 val, adc_val;=0A=
+	u32 data[6];=0A=
+=0A=
+	/*=0A=
+	 * TSC2101-controlled conversions=0A=
+	 * 12-bit samples=0A=
+	 * continuous X,Y,Z1,Z2 scan mode=0A=
+	 * average (mean) 16 samples per coordinate=0A=
+	 * 1 MHz internal conversion clock=0A=
+	 * 500 usec panel voltage stabilization delay=0A=
+	 * =3D> 0x8bf4=0A=
+	 */=0A=
+	/* Averaging and voltage stabilization settings in flags */=0A=
+	adc_val =3D TSC2101_ADCREG_CONVERSION_CTRL_BY_TSC2101 |=0A=
+		TSC2101_ADCREG_FUNCTION_XYZ |=0A=
+		TSC2101_ADCREG_RESOLUTION_12BIT |=0A=
+		TSC2101_ADCREG_CLOCK_1MHZ |=0A=
+		flags;=0A=
+	printk("adc val =3D 0x%08x\n", adc_val);=0A=
+=0A=
+	/* Now we prepare the command for transferring */=0A=
+	/* Use internal reference clock */=0A=
+	reg =3D TSC2101_REG_REF;=0A=
+	val =3D 0x0016;=0A=
+	data[0] =3D (reg << 16) | val;=0A=
+=0A=
+	reg =3D TSC2101_REG_CONFIG;=0A=
+	val =3D 0x0008;=0A=
+	data[1] =3D (reg << 16) | val;=0A=
+=0A=
+	reg =3D TSC2101_REG_BUFFER;=0A=
+	val =3D 0x0;=0A=
+	data[2] =3D (reg << 16) | val;=0A=
+=0A=
+	reg =3D TSC2101_REG_PROG_DELAY;=0A=
+	val =3D 0x0900;=0A=
+	data[3] =3D (reg << 16) | val;=0A=
+=0A=
+	reg =3D TSC2101_REG_STATUS;=0A=
+	val =3D TSC2101_STATUSREG_DAV;=0A=
+	data[4] =3D (reg << 16) | val;=0A=
+=0A=
+	reg =3D TSC2101_REG_ADC;=0A=
+	data[5] =3D (reg << 16) | adc_val;=0A=
+=0A=
+	spi_message_init(&m);=0A=
+	m.spi =3D tsc->spi;=0A=
+=0A=
+	memset(xfer, 0, sizeof(xfer));=0A=
+	x =3D &xfer[0];=0A=
+=0A=
+	x->tx_buf =3D &data[0];=0A=
+	x->len =3D 4;=0A=
+	x->cs_change =3D 1;=0A=
+	spi_message_add_tail(x, &m);=0A=
+=0A=
+	x++;=0A=
+	x->tx_buf =3D &data[1];=0A=
+	x->len =3D 4;=0A=
+	x->cs_change =3D 1;=0A=
+	spi_message_add_tail(x, &m);=0A=
+=0A=
+	x++;=0A=
+	x->tx_buf =3D &data[2];=0A=
+	x->len =3D 4;=0A=
+	spi_message_add_tail(x, &m);=0A=
+=0A=
+	x++;=0A=
+	x->tx_buf =3D &data[3];=0A=
+	x->len =3D 4;=0A=
+	spi_message_add_tail(x, &m);=0A=
+=0A=
+	x++;=0A=
+	x->tx_buf =3D &data[4];=0A=
+	x->len =3D 4;=0A=
+	spi_message_add_tail(x, &m);=0A=
+=0A=
+	x++;=0A=
+	x->tx_buf =3D &data[5];=0A=
+	x->len =3D 4;=0A=
+	spi_message_add_tail(x, &m);=0A=
+=0A=
+	spi_sync(m.spi, &m);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static void tsc2101_ts_start_scan(struct tsc2101 *tsc)=0A=
+{=0A=
+	tsc2101_ts_configure(tsc, tsc->ts->hw_flags);=0A=
+}=0A=
+=0A=
+static void tsc2101_ts_stop_scan(struct tsc2101 *tsc)=0A=
+{=0A=
+	tsc2101_ts_configure(tsc, TSC2101_ADCREG_STOP_CONVERSION);=0A=
+}=0A=
+=0A=
+static int device_suspended(struct device *dev)=0A=
+{=0A=
+	struct tsc2101 *tsc =3D dev_get_drvdata(dev);=0A=
+	return dev->power.power_state.event !=3D PM_EVENT_ON || =
tsc->ts->disabled;=0A=
+}=0A=
+=0A=
+static void update_pen_state(struct tsc2101_ts *ts, int x, int y, int =
pressure)=0A=
+{=0A=
+	int sync =3D 0;=0A=
+=0A=
+	if (pressure) {=0A=
+		input_report_abs(ts->idev, ABS_X, x);=0A=
+		input_report_abs(ts->idev, ABS_Y, y);=0A=
+		input_report_abs(ts->idev, ABS_PRESSURE, pressure);=0A=
+		if (!ts->pen_down)=0A=
+			input_report_key(ts->idev, BTN_TOUCH, 1);=0A=
+		sync =3D 1;=0A=
+	} else if (ts->pen_down) {=0A=
+		input_report_abs(ts->idev, ABS_PRESSURE, 0);=0A=
+		input_report_key(ts->idev, BTN_TOUCH, 0);=0A=
+		sync =3D 1;=0A=
+	}=0A=
+=0A=
+	if (sync)=0A=
+		input_sync(ts->idev);=0A=
+=0A=
+	ts->pen_down =3D pressure ? 1 : 0;=0A=
+#ifdef VERBOSE=0A=
+	dev_dbg(&tsc->spi->dev, "x %4d y %4d p %4d\n", x, y, pressure);=0A=
+#endif=0A=
+}=0A=
+=0A=
+/* XXX: TSC2101 specific */=0A=
+/*=0A=
+ * This procedure is called by the SPI framework after the coordinates=0A=
+ * have been read from TSC2101=0A=
+ */=0A=
+static void tsc2101_ts_rx(void *arg)=0A=
+{=0A=
+	struct tsc2101 *tsc =3D arg;=0A=
+	struct tsc2101_ts *ts =3D tsc->ts;=0A=
+	unsigned int x, y, z1, z2, pressure;=0A=
+=0A=
+	x  =3D ts->data[0] & 0xffff;=0A=
+	y  =3D ts->data[1] & 0xffff;=0A=
+	z1 =3D ts->data[2] & 0xffff;=0A=
+	z2 =3D ts->data[3] & 0xffff;=0A=
+=0A=
+	if (z1) {=0A=
+		pressure =3D ts->x_plate_ohm * x;=0A=
+		pressure /=3D 4096;=0A=
+		pressure *=3D z2 - z1;=0A=
+		pressure /=3D z1;=0A=
+	} else=0A=
+		pressure =3D 0;=0A=
+=0A=
+	/* If pressure value is above a preset limit (pen is barely=0A=
+	 * touching the screen) we can't trust the coordinate values.=0A=
+	 */=0A=
+	if (pressure < ts->pressure_limit && x < MAX_12BIT && y < MAX_12BIT) {=0A=
+		ts->pressure_limit =3D ts->max_pressure;=0A=
+		if (ts->ignore_last) {=0A=
+			if (ts->sample_cnt)=0A=
+				update_pen_state(ts, ts->x, ts->y, ts->p);=0A=
+			ts->x =3D x;=0A=
+			ts->y =3D y;=0A=
+			ts->p =3D pressure;=0A=
+		} else=0A=
+			update_pen_state(ts, x, y, pressure);=0A=
+		ts->sample_cnt++;=0A=
+	}=0A=
+=0A=
+	mod_timer(&ts->timer,=0A=
+		  jiffies + msecs_to_jiffies(TSC2101_TS_SCAN_TIME));=0A=
+}=0A=
+=0A=
+static int is_pen_down(struct tsc2101_ts *ts)=0A=
+{=0A=
+	return ts->pen_down;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Timer is called every TSC2101_TS_SCAN_TIME when the pen is down=0A=
+ */=0A=
+static void tsc2101_ts_timer(unsigned long arg)=0A=
+{=0A=
+	struct tsc2101 *tsc =3D (void *) arg;=0A=
+	struct tsc2101_ts *ts =3D tsc->ts;=0A=
+	unsigned long flags;=0A=
+	int ndav;=0A=
+	int r;=0A=
+=0A=
+	spin_lock_irqsave(&ts->lock, flags);=0A=
+	ndav =3D omap_get_gpio_datain(ts->dav_gpio);=0A=
+	if (ndav || device_suspended(&tsc->spi->dev)) {=0A=
+		/* Pen has been lifted */=0A=
+		if (!device_suspended(&tsc->spi->dev)) {=0A=
+			ts->irq_enabled =3D 1;=0A=
+			enable_irq(ts->irq);=0A=
+		}=0A=
+		update_pen_state(ts, 0, 0, 0);=0A=
+		ts->pending =3D 0;=0A=
+		spin_unlock_irqrestore(&ts->lock, flags);=0A=
+=0A=
+	} else {=0A=
+		ts->pen_down =3D 1;=0A=
+		spin_unlock_irqrestore(&ts->lock, flags);=0A=
+=0A=
+		r =3D spi_async(tsc->spi, &ts->read_msg);=0A=
+		if (r)=0A=
+			dev_err(&tsc->spi->dev, "ts: spi_async() failed");=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * This interrupt is called when pen is down and first coordinates are=0A=
+ * available. That is indicated by a falling edge on DEV line.  IRQ is=0A=
+ * disabled here because while the pen is down the coordinates are=0A=
+ * read by a timer.=0A=
+ */=0A=
+static irqreturn_t tsc2101_ts_irq_handler(int irq, void *dev_id)=0A=
+{=0A=
+	struct tsc2101 *tsc =3D dev_id;=0A=
+	struct tsc2101_ts *ts =3D tsc->ts;=0A=
+	unsigned long flags;=0A=
+=0A=
+	spin_lock_irqsave(&ts->lock, flags);=0A=
+	if (ts->irq_enabled) {=0A=
+		ts->irq_enabled =3D 0;=0A=
+		disable_irq(ts->irq);=0A=
+		ts->pending =3D 1;=0A=
+		ts->pressure_limit =3D ts->touch_pressure;=0A=
+		ts->sample_cnt =3D 0;=0A=
+		mod_timer(&ts->timer,=0A=
+			  jiffies + msecs_to_jiffies(TSC2101_TS_SCAN_TIME));=0A=
+	}=0A=
+	spin_unlock_irqrestore(&ts->lock, flags);=0A=
+=0A=
+	return IRQ_HANDLED;=0A=
+}=0A=
+=0A=
+/* Must be called with ts->lock held */=0A=
+static void tsc2101_ts_disable(struct tsc2101 *tsc)=0A=
+{=0A=
+	struct tsc2101_ts *ts =3D tsc->ts;=0A=
+=0A=
+	if (ts->disabled)=0A=
+		return;=0A=
+=0A=
+	ts->disabled =3D 1;=0A=
+	if (!ts->pending) {=0A=
+		ts->irq_enabled =3D 0;=0A=
+		disable_irq(ts->irq);=0A=
+	} else {=0A=
+		while (ts->pending) {=0A=
+			spin_unlock_irq(&ts->lock);=0A=
+			msleep(1);=0A=
+			spin_lock_irq(&ts->lock);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	spin_unlock_irq(&ts->lock);=0A=
+	tsc2101_ts_stop_scan(tsc);=0A=
+	spin_lock_irq(&ts->lock);=0A=
+}=0A=
+=0A=
+static void tsc2101_ts_enable(struct tsc2101 *tsc)=0A=
+{=0A=
+	struct tsc2101_ts *ts =3D tsc->ts;=0A=
+=0A=
+	if (!ts->disabled)=0A=
+		return;=0A=
+=0A=
+	ts->disabled =3D 0;=0A=
+	ts->irq_enabled =3D 1;=0A=
+	enable_irq(ts->irq);=0A=
+=0A=
+	spin_unlock_irq(&ts->lock);=0A=
+	tsc2101_ts_start_scan(tsc);=0A=
+	spin_lock_irq(&ts->lock);=0A=
+}=0A=
+=0A=
+#ifdef CONFIG_PM=0A=
+int tsc2101_ts_suspend(struct tsc2101 *tsc)=0A=
+{=0A=
+	struct tsc2101_ts *ts =3D tsc->ts;=0A=
+=0A=
+	spin_lock_irq(&ts->lock);=0A=
+	tsc2101_ts_disable(tsc);=0A=
+	spin_unlock_irq(&ts->lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+void tsc2101_ts_resume(struct tsc2101 *tsc)=0A=
+{=0A=
+	struct tsc2101_ts *ts =3D tsc->ts;=0A=
+=0A=
+	spin_lock_irq(&ts->lock);=0A=
+	tsc2101_ts_enable(tsc);=0A=
+	spin_unlock_irq(&ts->lock);=0A=
+}=0A=
+#endif=0A=
+=0A=
+void tsc2101_ts_prep_for_clk_stop(struct tsc2101 *tsc)=0A=
+{=0A=
+}=0A=
+=0A=
+void tsc2101_ts_cont_after_clk_stop(struct tsc2101 *tsc)=0A=
+{=0A=
+}=0A=
+=0A=
+/* XXX: tsc2101 specific */=0A=
+static u32 tsc2101_ts_read_data[] =3D {=0A=
+	(0x8000 | TSC2101_REG_X) << 16,=0A=
+	(0x8000 | TSC2101_REG_Y) << 16,=0A=
+	(0x8000 | TSC2101_REG_Z1) << 16,=0A=
+	(0x8000 | TSC2101_REG_Z2) << 16,=0A=
+};=0A=
+=0A=
+static void tsc2101_ts_setup_spi_xfer(struct tsc2101 *tsc)=0A=
+{=0A=
+	struct tsc2101_ts *ts =3D tsc->ts;=0A=
+	struct spi_message *m =3D &ts->read_msg;=0A=
+	struct spi_transfer *x =3D &ts->read_xfer[0];=0A=
+=0A=
+	spi_message_init(m);=0A=
+=0A=
+	x->tx_buf =3D &tsc2101_ts_read_data;=0A=
+	x->rx_buf =3D &ts->data;=0A=
+	x->len =3D 16;=0A=
+	spi_message_add_tail(x, m);=0A=
+=0A=
+	m->complete =3D tsc2101_ts_rx;=0A=
+	m->context =3D tsc;=0A=
+}=0A=
+=0A=
+static ssize_t tsc2101_ts_pen_down_show(struct device *dev,=0A=
+					struct device_attribute *attr,=0A=
+					char *buf)=0A=
+{=0A=
+	struct tsc2101 *tsc =3D dev_get_drvdata(dev);=0A=
+=0A=
+	return sprintf(buf, "%u\n", is_pen_down(tsc->ts));=0A=
+}=0A=
+=0A=
+static DEVICE_ATTR(pen_down, S_IRUGO, tsc2101_ts_pen_down_show, NULL);=0A=
+=0A=
+static ssize_t tsc2101_ts_disable_show(struct device *dev,=0A=
+				       struct device_attribute *attr, char *buf)=0A=
+{=0A=
+	struct tsc2101		*tsc =3D dev_get_drvdata(dev);=0A=
+	struct tsc2101_ts	*ts =3D tsc->ts;=0A=
+=0A=
+	return sprintf(buf, "%u\n", ts->disabled);=0A=
+}=0A=
+=0A=
+static ssize_t tsc2101_ts_disable_store(struct device *dev,=0A=
+					struct device_attribute *attr,=0A=
+					const char *buf, size_t count)=0A=
+{=0A=
+	struct tsc2101		*tsc =3D dev_get_drvdata(dev);=0A=
+	struct tsc2101_ts	*ts =3D tsc->ts;=0A=
+	char *endp;=0A=
+	int i;=0A=
+=0A=
+	i =3D simple_strtoul(buf, &endp, 10);=0A=
+	spin_lock_irq(&ts->lock);=0A=
+=0A=
+	if (i)=0A=
+		tsc2101_ts_disable(tsc);=0A=
+	else=0A=
+		tsc2101_ts_enable(tsc);=0A=
+=0A=
+	spin_unlock_irq(&ts->lock);=0A=
+=0A=
+	return count;=0A=
+}=0A=
+=0A=
+static DEVICE_ATTR(disable_ts, 0664, tsc2101_ts_disable_show,=0A=
+		   tsc2101_ts_disable_store);=0A=
+=0A=
+int __devinit tsc2101_ts_init(struct tsc2101 *tsc,=0A=
+			      struct tsc2101_platform_data *pdata)=0A=
+{=0A=
+	struct tsc2101_ts *ts;=0A=
+	struct input_dev *idev;=0A=
+	int dav_gpio, r;=0A=
+=0A=
+	if (pdata->dav_gpio < 0) {=0A=
+		dev_err(&tsc->spi->dev, "need DAV GPIO");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+	dav_gpio =3D pdata->dav_gpio;=0A=
+=0A=
+	ts =3D kzalloc(sizeof(*ts), GFP_KERNEL);=0A=
+	if (ts =3D=3D NULL)=0A=
+		return -ENOMEM;=0A=
+	tsc->ts =3D ts;=0A=
+=0A=
+	ts->dav_gpio =3D dav_gpio;=0A=
+#ifdef CONFIG_ARCH_OMAP=0A=
+	r =3D omap_request_gpio(dav_gpio);=0A=
+	if (r < 0) {=0A=
+		dev_err(&tsc->spi->dev, "unable to get DAV GPIO");=0A=
+		goto err1;=0A=
+	}=0A=
+	omap_set_gpio_direction(dav_gpio, 1);=0A=
+	ts->irq =3D OMAP_GPIO_IRQ(dav_gpio);=0A=
+#endif=0A=
+	init_timer(&ts->timer);=0A=
+	ts->timer.data =3D (unsigned long) tsc;=0A=
+	ts->timer.function =3D tsc2101_ts_timer;=0A=
+=0A=
+	spin_lock_init(&ts->lock);=0A=
+=0A=
+	ts->x_plate_ohm	=3D pdata->ts_x_plate_ohm ? : 280;=0A=
+	ts->hw_avg_max	=3D pdata->ts_hw_avg;=0A=
+	ts->max_pressure=3D pdata->ts_max_pressure ? : MAX_12BIT;=0A=
+	ts->touch_pressure =3D pdata->ts_touch_pressure ? : ts->max_pressure;=0A=
+	ts->ignore_last	=3D pdata->ts_ignore_last;=0A=
+	ts->stab_time	=3D pdata->ts_stab_time;=0A=
+=0A=
+	if ((r =3D tsc2101_ts_check_config(ts, &ts->hw_flags))) {=0A=
+		dev_err(&tsc->spi->dev, "invalid configuration\n");=0A=
+		goto err2;=0A=
+	}=0A=
+=0A=
+	idev =3D input_allocate_device();=0A=
+	if (idev =3D=3D NULL) {=0A=
+		r =3D -ENOMEM;=0A=
+		goto err2;=0A=
+	}=0A=
+	idev->cdev.dev =3D &tsc->spi->dev;=0A=
+	idev->name =3D "TSC2101 touchscreen";=0A=
+	snprintf(ts->phys, sizeof(ts->phys),=0A=
+		 "%s/input-ts", tsc->spi->dev.bus_id);=0A=
+	idev->phys =3D ts->phys;=0A=
+=0A=
+	idev->evbit[0] =3D BIT(EV_ABS) | BIT(EV_KEY);=0A=
+	idev->absbit[0] =3D BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);=0A=
+	ts->idev =3D idev;=0A=
+=0A=
+	tsc2101_ts_setup_spi_xfer(tsc);=0A=
+=0A=
+	/* These parameters should perhaps be configurable? */=0A=
+	input_set_abs_params(idev, ABS_X, 0, 4096, 0, 0);=0A=
+	input_set_abs_params(idev, ABS_Y, 0, 4096, 0, 0);=0A=
+	input_set_abs_params(idev, ABS_PRESSURE, 0, 1024, 0, 0);=0A=
+=0A=
+	tsc2101_ts_start_scan(tsc);=0A=
+=0A=
+	ts->irq_enabled =3D 1;=0A=
+	r =3D request_irq(ts->irq, tsc2101_ts_irq_handler,=0A=
+			SA_SAMPLE_RANDOM | SA_TRIGGER_FALLING,=0A=
+			"tsc2101-ts", tsc);=0A=
+	if (r < 0) {=0A=
+		dev_err(&tsc->spi->dev, "unable to get DAV IRQ");=0A=
+		goto err3;=0A=
+	}=0A=
+	set_irq_wake(ts->irq, 1);=0A=
+=0A=
+	r =3D device_create_file(&tsc->spi->dev, &dev_attr_pen_down);=0A=
+	r =3D device_create_file(&tsc->spi->dev, &dev_attr_disable_ts);=0A=
+=0A=
+	r =3D input_register_device(idev);=0A=
+	if (r < 0) {=0A=
+		dev_err(&tsc->spi->dev, "can't register touchscreen device\n");=0A=
+		goto err4;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+err4:=0A=
+	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);=0A=
+	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);=0A=
+	free_irq(ts->irq, tsc);=0A=
+err3:=0A=
+	tsc2101_ts_stop_scan(tsc);=0A=
+	input_free_device(idev);=0A=
+err2:=0A=
+#ifdef CONFIG_ARCH_OMAP=0A=
+	omap_free_gpio(dav_gpio);=0A=
+#endif=0A=
+err1:=0A=
+	kfree(ts);=0A=
+	return r;=0A=
+}=0A=
+=0A=
+void __devexit tsc2101_ts_exit(struct tsc2101 *tsc)=0A=
+{=0A=
+	struct tsc2101_ts *ts =3D tsc->ts;=0A=
+	unsigned long flags;=0A=
+=0A=
+	spin_lock_irqsave(&ts->lock, flags);=0A=
+	tsc2101_ts_disable(tsc);=0A=
+	spin_unlock_irqrestore(&ts->lock, flags);=0A=
+=0A=
+	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);=0A=
+	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);=0A=
+=0A=
+	free_irq(ts->irq, tsc);=0A=
+	input_unregister_device(ts->idev);=0A=
+=0A=
+#ifdef CONFIG_ARCH_OMAP=0A=
+	omap_free_gpio(ts->dav_gpio);=0A=
+#endif=0A=
+	kfree(ts);=0A=
+}=0A=
+=0A=
+MODULE_AUTHOR("Jarkko Oikarinen, Kyungmin Park");=0A=
+MODULE_DESCRIPTION("Touchscreen driver for TSC2101");=0A=
+MODULE_LICENSE("GPL");=0A=
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig=0A=
index c98392c..64f59e0 100644=0A=
--- a/drivers/spi/Kconfig=0A=
+++ b/drivers/spi/Kconfig=0A=
@@ -149,6 +149,21 @@ config SPI_OMAP24XX=0A=
 comment "SPI Protocol Masters"=0A=
 	depends on SPI_MASTER=0A=
 =0A=
+config SPI_TSC2101=0A=
+	tristate "TSC2101 driver"=0A=
+	depends on SPI_MASTER=0A=
+	help=0A=
+	  Say Y here if you have a TSC2101 chip connected to a SPI=0A=
+	  bus on your board.=0A=
+=0A=
+	  The TSC2101 is a highly integrated PDA analog interface circuit.=0A=
+	  It contains a complete 12-bit A/D resistive touch screen=0A=
+	  converter (ADC) including drivers, touch pressure measurement=0A=
+	  capability.=0A=
+=0A=
+	  To compile this driver as a module, choose M here: the=0A=
+	  module will be called tsc2101.=0A=
+=0A=
 config TSC2102=0A=
 	depends on SPI_MASTER=0A=
 	tristate "TSC2102 codec support"=0A=
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile=0A=
index bfa8ea3..810ff0f 100644=0A=
--- a/drivers/spi/Makefile=0A=
+++ b/drivers/spi/Makefile=0A=
@@ -24,6 +24,7 @@ obj-$(CONFIG_SPI_OMAP_UWIRE)		+=3D omap_uwire.o=0A=
 # 	... add above this line ...=0A=
 =0A=
 # SPI protocol drivers (device/link on bus)=0A=
+obj-$(CONFIG_SPI_TSC2101)		+=3D tsc2101.o=0A=
 obj-$(CONFIG_TSC2102)			+=3D tsc2102.o=0A=
 obj-$(CONFIG_SPI_AT25)		+=3D at25.o=0A=
 obj-$(CONFIG_SPI_TSC2301)		+=3D tsc2301.o=0A=
diff --git a/drivers/spi/tsc2101.c b/drivers/spi/tsc2101.c=0A=
new file mode 100644=0A=
index 0000000..6c8b1a4=0A=
--- /dev/null=0A=
+++ b/drivers/spi/tsc2101.c=0A=
@@ -0,0 +1,280 @@=0A=
+/*=0A=
+ * TSC2101 driver=0A=
+ *=0A=
+ * Copyright (C) 2005, 2006 Nokia Corporation=0A=
+ *=0A=
+ * Copyright (C) 2007 Samsung Electronics=0A=
+ * Kyungmin Park <kyungmin.park@samsung.com>=0A=
+ *=0A=
+ * Derived from TSC2301 written by Juha Yrjola=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or modify=0A=
+ * it under the terms of the GNU General Public License as published by=0A=
+ * the Free Software Foundation; either version 2 of the License, or=0A=
+ * (at your option) any later version.=0A=
+ *=0A=
+ * This program is distributed in the hope that it will be useful,=0A=
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the=0A=
+ * GNU General Public License for more details.=0A=
+ *=0A=
+ * You should have received a copy of the GNU General Public License=0A=
+ * along with this program; if not, write to the Free Software=0A=
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 =
USA=0A=
+ */=0A=
+=0A=
+#include <linux/module.h>=0A=
+#include <linux/device.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/spi/spi.h>=0A=
+#include <linux/spi/tsc2101.h>=0A=
+=0A=
+#ifdef CONFIG_ARCH_OMAP=0A=
+#include <asm/arch/gpio.h>=0A=
+#endif=0A=
+=0A=
+u16 tsc2101_read_reg(struct tsc2101 *tsc, int reg)=0A=
+{=0A=
+	struct spi_transfer t[2];=0A=
+	struct spi_message m;=0A=
+	u32 data =3D 0, cmd;=0A=
+=0A=
+	memset(&t, 0, sizeof(t));=0A=
+	spi_message_init(&m);=0A=
+	m.spi =3D tsc->spi;=0A=
+=0A=
+	if (tsc->spi->bits_per_word =3D=3D 32) {=0A=
+		cmd =3D 0x8000 | reg;=0A=
+		cmd <<=3D 16;=0A=
+		=0A=
+		t[0].tx_buf =3D &cmd;=0A=
+		t[0].rx_buf =3D &data;=0A=
+		t[0].len =3D 4;=0A=
+		spi_message_add_tail(&t[0], &m);=0A=
+	} else {=0A=
+		/* Address */=0A=
+		cmd =3D 0x8000 | reg;=0A=
+		t[0].tx_buf =3D &cmd;=0A=
+		t[0].rx_buf =3D NULL;=0A=
+		t[0].len =3D 2;=0A=
+		spi_message_add_tail(&t[0], &m);=0A=
+=0A=
+		/* Data */=0A=
+		t[1].tx_buf =3D NULL;=0A=
+		t[1].rx_buf =3D &data;=0A=
+		t[1].len =3D 2;=0A=
+		spi_message_add_tail(&t[1], &m);=0A=
+	}=0A=
+=0A=
+	spi_sync(m.spi, &m);=0A=
+=0A=
+	return (data & 0xffff);=0A=
+}=0A=
+=0A=
+void tsc2101_write_reg(struct tsc2101 *tsc, int reg, u16 val)=0A=
+{=0A=
+	struct spi_transfer t;=0A=
+	struct spi_message m;=0A=
+	u32 data;=0A=
+=0A=
+	spi_message_init(&m);=0A=
+	m.spi =3D tsc->spi;=0A=
+=0A=
+	/* Now we prepare the command for transferring */=0A=
+	if (tsc->spi->bits_per_word =3D=3D 32)=0A=
+		data =3D (reg << 16) | val;=0A=
+	else=0A=
+		data =3D (val << 16) | reg;=0A=
+=0A=
+	memset(&t, 0, sizeof(t));=0A=
+	t.tx_buf =3D &data;=0A=
+	t.rx_buf =3D NULL;=0A=
+	t.len =3D 4;=0A=
+	spi_message_add_tail(&t, &m);=0A=
+=0A=
+	spi_sync(m.spi, &m);=0A=
+}=0A=
+=0A=
+void tsc2101_read_buf(struct tsc2101 *tsc, int reg, u16 *rx_buf, int =
len)=0A=
+{=0A=
+	/* Not yet implemented... */=0A=
+}=0A=
+=0A=
+void tsc2101_enable_mclk(struct device *dev)=0A=
+{=0A=
+	struct tsc2101 *tsc =3D dev_get_drvdata(dev);=0A=
+=0A=
+	if (tsc->enable_clock =3D=3D NULL)=0A=
+		return;=0A=
+=0A=
+	tsc->enable_clock(dev);=0A=
+}=0A=
+=0A=
+void tsc2101_disable_mclk(struct device *dev)=0A=
+{=0A=
+	struct tsc2101 *tsc =3D dev_get_drvdata(dev);=0A=
+=0A=
+	might_sleep();=0A=
+	if (tsc->disable_clock =3D=3D NULL)=0A=
+		return;=0A=
+=0A=
+	/* Submodules might need to take action before stopping the=0A=
+	 * clock. Keypad scanning needs to be stopped / restarted for one.=0A=
+	 */=0A=
+	if (tsc->ts !=3D NULL)=0A=
+		tsc2101_ts_prep_for_clk_stop(tsc);=0A=
+	if (tsc->mixer !=3D NULL)=0A=
+		tsc2101_mixer_prep_for_clk_stop(tsc);=0A=
+=0A=
+	tsc->disable_clock(dev);=0A=
+=0A=
+	if (tsc->mixer !=3D NULL)=0A=
+		tsc2101_mixer_cont_after_clk_stop(tsc);=0A=
+	if (tsc->ts !=3D NULL)=0A=
+		tsc2101_ts_cont_after_clk_stop(tsc);=0A=
+}=0A=
+=0A=
+static int __devinit tsc2101_probe(struct spi_device *spi)=0A=
+{=0A=
+	struct tsc2101			*tsc;=0A=
+	struct tsc2101_platform_data	*pdata =3D spi->dev.platform_data;=0A=
+	int r;=0A=
+=0A=
+	if (!pdata) {=0A=
+		dev_dbg(&spi->dev, "no platform data?\n");=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	printk("TSC2101 driver initializing\n");=0A=
+=0A=
+	tsc =3D kzalloc(sizeof(*tsc), GFP_KERNEL);=0A=
+	if (tsc =3D=3D NULL)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	dev_set_drvdata(&spi->dev, tsc);=0A=
+	tsc->spi =3D spi;=0A=
+	spi->dev.power.power_state =3D PMSG_ON;=0A=
+=0A=
+	tsc->enable_clock =3D pdata->enable_clock;=0A=
+	tsc->disable_clock =3D pdata->disable_clock;=0A=
+=0A=
+	if (pdata->reset_gpio >=3D 0) {=0A=
+		tsc->reset_gpio =3D pdata->reset_gpio;=0A=
+#ifdef CONFIG_ARCH_OMAP=0A=
+		r =3D omap_request_gpio(tsc->reset_gpio);=0A=
+		if (r < 0)=0A=
+			goto err1;=0A=
+		omap_set_gpio_dataout(tsc->reset_gpio, 1);=0A=
+		omap_set_gpio_direction(tsc->reset_gpio, 0);=0A=
+		mdelay(1);=0A=
+		omap_set_gpio_dataout(tsc->reset_gpio, 0);=0A=
+#endif=0A=
+	} else=0A=
+		tsc->reset_gpio =3D -1;=0A=
+=0A=
+	spi->mode =3D SPI_MODE_0;=0A=
+	if (pdata->bits_per_word)=0A=
+		spi->bits_per_word =3D pdata->bits_per_word;=0A=
+	else=0A=
+		spi->bits_per_word =3D 16;=0A=
+=0A=
+	/* The max speed might've been defined by the board-specific struct */=0A=
+	if (!spi->max_speed_hz)=0A=
+		spi->max_speed_hz =3D TSC2101_HZ;=0A=
+	spi_setup(spi);=0A=
+=0A=
+	if (pdata->init) {=0A=
+		r =3D pdata->init(spi);=0A=
+		if (r)=0A=
+			goto err1;=0A=
+	}=0A=
+=0A=
+	r =3D tsc2101_ts_init(tsc, pdata);=0A=
+	if (r)=0A=
+		goto err1;=0A=
+	r =3D tsc2101_mixer_init(tsc, pdata);=0A=
+	if (r)=0A=
+		goto err2;=0A=
+	return 0;=0A=
+=0A=
+err2:=0A=
+	tsc2101_ts_exit(tsc);=0A=
+err1:=0A=
+	kfree(tsc);=0A=
+	return r;=0A=
+}=0A=
+=0A=
+static int __devexit tsc2101_remove(struct spi_device *spi)=0A=
+{=0A=
+	struct tsc2101_platform_data *pdata;=0A=
+	struct tsc2101 *tsc =3D dev_get_drvdata(&spi->dev);=0A=
+=0A=
+	pdata =3D spi->dev.platform_data;=0A=
+=0A=
+	if (pdata->cleanup)=0A=
+		pdata->cleanup(spi);=0A=
+=0A=
+	tsc2101_mixer_exit(tsc);=0A=
+        tsc2101_ts_exit(tsc);=0A=
+	kfree(tsc);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+#ifdef CONFIG_PM=0A=
+static int tsc2101_suspend(struct spi_device *spi, pm_message_t mesg)=0A=
+{=0A=
+	struct tsc2101 *tsc =3D dev_get_drvdata(&spi->dev);=0A=
+	int r;=0A=
+=0A=
+	if ((r =3D tsc2101_mixer_suspend(tsc)) < 0)=0A=
+		return r;=0A=
+	if ((r =3D tsc2101_ts_suspend(tsc)) < 0)=0A=
+		goto err1;=0A=
+=0A=
+	return 0;=0A=
+err1:=0A=
+	tsc2101_mixer_resume(tsc);=0A=
+	return r;=0A=
+}=0A=
+=0A=
+static int tsc2101_resume(struct spi_device *spi)=0A=
+{=0A=
+	struct tsc2101 *tsc =3D dev_get_drvdata(&spi->dev);=0A=
+=0A=
+	tsc2101_ts_resume(tsc);=0A=
+	tsc2101_mixer_resume(tsc);=0A=
+	return 0;=0A=
+}=0A=
+#endif=0A=
+=0A=
+static struct spi_driver tsc2101_driver =3D {=0A=
+	.driver =3D {=0A=
+		   .name =3D "tsc2101",=0A=
+		   .bus =3D &spi_bus_type,=0A=
+		   .owner =3D THIS_MODULE,=0A=
+	},=0A=
+#ifdef CONFIG_PM=0A=
+	.suspend =3D tsc2101_suspend,=0A=
+	.resume =3D tsc2101_resume,=0A=
+#endif=0A=
+	.probe =3D tsc2101_probe,=0A=
+	.remove =3D __devexit_p(tsc2101_remove),=0A=
+};=0A=
+=0A=
+static int __init tsc2101_init(void)=0A=
+{=0A=
+	return spi_register_driver(&tsc2101_driver);=0A=
+}=0A=
+=0A=
+static void __exit tsc2101_exit(void)=0A=
+{=0A=
+	spi_unregister_driver(&tsc2101_driver);=0A=
+}=0A=
+=0A=
+module_init(tsc2101_init);=0A=
+module_exit(tsc2101_exit);=0A=
+=0A=
+MODULE_AUTHOR("Imre Deak, Kyungmin Park");=0A=
+MODULE_DESCRIPTION("SPI Interface driver for TI TSC2101 chips");=0A=
+MODULE_LICENSE("GPL");=0A=
diff --git a/include/linux/spi/tsc2101.h b/include/linux/spi/tsc2101.h=0A=
new file mode 100644=0A=
index 0000000..22b803f=0A=
--- /dev/null=0A=
+++ b/include/linux/spi/tsc2101.h=0A=
@@ -0,0 +1,203 @@=0A=
+#ifndef _LINUX_SPI_TSC2101_H=0A=
+#define _LINUX_SPI_TSC2101_H=0A=
+=0A=
+#include <linux/types.h>=0A=
+#include <linux/timer.h>=0A=
+=0A=
+struct tsc2101_platform_data {=0A=
+	unsigned	bits_per_word;=0A=
+	int		(*init)(struct spi_device *spi);=0A=
+	void		(*cleanup)(struct spi_device *spi);=0A=
+=0A=
+	/*=0A=
+	 * Keypad=0A=
+	 */=0A=
+	s16	reset_gpio;=0A=
+	s16	keyb_int;=0A=
+	s16	keymap[16];	/* Set a key to a negative value if not used */=0A=
+	unsigned kp_rep:1;	/* Enable keypad repeating */=0A=
+=0A=
+	/*=0A=
+	 * Touchscreen=0A=
+	 */=0A=
+	s16	dav_gpio;=0A=
+	s16	pen_int_gpio;=0A=
+	u16	ts_x_plate_ohm;=0A=
+	u32	ts_stab_time;	/* voltage settling time */=0A=
+	u8	ts_hw_avg;	/* HW assiseted averaging. Can be=0A=
+				   0, 4, 8, 16 samples per reading */=0A=
+	u32	ts_max_pressure;/* Samples with bigger pressure value will=0A=
+				   be ignored, since the corresponding X, Y=0A=
+				   values are unreliable */=0A=
+	u32	ts_touch_pressure;	/* Pressure limit until we report a=0A=
+					   touch event. After that we switch=0A=
+					   to ts_max_pressure. */=0A=
+	unsigned ts_ignore_last : 1;=0A=
+=0A=
+	/*=0A=
+	 * Audio=0A=
+	 */=0A=
+	unsigned	pll_pdc:4;=0A=
+	unsigned	pll_a:4;=0A=
+	unsigned	pll_n:4;=0A=
+	unsigned	pll_output:1; /* Output PLL on GPIO_0 */=0A=
+=0A=
+	unsigned	mclk_ratio:2;=0A=
+	unsigned	i2s_sample_rate:4;=0A=
+	unsigned	i2s_format:2;=0A=
+	/* Mask for audio blocks to be powered down */=0A=
+	u16		power_down_blocks;=0A=
+=0A=
+	/* Called after codec has been initialized, can be NULL */=0A=
+	int (* codec_init)(struct device *tsc2101_dev);=0A=
+	/* Called when codec is being removed, can be NULL */=0A=
+	void (* codec_cleanup)(struct device *tsc2101_dev);=0A=
+	int	(*enable_clock)(struct device *dev);=0A=
+	void	(*disable_clock)(struct device *dev);=0A=
+	int	(*get_keyb_irq_state)(struct device *dev);=0A=
+=0A=
+	const struct tsc2101_mixer_gpio {=0A=
+		const char	*name;=0A=
+		unsigned	gpio:4;=0A=
+		unsigned	inverted:1;=0A=
+		unsigned	def_enable:1; /* enable by default */=0A=
+		unsigned	deactivate_on_pd:1; /* power-down flag */=0A=
+	} *mixer_gpios;=0A=
+	int	n_mixer_gpios;=0A=
+};=0A=
+=0A=
+struct tsc2101_kp;=0A=
+struct tsc2101_ts;=0A=
+struct tsc2101_mixer;=0A=
+=0A=
+struct tsc2101 {=0A=
+	struct spi_device	*spi;=0A=
+=0A=
+	s16			reset_gpio;=0A=
+	u16			config2_shadow;=0A=
+=0A=
+        struct tsc2101_kp	*kp;=0A=
+	struct tsc2101_ts	*ts;=0A=
+	struct tsc2101_mixer	*mixer;=0A=
+=0A=
+	int			(*enable_clock)(struct device *dev);=0A=
+	void			(*disable_clock)(struct device *dev);=0A=
+};=0A=
+=0A=
+=0A=
+#define TSC2101_HZ	33000000=0A=
+=0A=
+#define TSC2101_REG(page, addr)  (((page) << 11) | ((addr) << 5))=0A=
+#define TSC2101_REG_TO_PAGE(reg) (((reg) >> 11) & 0x03)=0A=
+#define TSC2101_REG_TO_ADDR(reg) (((reg) >> 5)  & 0x1f)=0A=
+=0A=
+#define TSC2101_REG_X		TSC2101_REG(0, 0)=0A=
+#define TSC2101_REG_Y		TSC2101_REG(0, 1)=0A=
+#define TSC2101_REG_Z1		TSC2101_REG(0, 2)=0A=
+#define TSC2101_REG_Z2		TSC2101_REG(0, 3)=0A=
+=0A=
+#define TSC2101_REG_ADC		TSC2101_REG(1, 0)=0A=
+#define TSC2101_REG_STATUS	TSC2101_REG(1, 1)=0A=
+#define TSC2101_REG_BUFFER	TSC2101_REG(1, 2)=0A=
+#define TSC2101_REG_REF		TSC2101_REG(1, 3)=0A=
+#define TSC2101_REG_CONFIG	TSC2101_REG(1, 5)=0A=
+#define TSC2101_REG_PROG_DELAY	TSC2101_REG(1, 13)=0A=
+=0A=
+#define TSC2101_REG_AUDIO1	TSC2101_REG(2, 0)=0A=
+#define TSC2101_REG_DAC_GAIN	TSC2101_REG(2, 2)=0A=
+#define TSC2101_REG_AUDIO2	TSC2101_REG(2, 4)=0A=
+#define TSC2101_REG_DAC_POWER	TSC2101_REG(2, 5)=0A=
+#define TSC2101_REG_AUDIO3	TSC2101_REG(2, 6)=0A=
+#define TSC2101_REG_ADCLKCFG	TSC2101_REG(2, 27)=0A=
+=0A=
+#define TSC2101_REG_PD_MISC_APD		(1 << 15)=0A=
+#define TSC2101_REG_PD_MISC_AVPD	(1 << 14)=0A=
+#define TSC2101_REG_PD_MISC_ABPD	(1 << 13)=0A=
+#define TSC2101_REG_PD_MISC_HAPD	(1 << 12)=0A=
+#define TSC2101_REG_PD_MISC_MOPD	(1 << 11)=0A=
+#define TSC2101_REG_PD_MISC_DAPD	(1 << 10)=0A=
+#define TSC2101_REG_PD_MISC_ADPDL	(1 << 9)=0A=
+#define TSC2101_REG_PD_MISC_ADPDR	(1 << 8)=0A=
+#define TSC2101_REG_PD_MISC_PDSTS	(1 << 7)=0A=
+#define TSC2101_REG_PD_MISC_MIBPD	(1 << 6)=0A=
+=0A=
+/* I2S sample rate */=0A=
+#define TSC2101_I2S_SR_48000	0x00=0A=
+#define TSC2101_I2S_SR_44100	0x01=0A=
+#define TSC2101_I2S_SR_32000	0x02=0A=
+#define TSC2101_I2S_SR_24000	0x03=0A=
+#define TSC2101_I2S_SR_22050	0x04=0A=
+#define TSC2101_I2S_SR_16000	0x05=0A=
+#define TSC2101_I2S_SR_12000	0x06=0A=
+#define TSC2101_I2S_SR_11050	0x07=0A=
+#define TSC2101_I2S_SR_8000	0x08=0A=
+=0A=
+/* 16-bit, MSB-first. DAC Right-Justified, ADC Left-Justified */=0A=
+#define TSC2101_I2S_FORMAT0	0x00=0A=
+/* 20-bit, MSB-first. DAC Right-Justified, ADC Left-Justified */=0A=
+#define TSC2101_I2S_FORMAT1	0x01=0A=
+/* 20-bit, MSB-first. DAC Left-Justified, ADC Left-Justified */=0A=
+#define TSC2101_I2S_FORMAT2	0x02=0A=
+/* 20-bit, MSB-first */=0A=
+#define TSC2101_I2S_FORMAT3	0x03=0A=
+=0A=
+/* Master Clock Ratio */=0A=
+#define TSC2101_MCLK_256xFS	0x00 /* default */=0A=
+#define TSC2101_MCLK_384xFS	0x01=0A=
+#define TSC2101_MCLK_512xFS	0x02=0A=
+=0A=
+=0A=
+extern u16 tsc2101_read_reg(struct tsc2101 *tsc, int reg);=0A=
+extern void tsc2101_write_reg(struct tsc2101 *tsc, int reg, u16 val);=0A=
+extern void tsc2101_write_kbc(struct tsc2101 *tsc, int val);=0A=
+extern void tsc2101_write_pll(struct tsc2101 *tsc, int pll_n, int pll_a,=0A=
+			      int pll_pdc, int pct_e, int pll_o);=0A=
+extern void tsc2101_read_buf(struct tsc2101 *tsc, int reg, u16 *buf, =
int len);=0A=
+=0A=
+#define TSC2101_DECL_MOD(module)					\=0A=
+extern int  tsc2101_##module##_init(struct tsc2101 *tsc,		\=0A=
+			   struct tsc2101_platform_data *pdata);	\=0A=
+extern void tsc2101_##module##_exit(struct tsc2101 *tsc);		\=0A=
+extern void tsc2101_##module##_prep_for_clk_stop(struct tsc2101 *tsc);	\=0A=
+extern void tsc2101_##module##_cont_after_clk_stop(struct tsc2101 =
*tsc);\=0A=
+extern int  tsc2101_##module##_suspend(struct tsc2101 *tsc);		\=0A=
+extern void tsc2101_##module##_resume(struct tsc2101 *tsc);=0A=
+=0A=
+#define TSC2101_DECL_EMPTY_MOD(module)					\=0A=
+static inline int tsc2101_##module##_init(struct tsc2101 *tsc,		\=0A=
+			   struct tsc2101_platform_data *pdata)		\=0A=
+{									\=0A=
+	return 0;							\=0A=
+}									\=0A=
+static inline void tsc2101_##module##_exit(struct tsc2101 *tsc) {}	\=0A=
+static inline void tsc2101_##module##_prep_for_clk_stop			\=0A=
+					(struct tsc2101 *tsc) {}	\=0A=
+static inline void tsc2101_##module##_cont_after_clk_stop		\=0A=
+					(struct tsc2101 *tsc) {}	\=0A=
+static inline int  tsc2101_##module##_suspend(struct tsc2101 *tsc)	\=0A=
+{									\=0A=
+	return 0;							\=0A=
+}									\=0A=
+static inline void tsc2101_##module##_resume(struct tsc2101 *tsc) {}=0A=
+=0A=
+#ifdef CONFIG_TOUCHSCREEN_TSC2101=0A=
+TSC2101_DECL_MOD(ts)=0A=
+#else=0A=
+TSC2101_DECL_EMPTY_MOD(ts)=0A=
+#endif=0A=
+=0A=
+#ifdef CONFIG_SND_SOC_TSC2101=0A=
+TSC2101_DECL_MOD(mixer)=0A=
+extern void tsc2101_mixer_set_power(struct device *tsc_dev, int dac, =
int adc);=0A=
+=0A=
+struct snd_card;=0A=
+extern int tsc2101_mixer_register_controls(struct device *tsc_dev,=0A=
+					   struct snd_card *card);=0A=
+#else=0A=
+TSC2101_DECL_EMPTY_MOD(mixer)=0A=
+#endif=0A=
+=0A=
+extern void tsc2101_enable_mclk(struct device *tsc_dev);=0A=
+extern void tsc2101_disable_mclk(struct device *tsc_dev);=0A=
+=0A=
+#endif=0A=

------=_NextPart_000_006F_01C76ADC.FEC9DCE0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_006F_01C76ADC.FEC9DCE0--
