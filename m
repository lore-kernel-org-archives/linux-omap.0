From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 03/11] ARM: OMAP3: USB: Add USB2 Host Device Tree Node
Date: Wed, 31 Oct 2012 17:46:41 +0530
Message-ID: <1351685810-20616-4-git-send-email-keshava_mgowda@ti.com>
References: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54831 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935482Ab2JaMRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 08:17:03 -0400
In-Reply-To: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com

The device tree node details of usb2 host and tll components
are included for OMAP3

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 696e929..5c805d7 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -300,5 +300,27 @@
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp5";
 		};
+
+		usbhs: usbhs@0x4a064000 {
+			compatible = "ti,usbhs";
+			reg = <0x48064000 0x400>, /* uhh */
+				  <0x48064400 0x400>, /* ohci */
+				  <0x48064800 0x400>; /* ehci */
+			reg-names = "uhh", "ohci", "ehci";
+			interrupts = <76>, <77>;
+			interrupt-names = "ohci-irq", "ehci-irq";
+			interrupt-parent = <&intc>;
+			ti,hwmods = "usb_host_hs";
+		};
+
+		usbtll: usbtll@0x4a062000 {
+			compatible = "ti,usbtll";
+			reg = <0x48062000 0x1000>;
+			reg-names = "tll";
+			interrupts = <78>;
+			interrupt-names = "tll-irq";
+			interrupt-parent = <&intc>;
+			ti,hwmods = "usb_tll_hs";
+		};
 	};
 };
-- 
1.7.9.5

