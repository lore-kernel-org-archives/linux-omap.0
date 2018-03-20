From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] ARM: multi_v7_defconfig: Enable CPCAP related options
 mostly as loadable modules
Date: Tue, 20 Mar 2018 07:16:22 -0700
Message-ID: <20180320141622.77989-6-tony@atomide.com>
References: <20180320141622.77989-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180320141622.77989-1-tony@atomide.com>
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

We need the CPCAP MFD and regulator built-in for UART console to work,
the rest can be loadable modules. Note that users probably want to also
enable serial 8250_OMAP that is not yet enabled by default.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/multi_v7_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -307,6 +307,7 @@ CONFIG_TOUCHSCREEN_WM97XX=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MAX77693_HAPTIC=m
 CONFIG_INPUT_MAX8997_HAPTIC=m
+CONFIG_INPUT_CPCAP_PWRBUTTON=m
 CONFIG_INPUT_AXP20X_PEK=m
 CONFIG_INPUT_ADXL34X=m
 CONFIG_SERIO_AMBAKMI=y
@@ -438,9 +439,11 @@ CONFIG_GPIO_SYSCON=y
 CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_BATTERY_ACT8945A=y
+CONFIG_BATTERY_CPCAP=m
 CONFIG_BATTERY_SBS=y
 CONFIG_BATTERY_MAX17040=m
 CONFIG_BATTERY_MAX17042=m
+CONFIG_CHARGER_CPCAP=m
 CONFIG_CHARGER_MAX14577=m
 CONFIG_CHARGER_MAX77693=m
 CONFIG_CHARGER_MAX8997=m
@@ -508,6 +511,7 @@ CONFIG_MFD_MAX8907=y
 CONFIG_MFD_MAX8997=y
 CONFIG_MFD_MAX8998=y
 CONFIG_MFD_RK808=y
+CONFIG_MFD_CPCAP=y
 CONFIG_MFD_PM8XXX=y
 CONFIG_MFD_QCOM_RPM=y
 CONFIG_MFD_SPMI_PMIC=y
@@ -527,6 +531,7 @@ CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_BCM590XX=y
+CONFIG_REGULATOR_CPCAP=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_RK808=y
@@ -674,6 +679,7 @@ CONFIG_SND_SOC_TEGRA_WM8903=m
 CONFIG_SND_SOC_TEGRA_WM9712=m
 CONFIG_SND_SOC_TEGRA_TRIMSLICE=m
 CONFIG_SND_SOC_TEGRA_ALC5632=m
+CONFIG_SND_SOC_CPCAP=m
 CONFIG_SND_SOC_TEGRA_MAX98090=m
 CONFIG_SND_SOC_AK4642=m
 CONFIG_SND_SOC_SGTL5000=m
@@ -787,6 +793,7 @@ CONFIG_MMC_SDHCI_OMAP=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_CLASS_FLASH=m
+CONFIG_LEDS_CPCAP=m
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_PWM=y
 CONFIG_LEDS_MAX77693=m
@@ -837,6 +844,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_RTC_DRV_TEGRA=y
+CONFIG_RTC_DRV_CPCAP=m
 CONFIG_DMADEVICES=y
 CONFIG_DW_DMAC=y
 CONFIG_AT_HDMAC=y
@@ -909,6 +917,7 @@ CONFIG_IIO_SW_TRIGGER=y
 CONFIG_AT91_ADC=m
 CONFIG_AT91_SAMA5D2_ADC=m
 CONFIG_BERLIN2_ADC=m
+CONFIG_CPCAP_ADC=m
 CONFIG_EXYNOS_ADC=m
 CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
-- 
2.16.2
