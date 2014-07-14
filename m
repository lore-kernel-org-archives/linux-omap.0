From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RESEND PATCH 8/8] ARM: dts: dra7: Add dt data for PCIe controller
Date: Mon, 14 Jul 2014 16:12:23 +0530
Message-ID: <1405334543-25509-9-git-send-email-kishon@ti.com>
References: <1405334543-25509-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405334543-25509-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Added dt data for PCIe controller. This node contains dt data for
both the DRA7 part of designware controller and for the designware core.
The documention for this node can be found @ ../bindings/pci/ti-pci.txt.

Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi |   69 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index cbaf47d..b6060d3 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -99,6 +99,75 @@
 			};
 		};
 
+		axi@0 {
+			compatible = "simple-bus";
+			#size-cells = <1>;
+			#address-cells = <1>;
+			ranges = <0x51000000 0x51000000 0x3000
+				  0x0	     0x20000000 0x10000000>;
+			pcie@51000000 {
+				compatible = "ti,dra7-pcie";
+				reg = <0x51000000 0x2000>, <0x51002000 0x14c>, <0x1000 0x2000>;
+				reg-names = "rc_dbics", "ti_conf", "config";
+				interrupts = <0 232 0x4>, <0 233 0x4>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges = <0x81000000 0 0          0x03000 0 0x00010000
+					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
+				#interrupt-cells = <1>;
+				num-lanes = <1>;
+				ti,hwmods = "pcie1";
+				phys = <&pcie1_phy>;
+				phy-names = "pcie-phy0";
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie1_intc 1>,
+						<0 0 0 2 &pcie1_intc 2>,
+						<0 0 0 3 &pcie1_intc 3>,
+						<0 0 0 4 &pcie1_intc 4>;
+				pcie1_intc: interrupt-controller {
+					interrupt-controller;
+					#address-cells = <0>;
+					#interrupt-cells = <1>;
+				};
+			};
+		};
+
+		axi@1 {
+			compatible = "simple-bus";
+			#size-cells = <1>;
+			#address-cells = <1>;
+			ranges = <0x51800000 0x51800000 0x3000
+				  0x0	     0x30000000 0x10000000>;
+			status = "disabled";
+			pcie@51000000 {
+				compatible = "ti,dra7-pcie";
+				reg = <0x51800000 0x2000>, <0x51802000 0x14c>, <0x1000 0x2000>;
+				reg-names = "rc_dbics", "ti_conf", "config";
+				interrupts = <0 355 0x4>, <0 356 0x4>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
+				ranges = <0x81000000 0 0          0x03000 0 0x00010000
+					  0x82000000 0 0x30013000 0x13000 0 0xffed000>;
+				#interrupt-cells = <1>;
+				num-lanes = <1>;
+				ti,hwmods = "pcie2";
+				phys = <&pcie2_phy>;
+				phy-names = "pcie-phy0";
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie2_intc 1>,
+						<0 0 0 2 &pcie2_intc 2>,
+						<0 0 0 3 &pcie2_intc 3>,
+						<0 0 0 4 &pcie2_intc 4>;
+				pcie2_intc: interrupt-controller {
+					interrupt-controller;
+					#address-cells = <0>;
+					#interrupt-cells = <1>;
+				};
+			};
+		};
+
 		cm_core_aon: cm_core_aon@4a005000 {
 			compatible = "ti,dra7-cm-core-aon";
 			reg = <0x4a005000 0x2000>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
