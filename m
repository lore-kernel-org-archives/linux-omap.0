From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [RFC PATCH v2 09/11] ARM: DT: Add support to system control module
 for OMAP4
Date: Mon, 18 Jun 2012 15:32:38 +0400
Message-ID: <4FDF11D6.6050205@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:48679 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752268Ab2FRLck (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 07:32:40 -0400
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

This patch adds device tree entries on OMAP4 based boards
for System Control Module (SCM).

TODO:
The IOMEM windows of ctrl_module_core, bandgap, usbphy overlap, so
probably only specific registers should be specified in dts for
bandgap and usb phy entries.

Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Index: linux-2.6/arch/arm/boot/dts/omap4.dtsi
===================================================================
--- linux-2.6.orig/arch/arm/boot/dts/omap4.dtsi
+++ linux-2.6/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,22 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		ctrl_module_core: ctrl_module_core@4a002000 {
+			compatible = "ti,omap4-control";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			ti,hwmods = "ctrl_module_core";
+			reg = <0x4a002000 0x1000>;
+			bandgap@4a002000 {
+				compatible = "ti,omap4-bandgap";
+				reg = <0x4a002000 0x1000>;
+			};
+			usb@4a002000 {
+				compatible = "ti,omap4-usb-phy";
+				reg = <0x4a002000 0x1000>;
+			};
+		};
 	};
 };
