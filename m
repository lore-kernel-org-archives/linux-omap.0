From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 10/11] ARM: dts: DRA7: Modify pcie1 dt node for EP mode
Date: Wed, 14 Sep 2016 10:42:06 +0530
Message-ID: <1473829927-20466-11-git-send-email-kishon@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473829927-20466-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, mingkai.hu-3arQi8VN3Tc@public.gmane.org, m-karicheri2-l0cyMroinI0@public.gmane.org, Pratyush Anand <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Joao Pinto <jpinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kishon-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Modify pcie1 dt node in order for the controller to operate in
endpoint mode. This is used only for testing EP mode.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi |   43 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d9bfb94..73f63d1 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -283,38 +283,17 @@
 			};
 		};
 
-		axi@0 {
-			compatible = "simple-bus";
-			#size-cells = <1>;
-			#address-cells = <1>;
-			ranges = <0x51000000 0x51000000 0x3000
-				  0x0	     0x20000000 0x10000000>;
-			pcie1: pcie@51000000 {
-				compatible = "ti,dra7-pcie";
-				reg = <0x51000000 0x2000>, <0x51002000 0x14c>, <0x1000 0x2000>;
-				reg-names = "rc_dbics", "ti_conf", "config";
-				interrupts = <0 232 0x4>, <0 233 0x4>;
-				#address-cells = <3>;
-				#size-cells = <2>;
-				device_type = "pci";
-				ranges = <0x81000000 0 0          0x03000 0 0x00010000
-					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
-				#interrupt-cells = <1>;
-				num-lanes = <1>;
-				ti,hwmods = "pcie1";
-				phys = <&pcie1_phy>;
-				phy-names = "pcie-phy0";
-				interrupt-map-mask = <0 0 0 7>;
-				interrupt-map = <0 0 0 1 &pcie1_intc 1>,
-						<0 0 0 2 &pcie1_intc 2>,
-						<0 0 0 3 &pcie1_intc 3>,
-						<0 0 0 4 &pcie1_intc 4>;
-				pcie1_intc: interrupt-controller {
-					interrupt-controller;
-					#address-cells = <0>;
-					#interrupt-cells = <1>;
-				};
-			};
+		pcie1: pcie@51000000 {
+			compatible = "ti,dra7-pcie-ep";
+			reg = <0x51000000 0x28>, <0x51002000 0x14c>, <0x51001000 0x28>;
+			reg-names = "ep_dbics", "ti_conf", "ep_dbics2";
+			interrupts = <0 232 0x4>;
+			num-lanes = <1>;
+			num-ib-windows = <4>;
+			num-ob-windows = <16>;
+			ti,hwmods = "pcie1";
+			phys = <&pcie1_phy>;
+			phy-names = "pcie-phy0";
 		};
 
 		axi@1 {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
