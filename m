From: =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>
Subject: [PATCH 1/3] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Thu,  1 Aug 2019 03:28:21 +0200
Message-ID: <20190801012823.28730-2-neolynx@gmail.com>
References: <20190801012823.28730-1-neolynx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190801012823.28730-1-neolynx@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@ti.com>, Thara Gopinath <thara@ti.com>, Shweta Gulati <shweta.gulati@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Thara Gopinath <thara@ti.com>

Voltage control on TWL can be done using VMODE/I2C1/I2C_SR.
Since almost all platforms use I2C_SR on omap3, omap3_twl_init by
default expects that OMAP's I2C_SR is plugged in to TWL's I2C
and calls omap3_twl_set_sr_bit. On platforms where I2C_SR is not connected,
the board files are expected to call omap3_twl_set_sr_bit(false) to
ensure that I2C_SR path is not set for voltage control and prevent
the default behavior of omap3_twl_init.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 6787f1e72c6b..1dae906128c2 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -43,8 +43,15 @@
 
 static bool is_offset_valid;
 static u8 smps_offset;
+/*
+ * Flag to ensure Smartreflex bit in TWL
+ * being cleared in board file is not overwritten.
+ */
+static bool __initdata twl_sr_enable_autoinit;
 
+#define TWL4030_DCDC_GLOBAL_CFG        0x06
 #define REG_SMPS_OFFSET         0xE0
+#define SMARTREFLEX_ENABLE     BIT(3)
 
 static unsigned long twl4030_vsel_to_uv(const u8 vsel)
 {
@@ -241,6 +248,18 @@ int __init omap3_twl_init(void)
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
+	/*
+	 * The smartreflex bit on twl4030 specifies if the setting of voltage
+	 * is done over the I2C_SR path. Since this setting is independent of
+	 * the actual usage of smartreflex AVS module, we enable TWL SR bit
+	 * by default irrespective of whether smartreflex AVS module is enabled
+	 * on the OMAP side or not. This is because without this bit enabled,
+	 * the voltage scaling through vp forceupdate/bypass mechanism of
+	 * voltage scaling will not function on TWL over I2C_SR.
+	 */
+	if (!twl_sr_enable_autoinit)
+		omap3_twl_set_sr_bit(true);
+
 	voltdm = voltdm_lookup("mpu_iva");
 	omap_voltage_register_pmic(voltdm, &omap3_mpu_pmic);
 
@@ -249,3 +268,44 @@ int __init omap3_twl_init(void)
 
 	return 0;
 }
+
+/**
+ * omap3_twl_set_sr_bit() - Set/Clear SR bit on TWL
+ * @enable: enable SR mode in twl or not
+ *
+ * If 'enable' is true, enables Smartreflex bit on TWL 4030 to make sure
+ * voltage scaling through OMAP SR works. Else, the smartreflex bit
+ * on twl4030 is cleared as there are platforms which use OMAP3 and T2 but
+ * use Synchronized Scaling Hardware Strategy (ENABLE_VMODE=1) and Direct
+ * Strategy Software Scaling Mode (ENABLE_VMODE=0), for setting the voltages,
+ * in those scenarios this bit is to be cleared (enable = false).
+ *
+ * Returns 0 on sucess, error is returned if I2C read/write fails.
+ */
+int __init omap3_twl_set_sr_bit(bool enable)
+{
+	u8 temp;
+	int ret;
+	if (twl_sr_enable_autoinit)
+		pr_warning("%s: unexpected multiple calls\n", __func__);
+
+	ret = twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &temp,
+					TWL4030_DCDC_GLOBAL_CFG);
+	if (ret)
+		goto err;
+
+	if (enable)
+		temp |= SMARTREFLEX_ENABLE;
+	else
+		temp &= ~SMARTREFLEX_ENABLE;
+
+	ret = twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, temp,
+				TWL4030_DCDC_GLOBAL_CFG);
+	if (!ret) {
+		twl_sr_enable_autoinit = true;
+		return 0;
+	}
+err:
+	pr_err("%s: Error access to TWL4030 (%d)\n", __func__, ret);
+	return ret;
+}
-- 
2.17.1
