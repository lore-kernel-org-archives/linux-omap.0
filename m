From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 5/5] arm/dts: OMAP3: Add gpio nodes
Date: Wed, 15 Feb 2012 17:04:14 +0100
Message-ID: <1329321854-24490-6-git-send-email-b-cousson@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55032 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab2BOQEx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 11:04:53 -0500
In-Reply-To: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Add the 6 GPIOs controller nodes present in OMAP3.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap3.dtsi |   54 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index ca37ba5..8eb181e 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -69,6 +69,60 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		gpio1: gpio@1 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio1";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio2: gpio@2 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio2";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio3: gpio@3 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio3";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio4: gpio@4 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio4";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio5: gpio@5 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio5";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio6: gpio@6 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio6";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		uart1: serial@0x4806a000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
-- 
1.7.0.4

