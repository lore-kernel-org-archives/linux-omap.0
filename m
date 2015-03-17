From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Tue, 17 Mar 2015 09:47:30 +0100
Message-ID: <20150317084730.GA9761@amd>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> >> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> >> new file mode 100644
> >> index 0000000..bb3580c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> >> @@ -0,0 +1,43 @@
> >> +twl4030_madc_battery
> >> +
> >> +Required properties:
> >> + - compatible : "ti,twl4030-madc-battery"
> >> + - capacity-uah : battery capacity in uAh
> >
> > Could we make it capacity-uAh ?
> This name was suggested by Mark Rutland [1] and naming convention
> should be all lowercase. There exists already bindings
> without uppercase (e.g. ti,bb-uamp) so I would keep it consistent.

Messing up SI units due to "convention" is _stupid_. Don't do it.

> > to introduce coefficients for temperature and discharge rate?
> What do you mean? Nothing like that is used in current driver why do
> we need to add it?

Well, conversion between Li-ion's voltage and state of charge at 0
current is well known:

    def percent(m, v):
    	u = 0.0387-(1.4523*(3.7835-v))
        if u < 0:
            return 0
          return (0.1966+math.sqrt(u))*100

And there's not much to calibrate there, and it should become library
helper function; there's no need to write it to every single dts.

The charge/discharge difference is due to internal battery resistance,
and Ohm's law. (Then, you should not need different values for
charging/discharging case.)

With your aproach, you'll get lower percentage when phone is under
load vs. idle. Taking internal resistance into account would give you
more precise readings. (Attached, old patch for zaurus shows the
needed computation).

And if you wanted even more precise readings... internal resistance
depends on temperature.

I guess this should go into library somewhere, because many machines
need similar code.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--liOOAslEiF7prFVr
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="zbattery.10.diff"

./drivers/power - ./drivers/power.ofic
diff -X /usr/src/linux/.gitignore -ur ./drivers/power.ofic/Makefile ./drivers/power/Makefile
--- ./drivers/power.ofic/Makefile	2011-03-16 10:11:34.000000000 +0100
+++ ./drivers/power/Makefile	2011-04-29 15:12:14.000000000 +0200
@@ -19,7 +19,9 @@
 obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
 obj-$(CONFIG_BATTERY_TOSA)	+= tosa_battery.o
+obj-m	+= spitz_battery.o
 obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
+obj-m	+= spitz_battery.o
 obj-$(CONFIG_BATTERY_WM97XX)	+= wm97xx_battery.o
 obj-$(CONFIG_BATTERY_BQ20Z75)	+= bq20z75.o
 obj-$(CONFIG_BATTERY_BQ27x00)	+= bq27x00_battery.o
