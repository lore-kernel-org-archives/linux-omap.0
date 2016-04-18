From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 4/5] ARM: dts: omap5: describe control for ckobuffer
Date: Mon, 18 Apr 2016 20:21:00 +0200
Message-ID: <a5fb89737594a656318896a8e43814c21ca992eb.1461003660.git.hns@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461003660.git.hns@goldelico.com>
In-Reply-To: <cover.1461003660.git.hns@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

OMAP5 has a register to control if the ckobuffer is enabled
and defines the polarity. ckobuffer is required to drive a twl6040
with the system clock. Hence, add the pinctrl,single to the
OMAP5 SoC description so that omap5-board-common can
set up the ckobuffer as required.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 120b6b8..1d9050f 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -277,6 +277,16 @@
 				pinctrl-single,register-width = <16>;
 				pinctrl-single,function-mask = <0x7fff>;
 			};
+
+			omap5_control_ckobuffer: pinmux@cdb4 {
+				compatible = "ti,omap5-padconf",
+					     "pinctrl-single";
+				reg = <0xcdb4 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-single,register-width = <32>;
+				pinctrl-single,function-mask = <0xf0000000>;
+			};
 		};
 
 		ocmcram: ocmcram@40300000 {
-- 
2.7.3
