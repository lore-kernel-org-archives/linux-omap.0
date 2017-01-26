From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] regulator: constify regulator_ops structures
Date: Thu, 26 Jan 2017 16:17:48 +0530
Message-ID: <1485427668-2816-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, michael.hennerich@analog.com, wens@csie.org, cw00.choi@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com, javier@osg.samsung.com, tony@atomide.com, sbkim73@samsung.com, liviu.dudau@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Declare regulator_ops structures as const as they are only stored in the
ops field of a regulator_desc structure. This field is of type const, so
regulator_ops structures having this property can be made const too.

File size details before and after patching.
First line of every .o file shows the file size before patching
and second line shows the size after patching.

   text    data     bss     dec     hex filename

   3258	   5488	      0	   8746	   222a	drivers/regulator/88pm8607.o
   3770	   4976	      0	   8746	   222a	drivers/regulator/88pm8607.o

    873	   1424	      0	   2297	    8f9	regulator/aat2870-regulator.o
   1129	   1168	      0	   2297	    8f9	regulator/aat2870-regulator.o

   1950	    464	      0	   2414	    96e	regulator/act8945a-regulator.o
   2206	    192	      0	   2398	    95e	regulator/act8945a-regulator.o

   1352	    722	      0	   2074	    81a	drivers/regulator/arizona-ldo1.
   1864	    194	      0	   2058	    80a	drivers/regulator/arizona-ldo1.o

   1488	    466	      0	   1954	    7a2	drivers/regulator/arizona-micsupp.o
   1744	    194	      0	   1938	    792	drivers/regulator/arizona-micsupp.o

   1095	   3666	      0	   4761	   1299	regulator/as3711-regulator.o
   1879	   2898	      0	   4777	   12a9	regulator/as3711-regulator.o

  15272	   1233	      0	  16505	   4079	regulator/axp20x-regulator.o
  16312	    193	      0	  16505	   4079	regulator/axp20x-regulator.o

   1539	   2272	      0	   3811	    ee3	regulator/bcm590xx-regulator.o
   2307	   1504	      0	   3811	    ee3	regulator/bcm590xx-regulator.o

   1718	    720	      0	   2438	    986	drivers/regulator/gpio-regulator.o
   2230	    192	      0	   2422	    976	drivers/regulator/gpio-regulator.o

    713	   3122	      0	   3835	    efb	regulator/hi655x-regulator.o
   1225	   2610	      0	   3835	    efb	regulator/hi655x-regulator.o

   2285	    978	      0	   3263	    cbf	regulator/max14577-regulator.o
   3053	    194	      0	   3247	    caf	regulator/max14577-regulator.o

   3304	   3730	      0	   7034	   1b7a	regulator/max77620-regulator.o
   3568	   3458	      0	   7026	   1b72	regulator/max77620-regulator.o

   9270	   1233	      0	  10503	   2907	regulator/max77686-regulator.o
  10294	    193	      0	  10487	   28f7	regulator/max77686-regulator.o

   2214	    722	      0	   2936	    b78	regulator/max77693-regulator.o
   2470	    466	      0	   2936	    b78	regulator/max77693-regulator.o

  11351	   1554	      0	  12905	   3269	regulator/max77802-regulator.o
  12631	    274	      0	  12905	   3269	regulator/max77802-regulator.o

   1182	   8241	    256	   9679	   25cf	regulator/max8907-regulator.o
   2462	   7217	      0	   9679	   25cf	regulator/max8907-regulator.o

   1090	   6256	      0	   7346	   1cb2	regulator/max8925-regulator.o
   1602	   5728	      0	   7330	   1ca2	regulator/max8925-regulator.o

   5514	    464	      0	   5978	   175a	drivers/regulator/pcap-regulator.o
   5770	    192	      0	   5962	   174a	drivers/regulator/pcap-regulator.o

   2746	    464	      0	   3210	    c8a	regulator/pcf50633-regulator.o
   3002	    192	      0	   3194	    c7a	regulator/pcf50633-regulator.o

    978	   3824	      0	   4802	   12c2	regulator/rc5t583-regulator.o
   1234	   3568	      0	   4802	   12c2 regulator/rc5t583-regulator.o

    365	   5392	      0	   5757	   167d	regulator/rn5t618-regulator.o
    621	   5136	      0	   5757	   167d	regulator/rn5t618-regulator.o

   9487	    721	      0	  10208	   27e0	drivers/regulator/s2mpa01.o
   9999	    193	      0	  10192	   27d0	drivers/regulator/s2mpa01.o

  47697	   2002	      0	  49699	   c223	drivers/regulator/s2mps11.o
  49489	    194	      0	  49683	   c213	drivers/regulator/s2mps11.o

   5602	   9010	      0	  14612	   3914	drivers/regulator/s5m8767.o
   6114	   8498	      0	  14612	   3914	drivers/regulator/s5m8767.o

    500	    464	      0	    964	    3c4	regulator/sky81452-regulator.o
    756	    192	      0	    948	    3b4	regulator/sky81452-regulator.o

    571	    464	      0	   1035	    40b	regulator/tps6105x-regulator.o
    827	    192	      0	   1019	    3fb	regulator/tps6105x-regulator.o

   2298	    624	      0	   2922	    b6a regulator/tps6507x-regulator.o
   2554	    368	      0	   2922	    b6a	regulator/tps6507x-regulator.o

    611	   3760	      0	   4371	   1113	regulator/tps65086-regulator.o
   1123	   3224	      0	   4347	   10fb	regulator/tps65086-regulator.o

   3444	    432	      0	   3876	    f24	regulator/tps6524x-regulator.o
   3700	    168	      0	   3868	    f1c	regulator/tps6524x-regulator.o

   1482	   7024	    256	   8762	   223a	regulator/tps6586x-regulator.o
   2506	   6240	      0	   8746	   222a	regulator/tps6586x-regulator.o

