From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/4] ARM: dts: OMAP36xx: Add device node for ABB
Date: Wed, 29 Jan 2014 17:46:13 -0600
Message-ID: <1391039177-25284-2-git-send-email-nm@ti.com>
References: <1391039177-25284-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391039177-25284-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Add ABB device node for OMAP36xx family of devices. Data is based on
OMAP36XX Technical Reference Manual revision AB (Dec 2012).

[nm@ti.com: co-developer]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 arch/arm/boot/dts/omap36xx.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 7e8dee9..ba077cd 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -39,6 +39,26 @@
 			clock-frequency = <48000000>;
 		};
 
+		abb_mpu_iva: regulator-abb-mpu {
+			compatible = "ti,abb-v1";
+			regulator-name = "abb_mpu_iva";
+			#address-cell = <0>;
+			#size-cells = <0>;
+			reg = <0x483072f0 0x8>, <0x48306818 0x4>;
+			reg-names = "base-address", "int-address";
+			ti,tranxdone-status-mask = <0x4000000>;
+			clocks = <&sys_ck>;
+			ti,settling-time = <30>;
+			ti,clock-cycles = <8>;
+			ti,abb_info = <
+			/*uV		ABB	efuse	rbb_m	fbb_m	vset_m*/
+			1012500		0	0	0	0	0
+			1200000		0	0	0	0	0
+			1325000		0	0	0	0	0
+			1375000		1	0	0	0	0
+			>;
+		};
+
 		omap3_pmx_core2: pinmux@480025a0 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
 			reg = <0x480025a0 0x5c>;
-- 
1.7.9.5
