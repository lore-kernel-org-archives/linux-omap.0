From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 12/13] ARM: dts: OMAP3: Add HS USB Host IP nodes
Date: Mon, 4 Feb 2013 17:58:59 +0200
Message-ID: <1359993540-20780-13-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58475 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756219Ab3BDP7s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 10:59:48 -0500
In-Reply-To: <1359993540-20780-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rogerq@ti.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

Adds device nodes for HS USB Host module, TLL module,
OHCI and EHCI controllers.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..39442b4 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -397,5 +397,36 @@
 			ti,timer-alwon;
 			ti,timer-secure;
 		};
+
+		usbhstll: usbhstll@0x48062000 {
+			compatible = "ti,usbhs-tll";
+			reg = <0x48062000 0x1000>;
+			interrupts = <78>;
+			ti,hwmods = "usb_tll_hs";
+		};
+
+		usbhshost: usbhshost@0x48064000 {
+			compatible = "ti,usbhs-host";
+			reg = <0x48064000 0x400>;
+			ti,hwmods = "usb_host_hs";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			usbhsohci: ohci@0x48064400 {
+				compatible = "ti,omap3-ohci", "usb-ohci";
+				reg = <0x48064400 0x400>;
+				interrupt-parent = <&intc>;
+				interrupts = <76>;
+			};
+
+			usbhsehci: ehci@0x48064800 {
+				compatible = "ti,omap-ehci", "usb-ehci";
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

