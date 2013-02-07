From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 12/14] ARM: dts: OMAP3: Add HS USB Host IP nodes
Date: Thu, 7 Feb 2013 18:02:52 +0200
Message-ID: <1360252974-7912-13-git-send-email-rogerq@ti.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360252974-7912-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, balbi@ti.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, linux@arm.linux.org.uk, kishon@ti.com, mark.rutland@arm.com, rogerq@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Adds device nodes for HS USB Host module, TLL module,
OHCI and EHCI controllers.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..a14f74b 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -397,5 +397,36 @@
 			ti,timer-alwon;
 			ti,timer-secure;
 		};
+
+		usbhstll: usbhstll@48062000 {
+			compatible = "ti,usbhs-tll";
+			reg = <0x48062000 0x1000>;
+			interrupts = <78>;
+			ti,hwmods = "usb_tll_hs";
+		};
+
+		usbhshost: usbhshost@48064000 {
+			compatible = "ti,usbhs-host";
+			reg = <0x48064000 0x400>;
+			ti,hwmods = "usb_host_hs";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			usbhsohci: ohci@48064400 {
+				compatible = "ti,ohci-omap3", "usb-ohci";
+				reg = <0x48064400 0x400>;
+				interrupt-parent = <&intc>;
+				interrupts = <76>;
+			};
+
+			usbhsehci: ehci@48064800 {
+				compatible = "ti,ehci-omap", "usb-ehci";
+				reg = <0x48064800 0x400>;
+				interrupt-parent = <&intc>;
+				interrupts = <77>;
+			};
+		};
+
 	};
 };
-- 
1.7.4.1
