From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/2] ARM: dts: omap3-igep0030: Use MMC pwrseq to init SDIO WiFi
Date: Thu,  3 Dec 2015 15:02:09 -0300
Message-ID: <1449165729-993-3-git-send-email-javier@osg.samsung.com>
References: <1449165729-993-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449165729-993-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

When the WiFi support was added to the IGEP0030 board, the MMC subsystem
did not provide a mechanism to define power sequence providers. So a DT
hack was used to toggle the WiFi chip reset and power down pins by using
fake fixed regulators whose enable GPIO was the GPIOs connected to these
pins.

But now the simple MMC power sequence provider can be used for this and
the workaround removed.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/omap3-igep0030.dts | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 468608dab30a..55b0cc4f5ee5 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -15,25 +15,17 @@
 	model = "IGEP COM MODULE Rev. E (TI OMAP AM/DM37x)";
 	compatible = "isee,omap3-igep0030", "ti,omap36xx", "ti,omap3";
 
-	/* Regulator to trigger the WIFI_PDN signal of the Wifi module */
-	lbee1usjyc_pdn: lbee1usjyc_pdn {
+	vmmcsdio_fixed: fixedregulator-mmcsdio {
 		compatible = "regulator-fixed";
-		regulator-name = "regulator-lbee1usjyc-pdn";
+		regulator-name = "vmmcsdio_fixed";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;	/* gpio_138 - WIFI_PDN */
-		startup-delay-us = <10000>;
-		enable-active-high;
 	};
 
-	/* Regulator to trigger the RESET_N_W signal of the Wifi module */
-	lbee1usjyc_reset_n_w: lbee1usjyc_reset_n_w {
-		compatible = "regulator-fixed";
-		regulator-name = "regulator-lbee1usjyc-reset-n-w";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 11 GPIO_ACTIVE_HIGH>;	/* gpio_139 - RESET_N_W */
-		enable-active-high;
+	mmc2_pwrseq: mmc2_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>,	/* gpio_139 - RESET_N_W */
+			      <&gpio5 10 GPIO_ACTIVE_LOW>;	/* gpio_138 - WIFI_PDN */
 	};
 };
 
@@ -62,8 +54,8 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins &lbee1usjyc_pins>;
-	vmmc-supply = <&lbee1usjyc_pdn>;
-	vmmc_aux-supply = <&lbee1usjyc_reset_n_w>;
+	vmmc-supply = <&vmmcsdio_fixed>;
+	mmc-pwrseq = <&mmc2_pwrseq>;
 	bus-width = <4>;
 	non-removable;
 };
-- 
2.4.3
