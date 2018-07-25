From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 17/32] ARM: dts: omap3-gta04: add camera interface parallel port
Date: Wed, 25 Jul 2018 08:58:49 +0200
Message-ID: <322301c4b84b8c64b634e3023c0c4767c233560c.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

The GTA04 has an optional OV9655 camera (for which we do
not yet have a driver upstream), but the ISP hardware
connection description in the device tree is independent
of that.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 4947e635c1af..05e24485f765 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -699,3 +699,23 @@
 &mcbsp4 {
 	status = "okay";
 };
+
+/* image signal processor within OMAP3 SoC */
+&isp {
+	ports {
+		port@0 {
+			reg = <0>;
+			parallel_ep: endpoint {
+				ti,isp-clock-divisor = <1>;
+				ti,strobe-mode;
+				bus-width = <8>;/* Used data lines */
+				data-shift = <2>; /* Lines 9:2 are used */
+				hsync-active = <0>; /* Active low */
+				vsync-active = <1>; /* Active high */
+				data-active = <1>;/* Active high */
+				pclk-sample = <1>;/* Falling */
+			};
+		};
+		/* port@1 and port@2 are not used by GTA04 */
+	};
+};
-- 
2.12.2
