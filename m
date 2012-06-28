From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 06/11] arm/dts: Add twl6030-usb data
Date: Thu, 28 Jun 2012 17:21:02 +0530
Message-ID: <1340884267-28908-7-git-send-email-kishon@ti.com>
References: <1340884267-28908-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340884267-28908-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, b-cousson@ti.com, rnayak@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: hvaibhav@ti.com
List-Id: linux-omap@vger.kernel.org

Add twl6030-usb data node in twl6030 device tree file

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/twl6030.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 3b2f351..6526366 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -83,4 +83,11 @@
 	clk32kg: regulator@12 {
 		compatible = "ti,twl6030-clk32kg";
 	};
+
+	twl6030-usb {
+		compatible = "ti,twl6030-usb";
+		interrupts = < 4 10 >;
+		regulator = "vusb";
+		vusb-supply = <&vusb>;
+	};
 };
-- 
1.7.5.4
