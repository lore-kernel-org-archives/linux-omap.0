From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH] ARM: dts: am57xx-idk: Remove support for voltage switching for SD card
Date: Thu, 2 May 2019 14:17:48 +0530
Message-ID: <20190502084748.22518-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: mark.rutland@arm.com, robh+dt@kernel.org, tony@atomide.com, bcousson@baylibre.com, ulf.hansson@linaro.org, adrian.hunter@intel.com
List-Id: linux-omap@vger.kernel.org

If UHS speed modes are enabled, a compatible SD card switches down to
1.8V during enumeration. If after this a software reboot/crash takes
place and on-chip ROM tries to enumerate the SD card, the difference in
IO voltages (host @ 3.3V and card @ 1.8V) may end up damaging the card.

The fix for this is to have support for power cycling the card in
hardware (with a PORz/soft-reset line causing a power cycle of the
card). Since am571x-, am572x- and am574x-idk don't have this
capability, disable voltage switching for these boards.

The major effect of this is that the maximum supported speed
mode is now high speed(50 MHz) down from SDR104(200 MHz).

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index f7bd26458915..42e433da79ec 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -420,6 +420,7 @@
 	vqmmc-supply = <&ldo1_reg>;
 	bus-width = <4>;
 	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>; /* gpio 219 */
+	no-1-8-v;
 };
 
 &mmc2 {
-- 
2.19.2
