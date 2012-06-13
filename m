From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 1/2] ARM: OMAP3: cm-t35: add mt9t001 camera sensor support
Date: Wed, 13 Jun 2012 15:55:09 +0300
Message-ID: <1339592110-14312-2-git-send-email-lifshitz@compulab.co.il>
References: <1339592110-14312-1-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339592110-14312-1-git-send-email-lifshitz@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, linux-omap@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Setup pinmux for CPI and register the mt9t001 camera sensor
in ISP subsystem.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |   69 ++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index ded100c..05c66e8 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -490,6 +490,51 @@ static struct twl4030_platform_data cm_t35_twldata = {
 	.power		= &cm_t35_power_data,
 };
 
+#if defined(CONFIG_VIDEO_OMAP3) || defined(CONFIG_VIDEO_OMAP3_MODULE)
+#include <media/omap3isp.h>
+#include "devices.h"
+
+static struct i2c_board_info cm_t35_isp_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("mt9t001", 0x5d),
+	},
+};
+
+static struct isp_subdev_i2c_board_info cm_t35_isp_primary_subdevs[] = {
+	{
+		.board_info = &cm_t35_isp_i2c_boardinfo[0],
+		.i2c_adapter_id = 3,
+	},
+	{ NULL, 0, },
+};
+
+static struct isp_v4l2_subdevs_group cm_t35_isp_subdevs[] = {
+	{
+		.subdevs = cm_t35_isp_primary_subdevs,
+		.interface = ISP_INTERFACE_PARALLEL,
+		.bus = {
+			.parallel = {
+				.clk_pol = 1,
+			},
+		},
+	},
+	{ NULL, 0, },
+};
+
+static struct isp_platform_data cm_t35_isp_pdata = {
+	.subdevs = cm_t35_isp_subdevs,
+};
+
+static void __init cm_t35_init_camera(void)
+{
+	if (omap3_init_camera(&cm_t35_isp_pdata) < 0)
+		pr_warn("CM-T3x: Failed registering camera device!\n");
+}
+
+#else
+static inline void cm_t35_init_camera(void) {}
+#endif /* CONFIG_VIDEO_OMAP3 */
+
 static void __init cm_t35_init_i2c(void)
 {
 	omap3_pmic_get_config(&cm_t35_twldata, TWL_COMMON_PDATA_USB,
@@ -497,6 +542,8 @@ static void __init cm_t35_init_i2c(void)
 			      TWL_COMMON_PDATA_AUDIO);
 
 	omap3_pmic_init("tps65930", &cm_t35_twldata);
+
+	omap_register_i2c_bus(3, 400, NULL, 0);
 }
 
 #ifdef CONFIG_OMAP_MUX
@@ -574,6 +621,27 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP3_MUX(DSS_DATA16, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
 	OMAP3_MUX(DSS_DATA17, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
 
+	/* Camera */
+	OMAP3_MUX(CAM_HS, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_VS, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_XCLKA, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_PCLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_FLD, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_D0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_D1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_D2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_D3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_D4, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_D5, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_D6, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_D7, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(CAM_D8, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+	OMAP3_MUX(CAM_D9, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+	OMAP3_MUX(CAM_STROBE, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+
+	OMAP3_MUX(CAM_D10, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLDOWN),
+	OMAP3_MUX(CAM_D11, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLDOWN),
+
 	/* display controls */
 	OMAP3_MUX(MCBSP1_FSR, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 	OMAP3_MUX(GPMC_NCS7, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
@@ -646,6 +714,7 @@ static void __init cm_t3x_common_init(void)
 
 	usb_musb_init(NULL);
 	cm_t35_init_usbh();
+	cm_t35_init_camera();
 }
 
 static void __init cm_t35_init(void)
-- 
1.7.5.4
