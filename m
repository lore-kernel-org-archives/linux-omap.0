From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP2+: Configure voltage controller for cpcap to
 low-speed
Date: Fri, 18 Oct 2019 15:21:07 -0700
Message-ID: <20191018222107.32917-3-tony@atomide.com>
References: <20191018222107.32917-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191018222107.32917-1-tony@atomide.com>
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
Cc: Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Looks like the i2c timings in high-speed mode do not work properly to
allow us to clear I2C_DISABLE bits for PRM_VOLTCTRL register and the
device reboots if I2C_DISABLE bits are cleared.

Let's configure the voltage controller i2c for low-speed mode as done in
the Motorola Mapphone Android Linux kernel. This saves us about 7mW of
power during retention compared to the high-speed values.

Let's also change the low-speed warning to pr_info about relying on the
bootloader configured low-speed values like we currently do.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pmic-cpcap.c | 18 +++++++++++++-----
 arch/arm/mach-omap2/vc.c         |  2 +-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pmic-cpcap.c b/arch/arm/mach-omap2/pmic-cpcap.c
--- a/arch/arm/mach-omap2/pmic-cpcap.c
+++ b/arch/arm/mach-omap2/pmic-cpcap.c
@@ -61,7 +61,7 @@ static struct omap_voltdm_pmic omap_cpcap_core = {
 	.i2c_slave_addr = 0x02,
 	.volt_reg_addr = 0x00,
 	.cmd_reg_addr = 0x01,
-	.i2c_high_speed = true,
+	.i2c_high_speed = false,
 	.vsel_to_uv = omap_cpcap_vsel_to_uv,
 	.uv_to_vsel = omap_cpcap_uv_to_vsel,
 };
@@ -78,7 +78,7 @@ static struct omap_voltdm_pmic omap_cpcap_iva = {
 	.i2c_slave_addr = 0x44,
 	.volt_reg_addr = 0x0,
 	.cmd_reg_addr = 0x01,
-	.i2c_high_speed = true,
+	.i2c_high_speed = false,
 	.vsel_to_uv = omap_cpcap_vsel_to_uv,
 	.uv_to_vsel = omap_cpcap_uv_to_vsel,
 };
@@ -125,7 +125,7 @@ static struct omap_voltdm_pmic omap443x_max8952_mpu = {
 	.i2c_slave_addr = 0x60,
 	.volt_reg_addr = 0x03,
 	.cmd_reg_addr = 0x03,
-	.i2c_high_speed = true,
+	.i2c_high_speed = false,
 	.vsel_to_uv = omap_max8952_vsel_to_uv,
 	.uv_to_vsel = omap_max8952_uv_to_vsel,
 };
@@ -212,7 +212,7 @@ static struct omap_voltdm_pmic omap4_fan_core = {
 	.vddmax = 1375000,
 	.vp_timeout_us = OMAP4_VP_VLIMITTO_TIMEOUT_US,
 	.i2c_slave_addr = 0x4A,
-	.i2c_high_speed = true,
+	.i2c_high_speed = false,
 	.volt_reg_addr = 0x01,
 	.cmd_reg_addr = 0x01,
 	.vsel_to_uv = omap_fan535508_vsel_to_uv,
@@ -232,7 +232,7 @@ static struct omap_voltdm_pmic omap4_fan_iva = {
 	.i2c_slave_addr = 0x48,
 	.volt_reg_addr = 0x01,
 	.cmd_reg_addr = 0x01,
-	.i2c_high_speed = true,
+	.i2c_high_speed = false,
 	.vsel_to_uv = omap_fan535503_vsel_to_uv,
 	.uv_to_vsel = omap_fan535503_uv_to_vsel,
 };
@@ -263,3 +263,11 @@ int __init omap4_cpcap_init(void)
 
 	return 0;
 }
+
+static int __init cpcap_late_init(void)
+{
+	omap4_vc_set_pmic_signaling(PWRDM_POWER_RET);
+
+	return 0;
+}
+omap_late_initcall(cpcap_late_init);
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -670,7 +670,7 @@ static void __init omap4_vc_i2c_timing_init(struct voltagedomain *voltdm)
 	const struct i2c_init_data *i2c_data;
 
 	if (!voltdm->pmic->i2c_high_speed) {
-		pr_warn("%s: only high speed supported!\n", __func__);
+		pr_info("%s: using bootloader low-speed timings\n", __func__);
 		return;
 	}
 
-- 
2.23.0
