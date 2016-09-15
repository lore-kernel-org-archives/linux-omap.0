From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: am57xx-beagle-x15-common: Fix wrong pinctrl selection for mmc2
Date: Thu, 15 Sep 2016 14:10:59 -0500
Message-ID: <20160915191059.18190-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Commit d20f997b4d1f ("ARM: dts: am57xx-beagle-x15: Remove pinmux
configurations for erratum i869") fat fingered a change in which
basically replaced mmc2_pinctrl_default with mmc1_pinctrl_default. And
kernel dutifully reports conflict of usage.

[...]
[    4.767335] pinctrl-single 4a003400.pinmux: pin 4a00376c.0 already requested by 4809c000.mmc; cannot claim for 480b4000.mmc
[    4.778976] pinctrl-single 4a003400.pinmux: pin-219 (480b4000.mmc) status -22
[    4.786427] pinctrl-single 4a003400.pinmux: could not request pin 219 (4a00376c.0) from group mmc1_pins_default  on device pinctrl-single
[    4.799328] omap_hsmmc 480b4000.mmc: Error applying setting, reverse things back
[    4.807110] omap_hsmmc 480b4000.mmc: could not initialize pin control state
[...]

But, thanks to the fact that we were in fact setting all the muxes in
U-Boot, all the MMC devices were still properly detected.

Fix the typo.

Fixes: d20f997b4d1f ("ARM: dts: am57xx-beagle-x15: Remove pinmux configurations for erratum i869")

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Patch based on: omap-for-v4.9/dt-pt2-signed git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
Before this patch (as in the original series http://pastebin.ubuntu.com/23124704/ - error visible, but was'nt caught)
After this patch, on rev B1: http://pastebin.ubuntu.com/23183323/

 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index ec85ff9004e8..6df7829a2c15 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -451,7 +451,7 @@
 	status = "okay";
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-0 = <&mmc2_pins_default>;
 
 	vmmc-supply = <&vdd_3v3>;
 	bus-width = <8>;
-- 
2.10.0
