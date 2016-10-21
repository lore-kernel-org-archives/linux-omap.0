From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 3/7] ARM: dts: tps65217: Add the power button device
Date: Fri, 21 Oct 2016 23:01:02 +0900
Message-ID: <20161021140106.21531-4-woogyom.kim@gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021140106.21531-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

Support the power button driver and disable it by default.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/tps65217.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 8f77d0d..02de56b 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -21,6 +21,11 @@
 		status = "disabled";
 	};
 
+	pwrbutton {
+		compatible = "ti,tps65217-pwrbutton";
+		status = "disabled";
+	};
+
 	regulators {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.9.3
