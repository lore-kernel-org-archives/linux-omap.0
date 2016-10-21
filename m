From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 6/7] ARM: dts: am335x: Add the power button interrupt
Date: Fri, 21 Oct 2016 23:01:05 +0900
Message-ID: <20161021140106.21531-7-woogyom.kim@gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021140106.21531-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

This enables the power button driver gets corresponding IRQ number by
using platform_get_irq().

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index cec9d91..0c0a90c 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -324,6 +324,11 @@
 		status = "okay";
 	};
 
+	pwrbutton {
+		interrupts = <TPS65217_IRQ_PB>;
+		status = "okay";
+	};
+
 	regulators {
 		dcdc1_reg: regulator@0 {
 			regulator-name = "vdds_dpr";
-- 
2.9.3
