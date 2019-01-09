From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2] arm: dts: gta04: add bluetooth serdev driver flags
Date: Wed,  9 Jan 2019 18:47:52 +0100
Message-ID: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, letux-kernel@openphoenux.org, Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

gta04a[34] have bluetooth chips which simply understand
h4 protocol.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 499e3b0e920b..ec7b1e31c07e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -722,6 +722,8 @@
 
 	bluetooth: bluetooth {
 		compatible = "wi2wi,w2cbw003-bluetooth";
+		speed = <3000000>;
+		flow;
 		vdd-supply = <&vaux4>;
 	};
 };
-- 
2.19.1
