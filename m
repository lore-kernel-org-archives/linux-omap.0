From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 6/6] arm/dts: OMAP3: Add gpio nodes
Date: Fri, 24 Feb 2012 23:21:31 +0100
Message-ID: <1330122091-28113-7-git-send-email-b-cousson@ti.com>
References: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38335 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932264Ab2BXWWX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 17:22:23 -0500
In-Reply-To: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Add the 6 GPIOs controller nodes present in OMAP3.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap3.dtsi |   54 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 0252812..695c469 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -69,6 +69,60 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		gpio1: gpio@48310000 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio1";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio2: gpio@49050000 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio2";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio3: gpio@49052000 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio3";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio4: gpio@49054000 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio4";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio5: gpio@49056000 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio5";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio6: gpio@49058000 {
+			compatible = "ti,omap3-gpio";
+			ti,hwmods = "gpio6";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		uart1: serial@4806a000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
-- 
1.7.0.4

