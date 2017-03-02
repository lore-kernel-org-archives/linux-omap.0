From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 5/8] ARM: dts: omap4-droid4: Add compass
Date: Thu,  2 Mar 2017 02:08:57 +0100
Message-ID: <20170302010900.28532-6-sre@kernel.org>
References: <20170302010900.28532-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302010900.28532-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index e9cffc375695..71e1769e9b0f 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -190,3 +190,20 @@
 	mode = <3>;
 	power = <50>;
 };
+
+&i2c4 {
+	ak8975: magnetometer@c {
+		compatible = "asahi-kasei,ak8975";
+		reg = <0x0c>;
+
+		vdd-supply = <&vhvio>;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <15 IRQ_TYPE_EDGE_RISING>; /* gpio175 */
+
+		rotation-matrix = "-1", "0", "0",
+				  "0", "1", "0",
+				  "0", "0", "-1";
+
+	};
+};
-- 
2.11.0
