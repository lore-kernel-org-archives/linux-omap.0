From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 10/20] ARM: DTS: am437x-gp-evm: Rename fixed regulator vmmcsd_fixed to evm_v3_3d
Date: Thu, 2 Jul 2015 17:06:25 +0300
Message-ID: <1435845995-19085-11-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

The same regulator is used by other chips on the board. The power path is:
VBAT -> TPS63031 - Enable signal is V1_8D regulator -> V3_3D.
V3_3D is used by SD slot and tlv320aic3106 codec as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index e2fb2713333d..e0ce7ce0a201 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -24,9 +24,9 @@
 		serial3 = &uart3;
 	};
 
-	vmmcsd_fixed: fixedregulator-sd {
+	evm_v3_3d: fixedregulator-v3_3d {
 		compatible = "regulator-fixed";
-		regulator-name = "vmmcsd_fixed";
+		regulator-name = "evm_v3_3d";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
@@ -567,7 +567,7 @@
 
 &mmc1 {
 	status = "okay";
-	vmmc-supply = <&vmmcsd_fixed>;
+	vmmc-supply = <&evm_v3_3d>;
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-- 
2.4.5
