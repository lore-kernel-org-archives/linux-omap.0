From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 8/8] ARM: dts: omap5: add dwc3 core dt data
Date: Tue, 5 Mar 2013 20:07:03 +0530
Message-ID: <1362494223-14151-9-git-send-email-kishon@ti.com>
References: <1362494223-14151-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362494223-14151-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, balbi@ti.com, kishon@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add dwc3 core dt data as a subnode to dwc3 omap glue data in omap5 dt
data file. The information for the entered data node is available @
Documentation/devicetree/bindings/usb/dwc3.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index c4eb2ec..24dd69f 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -514,6 +514,13 @@
 			#size-cells = <1>;
 			utmi-mode = <2>;
 			ranges;
+			dwc3@4a030000 {
+				compatible = "synopsys,dwc3";
+				reg = <0x4a030000 0x1000>;
+				interrupts = <0 92 4>;
+				usb-phy = <&usb2_phy>, <&usb3_phy>;
+				tx-fifo-resize;
+			};
 		};
 
 		ocp2scp {
-- 
1.7.10.4
