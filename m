From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 3/5] ARM: dts: omap5: fix range of permitted wakeup pinmux registers
Date: Mon, 18 Apr 2016 20:20:59 +0200
Message-ID: <df4871d061d698cbee340000a2665ed3b4e44738.1461003660.git.hns@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461003660.git.hns@goldelico.com>
In-Reply-To: <cover.1461003660.git.hns@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

otherwise we can't define gpio1_wk14

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 38805eb..120b6b8 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -269,7 +269,7 @@
 			omap5_pmx_wkup: pinmux@c840 {
 				compatible = "ti,omap5-padconf",
 					     "pinctrl-single";
-				reg = <0xc840 0x0038>;
+				reg = <0xc840 0x003c>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#interrupt-cells = <1>;
-- 
2.7.3