diff -X /usr/src/linux/.gitignore -ur ./drivers/power.ofic/power_supply_sysfs.c ./drivers/power/power_supply_sysfs.c
--- ./drivers/power.ofic/power_supply_sysfs.c	2011-02-02 10:54:32.000000000 +0100
+++ ./drivers/power/power_supply_sysfs.c	2011-04-29 15:02:07.000000000 +0200
@@ -40,7 +40,8 @@
 
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
-					  char *buf) {
+					  char *buf)
+{
 	static char *type_text[] = {
 		"Battery", "UPS", "Mains", "USB",
 		"USB_DCP", "USB_CDP", "USB_ACA"
@@ -102,7 +103,8 @@
 
 static ssize_t power_supply_store_property(struct device *dev,
 					   struct device_attribute *attr,
-					   const char *buf, size_t count) {
+					   const char *buf, size_t count)
+{
 	ssize_t ret;
 	struct power_supply *psy = dev_get_drvdata(dev);
 	const ptrdiff_t off = attr - power_supply_attrs;
Only in ./drivers/power: spitz_battery.c
./drivers/video - ./drivers/video.ofic
diff -X /usr/src/linux/.gitignore -ur ./drivers/video.ofic/pxafb.c ./drivers/video/pxafb.c
--- ./drivers/video.ofic/pxafb.c	2011-02-02 09:44:53.000000000 +0100
+++ ./drivers/video/pxafb.c	2011-04-29 14:50:27.000000000 +0200
@@ -1648,6 +1648,9 @@
 #endif
 
 #ifdef CONFIG_PM
+
+static struct pxafb_info *my_fbi;
+
 /*
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
@@ -1656,6 +1659,8 @@
 {
 	struct pxafb_info *fbi = dev_get_drvdata(dev);
 
+	my_fbi = fbi;
+
 	set_ctrlr_state(fbi, C_DISABLE_PM);
 	return 0;
 }
./arch/arm - ./arch/arm.ofic
Binary files ./arch/arm.ofic/boot/Image and ./arch/arm/boot/Image differ
Binary files ./arch/arm.ofic/boot/compressed/piggy.gzip and ./arch/arm/boot/compressed/piggy.gzip differ
Binary files ./arch/arm.ofic/boot/compressed/vmlinux and ./arch/arm/boot/compressed/vmlinux differ
Binary files ./arch/arm.ofic/boot/zImage and ./arch/arm/boot/zImage differ
diff -X /usr/src/linux/.gitignore -ur ./arch/arm.ofic/mach-pxa/corgi_pm.c ./arch/arm/mach-pxa/corgi_pm.c
--- ./arch/arm.ofic/mach-pxa/corgi_pm.c	2011-02-02 10:30:38.000000000 +0100
+++ ./arch/arm/mach-pxa/corgi_pm.c	2011-04-29 15:12:15.000000000 +0200
@@ -43,6 +43,92 @@
 	{ CORGI_GPIO_KEY_INT,	  GPIOF_IN, "Key Interrupt" },
 };
 
+static const struct battery_thresh corgi_battery_levels_acin[] = {
+	{ 213, 100},
+	{ 212,  98},
+	{ 211,  95},
+	{ 210,  93},
+	{ 209,  90},
+	{ 208,  88},
+	{ 207,  85},
+	{ 206,  83},
+	{ 205,  80},
+	{ 204,  78},
+	{ 203,  75},
+	{ 202,  73},
+	{ 201,  70},
+	{ 200,  68},
+	{ 199,  65},
+	{ 198,  63},
+	{ 197,  60},
+	{ 196,  58},
+	{ 195,  55},
+	{ 194,  53},
+	{ 193,  50},
+	{ 192,  48},
+	{ 192,  45},
+	{ 191,  43},
+	{ 191,  40},
+	{ 190,  38},
+	{ 190,  35},
+	{ 189,  33},
+	{ 188,  30},
+	{ 187,  28},
+	{ 186,  25},
+	{ 185,  23},
+	{ 184,  20},
+	{ 183,  18},
+	{ 182,  15},
+	{ 181,  13},
+	{ 180,  10},
+	{ 179,   8},
+	{ 178,   5},
+	{   0,   0},
+};
+
+static const struct battery_thresh  corgi_battery_levels_noac[] = {
+	{ 213, 100},
+	{ 212,  98},
+	{ 211,  95},
+	{ 210,  93},
+	{ 209,  90},
+	{ 208,  88},
+	{ 207,  85},
+	{ 206,  83},
+	{ 205,  80},
+	{ 204,  78},
+	{ 203,  75},
+	{ 202,  73},
+	{ 201,  70},
+	{ 200,  68},
+	{ 199,  65},
+	{ 198,  63},
+	{ 197,  60},
+	{ 196,  58},
+	{ 195,  55},
+	{ 194,  53},
+	{ 193,  50},
+	{ 192,  48},
+	{ 191,  45},
+	{ 190,  43},
+	{ 189,  40},
+	{ 188,  38},
+	{ 187,  35},
+	{ 186,  33},
+	{ 185,  30},
+	{ 184,  28},
+	{ 183,  25},
+	{ 182,  23},
+	{ 181,  20},
+	{ 180,  18},
+	{ 179,  15},
+	{ 178,  13},
+	{ 177,  10},
+	{ 176,   8},
+	{ 175,   5},
+	{   0,   0},
+};
+
 static void corgi_charger_init(void)
 {
 	gpio_request_array(ARRAY_AND_SIZE(charger_gpios));
@@ -173,7 +259,6 @@
 	.fatal_noacin_volt= SHARPSL_FATAL_NOACIN_VOLT,
 	.bat_levels       = 40,
 	.bat_levels_noac  = sharpsl_battery_levels_noac,
-	.bat_levels_acin  = sharpsl_battery_levels_acin,
 	.status_high_acin = 188,
 	.status_low_acin  = 178,
 	.status_high_noac = 185,
diff -X /usr/src/linux/.gitignore -ur ./arch/arm.ofic/mach-pxa/include/mach/sharpsl_pm.h ./arch/arm/mach-pxa/include/mach/sharpsl_pm.h
--- ./arch/arm.ofic/mach-pxa/include/mach/sharpsl_pm.h	2011-02-02 10:30:38.000000000 +0100
+++ ./arch/arm/mach-pxa/include/mach/sharpsl_pm.h	2011-04-29 15:18:19.000000000 +0200
@@ -110,4 +110,22 @@
 int sharpsl_pm_pxa_read_max1111(int channel);
 
 void corgi_lcd_limit_intensity(int limit);
+
+/*
+ * Constants
+ */
+#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (msecs_to_jiffies(1*60*1000))  /* 1 min */
+#define SHARPSL_CHARGE_FINISH_TIME             (msecs_to_jiffies(10*60*1000)) /* 10 min */
+#define SHARPSL_BATCHK_TIME                    (msecs_to_jiffies(15*1000))    /* 15 sec */
+#define SHARPSL_BATCHK_TIME_SUSPEND            (60*10)                        /* 10 min */
+
+#define SHARPSL_WAIT_CO_TIME                   15  /* 15 sec */
+#define SHARPSL_WAIT_DISCHARGE_ON              100 /* 100 msec */
+#define SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP   10  /* 10 msec */
+#define SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT   10  /* 10 msec */
+#define SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN   10  /* 10 msec */
+#define SHARPSL_CHARGE_WAIT_TIME               15  /* 15 msec */
+#define SHARPSL_CHARGE_CO_CHECK_TIME           5   /* 5 msec */
+#define SHARPSL_CHARGE_RETRY_CNT               1   /* eqv. 10 min */
+
 #endif
diff -X /usr/src/linux/.gitignore -ur ./arch/arm.ofic/mach-pxa/sharpsl_pm.c ./arch/arm/mach-pxa/sharpsl_pm.c
--- ./arch/arm.ofic/mach-pxa/sharpsl_pm.c	2011-03-16 10:07:44.000000000 +0100
+++ ./arch/arm/mach-pxa/sharpsl_pm.c	2011-04-29 15:27:09.000000000 +0200
@@ -32,23 +32,6 @@
 #include <mach/sharpsl_pm.h>
 
 /*
- * Constants
- */
-#define SHARPSL_CHARGE_ON_TIME_INTERVAL        (msecs_to_jiffies(1*60*1000))  /* 1 min */
-#define SHARPSL_CHARGE_FINISH_TIME             (msecs_to_jiffies(10*60*1000)) /* 10 min */
-#define SHARPSL_BATCHK_TIME                    (msecs_to_jiffies(15*1000))    /* 15 sec */
-#define SHARPSL_BATCHK_TIME_SUSPEND            (60*10)                        /* 10 min */
-
-#define SHARPSL_WAIT_CO_TIME                   15  /* 15 sec */
-#define SHARPSL_WAIT_DISCHARGE_ON              100 /* 100 msec */
-#define SHARPSL_CHECK_BATTERY_WAIT_TIME_TEMP   10  /* 10 msec */
-#define SHARPSL_CHECK_BATTERY_WAIT_TIME_VOLT   10  /* 10 msec */
-#define SHARPSL_CHECK_BATTERY_WAIT_TIME_ACIN   10  /* 10 msec */
-#define SHARPSL_CHARGE_WAIT_TIME               15  /* 15 msec */
-#define SHARPSL_CHARGE_CO_CHECK_TIME           5   /* 5 msec */
-#define SHARPSL_CHARGE_RETRY_CNT               1   /* eqv. 10 min */
-
-/*
  * Prototypes
  */
 #ifdef CONFIG_PM
@@ -68,96 +51,32 @@
  * Variables
  */
 struct sharpsl_pm_status sharpsl_pm;
+EXPORT_SYMBOL(sharpsl_pm);
 static DECLARE_DELAYED_WORK(toggle_charger, sharpsl_charge_toggle);
 static DECLARE_DELAYED_WORK(sharpsl_bat, sharpsl_battery_thread);
 DEFINE_LED_TRIGGER(sharpsl_charge_led_trigger);
 
 
 
-struct battery_thresh sharpsl_battery_levels_acin[] = {
-	{ 213, 100},
-	{ 212,  98},
-	{ 211,  95},
-	{ 210,  93},
-	{ 209,  90},
-	{ 208,  88},
-	{ 207,  85},
-	{ 206,  83},
-	{ 205,  80},
-	{ 204,  78},
-	{ 203,  75},
-	{ 202,  73},
-	{ 201,  70},
-	{ 200,  68},
-	{ 199,  65},
-	{ 198,  63},
-	{ 197,  60},
-	{ 196,  58},
-	{ 195,  55},
-	{ 194,  53},
-	{ 193,  50},
-	{ 192,  48},
-	{ 192,  45},
-	{ 191,  43},
-	{ 191,  40},
-	{ 190,  38},
-	{ 190,  35},
-	{ 189,  33},
-	{ 188,  30},
-	{ 187,  28},
-	{ 186,  25},
-	{ 185,  23},
-	{ 184,  20},
-	{ 183,  18},
-	{ 182,  15},
-	{ 181,  13},
-	{ 180,  10},
-	{ 179,   8},
-	{ 178,   5},
-	{   0,   0},
-};
-
 struct battery_thresh sharpsl_battery_levels_noac[] = {
-	{ 213, 100},
-	{ 212,  98},
-	{ 211,  95},
-	{ 210,  93},
-	{ 209,  90},
-	{ 208,  88},
-	{ 207,  85},
-	{ 206,  83},
-	{ 205,  80},
-	{ 204,  78},
-	{ 203,  75},
-	{ 202,  73},
-	{ 201,  70},
-	{ 200,  68},
-	{ 199,  65},
-	{ 198,  63},
-	{ 197,  60},
-	{ 196,  58},
-	{ 195,  55},
-	{ 194,  53},
-	{ 193,  50},
-	{ 192,  48},
-	{ 191,  45},
-	{ 190,  43},
-	{ 189,  40},
-	{ 188,  38},
-	{ 187,  35},
-	{ 186,  33},
-	{ 185,  30},
-	{ 184,  28},
-	{ 183,  25},
-	{ 182,  23},
-	{ 181,  20},
-	{ 180,  18},
-	{ 179,  15},
-	{ 178,  13},
-	{ 177,  10},
-	{ 176,   8},
-	{ 175,   5},
-	{   0,   0},
+	{ 3980, 100 },
+	{ 3900, 95 },
+	{ 3860, 90 },
+	{ 3800, 85 },
+	{ 3760, 80 },
+	{ 3720, 74 },
+	{ 3680, 69 },
+	{ 3620, 65 },
+	{ 3570, 59 },
+	{ 3560, 55 },
+	{ 3550, 48 },
+	{ 3530, 45 },
+	{ 3510, 39 },
+	{ 3490, 33 },
+	{ 3470, 29 },
+	{ 3450, 23 },
+	{ 3410, 16 },
+	{    0, 0 },
 };
 
 /* MAX1111 Commands */
@@ -185,22 +104,71 @@
 	return max1111_read_channel(channel >> 1);
 }
 
-static int get_percentage(int voltage)
+
+typedef int milliamp_t;
+typedef int milliohm_t;
+typedef int millivolt_t;
+
+milliamp_t basic_current = 125;
+milliohm_t battery_resistance = 100;
+
+/* 422 seems to be suitable for very old, 1Ah battery.
+   2Ah battery probably has better resistance */
+
+/* Unfortunately, resistance depends on state of charge, current
+ * direction and temperature.
+ *
+ * Ouch, and dependency is actually _not_ too simple. It is lowest
+ * at 3.55V, very slowly rises at 4V (approximately linear dependency),
+ * and quickly rises towards 3.2V (in something exponential-looking).
+ *
+ * It is about same at 25Celsius and 40Celsius, and about 2.5x the value
+ * on 0Celsius, rising _very_ sharply.
+ *
+ * Li-ion should only be charged between 0 and 45 Celsius, and discharged
+ * between -20 and 60 celsius.
+ */
+
+extern int backlight_current;
+
+/* Positive values: current drawn from battery */
+milliamp_t battery_current(void)
+{
+	if (sharpsl_pm.charge_mode == CHRG_ON)
+		return 0;
+
+	return basic_current;
+}
+
+millivolt_t liion_internal_voltage(millivolt_t voltage, milliamp_t current_ma)
+{
+	return voltage + (battery_resistance * current_ma / 1000);
+}
+
+/* returns mV */
+millivolt_t liion_voltage(int adc)
+{
+	/* Thanks to Stanislav B. ADC has 3.3V as reference,
+	   is connected to battery over 47kOhm,
+	   and to ground over 100kOhm. */
+	return (adc * 147 * 33)/256;
+}
+
+static int get_percentage(int voltage_adc)
 {
 	int i = sharpsl_pm.machinfo->bat_levels - 1;
 	int bl_status = sharpsl_pm.machinfo->backlight_get_status ? sharpsl_pm.machinfo->backlight_get_status() : 0;
 	struct battery_thresh *thresh;
+	millivolt_t voltage = liion_voltage(voltage_adc);
 
-	if (sharpsl_pm.charge_mode == CHRG_ON)
-		thresh = bl_status ? sharpsl_pm.machinfo->bat_levels_acin_bl : sharpsl_pm.machinfo->bat_levels_acin;
-	else
-		thresh = bl_status ? sharpsl_pm.machinfo->bat_levels_noac_bl : sharpsl_pm.machinfo->bat_levels_noac;
+	thresh = sharpsl_pm.machinfo->bat_levels_noac;
 
 	while (i > 0 && (voltage > thresh[i].voltage))
 		i--;
 
 	return thresh[i].percentage;
 }
+EXPORT_SYMBOL(get_percentage);
 
 static int get_apm_status(int voltage)
 {
@@ -317,6 +285,8 @@
 
 static void sharpsl_charge_error(void)
 {
+	dev_warn(sharpsl_pm.dev, "Charger Error\n");
+
 	sharpsl_pm_led(SHARPSL_LED_ERROR);
 	sharpsl_pm.machinfo->charge(0);
 	sharpsl_pm.charge_mode = CHRG_ERROR;
@@ -513,8 +483,10 @@
 	val = get_select_val(buff);
 
 	dev_dbg(sharpsl_pm.dev, "Temperature: %d\n", val);
-	if (val > sharpsl_pm.machinfo->charge_on_temp) {
-		printk(KERN_WARNING "Not charging: temperature out of limits.\n");
+	/* FIXME: this should catch battery read errors, but we should
+	   probably avoid charging in <0C temperatures, too. */
+	if ((val < 0) || (val > sharpsl_pm.machinfo->charge_on_temp)) {
+		dev_warn(sharpsl_pm.dev, "Not charging: temperature %d out of limits.\n", val);
 		return -1;
 	}
 
diff -X /usr/src/linux/.gitignore -ur ./arch/arm.ofic/mach-pxa/spitz.c ./arch/arm/mach-pxa/spitz.c
--- ./arch/arm.ofic/mach-pxa/spitz.c	2011-03-16 10:07:44.000000000 +0100
+++ ./arch/arm/mach-pxa/spitz.c	2011-04-29 15:25:47.000000000 +0200
@@ -922,6 +922,15 @@
 #endif
 
 /******************************************************************************
+ * Battery
+ ******************************************************************************/
+
+static struct platform_device spitz_battery_device = {
+	.name	= "spitz-battery",
+	.id	= -1,
+};
+
+/******************************************************************************
  * Machine init
  ******************************************************************************/
 static void spitz_poweroff(void)
@@ -969,6 +978,7 @@
 	spitz_nor_init();
 	spitz_nand_init();
 	spitz_i2c_init();
+	platform_device_register(&spitz_battery_device);
 }
 
 static void __init spitz_fixup(struct machine_desc *desc,
diff -X /usr/src/linux/.gitignore -ur ./arch/arm.ofic/mach-pxa/spitz_pm.c ./arch/arm/mach-pxa/spitz_pm.c
--- ./arch/arm.ofic/mach-pxa/spitz_pm.c	2011-02-02 10:30:39.000000000 +0100
+++ ./arch/arm/mach-pxa/spitz_pm.c	2011-04-29 15:15:16.000000000 +0200
@@ -45,6 +45,93 @@
 	{ SPITZ_GPIO_CHRG_ON,	  GPIOF_OUT_INIT_LOW, "Charger On" },
 };
 
+static const struct battery_thresh spitz_battery_levels_acin[] = {
+	{ 213, 100},
+	{ 212,  98},
+	{ 211,  95},
+	{ 210,  93},
+	{ 209,  90},
+	{ 208,  88},
+	{ 207,  85},
+	{ 206,  83},
+	{ 205,  80},
+	{ 204,  78},
+	{ 203,  75},
+	{ 202,  73},
+	{ 201,  70},
+	{ 200,  68},
+	{ 199,  65},
+	{ 198,  63},
+	{ 197,  60},
+	{ 196,  58},
+	{ 195,  55},
+	{ 194,  53},
+	{ 193,  50},
+	{ 192,  48},
+	{ 192,  45},
+	{ 191,  43},
+	{ 191,  40},
+	{ 190,  38},
+	{ 190,  35},
+	{ 189,  33},
+	{ 188,  30},
+	{ 187,  28},
+	{ 186,  25},
+	{ 185,  23},
+	{ 184,  20},
+	{ 183,  18},
+	{ 182,  15},
+	{ 181,  13},
+	{ 180,  10},
+	{ 179,   8},
+	{ 178,   5},
+	{   0,   0},
+};
+
+static const struct battery_thresh  spitz_battery_levels_noac[] = {
+	{ 213, 100},
+	{ 212,  98},
+	{ 211,  95},
+	{ 210,  93},
+	{ 209,  90},
+	{ 208,  88},
+	{ 207,  85},
+	{ 206,  83},
+	{ 205,  80},
+	{ 204,  78},
+	{ 203,  75},
+	{ 202,  73},
+	{ 201,  70},
+	{ 200,  68},
+	{ 199,  65},
+	{ 198,  63},
+	{ 197,  60},
+	{ 196,  58},
+	{ 195,  55},
+	{ 194,  53},
+	{ 193,  50},
+	{ 192,  48},
+	{ 191,  45},
+	{ 190,  43},
+	{ 189,  40},
+	{ 188,  38},
+	{ 187,  35},
+	{ 186,  33},
+	{ 185,  30},
+	{ 184,  28},
+	{ 183,  25},
+	{ 182,  23},
+	{ 181,  20},
+	{ 180,  18},
+	{ 179,  15},
+	{ 178,  13},
+	{ 177,  10},
+	{ 176,   8},
+	{ 175,   5},
+	{   0,   0},
+};
+
+
 static void spitz_charger_init(void)
 {
 	gpio_request_array(ARRAY_AND_SIZE(spitz_charger_gpios));
@@ -192,6 +279,11 @@
 	}
 }
 
+int backlight_get_status(void)
+{
+	return 0;
+}
+
 struct sharpsl_charger_machinfo spitz_pm_machinfo = {
 	.init             = spitz_charger_init,
 	.exit             = NULL,
@@ -210,7 +302,7 @@
 	.charger_wakeup   = spitz_charger_wakeup,
 	.should_wakeup    = spitz_should_wakeup,
 #if defined(CONFIG_LCD_CORGI)
-	.backlight_limit = corgi_lcd_limit_intensity,
+	.backlight_limit  = corgi_lcd_limit_intensity,
 #endif
 	.charge_on_volt	  = SHARPSL_CHARGE_ON_VOLT,
 	.charge_on_temp	  = SHARPSL_CHARGE_ON_TEMP,
@@ -220,7 +312,6 @@
 	.fatal_noacin_volt= SHARPSL_FATAL_NOACIN_VOLT,
 	.bat_levels       = 40,
 	.bat_levels_noac  = sharpsl_battery_levels_noac,
-	.bat_levels_acin  = sharpsl_battery_levels_acin,
 	.status_high_acin = 188,
 	.status_low_acin  = 178,
 	.status_high_noac = 185,

--liOOAslEiF7prFVr--
