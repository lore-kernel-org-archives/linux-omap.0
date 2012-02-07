From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 5/7] OMAP: sdp4430: Add fixed regulator for twl6040 needs
Date: Tue,  7 Feb 2012 15:01:16 +0200
Message-ID: <1328619678-26080-6-git-send-email-peter.ujfalusi@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-arm-kernel@lists.infradead.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

The twl6040 VIO power is connected to SMPS V1V8, the
V2V1 power is coming from SMPS V2V1 of twl6030.
These are fixed, always on regulators.
Create fixed voltage regulators for these supplies.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   58 +++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index d02172d..5de5753 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -64,6 +64,8 @@
 
 #define FIXED_REG_VBAT_ID	0
 #define FIXED_REG_VWLAN_ID	1
+#define FIXED_REG_V2V1_ID	2
+#define FIXED_REG_V1V8_ID	3
 
 static const int sdp4430_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -349,6 +351,60 @@ static int __init omap_ethernet_init(void)
 	return status;
 }
 
+static struct regulator_consumer_supply sdp4430_vpmic_v2v1_supply[] = {
+	REGULATOR_SUPPLY("v2v1", "1-004b"),
+};
+
+static struct regulator_init_data sdp4430_v2v1smps = {
+	.constraints = {
+		.always_on		= true,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(sdp4430_vpmic_v2v1_supply),
+	.consumer_supplies	= sdp4430_vpmic_v2v1_supply,
+};
+
+static struct fixed_voltage_config sdp4430_v2v1_pdata = {
+	.supply_name	= "VPMIC-V2V1",
+	.microvolts	= 2100000,
+	.init_data	= &sdp4430_v2v1smps,
+	.gpio		= -EINVAL,
+};
+
+static struct platform_device sdp4430_v2v1 = {
+	.name		= "reg-fixed-voltage",
+	.id		= FIXED_REG_V2V1_ID,
+	.dev = {
+		.platform_data = &sdp4430_v2v1_pdata,
+	},
+};
+
+static struct regulator_consumer_supply sdp4430_vpmic_v1v8_supply[] = {
+	REGULATOR_SUPPLY("vio", "1-004b"),
+};
+
+static struct regulator_init_data sdp4430_v1v8smps = {
+	.constraints = {
+		.always_on		= true,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(sdp4430_vpmic_v1v8_supply),
+	.consumer_supplies	= sdp4430_vpmic_v1v8_supply,
+};
+
+static struct fixed_voltage_config sdp4430_v1v8_pdata = {
+	.supply_name	= "VPMIC-V1V8",
+	.microvolts	= 1800000,
+	.init_data	= &sdp4430_v1v8smps,
+	.gpio		= -EINVAL,
+};
+
+static struct platform_device sdp4430_v1v8 = {
+	.name		= "reg-fixed-voltage",
+	.id		= FIXED_REG_V1V8_ID,
+	.dev = {
+		.platform_data = &sdp4430_v1v8_pdata,
+	},
+};
+
 static struct regulator_consumer_supply sdp4430_vbat_supply[] = {
 	REGULATOR_SUPPLY("vddvibl", "twl6040-vibra"),
 	REGULATOR_SUPPLY("vddvibr", "twl6040-vibra"),
@@ -416,6 +472,8 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 	&sdp4430_vbat,
 	&sdp4430_dmic_codec,
 	&sdp4430_abe_audio,
+	&sdp4430_v1v8,
+	&sdp4430_v2v1,
 };
 
 static struct omap_musb_board_data musb_board_data = {
-- 
1.7.8.4
