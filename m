From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2] thermal: consistently use int for temperatures
Date: Tue, 21 Jul 2015 09:21:32 +0200
Message-ID: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sensors@lm-sensors.org
List-Id: linux-omap@vger.kernel.org

The thermal code uses int, long and unsigned long for temperatures
in different places.

Using an unsigned type limits the thermal framework to positive
temperatures without need. Also several drivers currently will report
temperatures near UINT_MAX for temperatures below 0=C2=B0C. This will p=
robably
immediately shut the machine down due to overtemperature if started bel=
ow
0=C2=B0C.

'long' is 64bit on several architectures. This is not needed since INT_=
MAX =C2=B0mC
is above the melting point of all known materials.

Consistently use a plain 'int' for temperatures throughout the thermal =
code and
the drivers. This only changes the places in the drivers where the temp=
erature
is passed around as pointer, when drivers internally use another type t=
his is
not changed.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
Reviewed-by: Darren Hart <dvhart@linux.intel.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Peter Feuerer <peter@piie.net>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>
Cc: Peter Feuerer <peter@piie.net>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-acpi@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: lm-sensors@lm-sensors.org
---

changes since v1:
- Add missing pieces for power_allocator driver=20

 drivers/acpi/thermal.c                             | 12 +++++-----
 drivers/hwmon/lm75.c                               |  2 +-
 drivers/hwmon/ntc_thermistor.c                     |  2 +-
 drivers/hwmon/tmp102.c                             |  2 +-
 drivers/input/touchscreen/sun4i-ts.c               |  8 +++----
 drivers/platform/x86/acerhdf.c                     |  9 ++++----
 drivers/platform/x86/intel_mid_thermal.c           |  9 ++++----
 drivers/power/power_supply_core.c                  |  2 +-
 drivers/thermal/armada_thermal.c                   |  2 +-
 drivers/thermal/db8500_thermal.c                   |  7 +++---
 drivers/thermal/dove_thermal.c                     |  2 +-
 drivers/thermal/fair_share.c                       |  2 +-
 drivers/thermal/gov_bang_bang.c                    |  5 ++--
 drivers/thermal/hisi_thermal.c                     |  4 ++--
 drivers/thermal/imx_thermal.c                      | 27 +++++++++++---=
--------
 drivers/thermal/int340x_thermal/int3400_thermal.c  |  2 +-
 .../thermal/int340x_thermal/int340x_thermal_zone.c | 10 ++++----
 .../thermal/int340x_thermal/int340x_thermal_zone.h |  8 +++----
 .../int340x_thermal/processor_thermal_device.c     |  4 ++--
 drivers/thermal/intel_quark_dts_thermal.c          | 13 +++++------
 drivers/thermal/intel_soc_dts_iosf.c               |  8 +++----
 drivers/thermal/kirkwood_thermal.c                 |  2 +-
 drivers/thermal/of-thermal.c                       | 14 +++++------
 drivers/thermal/power_allocator.c                  | 16 ++++++-------
 drivers/thermal/qcom-spmi-temp-alarm.c             |  2 +-
 drivers/thermal/rcar_thermal.c                     |  7 +++---
 drivers/thermal/rockchip_thermal.c                 | 10 ++++----
 drivers/thermal/samsung/exynos_tmu.c               | 23 +++++++++-----=
----
 drivers/thermal/spear_thermal.c                    |  2 +-
 drivers/thermal/st/st_thermal.c                    |  5 ++--
 drivers/thermal/step_wise.c                        |  4 ++--
 drivers/thermal/tegra_soctherm.c                   |  4 ++--
 drivers/thermal/thermal_core.c                     | 26 ++++++++++----=
-------
 drivers/thermal/thermal_hwmon.c                    | 10 ++++----
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 10 ++++----
 drivers/thermal/x86_pkg_temp_thermal.c             | 10 ++++----
 include/linux/thermal.h                            | 26 +++++++++-----=
-------
 include/trace/events/thermal_power_allocator.h     |  6 ++---
 38 files changed, 151 insertions(+), 166 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 6d4e44e..e66ad25 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -529,8 +529,7 @@ static void acpi_thermal_check(void *data)
=20
 /* sys I/F for generic thermal sysfs support */
