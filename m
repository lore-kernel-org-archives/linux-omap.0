From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2] ARM: dts: omap3-gta04: Fix graph_port warning
Date: Wed,  9 Jan 2019 20:01:56 +0100
Message-ID: <97349a696b43af65d62b5d8e795ec3771b5e78bd.1547060514.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, devicetree <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

We're currently getting a warning with make dtbs:

arch/arm/boot/dts/omap3-gta04.dtsi:720.7-727.4: Warning (graph_port):
/ocp@68000000/dss@48050000/encoder@48050c0 0/port: graph node unit
address error, expected "0"

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index e53d32691308..93b420934e8e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -714,11 +714,7 @@
 
 	vdda-supply = <&vdac>;
 
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	port {
-		reg = <0>;
 		venc_out: endpoint {
 			remote-endpoint = <&opa_in>;
 			ti,channels = <1>;
-- 
2.19.1
