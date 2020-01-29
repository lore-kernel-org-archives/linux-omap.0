From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] ARM: dts: keystone-k2g: Add DSS node
Date: Wed, 29 Jan 2020 19:03:02 +0200
Message-ID: <0744088604f744e1263805082f4c2e6c2382e28c.1580317147.git.jsarha@ti.com>
References: <cover.1580317147.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1580317147.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: tomi.valkeinen-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, bparrot-l0cyMroinI0@public.gmane.org, praneeth-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add DT node for DSS. K2G has DSS version 6. Keystone family DSS are
somewhat different compered to the old OMAP family DSSes and the
binding looks different too.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 1c833105d6c5..08ba31780baa 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -324,6 +324,28 @@
 			clock-names = "gpio";
 		};
 
+		dss: dss@02540000 {
+			compatible = "ti,k2g-dss";
+			reg =	<0x02540000 0x400>,
+				<0x02550000 0x1000>,
+				<0x02557000 0x1000>,
+				<0x0255a800 0x100>,
+				<0x0255ac00 0x100>;
+			reg-names = "cfg", "common", "vid1", "ovr1", "vp1";
+			clocks =	<&k2g_clks 0x2 0>,
+					<&k2g_clks 0x2 1>;
+			clock-names = "fck", "vp1";
+			interrupts = <GIC_SPI 247 IRQ_TYPE_EDGE_RISING>;
+
+			power-domains = <&k2g_pds 0x2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			max-memory-bandwidth = <230000000>;
+		};
+
 		edma0: edma@2700000 {
 			compatible = "ti,k2g-edma3-tpcc", "ti,edma3-tpcc";
 			reg =	<0x02700000 0x8000>;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