=20
-static int thermal_get_temp(struct thermal_zone_device *thermal,
-			    unsigned long *temp)
+static int thermal_get_temp(struct thermal_zone_device *thermal, int *=
temp)
 {
 	struct acpi_thermal *tz =3D thermal->devdata;
 	int result;
@@ -637,7 +636,7 @@ static int thermal_get_trip_type(struct thermal_zon=
e_device *thermal,
 }
=20
 static int thermal_get_trip_temp(struct thermal_zone_device *thermal,
-				 int trip, unsigned long *temp)
+				 int trip, int *temp)
 {
 	struct acpi_thermal *tz =3D thermal->devdata;
 	int i;
@@ -690,7 +689,8 @@ static int thermal_get_trip_temp(struct thermal_zon=
e_device *thermal,
 }
=20
 static int thermal_get_crit_temp(struct thermal_zone_device *thermal,
-				unsigned long *temperature) {
+				int *temperature)
+{
 	struct acpi_thermal *tz =3D thermal->devdata;
=20
 	if (tz->trips.critical.flags.valid) {
@@ -713,8 +713,8 @@ static int thermal_get_trend(struct thermal_zone_de=
vice *thermal,
 		return -EINVAL;
=20
 	if (type =3D=3D THERMAL_TRIP_ACTIVE) {
-		unsigned long trip_temp;
-		unsigned long temp =3D DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
+		int trip_temp;
+		int temp =3D DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(
 					tz->temperature, tz->kelvin_offset);
 		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
 			return -EINVAL;
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index fe41d5a..e4e57bb 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -104,7 +104,7 @@ static inline long lm75_reg_to_mc(s16 temp, u8 reso=
lution)
=20
 /* sysfs attributes for hwmon */
=20
-static int lm75_read_temp(void *dev, long *temp)
+static int lm75_read_temp(void *dev, int *temp)
 {
 	struct lm75_data *data =3D lm75_update_device(dev);
=20
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermis=
tor.c
index dc0b76c..feed306 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -477,7 +477,7 @@ static int ntc_thermistor_get_ohm(struct ntc_data *=
data)
 	return -EINVAL;
 }
=20
-static int ntc_read_temp(void *dev, long *temp)
+static int ntc_read_temp(void *dev, int *temp)
 {
 	struct ntc_data *data =3D dev_get_drvdata(dev);
 	int ohm;
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 9da2735..6548262 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -98,7 +98,7 @@ static struct tmp102 *tmp102_update_device(struct dev=
ice *dev)
 	return tmp102;
 }
=20
-static int tmp102_read_temp(void *dev, long *temp)
+static int tmp102_read_temp(void *dev, int *temp)
 {
 	struct tmp102 *tmp102 =3D tmp102_update_device(dev);
=20
diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touch=
screen/sun4i-ts.c
index c011699..4857943 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -191,7 +191,7 @@ static void sun4i_ts_close(struct input_dev *dev)
 	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
 }
=20
-static int sun4i_get_temp(const struct sun4i_ts_data *ts, long *temp)
+static int sun4i_get_temp(const struct sun4i_ts_data *ts, int *temp)
 {
 	/* No temp_data until the first irq */
 	if (ts->temp_data =3D=3D -1)
@@ -202,7 +202,7 @@ static int sun4i_get_temp(const struct sun4i_ts_dat=
a *ts, long *temp)
 	return 0;
 }
=20
-static int sun4i_get_tz_temp(void *data, long *temp)
+static int sun4i_get_tz_temp(void *data, int *temp)
 {
 	return sun4i_get_temp(data, temp);
 }
@@ -215,14 +215,14 @@ static ssize_t show_temp(struct device *dev, stru=
ct device_attribute *devattr,
 			 char *buf)
 {
 	struct sun4i_ts_data *ts =3D dev_get_drvdata(dev);
-	long temp;
+	int temp;
 	int error;
=20
 	error =3D sun4i_get_temp(ts, &temp);
 	if (error)
 		return error;
=20
-	return sprintf(buf, "%ld\n", temp);
+	return sprintf(buf, "%d\n", temp);
 }
=20
 static ssize_t show_temp_label(struct device *dev,
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acer=
hdf.c
index 1ef02da..460fa67 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -346,8 +346,7 @@ static void acerhdf_check_param(struct thermal_zone=
_device *thermal)
  * as late as the polling interval is since we can't do that in the re=
spective
  * accessors of the module parameters.
  */
-static int acerhdf_get_ec_temp(struct thermal_zone_device *thermal,
-			       unsigned long *t)
+static int acerhdf_get_ec_temp(struct thermal_zone_device *thermal, in=
t *t)
 {
 	int temp, err =3D 0;
=20
@@ -453,7 +452,7 @@ static int acerhdf_get_trip_type(struct thermal_zon=
e_device *thermal, int trip,
 }
=20
 static int acerhdf_get_trip_hyst(struct thermal_zone_device *thermal, =
int trip,
-				 unsigned long *temp)
+				 int *temp)
 {
 	if (trip !=3D 0)
 		return -EINVAL;
@@ -464,7 +463,7 @@ static int acerhdf_get_trip_hyst(struct thermal_zon=
e_device *thermal, int trip,
 }
=20
 static int acerhdf_get_trip_temp(struct thermal_zone_device *thermal, =
int trip,
-				 unsigned long *temp)
+				 int *temp)
 {
 	if (trip =3D=3D 0)
 		*temp =3D fanon;
@@ -477,7 +476,7 @@ static int acerhdf_get_trip_temp(struct thermal_zon=
e_device *thermal, int trip,
 }
=20
 static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
-				 unsigned long *temperature)
+				 int *temperature)
 {
 	*temperature =3D ACERHDF_TEMP_CRIT;
 	return 0;
diff --git a/drivers/platform/x86/intel_mid_thermal.c b/drivers/platfor=
m/x86/intel_mid_thermal.c
index 0944e83..9f713b8 100644
--- a/drivers/platform/x86/intel_mid_thermal.c
+++ b/drivers/platform/x86/intel_mid_thermal.c
@@ -132,7 +132,7 @@ static int is_valid_adc(uint16_t adc_val, uint16_t =
min, uint16_t max)
  * to achieve very close approximate temp value with less than
  * 0.5C error
  */
-static int adc_to_temp(int direct, uint16_t adc_val, unsigned long *tp=
)
+static int adc_to_temp(int direct, uint16_t adc_val, int *tp)
 {
 	int temp;
=20
@@ -174,14 +174,13 @@ static int adc_to_temp(int direct, uint16_t adc_v=
al, unsigned long *tp)
  *
  * Can sleep
  */
-static int mid_read_temp(struct thermal_zone_device *tzd, unsigned lon=
g *temp)
+static int mid_read_temp(struct thermal_zone_device *tzd, int *temp)
 {
 	struct thermal_device_info *td_info =3D tzd->devdata;
 	uint16_t adc_val, addr;
 	uint8_t data =3D 0;
 	int ret;
-	unsigned long curr_temp;
-
+	int curr_temp;
=20
 	addr =3D td_info->chnl_addr;
=20
@@ -453,7 +452,7 @@ static SIMPLE_DEV_PM_OPS(mid_thermal_pm,
  *
  * Can sleep
  */
-static int read_curr_temp(struct thermal_zone_device *tzd, unsigned lo=
ng *temp)
+static int read_curr_temp(struct thermal_zone_device *tzd, int *temp)
 {
 	WARN_ON(tzd =3D=3D NULL);
 	return mid_read_temp(tzd, temp);
diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_su=
pply_core.c
index 869284c..456987c 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -557,7 +557,7 @@ EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
=20
 #ifdef CONFIG_THERMAL
 static int power_supply_read_temp(struct thermal_zone_device *tzd,
-		unsigned long *temp)
+		int *temp)
 {
 	struct power_supply *psy;
 	union power_supply_propval val;
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_=
thermal.c
index 01255fd..26b8d32 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -155,7 +155,7 @@ static bool armada_is_valid(struct armada_thermal_p=
riv *priv)
 }
=20
 static int armada_get_temp(struct thermal_zone_device *thermal,
-			  unsigned long *temp)
+			  int *temp)
 {
 	struct armada_thermal_priv *priv =3D thermal->devdata;
 	unsigned long reg;
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_=
thermal.c
index 2fb273c..652acd8 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -107,8 +107,7 @@ static int db8500_cdev_unbind(struct thermal_zone_d=
evice *thermal,
 }
=20
 /* Callback to get current temperature */
-static int db8500_sys_get_temp(struct thermal_zone_device *thermal,
-		unsigned long *temp)
+static int db8500_sys_get_temp(struct thermal_zone_device *thermal, in=
t *temp)
 {
 	struct db8500_thermal_zone *pzone =3D thermal->devdata;
=20
@@ -180,7 +179,7 @@ static int db8500_sys_get_trip_type(struct thermal_=
zone_device *thermal,
=20
 /* Callback to get trip point temperature */
 static int db8500_sys_get_trip_temp(struct thermal_zone_device *therma=
l,
-		int trip, unsigned long *temp)
+		int trip, int *temp)
 {
 	struct db8500_thermal_zone *pzone =3D thermal->devdata;
 	struct db8500_thsens_platform_data *ptrips =3D pzone->trip_tab;
@@ -195,7 +194,7 @@ static int db8500_sys_get_trip_temp(struct thermal_=
zone_device *thermal,
=20
 /* Callback to get critical trip point temperature */
 static int db8500_sys_get_crit_temp(struct thermal_zone_device *therma=
l,
-		unsigned long *temp)
+		int *temp)
 {
 	struct db8500_thermal_zone *pzone =3D thermal->devdata;
 	struct db8500_thsens_platform_data *ptrips =3D pzone->trip_tab;
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_ther=
mal.c
index 09f6e30..a0bc9de 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -93,7 +93,7 @@ static int dove_init_sensor(const struct dove_thermal=
_priv *priv)
 }
=20
 static int dove_get_temp(struct thermal_zone_device *thermal,
-			  unsigned long *temp)
+			  int *temp)
 {
 	unsigned long reg;
 	struct dove_thermal_priv *priv =3D thermal->devdata;
diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.=
c
index c2c10bb..34fe365 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -34,7 +34,7 @@
 static int get_trip_level(struct thermal_zone_device *tz)
 {
 	int count =3D 0;
-	unsigned long trip_temp;
+	int trip_temp;
 	enum thermal_trip_type trip_type;
=20
 	if (tz->trips =3D=3D 0 || !tz->ops->get_trip_temp)
diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang=
_bang.c
index c5dd76b..70836c5 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -25,14 +25,13 @@
=20
 static void thermal_zone_trip_update(struct thermal_zone_device *tz, i=
nt trip)
 {
-	long trip_temp;
-	unsigned long trip_hyst;
+	int trip_temp, trip_hyst;
 	struct thermal_instance *instance;
=20
 	tz->ops->get_trip_temp(tz, trip, &trip_temp);
 	tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
=20
-	dev_dbg(&tz->device, "Trip%d[temp=3D%ld]:temp=3D%d:hyst=3D%ld\n",
+	dev_dbg(&tz->device, "Trip%d[temp=3D%d]:temp=3D%d:hyst=3D%d\n",
 				trip, trip_temp, tz->temperature,
 				trip_hyst);
=20
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_ther=
mal.c
index d5dd357..49aa068 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -155,7 +155,7 @@ static void hisi_thermal_disable_sensor(struct hisi=
_thermal_data *data)
 	mutex_unlock(&data->thermal_lock);
 }
=20
-static int hisi_thermal_get_temp(void *_sensor, long *temp)
+static int hisi_thermal_get_temp(void *_sensor, int *temp)
 {
 	struct hisi_thermal_sensor *sensor =3D _sensor;
 	struct hisi_thermal_data *data =3D sensor->thermal;
@@ -178,7 +178,7 @@ static int hisi_thermal_get_temp(void *_sensor, lon=
g *temp)
 	data->irq_bind_sensor =3D sensor_id;
 	mutex_unlock(&data->thermal_lock);
=20
-	dev_dbg(&data->pdev->dev, "id=3D%d, irq=3D%d, temp=3D%ld, thres=3D%d\=
n",
+	dev_dbg(&data->pdev->dev, "id=3D%d, irq=3D%d, temp=3D%d, thres=3D%d\n=
",
 		sensor->id, data->irq_enabled, *temp, sensor->thres_temp);
 	/*
 	 * Bind irq to sensor for two cases:
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_therma=
l.c
index fde4c28..4bec1d3 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -98,10 +98,10 @@ struct imx_thermal_data {
 	enum thermal_device_mode mode;
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_get_sensor_data() */
-	unsigned long temp_passive;
-	unsigned long temp_critical;
-	unsigned long alarm_temp;
-	unsigned long last_temp;
+	int temp_passive;
+	int temp_critical;
+	int alarm_temp;
+	int last_temp;
 	bool irq_enabled;
 	int irq;
 	struct clk *thermal_clk;
@@ -109,7 +109,7 @@ struct imx_thermal_data {
 };
=20
 static void imx_set_panic_temp(struct imx_thermal_data *data,
-			       signed long panic_temp)
+			       int panic_temp)
 {
 	struct regmap *map =3D data->tempmon;
 	int critical_value;
@@ -121,7 +121,7 @@ static void imx_set_panic_temp(struct imx_thermal_d=
ata *data,
 }
=20
 static void imx_set_alarm_temp(struct imx_thermal_data *data,
-			       signed long alarm_temp)
+			       int alarm_temp)
 {
 	struct regmap *map =3D data->tempmon;
 	int alarm_value;
@@ -133,7 +133,7 @@ static void imx_set_alarm_temp(struct imx_thermal_d=
ata *data,
 			TEMPSENSE0_ALARM_VALUE_SHIFT);
 }
=20
-static int imx_get_temp(struct thermal_zone_device *tz, unsigned long =
*temp)
+static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct imx_thermal_data *data =3D tz->devdata;
 	struct regmap *map =3D data->tempmon;
@@ -189,13 +189,13 @@ static int imx_get_temp(struct thermal_zone_devic=
e *tz, unsigned long *temp)
 		if (data->alarm_temp =3D=3D data->temp_critical &&
 			*temp < data->temp_passive) {
 			imx_set_alarm_temp(data, data->temp_passive);
-			dev_dbg(&tz->device, "thermal alarm off: T < %lu\n",
+			dev_dbg(&tz->device, "thermal alarm off: T < %d\n",
 				data->alarm_temp / 1000);
 		}
 	}
=20
 	if (*temp !=3D data->last_temp) {
-		dev_dbg(&tz->device, "millicelsius: %ld\n", *temp);
+		dev_dbg(&tz->device, "millicelsius: %d\n", *temp);
 		data->last_temp =3D *temp;
 	}
=20
@@ -262,8 +262,7 @@ static int imx_get_trip_type(struct thermal_zone_de=
vice *tz, int trip,
 	return 0;
 }
=20
-static int imx_get_crit_temp(struct thermal_zone_device *tz,
-			     unsigned long *temp)
+static int imx_get_crit_temp(struct thermal_zone_device *tz, int *temp=
)
 {
 	struct imx_thermal_data *data =3D tz->devdata;
=20
@@ -272,7 +271,7 @@ static int imx_get_crit_temp(struct thermal_zone_de=
vice *tz,
 }
=20
 static int imx_get_trip_temp(struct thermal_zone_device *tz, int trip,
-			     unsigned long *temp)
+			     int *temp)
 {
 	struct imx_thermal_data *data =3D tz->devdata;
=20
@@ -282,7 +281,7 @@ static int imx_get_trip_temp(struct thermal_zone_de=
vice *tz, int trip,
 }
=20
 static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
-			     unsigned long temp)
+			     int temp)
 {
 	struct imx_thermal_data *data =3D tz->devdata;
=20
@@ -434,7 +433,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int=
 irq, void *dev)
 {
 	struct imx_thermal_data *data =3D dev;
=20
-	dev_dbg(&data->tz->device, "THERMAL ALARM: T > %lu\n",
+	dev_dbg(&data->tz->device, "THERMAL ALARM: T > %d\n",
 		data->alarm_temp / 1000);
=20
 	thermal_zone_device_update(data->tz);
diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/driver=
s/thermal/int340x_thermal/int3400_thermal.c
index 031018e..5836e55 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -186,7 +186,7 @@ static int int3400_thermal_run_osc(acpi_handle hand=
le,
 }
=20
 static int int3400_thermal_get_temp(struct thermal_zone_device *therma=
l,
-			unsigned long *temp)
+			int *temp)
 {
 	*temp =3D 20 * 1000; /* faked temp sensor with 20C */
 	return 0;
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/d=
rivers/thermal/int340x_thermal/int340x_thermal_zone.c
index 1e25133..b9b2666 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
@@ -20,7 +20,7 @@
 #include "int340x_thermal_zone.h"
=20
 static int int340x_thermal_get_zone_temp(struct thermal_zone_device *z=
one,
-					 unsigned long *temp)
+					 int *temp)
 {
 	struct int34x_thermal_zone *d =3D zone->devdata;
 	unsigned long long tmp;
@@ -49,7 +49,7 @@ static int int340x_thermal_get_zone_temp(struct therm=
al_zone_device *zone,
 }
=20
 static int int340x_thermal_get_trip_temp(struct thermal_zone_device *z=
one,
-					 int trip, unsigned long *temp)
+					 int trip, int *temp)
 {
 	struct int34x_thermal_zone *d =3D zone->devdata;
 	int i;
@@ -114,7 +114,7 @@ static int int340x_thermal_get_trip_type(struct the=
rmal_zone_device *zone,
 }
=20
 static int int340x_thermal_set_trip_temp(struct thermal_zone_device *z=
one,
-				      int trip, unsigned long temp)
+				      int trip, int temp)
 {
 	struct int34x_thermal_zone *d =3D zone->devdata;
 	acpi_status status;
@@ -136,7 +136,7 @@ static int int340x_thermal_set_trip_temp(struct the=
rmal_zone_device *zone,
=20
=20
 static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *z=
one,
-		int trip, unsigned long *temp)
+		int trip, int *temp)
 {
 	struct int34x_thermal_zone *d =3D zone->devdata;
 	acpi_status status;
@@ -163,7 +163,7 @@ static struct thermal_zone_device_ops int340x_therm=
al_zone_ops =3D {
 };
=20
 static int int340x_thermal_get_trip_config(acpi_handle handle, char *n=
ame,
-				      unsigned long *temp)
+				      int *temp)
 {
 	unsigned long long r;
 	acpi_status status;
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h b/d=
rivers/thermal/int340x_thermal/int340x_thermal_zone.h
index 9f38ab7..aaadf72 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
@@ -21,7 +21,7 @@
 #define INT340X_THERMAL_MAX_ACT_TRIP_COUNT	10
=20
 struct active_trip {
-	unsigned long temp;
+	int temp;
 	int id;
 	bool valid;
 };
@@ -31,11 +31,11 @@ struct int34x_thermal_zone {
 	struct active_trip act_trips[INT340X_THERMAL_MAX_ACT_TRIP_COUNT];
 	unsigned long *aux_trips;
 	int aux_trip_nr;
-	unsigned long psv_temp;
+	int psv_temp;
 	int psv_trip_id;
-	unsigned long crt_temp;
+	int crt_temp;
 	int crt_trip_id;
-	unsigned long hot_temp;
+	int hot_temp;
 	int hot_trip_id;
 	struct thermal_zone_device *zone;
 	struct thermal_zone_device_ops *override_ops;
diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c=
 b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 3df3dc3..ccc0ad0 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -145,7 +145,7 @@ static int get_tjmax(void)
 	return -EINVAL;
 }
=20
-static int read_temp_msr(unsigned long *temp)
+static int read_temp_msr(int *temp)
 {
 	int cpu;
 	u32 eax, edx;
@@ -177,7 +177,7 @@ err_ret:
 }
=20
 static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone=
,
-					 unsigned long *temp)
+					 int *temp)
 {
 	int ret;
=20
diff --git a/drivers/thermal/intel_quark_dts_thermal.c b/drivers/therma=
l/intel_quark_dts_thermal.c
index 4434ec8..5ed90e6 100644
--- a/drivers/thermal/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel_quark_dts_thermal.c
@@ -186,7 +186,7 @@ static int soc_dts_disable(struct thermal_zone_devi=
ce *tzd)
 	return ret;
 }
=20
-static int _get_trip_temp(int trip, unsigned long *temp)
+static int _get_trip_temp(int trip, int *temp)
 {
 	int status;
 	u32 out;
@@ -212,19 +212,18 @@ static int _get_trip_temp(int trip, unsigned long=
 *temp)
 }
=20
 static inline int sys_get_trip_temp(struct thermal_zone_device *tzd,
-				int trip, unsigned long *temp)
+				int trip, int *temp)
 {
 	return _get_trip_temp(trip, temp);
 }
=20
-static inline int sys_get_crit_temp(struct thermal_zone_device *tzd,
-				unsigned long *temp)
+static inline int sys_get_crit_temp(struct thermal_zone_device *tzd, i=
nt *temp)
 {
 	return _get_trip_temp(QRK_DTS_ID_TP_CRITICAL, temp);
 }
=20
 static int update_trip_temp(struct soc_sensor_entry *aux_entry,
-				int trip, unsigned long temp)
+				int trip, int temp)
 {
 	u32 out;
 	u32 temp_out;
@@ -272,7 +271,7 @@ failed:
 }
=20
 static inline int sys_set_trip_temp(struct thermal_zone_device *tzd, i=
nt trip,
-				unsigned long temp)
+				int temp)
 {
 	return update_trip_temp(tzd->devdata, trip, temp);
 }
@@ -289,7 +288,7 @@ static int sys_get_trip_type(struct thermal_zone_de=
vice *thermal,
 }
=20
 static int sys_get_curr_temp(struct thermal_zone_device *tzd,
-				unsigned long *temp)
+				int *temp)
 {
 	u32 out;
 	int ret;
diff --git a/drivers/thermal/intel_soc_dts_iosf.c b/drivers/thermal/int=
el_soc_dts_iosf.c
index 42e4b6a..5841d1d 100644
--- a/drivers/thermal/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel_soc_dts_iosf.c
@@ -80,7 +80,7 @@ err_ret:
 }
=20
 static int sys_get_trip_temp(struct thermal_zone_device *tzd, int trip=
,
-			     unsigned long *temp)
+			     int *temp)
 {
 	int status;
 	u32 out;
@@ -106,7 +106,7 @@ static int sys_get_trip_temp(struct thermal_zone_de=
vice *tzd, int trip,
 }
=20
 static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
-			    int thres_index, unsigned long temp,
+			    int thres_index, int temp,
 			    enum thermal_trip_type trip_type)
 {
 	int status;
@@ -196,7 +196,7 @@ err_restore_ptps:
 }
=20
 static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip=
,
-			     unsigned long temp)
+			     int temp)
 {
 	struct intel_soc_dts_sensor_entry *dts =3D tzd->devdata;
 	struct intel_soc_dts_sensors *sensors =3D dts->sensors;
@@ -226,7 +226,7 @@ static int sys_get_trip_type(struct thermal_zone_de=
vice *tzd,
 }
=20
 static int sys_get_curr_temp(struct thermal_zone_device *tzd,
-			     unsigned long *temp)
+			     int *temp)
 {
 	int status;
 	u32 out;
diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkw=
ood_thermal.c
index 11041fe..8922366 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -33,7 +33,7 @@ struct kirkwood_thermal_priv {
 };
=20
 static int kirkwood_get_temp(struct thermal_zone_device *thermal,
-			  unsigned long *temp)
+			  int *temp)
 {
 	unsigned long reg;
 	struct kirkwood_thermal_priv *priv =3D thermal->devdata;
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.=
c
index b295b2b..42b7d42 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -91,7 +91,7 @@ struct __thermal_zone {
 /***   DT thermal zone device callbacks   ***/
=20
 static int of_thermal_get_temp(struct thermal_zone_device *tz,
-			       unsigned long *temp)
+			       int *temp)
 {
 	struct __thermal_zone *data =3D tz->devdata;
=20
@@ -177,7 +177,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
  * Return: zero on success, error code otherwise
  */
 static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
-				    unsigned long temp)
+				    int temp)
 {
 	struct __thermal_zone *data =3D tz->devdata;
=20
@@ -311,7 +311,7 @@ static int of_thermal_get_trip_type(struct thermal_=
zone_device *tz, int trip,
 }
=20
 static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, in=
t trip,
-				    unsigned long *temp)
+				    int *temp)
 {
 	struct __thermal_zone *data =3D tz->devdata;
=20
@@ -324,7 +324,7 @@ static int of_thermal_get_trip_temp(struct thermal_=
zone_device *tz, int trip,
 }
=20
 static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, in=
t trip,
-				    unsigned long temp)
+				    int temp)
 {
 	struct __thermal_zone *data =3D tz->devdata;
=20
@@ -338,7 +338,7 @@ static int of_thermal_set_trip_temp(struct thermal_=
zone_device *tz, int trip,
 }
=20
 static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, in=
t trip,
-				    unsigned long *hyst)
+				    int *hyst)
 {
 	struct __thermal_zone *data =3D tz->devdata;
=20
@@ -351,7 +351,7 @@ static int of_thermal_get_trip_hyst(struct thermal_=
zone_device *tz, int trip,
 }
=20
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, in=
t trip,
-				    unsigned long hyst)
+				    int hyst)
 {
 	struct __thermal_zone *data =3D tz->devdata;
=20
@@ -365,7 +365,7 @@ static int of_thermal_set_trip_hyst(struct thermal_=
zone_device *tz, int trip,
 }
=20
 static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
-				    unsigned long *temp)
+				    int *temp)
 {
 	struct __thermal_zone *data =3D tz->devdata;
 	int i;
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_=
allocator.c
index 4672250..045aea59 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -92,8 +92,8 @@ struct power_allocator_params {
  * Return: The power budget for the next period.
  */
 static u32 pid_controller(struct thermal_zone_device *tz,
-			  unsigned long current_temp,
-			  unsigned long control_temp,
+			  int current_temp,
+			  int control_temp,
 			  u32 max_allocatable_power)
 {
 	s64 p, i, d, power_range;
@@ -102,7 +102,7 @@ static u32 pid_controller(struct thermal_zone_devic=
e *tz,
=20
 	max_power_frac =3D int_to_frac(max_allocatable_power);
=20
-	err =3D ((s32)control_temp - (s32)current_temp);
+	err =3D control_temp - current_temp;
 	err =3D int_to_frac(err);
=20
 	/* Calculate the proportional term */
@@ -223,8 +223,8 @@ static void divvy_up_power(u32 *req_power, u32 *max=
_power, int num_actors,
 }
=20
 static int allocate_power(struct thermal_zone_device *tz,
-			  unsigned long current_temp,
-			  unsigned long control_temp)
+			  int current_temp,
+			  int control_temp)
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params =3D tz->governor_data;
@@ -326,7 +326,7 @@ static int allocate_power(struct thermal_zone_devic=
e *tz,
 				      granted_power, total_granted_power,
 				      num_actors, power_range,
 				      max_allocatable_power, current_temp,
-				      (s32)control_temp - (s32)current_temp);
+				      control_temp - current_temp);
=20
 	devm_kfree(&tz->device, req_power);
 unlock:
@@ -411,7 +411,7 @@ static int power_allocator_bind(struct thermal_zone=
_device *tz)
 {
 	int ret;
 	struct power_allocator_params *params;
-	unsigned long switch_on_temp, control_temp;
+	int switch_on_temp, control_temp;
 	u32 temperature_threshold;
=20
 	if (!tz->tzp || !tz->tzp->sustainable_power) {
@@ -476,7 +476,7 @@ static void power_allocator_unbind(struct thermal_z=
one_device *tz)
 static int power_allocator_throttle(struct thermal_zone_device *tz, in=
t trip)
 {
 	int ret;
-	unsigned long switch_on_temp, control_temp, current_temp;
+	int switch_on_temp, control_temp, current_temp;
 	struct power_allocator_params *params =3D tz->governor_data;
=20
 	/*
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/q=
com-spmi-temp-alarm.c
index c8d27b8..b677aad 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -117,7 +117,7 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_t=
m_chip *chip)
 	return 0;
 }
=20
-static int qpnp_tm_get_temp(void *data, long *temp)
+static int qpnp_tm_get_temp(void *data, int *temp)
 {
 	struct qpnp_tm_chip *chip =3D data;
 	int ret, mili_celsius;
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_ther=
mal.c
index fe4e767..5d4ae7d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -200,8 +200,7 @@ err_out_unlock:
 	return ret;
 }
=20
-static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
-				 unsigned long *temp)
+static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int=
 *temp)
 {
 	struct rcar_thermal_priv *priv =3D rcar_zone_to_priv(zone);
=20
@@ -235,7 +234,7 @@ static int rcar_thermal_get_trip_type(struct therma=
l_zone_device *zone,
 }
=20
 static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone=
,
-				      int trip, unsigned long *temp)
+				      int trip, int *temp)
 {
 	struct rcar_thermal_priv *priv =3D rcar_zone_to_priv(zone);
 	struct device *dev =3D rcar_priv_to_dev(priv);
@@ -299,7 +298,7 @@ static void _rcar_thermal_irq_ctrl(struct rcar_ther=
mal_priv *priv, int enable)
 static void rcar_thermal_work(struct work_struct *work)
 {
 	struct rcar_thermal_priv *priv;
-	unsigned long cctemp, nctemp;
+	int cctemp, nctemp;
=20
 	priv =3D container_of(work, struct rcar_thermal_priv, work.work);
=20
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockc=
hip_thermal.c
index cd8f5f93..c89ffb2 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -64,7 +64,7 @@ struct rockchip_tsadc_chip {
 	void (*control)(void __iomem *reg, bool on);
=20
 	/* Per-sensor methods */
-	int (*get_temp)(int chn, void __iomem *reg, long *temp);
+	int (*get_temp)(int chn, void __iomem *reg, int *temp);
 	void (*set_tshut_temp)(int chn, void __iomem *reg, long temp);
 	void (*set_tshut_mode)(int chn, void __iomem *reg, enum tshut_mode m)=
;
 };
@@ -191,7 +191,7 @@ static u32 rk_tsadcv2_temp_to_code(long temp)
 	return 0;
 }
=20
-static long rk_tsadcv2_code_to_temp(u32 code)
+static int rk_tsadcv2_code_to_temp(u32 code)
 {
 	unsigned int low =3D 0;
 	unsigned int high =3D ARRAY_SIZE(v2_code_table) - 1;
@@ -277,7 +277,7 @@ static void rk_tsadcv2_control(void __iomem *regs, =
bool enable)
 	writel_relaxed(val, regs + TSADCV2_AUTO_CON);
 }
=20
-static int rk_tsadcv2_get_temp(int chn, void __iomem *regs, long *temp=
)
+static int rk_tsadcv2_get_temp(int chn, void __iomem *regs, int *temp)
 {
 	u32 val;
=20
@@ -366,7 +366,7 @@ static irqreturn_t rockchip_thermal_alarm_irq_threa=
d(int irq, void *dev)
 	return IRQ_HANDLED;
 }
=20
-static int rockchip_thermal_get_temp(void *_sensor, long *out_temp)
+static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
 {
 	struct rockchip_thermal_sensor *sensor =3D _sensor;
 	struct rockchip_thermal_data *thermal =3D sensor->thermal;
@@ -374,7 +374,7 @@ static int rockchip_thermal_get_temp(void *_sensor,=
 long *out_temp)
 	int retval;
=20
 	retval =3D tsadc->get_temp(sensor->id, thermal->regs, out_temp);
-	dev_dbg(&thermal->pdev->dev, "sensor %d - temp: %ld, retval: %d\n",
+	dev_dbg(&thermal->pdev->dev, "sensor %d - temp: %d, retval: %d\n",
 		sensor->id, *out_temp, retval);
=20
 	return retval;
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/sam=
sung/exynos_tmu.c
index 531f4b17..9ec29a3 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -207,8 +207,7 @@ struct exynos_tmu_data {
 	int (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
 	int (*tmu_read)(struct exynos_tmu_data *data);
-	void (*tmu_set_emulation)(struct exynos_tmu_data *data,
-				  unsigned long temp);
+	void (*tmu_set_emulation)(struct exynos_tmu_data *data, int temp);
 	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
 };
=20
@@ -216,7 +215,7 @@ static void exynos_report_trigger(struct exynos_tmu=
_data *p)
 {
 	char data[10], *envp[] =3D { data, NULL };
 	struct thermal_zone_device *tz =3D p->tzd;
-	unsigned long temp;
+	int temp;
 	unsigned int i;
=20
 	if (!tz) {
@@ -517,7 +516,7 @@ static int exynos5433_tmu_initialize(struct platfor=
m_device *pdev)
 	struct thermal_zone_device *tz =3D data->tzd;
 	unsigned int status, trim_info;
 	unsigned int rising_threshold =3D 0, falling_threshold =3D 0;
-	unsigned long temp, temp_hist;
+	int temp, temp_hist;
 	int ret =3D 0, threshold_code, i, sensor_id, cal_type;
=20
 	status =3D readb(data->base + EXYNOS_TMU_REG_STATUS);
@@ -610,7 +609,7 @@ static int exynos5440_tmu_initialize(struct platfor=
m_device *pdev)
 	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
 	unsigned int trim_info =3D 0, con, rising_threshold;
 	int ret =3D 0, threshold_code;
-	unsigned long crit_temp =3D 0;
+	int crit_temp =3D 0;
=20
 	/*
 	 * For exynos5440 soc triminfo value is swapped between TMU0 and
@@ -663,7 +662,7 @@ static int exynos7_tmu_initialize(struct platform_d=
evice *pdev)
 	unsigned int status, trim_info;
 	unsigned int rising_threshold =3D 0, falling_threshold =3D 0;
 	int ret =3D 0, threshold_code, i;
-	unsigned long temp, temp_hist;
+	int temp, temp_hist;
 	unsigned int reg_off, bit_off;
=20
 	status =3D readb(data->base + EXYNOS_TMU_REG_STATUS);
@@ -876,7 +875,7 @@ static void exynos7_tmu_control(struct platform_dev=
ice *pdev, bool on)
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
=20
-static int exynos_get_temp(void *p, long *temp)
+static int exynos_get_temp(void *p, int *temp)
 {
 	struct exynos_tmu_data *data =3D p;
=20
@@ -896,7 +895,7 @@ static int exynos_get_temp(void *p, long *temp)
=20
 #ifdef CONFIG_THERMAL_EMULATION
 static u32 get_emul_con_reg(struct exynos_tmu_data *data, unsigned int=
 val,
-			    unsigned long temp)
+			    int temp)
 {
 	if (temp) {
 		temp /=3D MCELSIUS;
@@ -926,7 +925,7 @@ static u32 get_emul_con_reg(struct exynos_tmu_data =
*data, unsigned int val,
 }
=20
 static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
-					 unsigned long temp)
+					 int temp)
 {
 	unsigned int val;
 	u32 emul_con;
@@ -946,7 +945,7 @@ static void exynos4412_tmu_set_emulation(struct exy=
nos_tmu_data *data,
 }
=20
 static void exynos5440_tmu_set_emulation(struct exynos_tmu_data *data,
-					 unsigned long temp)
+					 int temp)
 {
 	unsigned int val;
=20
@@ -955,7 +954,7 @@ static void exynos5440_tmu_set_emulation(struct exy=
nos_tmu_data *data,
 	writel(val, data->base + EXYNOS5440_TMU_S0_7_DEBUG);
 }
=20
-static int exynos_tmu_set_emulation(void *drv_data, unsigned long temp=
)
+static int exynos_tmu_set_emulation(void *drv_data, int temp)
 {
 	struct exynos_tmu_data *data =3D drv_data;
 	int ret =3D -EINVAL;
@@ -978,7 +977,7 @@ out:
 #else
 #define exynos4412_tmu_set_emulation NULL
 #define exynos5440_tmu_set_emulation NULL
-static int exynos_tmu_set_emulation(void *drv_data,	unsigned long temp=
)
+static int exynos_tmu_set_emulation(void *drv_data, int temp)
 	{ return -EINVAL; }
 #endif /* CONFIG_THERMAL_EMULATION */
=20
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_th=
ermal.c
index bddb717..534dd91 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -38,7 +38,7 @@ struct spear_thermal_dev {
 };
=20
 static inline int thermal_get_temp(struct thermal_zone_device *thermal=
,
-				unsigned long *temp)
+				int *temp)
 {
 	struct spear_thermal_dev *stdev =3D thermal->devdata;
=20
diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_th=
ermal.c
index 76c515d..44cbba9 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -111,8 +111,7 @@ static int st_thermal_calibration(struct st_thermal=
_sensor *sensor)
 }
=20
 /* Callback to get temperature from HW*/
-static int st_thermal_get_temp(struct thermal_zone_device *th,
-		unsigned long *temperature)
+static int st_thermal_get_temp(struct thermal_zone_device *th, int *te=
mperature)
 {
 	struct st_thermal_sensor *sensor =3D th->devdata;
 	struct device *dev =3D sensor->dev;
@@ -159,7 +158,7 @@ static int st_thermal_get_trip_type(struct thermal_=
zone_device *th,
 }
=20
 static int st_thermal_get_trip_temp(struct thermal_zone_device *th,
-				    int trip, unsigned long *temp)
+				    int trip, int *temp)
 {
 	struct st_thermal_sensor *sensor =3D th->devdata;
 	struct device *dev =3D sensor->dev;
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 5a0f12d..2f9f708 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -113,7 +113,7 @@ static void update_passive_instance(struct thermal_=
zone_device *tz,
=20
 static void thermal_zone_trip_update(struct thermal_zone_device *tz, i=
nt trip)
 {
-	long trip_temp;
+	int trip_temp;
 	enum thermal_trip_type trip_type;
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
@@ -135,7 +135,7 @@ static void thermal_zone_trip_update(struct thermal=
_zone_device *tz, int trip)
 		trace_thermal_zone_trip(tz, trip, trip_type);
 	}
=20
-	dev_dbg(&tz->device, "Trip%d[type=3D%d,temp=3D%ld]:trend=3D%d,throttl=
e=3D%d\n",
+	dev_dbg(&tz->device, "Trip%d[type=3D%d,temp=3D%d]:trend=3D%d,throttle=
=3D%d\n",
 				trip, trip_type, trip_temp, trend, throttle);
=20
 	mutex_lock(&tz->lock);
diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_s=
octherm.c
index 9197fc0..74ea576 100644
--- a/drivers/thermal/tegra_soctherm.c
+++ b/drivers/thermal/tegra_soctherm.c
@@ -293,7 +293,7 @@ static int enable_tsensor(struct tegra_soctherm *te=
gra,
  * H denotes an addition of 0.5 Celsius and N denotes negation
  * of the final value.
  */
-static long translate_temp(u16 val)
+static int translate_temp(u16 val)
 {
 	long t;
=20
@@ -306,7 +306,7 @@ static long translate_temp(u16 val)
 	return t;
 }
=20
-static int tegra_thermctl_get_temp(void *data, long *out_temp)
+static int tegra_thermctl_get_temp(void *data, int *out_temp)
 {
 	struct tegra_thermctl_zone *zone =3D data;
 	u32 val;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
index 04659bf..371a543 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -426,7 +426,7 @@ static void handle_non_critical_trips(struct therma=
l_zone_device *tz,
 static void handle_critical_trips(struct thermal_zone_device *tz,
 				int trip, enum thermal_trip_type trip_type)
 {
-	long trip_temp;
+	int trip_temp;
=20
 	tz->ops->get_trip_temp(tz, trip, &trip_temp);
=20
@@ -474,12 +474,12 @@ static void handle_thermal_trip(struct thermal_zo=
ne_device *tz, int trip)
  *
  * Return: On success returns 0, an error code otherwise
  */
-int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned lon=
g *temp)
+int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret =3D -EINVAL;
 #ifdef CONFIG_THERMAL_EMULATION
 	int count;
-	unsigned long crit_temp =3D -1UL;
+	int crit_temp =3D INT_MAX;
 	enum thermal_trip_type type;
 #endif
=20
@@ -516,8 +516,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
=20
 static void update_temperature(struct thermal_zone_device *tz)
 {
-	long temp;
-	int ret;
+	int temp, ret;
=20
 	ret =3D thermal_zone_get_temp(tz, &temp);
 	if (ret) {
@@ -577,15 +576,14 @@ static ssize_t
 temp_show(struct device *dev, struct device_attribute *attr, char *buf=
)
 {
 	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
-	long temperature;
-	int ret;
+	int temperature, ret;
=20
 	ret =3D thermal_zone_get_temp(tz, &temperature);
=20
 	if (ret)
 		return ret;
=20
-	return sprintf(buf, "%ld\n", temperature);
+	return sprintf(buf, "%d\n", temperature);
 }
=20
 static ssize_t
@@ -689,7 +687,7 @@ trip_point_temp_show(struct device *dev, struct dev=
ice_attribute *attr,
 {
 	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
 	int trip, ret;
-	long temperature;
+	int temperature;
=20
 	if (!tz->ops->get_trip_temp)
 		return -EPERM;
@@ -702,7 +700,7 @@ trip_point_temp_show(struct device *dev, struct dev=
ice_attribute *attr,
 	if (ret)
 		return ret;
=20
-	return sprintf(buf, "%ld\n", temperature);
+	return sprintf(buf, "%d\n", temperature);
 }
=20
 static ssize_t
@@ -711,7 +709,7 @@ trip_point_hyst_store(struct device *dev, struct de=
vice_attribute *attr,
 {
 	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
 	int trip, ret;
-	unsigned long temperature;
+	int temperature;
=20
 	if (!tz->ops->set_trip_hyst)
 		return -EPERM;
@@ -719,7 +717,7 @@ trip_point_hyst_store(struct device *dev, struct de=
vice_attribute *attr,
 	if (!sscanf(attr->attr.name, "trip_point_%d_hyst", &trip))
 		return -EINVAL;
=20
-	if (kstrtoul(buf, 10, &temperature))
+	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
=20
 	/*
@@ -738,7 +736,7 @@ trip_point_hyst_show(struct device *dev, struct dev=
ice_attribute *attr,
 {
 	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
 	int trip, ret;
-	unsigned long temperature;
+	int temperature;
=20
 	if (!tz->ops->get_trip_hyst)
 		return -EPERM;
@@ -748,7 +746,7 @@ trip_point_hyst_show(struct device *dev, struct dev=
ice_attribute *attr,
=20
 	ret =3D tz->ops->get_trip_hyst(tz, trip, &temperature);
=20
-	return ret ? ret : sprintf(buf, "%ld\n", temperature);
+	return ret ? ret : sprintf(buf, "%d\n", temperature);
 }
=20
 static ssize_t
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_=
hwmon.c
index 1967bee..06fd2ed9 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -69,7 +69,7 @@ static DEVICE_ATTR(name, 0444, name_show, NULL);
 static ssize_t
 temp_input_show(struct device *dev, struct device_attribute *attr, cha=
r *buf)
 {
-	long temperature;
+	int temperature;
 	int ret;
 	struct thermal_hwmon_attr *hwmon_attr
 			=3D container_of(attr, struct thermal_hwmon_attr, attr);
@@ -83,7 +83,7 @@ temp_input_show(struct device *dev, struct device_att=
ribute *attr, char *buf)
 	if (ret)
 		return ret;
=20
-	return sprintf(buf, "%ld\n", temperature);
+	return sprintf(buf, "%d\n", temperature);
 }
=20
 static ssize_t
@@ -95,14 +95,14 @@ temp_crit_show(struct device *dev, struct device_at=
tribute *attr, char *buf)
 			=3D container_of(hwmon_attr, struct thermal_hwmon_temp,
 				       temp_crit);
 	struct thermal_zone_device *tz =3D temp->tz;
-	long temperature;
+	int temperature;
 	int ret;
=20
 	ret =3D tz->ops->get_trip_temp(tz, 0, &temperature);
 	if (ret)
 		return ret;
=20
-	return sprintf(buf, "%ld\n", temperature);
+	return sprintf(buf, "%d\n", temperature);
 }
=20
=20
@@ -142,7 +142,7 @@ thermal_hwmon_lookup_temp(const struct thermal_hwmo=
n_device *hwmon,
=20
 static bool thermal_zone_crit_temp_valid(struct thermal_zone_device *t=
z)
 {
-	unsigned long temp;
+	int temp;
 	return tz->ops->get_crit_temp && !tz->ops->get_crit_temp(tz, &temp);
 }
=20
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drive=
rs/thermal/ti-soc-thermal/ti-thermal-common.c
index c7c5b37..b213a12 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -76,14 +76,14 @@ static inline int ti_thermal_hotspot_temperature(in=
t t, int s, int c)
=20
 /* thermal zone ops */
 /* Get temperature callback function for thermal zone */
-static inline int __ti_thermal_get_temp(void *devdata, long *temp)
+static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 {
 	struct thermal_zone_device *pcb_tz =3D NULL;
 	struct ti_thermal_data *data =3D devdata;
 	struct ti_bandgap *bgp;
 	const struct ti_temp_sensor *s;
 	int ret, tmp, slope, constant;
-	unsigned long pcb_temp;
+	int pcb_temp;
=20
 	if (!data)
 		return 0;
@@ -119,7 +119,7 @@ static inline int __ti_thermal_get_temp(void *devda=
ta, long *temp)
 }
=20
 static inline int ti_thermal_get_temp(struct thermal_zone_device *ther=
mal,
-				      unsigned long *temp)
+				      int *temp)
 {
 	struct ti_thermal_data *data =3D thermal->devdata;
=20
@@ -229,7 +229,7 @@ static int ti_thermal_get_trip_type(struct thermal_=
zone_device *thermal,
=20
 /* Get trip temperature callback functions for thermal zone */
 static int ti_thermal_get_trip_temp(struct thermal_zone_device *therma=
l,
-				    int trip, unsigned long *temp)
+				    int trip, int *temp)
 {
 	if (!ti_thermal_is_valid_trip(trip))
 		return -EINVAL;
@@ -280,7 +280,7 @@ static int ti_thermal_get_trend(struct thermal_zone=
_device *thermal,
=20
 /* Get critical temperature callback functions for thermal zone */
 static int ti_thermal_get_crit_temp(struct thermal_zone_device *therma=
l,
-				    unsigned long *temp)
+				    int *temp)
 {
 	/* shutdown zone */
 	return ti_thermal_get_trip_temp(thermal, OMAP_TRIP_NUMBER - 1, temp);
diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x=
86_pkg_temp_thermal.c
index 50d1d2c..7fc919f 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -164,7 +164,7 @@ err_ret:
 	return err;
 }
=20
-static int sys_get_curr_temp(struct thermal_zone_device *tzd, unsigned=
 long *temp)
+static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *tem=
p)
 {
 	u32 eax, edx;
 	struct phy_dev_entry *phy_dev_entry;
@@ -175,7 +175,7 @@ static int sys_get_curr_temp(struct thermal_zone_de=
vice *tzd, unsigned long *tem
 	if (eax & 0x80000000) {
 		*temp =3D phy_dev_entry->tj_max -
 				((eax >> 16) & 0x7f) * 1000;
-		pr_debug("sys_get_curr_temp %ld\n", *temp);
+		pr_debug("sys_get_curr_temp %d\n", *temp);
 		return 0;
 	}
=20
@@ -183,7 +183,7 @@ static int sys_get_curr_temp(struct thermal_zone_de=
vice *tzd, unsigned long *tem
 }
=20
 static int sys_get_trip_temp(struct thermal_zone_device *tzd,
-		int trip, unsigned long *temp)
+		int trip, int *temp)
 {
 	u32 eax, edx;
 	struct phy_dev_entry *phy_dev_entry;
@@ -214,13 +214,13 @@ static int sys_get_trip_temp(struct thermal_zone_=
device *tzd,
 		*temp =3D phy_dev_entry->tj_max - thres_reg_value * 1000;
 	else
 		*temp =3D 0;
-	pr_debug("sys_get_trip_temp %ld\n", *temp);
+	pr_debug("sys_get_trip_temp %d\n", *temp);
=20
 	return 0;
 }
=20
 static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip=
,
-							unsigned long temp)
+							int temp)
 {
 	u32 l, h;
 	struct phy_dev_entry *phy_dev_entry;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 037e9df..17292fe 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -92,23 +92,19 @@ struct thermal_zone_device_ops {
 		     struct thermal_cooling_device *);
 	int (*unbind) (struct thermal_zone_device *,
 		       struct thermal_cooling_device *);
-	int (*get_temp) (struct thermal_zone_device *, unsigned long *);
+	int (*get_temp) (struct thermal_zone_device *, int *);
 	int (*get_mode) (struct thermal_zone_device *,
 			 enum thermal_device_mode *);
 	int (*set_mode) (struct thermal_zone_device *,
 		enum thermal_device_mode);
 	int (*get_trip_type) (struct thermal_zone_device *, int,
 		enum thermal_trip_type *);
-	int (*get_trip_temp) (struct thermal_zone_device *, int,
-			      unsigned long *);
-	int (*set_trip_temp) (struct thermal_zone_device *, int,
-			      unsigned long);
-	int (*get_trip_hyst) (struct thermal_zone_device *, int,
-			      unsigned long *);
-	int (*set_trip_hyst) (struct thermal_zone_device *, int,
-			      unsigned long);
-	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
-	int (*set_emul_temp) (struct thermal_zone_device *, unsigned long);
+	int (*get_trip_temp) (struct thermal_zone_device *, int, int *);
+	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
+	int (*get_trip_hyst) (struct thermal_zone_device *, int, int *);
+	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
+	int (*get_crit_temp) (struct thermal_zone_device *, int *);
+	int (*set_emul_temp) (struct thermal_zone_device *, int);
 	int (*get_trend) (struct thermal_zone_device *, int,
 			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
@@ -332,9 +328,9 @@ struct thermal_genl_event {
  *		   temperature.
  */
 struct thermal_zone_of_device_ops {
-	int (*get_temp)(void *, long *);
+	int (*get_temp)(void *, int *);
 	int (*get_trend)(void *, long *);
-	int (*set_emul_temp)(void *, unsigned long);
+	int (*set_emul_temp)(void *, int);
 };
=20
 /**
@@ -406,7 +402,7 @@ thermal_of_cooling_device_register(struct device_no=
de *np, char *, void *,
 				   const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *=
);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *=
name);
-int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned lon=
g *temp);
+int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
=20
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_devi=
ce *,
@@ -457,7 +453,7 @@ static inline struct thermal_zone_device *thermal_z=
one_get_zone_by_name(
 		const char *name)
 { return ERR_PTR(-ENODEV); }
 static inline int thermal_zone_get_temp(
-		struct thermal_zone_device *tz, unsigned long *temp)
+		struct thermal_zone_device *tz, int *temp)
 { return -ENODEV; }
 static inline int get_tz_trend(struct thermal_zone_device *tz, int tri=
p)
 { return -ENODEV; }
diff --git a/include/trace/events/thermal_power_allocator.h b/include/t=
race/events/thermal_power_allocator.h
index 12e1321..5afae8f 100644
--- a/include/trace/events/thermal_power_allocator.h
+++ b/include/trace/events/thermal_power_allocator.h
@@ -11,7 +11,7 @@ TRACE_EVENT(thermal_power_allocator,
 		 u32 total_req_power, u32 *granted_power,
 		 u32 total_granted_power, size_t num_actors,
 		 u32 power_range, u32 max_allocatable_power,
-		 unsigned long current_temp, s32 delta_temp),
+		 int current_temp, s32 delta_temp),
 	TP_ARGS(tz, req_power, total_req_power, granted_power,
 		total_granted_power, num_actors, power_range,
 		max_allocatable_power, current_temp, delta_temp),
@@ -24,7 +24,7 @@ TRACE_EVENT(thermal_power_allocator,
 		__field(size_t,        num_actors               )
 		__field(u32,           power_range              )
 		__field(u32,           max_allocatable_power    )
-		__field(unsigned long, current_temp             )
+		__field(int,           current_temp             )
 		__field(s32,           delta_temp               )
 	),
 	TP_fast_assign(
@@ -42,7 +42,7 @@ TRACE_EVENT(thermal_power_allocator,
 		__entry->delta_temp =3D delta_temp;
 	),
=20
-	TP_printk("thermal_zone_id=3D%d req_power=3D{%s} total_req_power=3D%u=
 granted_power=3D{%s} total_granted_power=3D%u power_range=3D%u max_all=
ocatable_power=3D%u current_temperature=3D%lu delta_temperature=3D%d",
+	TP_printk("thermal_zone_id=3D%d req_power=3D{%s} total_req_power=3D%u=
 granted_power=3D{%s} total_granted_power=3D%u power_range=3D%u max_all=
ocatable_power=3D%u current_temperature=3D%d delta_temperature=3D%d",
 		__entry->tz_id,
 		__print_array(__get_dynamic_array(req_power),
                               __entry->num_actors, 4),
--=20
2.1.4

