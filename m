From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH v3 1/2] dt-bindings: regulator: extend tps65218 bindings
Date: Mon, 14 Jan 2019 09:16:33 +0100
Message-ID: <1547453794-18770-2-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add input voltage configuration options

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/regulator/tps65218.txt     | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
index 02f0e9b..982597d 100644
--- a/Documentation/devicetree/bindings/regulator/tps65218.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -16,12 +16,34 @@ Required properties:
   regulator-dcdc5, regulator-dcdc6, regulator-ldo1, regulator-ls3.
   Each regulator is defined using the standard binding for regulators.
 
+Optional properties:
+  If any of these properties is absent then the corresponding setting will be
+  untouched.
+- ti,strict-supply-voltage-supervision: Set/Reset STRICT flag in CONFIG1.
+  The supervisor has two modes of operation, controlled by the STRICT bit.
+  With the STRICT bit set to 0, all five rails are monitored for under-voltage
+  only with relaxed thresholds and deglitch times.
+  With the STRCT bit set to 1, all five rails are monitored for under-voltage
+  and over-voltage with tight limits and short deglitch times.
+- ti,under-voltage-limit-microvolt: Configures UVLO in CONFIG1.
+  Valid values are: 2750000, 2950000, 3250000, 3350000
+- ti,under-voltage-hyst-microvolt: Select 200mV or 400mV UVLOHYS in CONFIG2
+  Power rails are only enabled if the input voltage measured at the IN_BIAS pin
+  is greater than the under-voltage lockout threshold plus hysteresis
+  (UVLO + UVLOHYS). Once the input voltage rises above this level,
+  the input voltage may drop to the UVLO level before the PMIC shuts down.
+  UVLO is deglitched by 5 ms on rising and falling edge.
+
 Example:
 tps65218: tps65218@24 {
 	reg = <0x24>;
 	compatible = "ti,tps65218";
 	interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
 	interrupt-controller;
+	ti,strict-supply-voltage-supervision = <1>;
+	ti,under-voltage-hyst-microvolt = <400000>;
+	ti,under-voltage-limit-microvolt = <3350000>;
+
 	#interrupt-cells = <2>;
 
 	dcdc1: regulator-dcdc1 {
-- 
2.7.4
