From: Koen Kooi <koen@dominion.thruhere.net>
Subject: [PATCHv2 2/2] am335x-boneblack: add eMMC DT entry
Date: Wed, 11 Sep 2013 13:02:27 +0200
Message-ID: <1378897347-11840-3-git-send-email-koen@dominion.thruhere.net>
References: <1378897347-11840-1-git-send-email-koen@dominion.thruhere.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378897347-11840-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---

Changes since v1:
	dropped the ti,non-removable entry per Sehkars request

 arch/arm/boot/dts/am335x-bone-common.dtsi |  7 +++++++
 arch/arm/boot/dts/am335x-boneblack.dts    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index ced256c..9c61fef 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -241,6 +241,13 @@
 			regulator-always-on;
 		};
 	};
+
+	vmmcsd_fixed: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &cpsw_emac0 {
diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 197cadf..f4703cf 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -15,3 +15,17 @@
 	regulator-max-microvolt = <1800000>;
 	regulator-always-on;
 };
+
+&mmc1 { 
+	vmmc-supply = <&vmmcsd_fixed>;
+};
+
+&mmc2 { 
+	vmmc-supply = <&vmmcsd_fixed>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_pins>;
+	bus-width = <8>;
+	status = "okay";
+	ti,vcc-aux-disable-is-sleep;
+};
+
-- 
1.8.2.1
