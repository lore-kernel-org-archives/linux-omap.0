From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [PATCH v3 7/7] ARM: DT: Add support to system control module for
 OMAP4
Date: Wed, 27 Jun 2012 22:05:16 +0400
Message-ID: <4FEB4B5C.5020109@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:52725 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757719Ab2F0SFS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 14:05:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

This patch adds device tree entries on OMAP4 based boards
for System Control Module (SCM).

Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..8ecf80a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,20 @@
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
+			};
+			usb@4a002000 {
+				compatible = "ti,omap4-usb-phy";
+			};
+		};
 	};
 };
-- 
1.7.7.6


