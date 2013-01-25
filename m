From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/3] ARM: dts: omap: Add omap-usb2 dt data
Date: Fri, 25 Jan 2013 07:54:36 +0530
Message-ID: <1359080677-5381-3-git-send-email-kishon@ti.com>
References: <1359080677-5381-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1359080677-5381-1-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: rob.herring@calxeda.com, rob@landley.net, tony@atomide.com, balbi@ti.com, b-cousson@ti.com, rnayak@ti.com, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, linux@arm.linux.org.uk, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Add omap-usb2 data node in omap4 device tree file. Since omap-usb2 is
connected to ocp2scp, omap-usb2 dt data is added as a child node
of ocp2scp. The information about this data node is availabe @
Documentation/devicetree/bindings/usb/usb-phy.txt

Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index ffc7352..5f68d68 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -438,6 +438,10 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "ocp2scp_usb_phy";
+			usb2_phy: usb2phy@4a0ad080 {
+				compatible = "ti,omap-usb2";
+				reg = <0x4a0ad080 0x58>;
+			};
 		};
 
 		timer1: timer@4a318000 {
-- 
1.7.9.5

