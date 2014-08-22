From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/6] ARM: dts: DRA7: switch to compatible pinctrl
Date: Fri, 22 Aug 2014 09:03:52 -0500
Message-ID: <1408716235-26164-4-git-send-email-nm@ti.com>
References: <1408716235-26164-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408716235-26164-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Now that ti,dra7-padconf is available, switch over to that compatible
property. Retain pinctrl-single for legacy support.

While at it, mark pinctrl as interrupt controller so that it can be used
with interrupts-extended property for wakeup events.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 7a3e011..4e4ce96 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -218,10 +218,12 @@
 		};
 
 		dra7_pmx_core: pinmux@4a003400 {
-			compatible = "pinctrl-single";
+			compatible = "ti,dra7-padconf", "pinctrl-single";
 			reg = <0x4a003400 0x0464>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0x3fffffff>;
 		};
-- 
1.7.9.5
