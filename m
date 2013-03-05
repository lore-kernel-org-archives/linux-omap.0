From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 5/8] ARM: dts: omap5: Add ocp2scp data
Date: Tue, 5 Mar 2013 20:07:00 +0530
Message-ID: <1362494223-14151-6-git-send-email-kishon@ti.com>
References: <1362494223-14151-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362494223-14151-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, balbi@ti.com, kishon@ti.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add ocp2scp data node in omap5 device tree file. The information for
the node added here can be found @
Documentation/devicetree/bindings/bus/omap-ocp2scp.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index c937500..230b779 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -504,5 +504,13 @@
 			reg-names = "control_dev_conf", "phy_power_usb";
 			ti,type = <2>;
 		};
+
+		ocp2scp {
+			compatible = "ti,omap-ocp2scp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			ti,hwmods = "ocp2scp1";
+		};
 	};
 };
-- 
1.7.10.4
