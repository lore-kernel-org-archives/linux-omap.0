From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 2/8] ARM: DTS: am33xx: add sgx gpu child node
Date: Sun, 24 Nov 2019 12:40:22 +0100
Message-ID: <2ae609d6958727723ebaea2cfb62b547b38c23ee.1574595627.git.hns@goldelico.com>
References: <cover.1574595627.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1574595627.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

and add timer and interrupt

Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # BeagleBone Black
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 38 +++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index a9d848d50b20..1fbc8a2cc7fd 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -480,13 +480,43 @@
 			#size-cells = <1>;
 			ranges = <0 0x56000000 0x1000000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			sgx: gpu@0 {
+				compatible = "ti,am3352-sgx530-125", "img,sgx530-125", "img,sgx530";
+				reg = <0x00 0x1000000>;	/* 16 MB */
+				interrupts = <37>;
+			};
 		};
 	};
 };
 
 #include "am33xx-l4.dtsi"
 #include "am33xx-clocks.dtsi"
+
+&prcm {
+	prm_per: prm@c00 {
+		compatible = "ti,am3-prm-inst";
+		reg = <0xc00 0x100>;
+		#reset-cells = <1>;
+		clocks = <&pruss_ocp_clkctrl AM3_PRUSS_OCP_PRUSS_CLKCTRL 0>;
+	};
+
+	prm_wkup: prm@d00 {
+		compatible = "ti,am3-prm-inst";
+		reg = <0xd00 0x100>;
+		#reset-cells = <1>;
+		clocks = <&l4_wkup_clkctrl AM3_WKUP_M3_CLKCTRL 0>;
+	};
+
+	prm_device: prm@f00 {
+		compatible = "ti,am3-prm-inst";
+		reg = <0xf00 0x100>;
+		#reset-cells = <1>;
+	};
+
+	prm_gfx: prm@1100 {
+		compatible = "ti,am3-prm-inst";
+		reg = <0x1100 0x100>;
+		#reset-cells = <1>;
+		clocks = <&gfx_l3_clkctrl AM3_GFX_CLKCTRL 0>;
+	};
+};
-- 
2.23.0
