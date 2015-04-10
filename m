From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] thermal: ti-soc-thermal: dra7: Implement Workaround for Errata i814 - Bandgap Temperature read Dtemp can be corrupted
Date: Fri, 10 Apr 2015 12:06:30 +0530
Message-ID: <1428647790-6585-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Bandgap Temperature read Dtemp can be corrupted

DESCRIPTION
        Read accesses to registers listed below can be corrupted due to=
 incorrect resynchronization between
        clock domains.

        Read access to registers below can be corrupted :
                =E2=80=A2 CTRL_CORE_DTEMP_MPU/GPU/CORE/DSPEVE/IVA_n (n =
=3D 0 to 4)
        =E2=80=A2 CTRL_CORE_TEMP_SENSOR_MPU/GPU/CORE/DSPEVE/IVA_n

WORKAROUND
        Multiple reads to CTRL_CORE_TEMP_SENSOR_MPU/GPU/CORE/DSPEVE/IVA=
[9:0]:
        BGAP_DTEMPMPU/GPU/CORE/DSPEVE/IVA is needed to discard false va=
lue and read right value:
                1. Perform two successive reads to BGAP_DTEMP bit field=
=2E
                        (a) If read1 returns Val1 and read2 returns Val=
1, then right value is Val1.
                        (b) If read1 returns Val1, read 2 returns Val2,=
 a third read is needed.
                2. Perform third read
                        (a) If read3 returns Val2 then right value is V=
al2.
                        (b) If read3 returns Val3, then right value is =
Val3.

        The above in gist means if val1 and val2 are the same then we c=
an go ahead with that value
        else we need a third read which will be right since synchroniza=
tion will be complete by then.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in V2:

  * Added more details in the description part.
  * Indented the comments.
  * Renamed ti_dra7_bandgap_read_temp to ti_errata814_bandgap_read_temp=
=2E

 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  3 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 37 ++++++++++++++=
+++++++-
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  4 +++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/dri=
vers/thermal/ti-soc-thermal/dra752-thermal-data.c
index a492927..58b5c66 100644
--- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
@@ -420,7 +420,8 @@ const struct ti_bandgap_data dra752_data =3D {
 			TI_BANDGAP_FEATURE_FREEZE_BIT |
 			TI_BANDGAP_FEATURE_TALERT |
 			TI_BANDGAP_FEATURE_COUNTER_DELAY |
-			TI_BANDGAP_FEATURE_HISTORY_BUFFER,
+			TI_BANDGAP_FEATURE_HISTORY_BUFFER |
+			TI_BANDGAP_FEATURE_ERRATA_814,
 	.fclock_name =3D "l3instr_ts_gclk_div",
 	.div_ck_name =3D "l3instr_ts_gclk_div",
 	.conv_table =3D dra752_adc_to_temp,
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/ther=
mal/ti-soc-thermal/ti-bandgap.c
index 74c0e34..94acd80 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -119,6 +119,37 @@ exit:
 }
=20
 /**
+ * ti_errata814_bandgap_read_temp() - helper function to read dra7 sen=
sor temperature
+ * @bgp: pointer to ti_bandgap structure
+ * @reg: desired register (offset) to be read
+ *
+ * Function to read dra7 bandgap sensor temperature. This is done sepa=
rately
+ * so as to workaround the errata "Bandgap Temperature read Dtemp can =
be
+ * corrupted" - Errata ID: i814".
+ * Read accesses to registers listed below can be corrupted due to inc=
orrect
+ * resynchronization between clock domains.
+ * Read access to registers below can be corrupted :
+ * CTRL_CORE_DTEMP_MPU/GPU/CORE/DSPEVE/IVA_n (n =3D 0 to 4)
+ * CTRL_CORE_TEMP_SENSOR_MPU/GPU/CORE/DSPEVE/IVA_n
+ *
+ * Return: the register value.
+ */
+static u32 ti_errata814_bandgap_read_temp(struct ti_bandgap *bgp,  u32=
 reg)
+{
+	u32 val1, val2;
+
+	val1 =3D ti_bandgap_readl(bgp, reg);
+	val2 =3D ti_bandgap_readl(bgp, reg);
+
+	/* If both times we read the same value then that is right */
+	if (val1 =3D=3D val2)
+		return val1;
+
+	/* if val1 and val2 are different read it third time */
+	return ti_bandgap_readl(bgp, reg);
+}
+
+/**
  * ti_bandgap_read_temp() - helper function to read sensor temperature
  * @bgp: pointer to ti_bandgap structure
  * @id: bandgap sensor id
@@ -148,7 +179,11 @@ static u32 ti_bandgap_read_temp(struct ti_bandgap =
*bgp, int id)
 	}
=20
 	/* read temperature */
-	temp =3D ti_bandgap_readl(bgp, reg);
+	if (TI_BANDGAP_HAS(bgp, ERRATA_814))
+		temp =3D ti_errata814_bandgap_read_temp(bgp, reg);
+	else
+		temp =3D ti_bandgap_readl(bgp, reg);
+
 	temp &=3D tsr->bgap_dtemp_mask;
=20
 	if (TI_BANDGAP_HAS(bgp, FREEZE_BIT))
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/ther=
mal/ti-soc-thermal/ti-bandgap.h
index b3adf72..b2da3fc 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -318,6 +318,9 @@ struct ti_temp_sensor {
  * TI_BANDGAP_FEATURE_HISTORY_BUFFER - used when the bandgap device fe=
atures
  *	a history buffer of temperatures.
  *
+ * TI_BANDGAP_FEATURE_ERRATA_814 - used to workaorund when the bandgap=
 device
+ *	has Errata 814
+ *
  * TI_BANDGAP_HAS(b, f) - macro to check if a bandgap device is capabl=
e of a
  *      specific feature (above) or not. Return non-zero, if yes.
  */
@@ -331,6 +334,7 @@ struct ti_temp_sensor {
 #define TI_BANDGAP_FEATURE_FREEZE_BIT		BIT(7)
 #define TI_BANDGAP_FEATURE_COUNTER_DELAY	BIT(8)
 #define TI_BANDGAP_FEATURE_HISTORY_BUFFER	BIT(9)
+#define TI_BANDGAP_FEATURE_ERRATA_814		BIT(10)
 #define TI_BANDGAP_HAS(b, f)			\
 			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
=20
--=20
1.9.1