Size details after cross compiling for arm architecture.

  13700	    612	      0	  14312	   37e8	regulator/twl6030-regulator.o
  14212	    100	      0	  14312	   37e8	regulator/twl6030-regulator.o

  10032	    484	      0	  10516	   2914	drivers/regulator/twl-regulator.o
  10416	    100	      0	  10516	   2914	drivers/regulator/twl-regulator.o

    864	    356	      0	   1220	    4c4	regulator/vexpress-regulator.o
   1120	    100	      0	   1220	    4c4	regulator/vexpress-regulator.o

   5004	   4236	      0	   9240	   2418	regulator/tps80031-regulator.o
   5392	   3852	      0	   9244	   241c	regulator/tps80031-regulator.o

   6395	   1924	      0	   8319	   207f	regulator/tps65910-regulator.o
   7035	   1284	      0	   8319	   207f	regulator/tps65910-regulator.o

   2856	   2660	    256	   5772	   168c	regulator/tps65090-regulator.o
   2984	   2660	    128	   5772	   168c	regulator/tps65090-regulator.o

   4420	    252	      0	   4672	   1240	regulator/tps62360-regulator.o
   4544	    124	      0	   4668	   123c	regulator/tps62360-regulator.o

   880	    400	      0	   1280	    500	drivers/regulator/stw481x-vmmc.o
   1008	    272	      0	   1280	    500	drivers/regulator/stw481x-vmmc.o

   1156	   4580	      0	   5736	   1668	drivers/regulator/88pm800.o
   1412	   4324	      0	   5736	   1668	drivers/regulator/88pm800.o

  2816	    356	      0	   3172	    c64	regulator/anatop-regulator.o
   3072	    100	      0	   3172	    c64	regulator/anatop-regulator.o

   3252	    252	      0	   3504	    db0	drivers/regulator/fan53555.o
   3380	    124	      0	   3504	    db0	drivers/regulator/fan53555.o

   3320	   2100	      0	   5420	   152c	drivers/regulator/lp8755.o
   3448	   1972	      0	   5420	   152c	drivers/regulator/lp8755.o

  11472	   2120	      0	  13592	   3518	regulator/qcom_spmi-regulator.o
  12624	    968	      0	  13592	   3518	regulator/qcom_spmi-regulator.o

   2448	    252	      0	   2700	    a8c	regulator/tps51632-regulator.o
   2576	    124	      0	   2700	    a8c	regulator/tps51632-regulator.o

    2244   1756	    128	   4128	   1020	drivers/regulator/ltc3676.o
   2628	   1500	      0	   4128	   1020	drivers/regulator/ltc3676.o

   2940	    252	      0	   3192	    c78	drivers/regulator/max8952.o
   3068	    124	      0	   3192	    c78	drivers/regulator/max8952.o

   2672   1340	      0	   4012	    fac	regulator/pv88090-regulator.o
   2928	   1084	      0	   4012	    fac	regulator/pv88090-regulator.o

   3652	   1180	      0	   4832	   12e0	regulator/pv88080-regulator.o
   3908	    924	      0	   4832	   12e0 regulator/pv88080-regulator.o

   5228	    380	      0	   5608	   15e8	regulator/pv88060-regulator.o
   5484	    124	      0	   5608	   15e8	regulator/pv88060-regulator.o

   3572	   8672	      4	  12248	   2fd8	regulator/pfuze100-regulator.o
   4084	   8160	      4	  12248	   2fd8	regulator/pfuze100-regulator.o

   2444	    308	      0	   2752	    ac0	drivers/regulator/pbias-regulator.o
   2568	    180	      0	   2748	    abc	drivers/regulator/pbias-regulator.o

 10112	   3544	    132	  13788	   35dc	drivers/regulator/palmas-regulator.o
 11648	   2136	      4	  13788	   35dc	drivers/regulator/palmas-regulator.o

   2972	   2204	    128	   5304	   14b8	drivers/regulator/ltc3589.o
   3484   1820	      0	   5304	   14b8	drivers/regulator/ltc3589.o

  6180	    424	      0	   6604	   19cc	regulator/ti-abb-regulator.o
  6308	    296	      0	   6604	   19cc	regulator/ti-abb-regulator.o

  1239	    192	      0	   1431	    597	drivers/regulator/fixed.o
  1592	    100	    128	   1820	    71c	drivers/regulator/fixed.o

Size details after cross compiling for blackfin architecture.

   1080	    252	      0	   1332	    534	drivers/regulator/ad5398.o
   1208	    124	      0	   1332	    534	drivers/regulator/ad5398.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/regulator/88pm800.c             |  4 ++--
 drivers/regulator/88pm8607.c            |  4 ++--
 drivers/regulator/aat2870-regulator.c   |  2 +-
 drivers/regulator/act8945a-regulator.c  |  2 +-
 drivers/regulator/ad5398.c              |  2 +-
 drivers/regulator/anatop-regulator.c    |  4 ++--
 drivers/regulator/arizona-ldo1.c        |  4 ++--
 drivers/regulator/arizona-micsupp.c     |  2 +-
 drivers/regulator/as3711-regulator.c    |  6 +++---
 drivers/regulator/axp20x-regulator.c    |  8 ++++----
 drivers/regulator/bcm590xx-regulator.c  |  6 +++---
 drivers/regulator/fan53555.c            |  2 +-
 drivers/regulator/fixed.c               |  2 +-
 drivers/regulator/gpio-regulator.c      |  4 ++--
 drivers/regulator/hi655x-regulator.c    |  4 ++--
 drivers/regulator/lp8755.c              |  2 +-
 drivers/regulator/ltc3589.c             |  8 ++++----
 drivers/regulator/ltc3676.c             |  6 +++---
 drivers/regulator/max14577-regulator.c  |  6 +++---
 drivers/regulator/max77620-regulator.c  |  2 +-
 drivers/regulator/max77686-regulator.c  |  8 ++++----
 drivers/regulator/max77693-regulator.c  |  2 +-
 drivers/regulator/max77802-regulator.c  | 10 +++++-----
 drivers/regulator/max8907-regulator.c   | 10 +++++-----
 drivers/regulator/max8925-regulator.c   |  4 ++--
 drivers/regulator/max8952.c             |  2 +-
 drivers/regulator/palmas-regulator.c    | 24 ++++++++++++------------
 drivers/regulator/pbias-regulator.c     |  2 +-
 drivers/regulator/pcap-regulator.c      |  2 +-
 drivers/regulator/pcf50633-regulator.c  |  2 +-
 drivers/regulator/pfuze100-regulator.c  |  8 ++++----
 drivers/regulator/pv88060-regulator.c   |  4 ++--
 drivers/regulator/pv88080-regulator.c   |  4 ++--
 drivers/regulator/pv88090-regulator.c   |  4 ++--
 drivers/regulator/qcom_spmi-regulator.c | 18 +++++++++---------
 drivers/regulator/rc5t583-regulator.c   |  2 +-
 drivers/regulator/rn5t618-regulator.c   |  2 +-
 drivers/regulator/s2mpa01.c             |  4 ++--
 drivers/regulator/s2mps11.c             | 16 ++++++++--------
 drivers/regulator/s5m8767.c             |  4 ++--
 drivers/regulator/sky81452-regulator.c  |  2 +-
 drivers/regulator/stw481x-vmmc.c        |  2 +-
 drivers/regulator/ti-abb-regulator.c    |  2 +-
 drivers/regulator/tps51632-regulator.c  |  2 +-
 drivers/regulator/tps6105x-regulator.c  |  2 +-
 drivers/regulator/tps62360-regulator.c  |  2 +-
 drivers/regulator/tps6507x-regulator.c  |  2 +-
 drivers/regulator/tps65086-regulator.c  |  4 ++--
 drivers/regulator/tps65090-regulator.c  |  2 +-
 drivers/regulator/tps6524x-regulator.c  |  2 +-
 drivers/regulator/tps6586x-regulator.c  |  8 ++++----
 drivers/regulator/tps65910-regulator.c  | 10 +++++-----
 drivers/regulator/tps80031-regulator.c  |  6 +++---
 drivers/regulator/twl-regulator.c       |  6 +++---
 drivers/regulator/twl6030-regulator.c   |  8 ++++----
 drivers/regulator/vexpress-regulator.c  |  4 ++--
 56 files changed, 138 insertions(+), 138 deletions(-)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index a62a896..89bbd6e 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -180,7 +180,7 @@ static int pm800_get_current_limit(struct regulator_dev *rdev)
 	return info->max_ua;
 }
 
