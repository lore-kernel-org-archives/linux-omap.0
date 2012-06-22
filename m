From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 07/10] arm/dts: Add twl4030-usb data
Date: Fri, 22 Jun 2012 19:02:16 +0530
Message-ID: <1340371939-23572-8-git-send-email-kishon@ti.com>
References: <1340371939-23572-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1340371939-23572-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, kishon@ti.com, b-cousson@ti.com, rnayak@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add twl4030-usb data node in twl4030 device tree file.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/twl4030.dtsi |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 22f4d13..66534a3 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -37,6 +37,18 @@
 		regulator-max-microvolt = <3150000>;
 	};
 
+	vusb1v5: regulator@3 {
+		compatible = "ti,twl4030-vusb1v5";
+	};
+
+	vusb1v8: regulator@4 {
+		compatible = "ti,twl4030-vusb1v8";
+	};
+
+	vusb3v1: regulator@5 {
+		compatible = "ti,twl4030-vusb3v1";
+	};
+
 	twl_gpio: gpio {
 		compatible = "ti,twl4030-gpio";
 		gpio-controller;
@@ -44,4 +56,13 @@
 		interrupt-controller;
 		#interrupt-cells = <1>;
 	};
+
+	twl4030-usb {
+		compatible = "ti,twl4030-usb";
+		interrupts = < 10 4 >;
+		usb1v5-supply = <&vusb1v5>;
+		usb1v8-supply = <&vusb1v8>;
+		usb3v1-supply = <&vusb3v1>;
+		usb_mode = <1>;
+	};
 };
-- 
1.7.5.4
