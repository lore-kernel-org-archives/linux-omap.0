From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 17/32] ARM: dts: omap3-gta04: add camera interface parallel port
Date: Tue, 31 Jul 2018 09:11:20 +0200
Message-ID: <e477d1ce82879e947dbf5ca3579fc94ec667a748.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ladis@linux-mips.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
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
index 28e041ec4e98..3d3876782a00 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -700,3 +700,23 @@
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