-static struct regulator_ops pm800_volt_range_ops = {
+static const struct regulator_ops pm800_volt_range_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
@@ -191,7 +191,7 @@ static struct regulator_ops pm800_volt_range_ops = {
 	.get_current_limit	= pm800_get_current_limit,
 };
 
-static struct regulator_ops pm800_volt_table_ops = {
+static const struct regulator_ops pm800_volt_table_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 	.map_voltage		= regulator_map_voltage_iterate,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index b100a63..fd86446 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -220,7 +220,7 @@ static int pm8607_list_voltage(struct regulator_dev *rdev, unsigned index)
 	return ret;
 }
 
-static struct regulator_ops pm8607_regulator_ops = {
+static const struct regulator_ops pm8607_regulator_ops = {
 	.list_voltage	= pm8607_list_voltage,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -229,7 +229,7 @@ static struct regulator_ops pm8607_regulator_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops pm8606_preg_ops = {
+static const struct regulator_ops pm8606_preg_ops = {
 	.enable		= regulator_enable_regmap,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
index 9dfabda..afc5b59 100644
--- a/drivers/regulator/aat2870-regulator.c
+++ b/drivers/regulator/aat2870-regulator.c
@@ -97,7 +97,7 @@ static int aat2870_ldo_is_enabled(struct regulator_dev *rdev)
 	return val & ri->enable_mask ? 1 : 0;
 }
 
-static struct regulator_ops aat2870_ldo_ops = {
+static const struct regulator_ops aat2870_ldo_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = aat2870_ldo_set_voltage_sel,
diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 441864b..43fda8b 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -69,7 +69,7 @@ static const struct regulator_linear_range act8945a_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(2400000, 48, 63, 100000),
 };
 
-static struct regulator_ops act8945a_ops = {
+static const struct regulator_ops act8945a_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
index 8b0f788..11c1f88 100644
--- a/drivers/regulator/ad5398.c
+++ b/drivers/regulator/ad5398.c
@@ -181,7 +181,7 @@ static int ad5398_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static struct regulator_ops ad5398_ops = {
+static const struct regulator_ops ad5398_ops = {
 	.get_current_limit = ad5398_get_current_limit,
 	.set_current_limit = ad5398_set_current_limit,
 	.enable = ad5398_enable,
diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 3a6d029..330136a 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -157,14 +157,14 @@ static int anatop_regmap_set_bypass(struct regulator_dev *reg, bool enable)
 	return regulator_set_voltage_sel_regmap(reg, sel);
 }
 
-static struct regulator_ops anatop_rops = {
+static const struct regulator_ops anatop_rops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
 	.map_voltage = regulator_map_voltage_linear,
 };
 
-static struct regulator_ops anatop_core_rops = {
+static const struct regulator_ops anatop_core_rops = {
 	.enable = anatop_regmap_enable,
 	.disable = anatop_regmap_disable,
 	.is_enabled = anatop_regmap_is_enabled,
diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 302b57c..e76d094 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -109,7 +109,7 @@ static int arizona_ldo1_hc_get_voltage_sel(struct regulator_dev *rdev)
 	return (val & ARIZONA_LDO1_VSEL_MASK) >> ARIZONA_LDO1_VSEL_SHIFT;
 }
 
-static struct regulator_ops arizona_ldo1_hc_ops = {
+static const struct regulator_ops arizona_ldo1_hc_ops = {
 	.list_voltage = arizona_ldo1_hc_list_voltage,
 	.map_voltage = arizona_ldo1_hc_map_voltage,
 	.get_voltage_sel = arizona_ldo1_hc_get_voltage_sel,
@@ -135,7 +135,7 @@ static const struct regulator_desc arizona_ldo1_hc = {
 	.owner = THIS_MODULE,
 };
 
-static struct regulator_ops arizona_ldo1_ops = {
+static const struct regulator_ops arizona_ldo1_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.map_voltage = regulator_map_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index fcb98db..ce90021 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -104,7 +104,7 @@ static int arizona_micsupp_set_bypass(struct regulator_dev *rdev, bool ena)
 	return ret;
 }
 
-static struct regulator_ops arizona_micsupp_ops = {
+static const struct regulator_ops arizona_micsupp_ops = {
 	.enable = arizona_micsupp_enable,
 	.disable = arizona_micsupp_disable,
 	.is_enabled = regulator_is_enabled_regmap,
diff --git a/drivers/regulator/as3711-regulator.c b/drivers/regulator/as3711-regulator.c
index c0e93b1..874d415 100644
--- a/drivers/regulator/as3711-regulator.c
+++ b/drivers/regulator/as3711-regulator.c
@@ -82,7 +82,7 @@ static unsigned int as3711_get_mode_sd(struct regulator_dev *rdev)
 	return -EINVAL;
 }
 
-static struct regulator_ops as3711_sd_ops = {
+static const struct regulator_ops as3711_sd_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -94,7 +94,7 @@ static struct regulator_ops as3711_sd_ops = {
 	.set_mode		= as3711_set_mode_sd,
 };
 
-static struct regulator_ops as3711_aldo_ops = {
+static const struct regulator_ops as3711_aldo_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -104,7 +104,7 @@ static struct regulator_ops as3711_aldo_ops = {
 	.map_voltage		= regulator_map_voltage_linear_range,
 };
 
-static struct regulator_ops as3711_dldo_ops = {
+static const struct regulator_ops as3711_dldo_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index e6a512e..5478151 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -128,11 +128,11 @@
 		.ops		= &axp20x_ops_range,				\
 	}
 
-static struct regulator_ops axp20x_ops_fixed = {
+static const struct regulator_ops axp20x_ops_fixed = {
 	.list_voltage		= regulator_list_voltage_linear,
 };
 
-static struct regulator_ops axp20x_ops_range = {
+static const struct regulator_ops axp20x_ops_range = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear_range,
@@ -141,7 +141,7 @@ static struct regulator_ops axp20x_ops_range = {
 	.is_enabled		= regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops axp20x_ops = {
+static const struct regulator_ops axp20x_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
@@ -150,7 +150,7 @@ static struct regulator_ops axp20x_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops axp20x_ops_sw = {
+static const struct regulator_ops axp20x_ops_sw = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index 76b0183..9dd7154 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -250,7 +250,7 @@ static int bcm590xx_get_enable_register(int id)
 	return reg;
 }
 
-static struct regulator_ops bcm590xx_ops_ldo = {
+static const struct regulator_ops bcm590xx_ops_ldo = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -260,7 +260,7 @@ static struct regulator_ops bcm590xx_ops_ldo = {
 	.map_voltage		= regulator_map_voltage_iterate,
 };
 
-static struct regulator_ops bcm590xx_ops_dcdc = {
+static const struct regulator_ops bcm590xx_ops_dcdc = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -270,7 +270,7 @@ static struct regulator_ops bcm590xx_ops_dcdc = {
 	.map_voltage		= regulator_map_voltage_linear_range,
 };
 
-static struct regulator_ops bcm590xx_ops_vbus = {
+static const struct regulator_ops bcm590xx_ops_vbus = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index d7da81a..60f4318 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -202,7 +202,7 @@ static int fan53555_set_ramp(struct regulator_dev *rdev, int ramp)
 				  CTL_SLEW_MASK, regval << CTL_SLEW_SHIFT);
 }
 
-static struct regulator_ops fan53555_regulator_ops = {
+static const struct regulator_ops fan53555_regulator_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index a43b0e8..9619022 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -135,7 +135,7 @@ acpi_get_fixed_voltage_config(struct device *dev,
 	return config;
 }
 
-static struct regulator_ops fixed_voltage_ops = {
+static const struct regulator_ops fixed_voltage_ops = {
 };
 
 static int reg_fixed_voltage_probe(struct platform_device *pdev)
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 0fce06a..3f9a3ec 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -126,7 +126,7 @@ static int gpio_regulator_set_current_limit(struct regulator_dev *dev,
 	return 0;
 }
 
-static struct regulator_ops gpio_regulator_voltage_ops = {
+static const struct regulator_ops gpio_regulator_voltage_ops = {
 	.get_voltage = gpio_regulator_get_value,
 	.set_voltage = gpio_regulator_set_voltage,
 	.list_voltage = gpio_regulator_list_voltage,
@@ -243,7 +243,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 	return config;
 }
 
-static struct regulator_ops gpio_regulator_current_ops = {
+static const struct regulator_ops gpio_regulator_current_ops = {
 	.get_current_limit = gpio_regulator_get_value,
 	.set_current_limit = gpio_regulator_set_current_limit,
 };
diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index aca1846..065c100 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -96,7 +96,7 @@ static int hi655x_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static struct regulator_ops hi655x_regulator_ops = {
+static const struct regulator_ops hi655x_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = hi655x_disable,
 	.is_enabled = hi655x_is_enabled,
@@ -105,7 +105,7 @@ static struct regulator_ops hi655x_regulator_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 };
 
-static struct regulator_ops hi655x_ldo_linear_ops = {
+static const struct regulator_ops hi655x_ldo_linear_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = hi655x_disable,
 	.is_enabled = hi655x_is_enabled,
diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index d6773da..db34e1d 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -227,7 +227,7 @@ static int lp8755_buck_set_ramp(struct regulator_dev *rdev, int ramp)
 	return ret;
 }
 
-static struct regulator_ops lp8755_buck_ops = {
+static const struct regulator_ops lp8755_buck_ops = {
 	.map_voltage = regulator_map_voltage_linear,
 	.list_voltage = regulator_list_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 47bef32..a7a1a03 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -161,7 +161,7 @@ static int ltc3589_set_suspend_mode(struct regulator_dev *rdev,
 }
 
 /* SW1, SW2, SW3, LDO2 */
-static struct regulator_ops ltc3589_linear_regulator_ops = {
+static const struct regulator_ops ltc3589_linear_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -175,18 +175,18 @@ static struct regulator_ops ltc3589_linear_regulator_ops = {
 };
 
 /* BB_OUT, LDO3 */
-static struct regulator_ops ltc3589_fixed_regulator_ops = {
+static const struct regulator_ops ltc3589_fixed_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
 };
 
 /* LDO1 */
-static struct regulator_ops ltc3589_fixed_standby_regulator_ops = {
+static const struct regulator_ops ltc3589_fixed_standby_regulator_ops = {
 };
 
 /* LDO4 */
-static struct regulator_ops ltc3589_table_regulator_ops = {
+static const struct regulator_ops ltc3589_table_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index e2b476c..503cd90 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -161,7 +161,7 @@ static int ltc3676_of_parse_cb(struct device_node *np,
 }
 
 /* SW1, SW2, SW3, SW4 linear 0.8V-3.3V with scalar via R1/R2 feeback res */
-static struct regulator_ops ltc3676_linear_regulator_ops = {
+static const struct regulator_ops ltc3676_linear_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -173,11 +173,11 @@ static struct regulator_ops ltc3676_linear_regulator_ops = {
 };
 
 /* LDO1 always on fixed 0.8V-3.3V via scalar via R1/R2 feeback res */
-static struct regulator_ops ltc3676_fixed_standby_regulator_ops = {
+static const struct regulator_ops ltc3676_fixed_standby_regulator_ops = {
 };
 
 /* LDO2, LDO3 fixed (LDO2 has external scalar via R1/R2 feedback res) */
-static struct regulator_ops ltc3676_fixed_regulator_ops = {
+static const struct regulator_ops ltc3676_fixed_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index c9ff261..0db288c 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -85,14 +85,14 @@ static int max14577_reg_set_current_limit(struct regulator_dev *rdev,
 			reg_data);
 }
 
-static struct regulator_ops max14577_safeout_ops = {
+static const struct regulator_ops max14577_safeout_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
 };
 
-static struct regulator_ops max14577_charger_ops = {
+static const struct regulator_ops max14577_charger_ops = {
 	.is_enabled		= max14577_reg_is_enabled,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -130,7 +130,7 @@ static const struct regulator_desc max14577_supported_regulators[] = {
 	[MAX14577_CHARGER] = MAX14577_CHARGER_REG,
 };
 
-static struct regulator_ops max77836_ldo_ops = {
+static const struct regulator_ops max77836_ldo_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index d088a7c..b94e3a7 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -644,7 +644,7 @@ static int max77620_of_parse_cb(struct device_node *np,
 	return max77620_init_pmic(pmic, desc->id);
 }
 
-static struct regulator_ops max77620_regulator_ops = {
+static const struct regulator_ops max77620_regulator_ops = {
 	.is_enabled = max77620_regulator_is_enabled,
 	.enable = max77620_regulator_enable,
 	.disable = max77620_regulator_disable,
diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index ac4fa58..c301f37 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -289,7 +289,7 @@ static int max77686_of_parse_cb(struct device_node *np,
 	return 0;
 }
 
-static struct regulator_ops max77686_ops = {
+static const struct regulator_ops max77686_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -301,7 +301,7 @@ static struct regulator_ops max77686_ops = {
 	.set_suspend_mode	= max77686_set_suspend_mode,
 };
 
-static struct regulator_ops max77686_ldo_ops = {
+static const struct regulator_ops max77686_ldo_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -314,7 +314,7 @@ static struct regulator_ops max77686_ldo_ops = {
 	.set_suspend_disable	= max77686_set_suspend_disable,
 };
 
-static struct regulator_ops max77686_buck1_ops = {
+static const struct regulator_ops max77686_buck1_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -326,7 +326,7 @@ static struct regulator_ops max77686_buck1_ops = {
 	.set_suspend_disable	= max77686_set_suspend_disable,
 };
 
-static struct regulator_ops max77686_buck_dvs_ops = {
+static const struct regulator_ops max77686_buck_dvs_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/max77693-regulator.c b/drivers/regulator/max77693-regulator.c
index cfbb951..3fce679 100644
--- a/drivers/regulator/max77693-regulator.c
+++ b/drivers/regulator/max77693-regulator.c
@@ -141,7 +141,7 @@ static const unsigned int max77693_safeout_table[] = {
 	3300000,
 };
 
-static struct regulator_ops max77693_safeout_ops = {
+static const struct regulator_ops max77693_safeout_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index 1d35393..b626190 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -288,7 +288,7 @@ static int max77802_set_ramp_delay_4bit(struct regulator_dev *rdev,
 /*
  * LDOs 2, 4-19, 22-35
  */
-static struct regulator_ops max77802_ldo_ops_logic1 = {
+static const struct regulator_ops max77802_ldo_ops_logic1 = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -304,7 +304,7 @@ static struct regulator_ops max77802_ldo_ops_logic1 = {
 /*
  * LDOs 1, 20, 21, 3
  */
-static struct regulator_ops max77802_ldo_ops_logic2 = {
+static const struct regulator_ops max77802_ldo_ops_logic2 = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -319,7 +319,7 @@ static struct regulator_ops max77802_ldo_ops_logic2 = {
 };
 
 /* BUCKS 1, 6 */
-static struct regulator_ops max77802_buck_16_dvs_ops = {
+static const struct regulator_ops max77802_buck_16_dvs_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -333,7 +333,7 @@ static struct regulator_ops max77802_buck_16_dvs_ops = {
 };
 
 /* BUCKs 2-4 */
-static struct regulator_ops max77802_buck_234_ops = {
+static const struct regulator_ops max77802_buck_234_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -348,7 +348,7 @@ static struct regulator_ops max77802_buck_234_ops = {
 };
 
 /* BUCKs 5, 7-10 */
-static struct regulator_ops max77802_buck_dvs_ops = {
+static const struct regulator_ops max77802_buck_dvs_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index 5e941db..860400d 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -109,7 +109,7 @@ struct max8907_regulator {
 #define LDO_650_25(id, supply, base) REG_LDO(id, supply, (base), \
 			650000, 2225000, 25000)
 
-static struct regulator_ops max8907_mbatt_ops = {
+static const struct regulator_ops max8907_mbatt_ops = {
 };
 
 static struct regulator_ops max8907_ldo_ops = {
@@ -121,13 +121,13 @@ static struct regulator_ops max8907_ldo_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops max8907_ldo_hwctl_ops = {
+static const struct regulator_ops max8907_ldo_hwctl_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static struct regulator_ops max8907_fixed_ops = {
+static const struct regulator_ops max8907_fixed_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 };
 
@@ -138,11 +138,11 @@ static struct regulator_ops max8907_out5v_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 };
 
-static struct regulator_ops max8907_out5v_hwctl_ops = {
+static const struct regulator_ops max8907_out5v_hwctl_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 };
 
-static struct regulator_ops max8907_bbat_ops = {
+static const struct regulator_ops max8907_bbat_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
diff --git a/drivers/regulator/max8925-regulator.c b/drivers/regulator/max8925-regulator.c
index c802f02..39b63dd 100644
--- a/drivers/regulator/max8925-regulator.c
+++ b/drivers/regulator/max8925-regulator.c
@@ -132,7 +132,7 @@ static int max8925_set_dvm_disable(struct regulator_dev *rdev)
 	return max8925_set_bits(info->i2c, info->vol_reg, 1 << SD1_DVM_EN, 0);
 }
 
-static struct regulator_ops max8925_regulator_sdv_ops = {
+static const struct regulator_ops max8925_regulator_sdv_ops = {
 	.map_voltage		= regulator_map_voltage_linear,
 	.list_voltage		= regulator_list_voltage_linear,
 	.set_voltage_sel	= max8925_set_voltage_sel,
@@ -145,7 +145,7 @@ static struct regulator_ops max8925_regulator_sdv_ops = {
 	.set_suspend_disable	= max8925_set_dvm_disable,
 };
 
-static struct regulator_ops max8925_regulator_ldo_ops = {
+static const struct regulator_ops max8925_regulator_ldo_ops = {
 	.map_voltage		= regulator_map_voltage_linear,
 	.list_voltage		= regulator_list_voltage_linear,
 	.set_voltage_sel	= max8925_set_voltage_sel,
diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index 1af8f4a..1096546 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -113,7 +113,7 @@ static int max8952_set_voltage_sel(struct regulator_dev *rdev,
 	return 0;
 }
 
-static struct regulator_ops max8952_ops = {
+static const struct regulator_ops max8952_ops = {
 	.list_voltage		= max8952_list_voltage,
 	.get_voltage_sel	= max8952_get_voltage_sel,
 	.set_voltage_sel	= max8952_set_voltage_sel,
diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index f11d41d..31ae5ee 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -528,7 +528,7 @@ static int palmas_smps_set_ramp_delay(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops palmas_ops_smps = {
+static const struct regulator_ops palmas_ops_smps = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -542,7 +542,7 @@ static struct regulator_ops palmas_ops_smps = {
 	.set_ramp_delay		= palmas_smps_set_ramp_delay,
 };
 
-static struct regulator_ops palmas_ops_ext_control_smps = {
+static const struct regulator_ops palmas_ops_ext_control_smps = {
 	.set_mode		= palmas_set_mode_smps,
 	.get_mode		= palmas_get_mode_smps,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -553,7 +553,7 @@ static struct regulator_ops palmas_ops_ext_control_smps = {
 	.set_ramp_delay		= palmas_smps_set_ramp_delay,
 };
 
-static struct regulator_ops palmas_ops_smps10 = {
+static const struct regulator_ops palmas_ops_smps10 = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -565,7 +565,7 @@ static struct regulator_ops palmas_ops_smps10 = {
 	.get_bypass		= regulator_get_bypass_regmap,
 };
 
-static struct regulator_ops tps65917_ops_smps = {
+static const struct regulator_ops tps65917_ops_smps = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -578,7 +578,7 @@ static struct regulator_ops tps65917_ops_smps = {
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops tps65917_ops_ext_control_smps = {
+static const struct regulator_ops tps65917_ops_ext_control_smps = {
 	.set_mode		= palmas_set_mode_smps,
 	.get_mode		= palmas_get_mode_smps,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -602,7 +602,7 @@ static int palmas_is_enabled_ldo(struct regulator_dev *dev)
 	return !!(reg);
 }
 
-static struct regulator_ops palmas_ops_ldo = {
+static const struct regulator_ops palmas_ops_ldo = {
 	.is_enabled		= palmas_is_enabled_ldo,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -612,7 +612,7 @@ static struct regulator_ops palmas_ops_ldo = {
 	.map_voltage		= regulator_map_voltage_linear,
 };
 
-static struct regulator_ops palmas_ops_ldo9 = {
+static const struct regulator_ops palmas_ops_ldo9 = {
 	.is_enabled		= palmas_is_enabled_ldo,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -624,23 +624,23 @@ static struct regulator_ops palmas_ops_ldo9 = {
 	.get_bypass		= regulator_get_bypass_regmap,
 };
 
-static struct regulator_ops palmas_ops_ext_control_ldo = {
+static const struct regulator_ops palmas_ops_ext_control_ldo = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 };
 
-static struct regulator_ops palmas_ops_extreg = {
+static const struct regulator_ops palmas_ops_extreg = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 };
 
-static struct regulator_ops palmas_ops_ext_control_extreg = {
+static const struct regulator_ops palmas_ops_ext_control_extreg = {
 };
 
-static struct regulator_ops tps65917_ops_ldo = {
+static const struct regulator_ops tps65917_ops_ldo = {
 	.is_enabled		= palmas_is_enabled_ldo,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -651,7 +651,7 @@ static struct regulator_ops tps65917_ops_ldo = {
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops tps65917_ops_ldo_1_2 = {
+static const struct regulator_ops tps65917_ops_ldo_1_2 = {
 	.is_enabled		= palmas_is_enabled_ldo,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index f9d74d6..0cb76ba 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -54,7 +54,7 @@ static const unsigned int pbias_volt_table[] = {
 	3000000
 };
 
-static struct regulator_ops pbias_regulator_voltage_ops = {
+static const struct regulator_ops pbias_regulator_voltage_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
diff --git a/drivers/regulator/pcap-regulator.c b/drivers/regulator/pcap-regulator.c
index 9b16e61..79cb971 100644
--- a/drivers/regulator/pcap-regulator.c
+++ b/drivers/regulator/pcap-regulator.c
@@ -210,7 +210,7 @@ static int pcap_regulator_is_enabled(struct regulator_dev *rdev)
 	return (tmp >> vreg->en) & 1;
 }
 
-static struct regulator_ops pcap_regulator_ops = {
+static const struct regulator_ops pcap_regulator_ops = {
 	.list_voltage	= regulator_list_voltage_table,
 	.set_voltage_sel = pcap_regulator_set_voltage_sel,
 	.get_voltage_sel = pcap_regulator_get_voltage_sel,
diff --git a/drivers/regulator/pcf50633-regulator.c b/drivers/regulator/pcf50633-regulator.c
index 134f90e..762e184 100644
--- a/drivers/regulator/pcf50633-regulator.c
+++ b/drivers/regulator/pcf50633-regulator.c
@@ -41,7 +41,7 @@
 		.enable_mask = PCF50633_REGULATOR_ON,		\
 	}
 
-static struct regulator_ops pcf50633_regulator_ops = {
+static const struct regulator_ops pcf50633_regulator_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_linear,
diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index cb18b5c..e193bbb 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -126,7 +126,7 @@ static int pfuze100_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 	return ret;
 }
 
-static struct regulator_ops pfuze100_ldo_regulator_ops = {
+static const struct regulator_ops pfuze100_ldo_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -135,14 +135,14 @@ static struct regulator_ops pfuze100_ldo_regulator_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static struct regulator_ops pfuze100_fixed_regulator_ops = {
+static const struct regulator_ops pfuze100_fixed_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_linear,
 };
 
-static struct regulator_ops pfuze100_sw_regulator_ops = {
+static const struct regulator_ops pfuze100_sw_regulator_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -150,7 +150,7 @@ static struct regulator_ops pfuze100_sw_regulator_ops = {
 	.set_ramp_delay = pfuze100_set_ramp_delay,
 };
 
-static struct regulator_ops pfuze100_swb_regulator_ops = {
+static const struct regulator_ops pfuze100_swb_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.list_voltage = regulator_list_voltage_table,
diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index 6c4afc7..a944605 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -162,7 +162,7 @@ static int pv88060_get_current_limit(struct regulator_dev *rdev)
 	return info->current_limits[data];
 }
 
-static struct regulator_ops pv88060_buck_ops = {
+static const struct regulator_ops pv88060_buck_ops = {
 	.get_mode = pv88060_buck_get_mode,
 	.set_mode = pv88060_buck_set_mode,
 	.enable = regulator_enable_regmap,
@@ -175,7 +175,7 @@ static struct regulator_ops pv88060_buck_ops = {
 	.get_current_limit = pv88060_get_current_limit,
 };
 
-static struct regulator_ops pv88060_ldo_ops = {
+static const struct regulator_ops pv88060_ldo_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 954a20e..9a08cb2 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -306,7 +306,7 @@ static int pv88080_get_current_limit(struct regulator_dev *rdev)
 	return info->current_limits[data];
 }
 
-static struct regulator_ops pv88080_buck_ops = {
+static const struct regulator_ops pv88080_buck_ops = {
 	.get_mode = pv88080_buck_get_mode,
 	.set_mode = pv88080_buck_set_mode,
 	.enable = regulator_enable_regmap,
@@ -319,7 +319,7 @@ static struct regulator_ops pv88080_buck_ops = {
 	.get_current_limit = pv88080_get_current_limit,
 };
 
-static struct regulator_ops pv88080_hvbuck_ops = {
+static const struct regulator_ops pv88080_hvbuck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index 4216411..ab51e25 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -184,7 +184,7 @@ static int pv88090_get_current_limit(struct regulator_dev *rdev)
 	return info->current_limits[data];
 }
 
-static struct regulator_ops pv88090_buck_ops = {
+static const struct regulator_ops pv88090_buck_ops = {
 	.get_mode = pv88090_buck_get_mode,
 	.set_mode = pv88090_buck_set_mode,
 	.enable = regulator_enable_regmap,
@@ -197,7 +197,7 @@ static struct regulator_ops pv88090_buck_ops = {
 	.get_current_limit = pv88090_get_current_limit,
 };
 
-static struct regulator_ops pv88090_ldo_ops = {
+static const struct regulator_ops pv88090_ldo_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 16c5f84..dabaf26 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1034,7 +1034,7 @@ static irqreturn_t spmi_regulator_vs_ocp_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct regulator_ops spmi_smps_ops = {
+static const struct regulator_ops spmi_smps_ops = {
 	.enable			= spmi_regulator_common_enable,
 	.disable		= spmi_regulator_common_disable,
 	.is_enabled		= spmi_regulator_common_is_enabled,
@@ -1049,7 +1049,7 @@ static struct regulator_ops spmi_smps_ops = {
 	.set_pull_down		= spmi_regulator_common_set_pull_down,
 };
 
-static struct regulator_ops spmi_ldo_ops = {
+static const struct regulator_ops spmi_ldo_ops = {
 	.enable			= spmi_regulator_common_enable,
 	.disable		= spmi_regulator_common_disable,
 	.is_enabled		= spmi_regulator_common_is_enabled,
@@ -1066,7 +1066,7 @@ static struct regulator_ops spmi_ldo_ops = {
 	.set_soft_start		= spmi_regulator_common_set_soft_start,
 };
 
-static struct regulator_ops spmi_ln_ldo_ops = {
+static const struct regulator_ops spmi_ln_ldo_ops = {
 	.enable			= spmi_regulator_common_enable,
 	.disable		= spmi_regulator_common_disable,
 	.is_enabled		= spmi_regulator_common_is_enabled,
@@ -1078,7 +1078,7 @@ static struct regulator_ops spmi_ln_ldo_ops = {
 	.get_bypass		= spmi_regulator_common_get_bypass,
 };
 
-static struct regulator_ops spmi_vs_ops = {
+static const struct regulator_ops spmi_vs_ops = {
 	.enable			= spmi_regulator_vs_enable,
 	.disable		= spmi_regulator_common_disable,
 	.is_enabled		= spmi_regulator_common_is_enabled,
@@ -1089,7 +1089,7 @@ static struct regulator_ops spmi_vs_ops = {
 	.get_mode		= spmi_regulator_common_get_mode,
 };
 
-static struct regulator_ops spmi_boost_ops = {
+static const struct regulator_ops spmi_boost_ops = {
 	.enable			= spmi_regulator_common_enable,
 	.disable		= spmi_regulator_common_disable,
 	.is_enabled		= spmi_regulator_common_is_enabled,
@@ -1100,7 +1100,7 @@ static struct regulator_ops spmi_boost_ops = {
 	.set_input_current_limit = spmi_regulator_set_ilim,
 };
 
-static struct regulator_ops spmi_ftsmps_ops = {
+static const struct regulator_ops spmi_ftsmps_ops = {
 	.enable			= spmi_regulator_common_enable,
 	.disable		= spmi_regulator_common_disable,
 	.is_enabled		= spmi_regulator_common_is_enabled,
@@ -1115,7 +1115,7 @@ static struct regulator_ops spmi_ftsmps_ops = {
 	.set_pull_down		= spmi_regulator_common_set_pull_down,
 };
 
-static struct regulator_ops spmi_ult_lo_smps_ops = {
+static const struct regulator_ops spmi_ult_lo_smps_ops = {
 	.enable			= spmi_regulator_common_enable,
 	.disable		= spmi_regulator_common_disable,
 	.is_enabled		= spmi_regulator_common_is_enabled,
@@ -1129,7 +1129,7 @@ static struct regulator_ops spmi_ult_lo_smps_ops = {
 	.set_pull_down		= spmi_regulator_common_set_pull_down,
 };
 
-static struct regulator_ops spmi_ult_ho_smps_ops = {
+static const struct regulator_ops spmi_ult_ho_smps_ops = {
 	.enable			= spmi_regulator_common_enable,
 	.disable		= spmi_regulator_common_disable,
 	.is_enabled		= spmi_regulator_common_is_enabled,
@@ -1144,7 +1144,7 @@ static struct regulator_ops spmi_ult_ho_smps_ops = {
 	.set_pull_down		= spmi_regulator_common_set_pull_down,
 };
 
-static struct regulator_ops spmi_ult_ldo_ops = {
+static const struct regulator_ops spmi_ult_ldo_ops = {
 	.enable			= spmi_regulator_common_enable,
 	.disable		= spmi_regulator_common_disable,
 	.is_enabled		= spmi_regulator_common_is_enabled,
diff --git a/drivers/regulator/rc5t583-regulator.c b/drivers/regulator/rc5t583-regulator.c
index d2e67c5..d0f1340 100644
--- a/drivers/regulator/rc5t583-regulator.c
+++ b/drivers/regulator/rc5t583-regulator.c
@@ -61,7 +61,7 @@ static int rc5t583_regulator_enable_time(struct regulator_dev *rdev)
 	return DIV_ROUND_UP(curr_uV, reg->reg_info->enable_uv_per_us);
 }
 
-static struct regulator_ops rc5t583_ops = {
+static const struct regulator_ops rc5t583_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/rn5t618-regulator.c b/drivers/regulator/rn5t618-regulator.c
index 9c930eb..8d2819e 100644
--- a/drivers/regulator/rn5t618-regulator.c
+++ b/drivers/regulator/rn5t618-regulator.c
@@ -19,7 +19,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
 
-static struct regulator_ops rn5t618_reg_ops = {
+static const struct regulator_ops rn5t618_reg_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index 92f8875..dc2105c 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -212,7 +212,7 @@ static int s2mpa01_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 				  1 << enable_shift, 0);
 }
 
-static struct regulator_ops s2mpa01_ldo_ops = {
+static const struct regulator_ops s2mpa01_ldo_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -223,7 +223,7 @@ static struct regulator_ops s2mpa01_ldo_ops = {
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops s2mpa01_buck_ops = {
+static const struct regulator_ops s2mpa01_buck_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index d838e77..7726b87 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -238,7 +238,7 @@ static int s2mps11_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 				  1 << enable_shift, 0);
 }
 
-static struct regulator_ops s2mps11_ldo_ops = {
+static const struct regulator_ops s2mps11_ldo_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -249,7 +249,7 @@ static struct regulator_ops s2mps11_ldo_ops = {
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops s2mps11_buck_ops = {
+static const struct regulator_ops s2mps11_buck_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -392,7 +392,7 @@ static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_buck67810(10, MIN_750_MV, STEP_12_5_MV),
 };
 
-static struct regulator_ops s2mps14_reg_ops;
+static const struct regulator_ops s2mps14_reg_ops;
 
 #define regulator_desc_s2mps13_ldo(num, min, step, min_sel) {	\
 	.name		= "LDO"#num,				\
@@ -599,7 +599,7 @@ static int s2mps14_regulator_set_suspend_disable(struct regulator_dev *rdev)
 			rdev->desc->enable_mask, state);
 }
 
-static struct regulator_ops s2mps14_reg_ops = {
+static const struct regulator_ops s2mps14_reg_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -681,7 +681,7 @@ static const struct regulator_desc s2mps14_regulators[] = {
 				    S2MPS14_BUCK1235_START_SEL),
 };
 
-static struct regulator_ops s2mps15_reg_ldo_ops = {
+static const struct regulator_ops s2mps15_reg_ldo_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -691,7 +691,7 @@ static struct regulator_ops s2mps15_reg_ldo_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 };
 
-static struct regulator_ops s2mps15_reg_buck_ops = {
+static const struct regulator_ops s2mps15_reg_buck_ops = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -886,7 +886,7 @@ static int s2mpu02_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 				  ramp_val << ramp_shift);
 }
 
-static struct regulator_ops s2mpu02_ldo_ops = {
+static const struct regulator_ops s2mpu02_ldo_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -898,7 +898,7 @@ static struct regulator_ops s2mpu02_ldo_ops = {
 	.set_suspend_disable	= s2mps14_regulator_set_suspend_disable,
 };
 
-static struct regulator_ops s2mpu02_buck_ops = {
+static const struct regulator_ops s2mpu02_buck_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 27343e1..383cd753 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -357,7 +357,7 @@ static int s5m8767_set_voltage_time_sel(struct regulator_dev *rdev,
 	return 0;
 }
 
-static struct regulator_ops s5m8767_ops = {
+static const struct regulator_ops s5m8767_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
@@ -367,7 +367,7 @@ static struct regulator_ops s5m8767_ops = {
 	.set_voltage_time_sel	= s5m8767_set_voltage_time_sel,
 };
 
-static struct regulator_ops s5m8767_buck78_ops = {
+static const struct regulator_ops s5m8767_buck78_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
diff --git a/drivers/regulator/sky81452-regulator.c b/drivers/regulator/sky81452-regulator.c
index 6478606..eb2b609 100644
--- a/drivers/regulator/sky81452-regulator.c
+++ b/drivers/regulator/sky81452-regulator.c
@@ -34,7 +34,7 @@
 #define SKY81452_LEN	0x40
 #define SKY81452_LOUT	0x1F
 
-static struct regulator_ops sky81452_reg_ops = {
+static const struct regulator_ops sky81452_reg_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
diff --git a/drivers/regulator/stw481x-vmmc.c b/drivers/regulator/stw481x-vmmc.c
index 342f5da..edd8fa7 100644
--- a/drivers/regulator/stw481x-vmmc.c
+++ b/drivers/regulator/stw481x-vmmc.c
@@ -28,7 +28,7 @@ static const unsigned int stw481x_vmmc_voltages[] = {
 	3300000,
 };
 
-static struct regulator_ops stw481x_vmmc_ops = {
+static const struct regulator_ops stw481x_vmmc_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.enable      = regulator_enable_regmap,
 	.disable     = regulator_disable_regmap,
diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index d2f9942..a263148 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -629,7 +629,7 @@ static int ti_abb_init_table(struct device *dev, struct ti_abb *abb,
 	return 0;
 }
 
-static struct regulator_ops ti_abb_reg_ops = {
+static const struct regulator_ops ti_abb_reg_ops = {
 	.list_voltage = regulator_list_voltage_table,
 
 	.set_voltage_sel = ti_abb_set_voltage_sel,
diff --git a/drivers/regulator/tps51632-regulator.c b/drivers/regulator/tps51632-regulator.c
index c139890..a15e415 100644
--- a/drivers/regulator/tps51632-regulator.c
+++ b/drivers/regulator/tps51632-regulator.c
@@ -108,7 +108,7 @@ static int tps51632_dcdc_set_ramp_delay(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops tps51632_dcdc_ops = {
+static const struct regulator_ops tps51632_dcdc_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
diff --git a/drivers/regulator/tps6105x-regulator.c b/drivers/regulator/tps6105x-regulator.c
index 584ef3d..c3d48a8 100644
--- a/drivers/regulator/tps6105x-regulator.c
+++ b/drivers/regulator/tps6105x-regulator.c
@@ -27,7 +27,7 @@ static const unsigned int tps6105x_voltages[] = {
 	5000000, /* There is an additional 5V */
 };
 
-static struct regulator_ops tps6105x_regulator_ops = {
+static const struct regulator_ops tps6105x_regulator_ops = {
 	.enable		= regulator_enable_regmap,
 	.disable	= regulator_disable_regmap,
 	.is_enabled	= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/tps62360-regulator.c b/drivers/regulator/tps62360-regulator.c
index f6a6d36..315cd5d 100644
--- a/drivers/regulator/tps62360-regulator.c
+++ b/drivers/regulator/tps62360-regulator.c
@@ -233,7 +233,7 @@ static unsigned int tps62360_get_mode(struct regulator_dev *rdev)
 				REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
 }
 
-static struct regulator_ops tps62360_dcdc_ops = {
+static const struct regulator_ops tps62360_dcdc_ops = {
 	.get_voltage_sel	= tps62360_dcdc_get_voltage_sel,
 	.set_voltage_sel	= tps62360_dcdc_set_voltage_sel,
 	.list_voltage		= regulator_list_voltage_linear,
diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index c179a3a..2b3064f 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -349,7 +349,7 @@ static int tps6507x_pmic_set_voltage_sel(struct regulator_dev *dev,
 	return tps6507x_pmic_reg_write(tps, reg, data);
 }
 
-static struct regulator_ops tps6507x_pmic_ops = {
+static const struct regulator_ops tps6507x_pmic_ops = {
 	.is_enabled = tps6507x_pmic_is_enabled,
 	.enable = tps6507x_pmic_enable,
 	.disable = tps6507x_pmic_disable,
diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index ecb0371..5cf8113 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -101,7 +101,7 @@ static const struct regulator_linear_range tps65086_ldoa23_ranges[] = {
 };
 
 /* Operations permitted on regulators */
-static struct regulator_ops reg_ops = {
+static const struct regulator_ops reg_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -112,7 +112,7 @@ static struct regulator_ops reg_ops = {
 };
 
 /* Operations permitted on load switches */
-static struct regulator_ops switch_ops = {
+static const struct regulator_ops switch_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index 395f35d..db183f5 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -57,7 +57,7 @@ struct tps65090_regulator {
 	int			overcurrent_wait;
 };
 
-static struct regulator_ops tps65090_ext_control_ops = {
+static const struct regulator_ops tps65090_ext_control_ops = {
 };
 
 /**
diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index 67cac26..c09223c 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -565,7 +565,7 @@ static int is_supply_enabled(struct regulator_dev *rdev)
 	return read_field(hw, &info->enable);
 }
 
-static struct regulator_ops regulator_ops = {
+static const struct regulator_ops regulator_ops = {
 	.is_enabled		= is_supply_enabled,
 	.enable			= enable_supply,
 	.disable		= disable_supply,
diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 9e9d220..8186508 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -63,7 +63,7 @@ struct tps6586x_regulator {
 	int enable_reg[2];
 };
 
-static struct regulator_ops tps6586x_rw_regulator_ops = {
+static const struct regulator_ops tps6586x_rw_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -74,7 +74,7 @@ static struct regulator_ops tps6586x_rw_regulator_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_rw_linear_regulator_ops = {
+static const struct regulator_ops tps6586x_rw_linear_regulator_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
@@ -84,7 +84,7 @@ static struct regulator_ops tps6586x_rw_linear_regulator_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_ro_regulator_ops = {
+static const struct regulator_ops tps6586x_ro_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -94,7 +94,7 @@ static struct regulator_ops tps6586x_ro_regulator_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-static struct regulator_ops tps6586x_sys_regulator_ops = {
+static const struct regulator_ops tps6586x_sys_regulator_ops = {
 };
 
 static const unsigned int tps6586x_ldo0_voltages[] = {
diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 696116e..7e2ba46 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -762,7 +762,7 @@ static int tps65911_list_voltage(struct regulator_dev *dev, unsigned selector)
 }
 
 /* Regulator ops (except VRTC) */
-static struct regulator_ops tps65910_ops_dcdc = {
+static const struct regulator_ops tps65910_ops_dcdc = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -775,7 +775,7 @@ static struct regulator_ops tps65910_ops_dcdc = {
 	.map_voltage		= regulator_map_voltage_ascend,
 };
 
-static struct regulator_ops tps65910_ops_vdd3 = {
+static const struct regulator_ops tps65910_ops_vdd3 = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -786,7 +786,7 @@ static struct regulator_ops tps65910_ops_vdd3 = {
 	.map_voltage		= regulator_map_voltage_ascend,
 };
 
-static struct regulator_ops tps65910_ops_vbb = {
+static const struct regulator_ops tps65910_ops_vbb = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -798,7 +798,7 @@ static struct regulator_ops tps65910_ops_vbb = {
 	.map_voltage		= regulator_map_voltage_iterate,
 };
 
-static struct regulator_ops tps65910_ops = {
+static const struct regulator_ops tps65910_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -810,7 +810,7 @@ static struct regulator_ops tps65910_ops = {
 	.map_voltage		= regulator_map_voltage_ascend,
 };
 
-static struct regulator_ops tps65911_ops = {
+static const struct regulator_ops tps65911_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index d4cc60a..2ebb336 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -378,7 +378,7 @@ static int tps80031_vbus_disable(struct regulator_dev *rdev)
 	return ret;
 }
 
-static struct regulator_ops tps80031_dcdc_ops = {
+static const struct regulator_ops tps80031_dcdc_ops = {
 	.list_voltage		= tps80031_dcdc_list_voltage,
 	.set_voltage_sel	= tps80031_dcdc_set_voltage_sel,
 	.get_voltage_sel	= tps80031_dcdc_get_voltage_sel,
@@ -387,7 +387,7 @@ static struct regulator_ops tps80031_dcdc_ops = {
 	.is_enabled	= tps80031_reg_is_enabled,
 };
 
-static struct regulator_ops tps80031_ldo_ops = {
+static const struct regulator_ops tps80031_ldo_ops = {
 	.list_voltage		= tps80031_ldo_list_voltage,
 	.map_voltage		= tps80031_ldo_map_voltage,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
@@ -397,7 +397,7 @@ static struct regulator_ops tps80031_ldo_ops = {
 	.is_enabled		= tps80031_reg_is_enabled,
 };
 
-static struct regulator_ops tps80031_vbus_sw_ops = {
+static const struct regulator_ops tps80031_vbus_sw_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= tps80031_vbus_enable,
 	.disable	= tps80031_vbus_disable,
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 6c9ec84..8c2e2be 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -392,7 +392,7 @@ static int twl4030ldo_get_voltage_sel(struct regulator_dev *rdev)
 	return vsel;
 }
 
-static struct regulator_ops twl4030ldo_ops = {
+static const struct regulator_ops twl4030ldo_ops = {
 	.list_voltage	= twl4030ldo_list_voltage,
 
 	.set_voltage_sel = twl4030ldo_set_voltage_sel,
@@ -430,14 +430,14 @@ static int twl4030smps_get_voltage(struct regulator_dev *rdev)
 	return vsel * 12500 + 600000;
 }
 
-static struct regulator_ops twl4030smps_ops = {
+static const struct regulator_ops twl4030smps_ops = {
 	.set_voltage	= twl4030smps_set_voltage,
 	.get_voltage	= twl4030smps_get_voltage,
 };
 
 /*----------------------------------------------------------------------*/
 
-static struct regulator_ops twl4030fixed_ops = {
+static const struct regulator_ops twl4030fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 
 	.enable		= twl4030reg_enable,
diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 4864b9d..50745d1 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -247,7 +247,7 @@ static int twl6030coresmps_get_voltage(struct regulator_dev *rdev)
 	return -ENODEV;
 }
 
-static struct regulator_ops twl6030coresmps_ops = {
+static const struct regulator_ops twl6030coresmps_ops = {
 	.set_voltage	= twl6030coresmps_set_voltage,
 	.get_voltage	= twl6030coresmps_get_voltage,
 };
@@ -290,7 +290,7 @@ static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
 	return vsel;
 }
 
-static struct regulator_ops twl6030ldo_ops = {
+static const struct regulator_ops twl6030ldo_ops = {
 	.list_voltage	= twl6030ldo_list_voltage,
 
 	.set_voltage_sel = twl6030ldo_set_voltage_sel,
@@ -305,7 +305,7 @@ static struct regulator_ops twl6030ldo_ops = {
 	.get_status	= twl6030reg_get_status,
 };
 
-static struct regulator_ops twl6030fixed_ops = {
+static const struct regulator_ops twl6030fixed_ops = {
 	.list_voltage	= regulator_list_voltage_linear,
 
 	.enable		= twl6030reg_enable,
@@ -498,7 +498,7 @@ static int twl6030smps_get_voltage_sel(struct regulator_dev *rdev)
 	return twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_VOLTAGE_SMPS);
 }
 
-static struct regulator_ops twlsmps_ops = {
+static const struct regulator_ops twlsmps_ops = {
 	.list_voltage		= twl6030smps_list_voltage,
 	.map_voltage		= twl6030smps_map_voltage,
 
diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index c810cbb..ca4230f 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -46,11 +46,11 @@ static int vexpress_regulator_set_voltage(struct regulator_dev *regdev,
 	return regmap_write(reg->regmap, 0, min_uV);
 }
 
-static struct regulator_ops vexpress_regulator_ops_ro = {
+static const struct regulator_ops vexpress_regulator_ops_ro = {
 	.get_voltage = vexpress_regulator_get_voltage,
 };
 
-static struct regulator_ops vexpress_regulator_ops = {
+static const struct regulator_ops vexpress_regulator_ops = {
 	.get_voltage = vexpress_regulator_get_voltage,
 	.set_voltage = vexpress_regulator_set_voltage,
 };
-- 
2.7.4
