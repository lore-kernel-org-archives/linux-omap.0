From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 6/8] ARM: dts: omap4-droid4: Add accelerometer
Date: Thu,  2 Mar 2017 02:08:58 +0100
Message-ID: <20170302010900.28532-7-sre@kernel.org>
References: <20170302010900.28532-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302010900.28532-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 71e1769e9b0f..479cd5e5de83 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -206,4 +206,18 @@
 				  "0", "0", "-1";
 
 	};
+
+	lis3dh: accelerometer@18 {
+		compatible = "st,lis3dh-accel";
+		reg = <0x18>;
+
+		vdd-supply = <&vhvio>;
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <2 IRQ_TYPE_EDGE_BOTH>; /* gpio34 */
+
+		rotation-matrix = "0", "-1", "0",
+				  "1", "0", "0",
+				  "0", "0", "1";
+	};
 };
-- 
2.11.0
