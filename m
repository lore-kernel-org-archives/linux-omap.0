From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: omap2plus_defconfig: Enable droid 4 devices
Date: Sun,  9 Apr 2017 16:28:40 -0700
Message-ID: <20170409232840.19927-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We only need to have MFD_CPCAP and CPCAP_REGULATOR as built-in to
be able to mount root on the eMMC. And then POWER_RESET_GPIO
is good to have built-in. The rest of the devices can be loadable
modules.

This gets various devices such as regulators, touchscreen, power
button, charger, HDMI audio, LEDs, RTC, ADC, and USB working.

Note that omapdrm needs to be configured manually as we're still
using omapfb by default.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -213,6 +213,7 @@ CONFIG_KEYBOARD_TWL4030=m
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=m
+CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
 CONFIG_TOUCHSCREEN_PIXCIR=m
@@ -220,6 +221,7 @@ CONFIG_TOUCHSCREEN_TSC2004=m
 CONFIG_TOUCHSCREEN_TSC2005=m
 CONFIG_TOUCHSCREEN_TSC2007=m
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_CPCAP_PWRBUTTON=m
 CONFIG_INPUT_TPS65218_PWRBUTTON=m
 CONFIG_INPUT_TWL4030_PWRBUTTON=m
 CONFIG_INPUT_PALMAS_PWRBUTTON=m
@@ -256,7 +258,9 @@ CONFIG_W1=m
 CONFIG_HDQ_MASTER_OMAP=m
 CONFIG_POWER_AVS=y
 CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_GPIO=y
 CONFIG_BATTERY_BQ27XXX=m
+CONFIG_CHARGER_CPCAP=m
 CONFIG_CHARGER_ISP1704=m
 CONFIG_CHARGER_TWL4030=m
 CONFIG_CHARGER_BQ2415X=m
@@ -278,6 +282,7 @@ CONFIG_DRA752_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_OMAP_WATCHDOG=m
 CONFIG_TWL4030_WATCHDOG=m
+CONFIG_MFD_CPCAP=y
 CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
@@ -285,7 +290,9 @@ CONFIG_MFD_TI_LP873X=y
 CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS65910=y
 CONFIG_TWL6040_CORE=y
+CONFIG_REGULATOR_CPCAP=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_LM363X=m
 CONFIG_REGULATOR_LP872X=y
 CONFIG_REGULATOR_LP873X=y
 CONFIG_REGULATOR_PALMAS=y
@@ -354,6 +361,7 @@ CONFIG_SND_SOC=m
 CONFIG_SND_EDMA_SOC=m
 CONFIG_SND_AM33XX_SOC_EVM=m
 CONFIG_SND_OMAP_SOC=m
+CONFIG_SND_OMAP_SOC_HDMI_AUDIO=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
@@ -418,6 +426,7 @@ CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_CPCAP=m
 CONFIG_LEDS_GPIO=m
 CONFIG_LEDS_PCA963X=m
 CONFIG_LEDS_PWM=m
@@ -436,6 +445,7 @@ CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=m
 CONFIG_RTC_DRV_PALMAS=m
 CONFIG_RTC_DRV_OMAP=m
+CONFIG_RTC_DRV_CPCAP=m
 CONFIG_DMADEVICES=y
 CONFIG_DMA_OMAP=y
 CONFIG_TI_EDMA=y
@@ -448,6 +458,7 @@ CONFIG_IIO=m
 CONFIG_IIO_SW_DEVICE=m
 CONFIG_IIO_SW_TRIGGER=m
 CONFIG_IIO_ST_ACCEL_3AXIS=m
+CONFIG_CPCAP_ADC=m
 CONFIG_TI_AM335X_ADC=m
 CONFIG_BMP280=m
 CONFIG_PWM=y
@@ -456,6 +467,7 @@ CONFIG_PWM_TIECAP=m
 CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_TWL=m
 CONFIG_PWM_TWL_LED=m
+CONFIG_PHY_CPCAP_USB=m
 CONFIG_PHY_DM816X_USB=m
 CONFIG_OMAP_USB2=m
 CONFIG_TI_PIPE3=y
-- 
2.12.2
