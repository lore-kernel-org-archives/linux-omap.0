From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 7/8] ARM: dts: OMAP3: Add reg and interrupt properties for gpio
Date: Fri, 15 Mar 2013 08:57:40 -0500
Message-ID: <1363355861-11773-8-git-send-email-jon-hunter@ti.com>
References: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45228 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab3CON6F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 09:58:05 -0400
In-Reply-To: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The OMAP3 gpio bindings are currently missing the reg and interrupt
properties and so add these properties.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index badedc8..0cc65b5 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -113,6 +113,8 @@
 
 		gpio1: gpio@48310000 {
 			compatible = "ti,omap3-gpio";
+			reg = <0x48310000 0x200>;
+			interrupts = <29>;
 			ti,hwmods = "gpio1";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -122,6 +124,8 @@
 
 		gpio2: gpio@49050000 {
 			compatible = "ti,omap3-gpio";
+			reg = <0x49050000 0x200>;
+			interrupts = <30>;
 			ti,hwmods = "gpio2";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -131,6 +135,8 @@
 
 		gpio3: gpio@49052000 {
 			compatible = "ti,omap3-gpio";
+			reg = <0x49052000 0x200>;
+			interrupts = <31>;
 			ti,hwmods = "gpio3";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -140,6 +146,8 @@
 
 		gpio4: gpio@49054000 {
 			compatible = "ti,omap3-gpio";
+			reg = <0x49054000 0x200>;
+			interrupts = <32>;
 			ti,hwmods = "gpio4";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -149,6 +157,8 @@
 
 		gpio5: gpio@49056000 {
 			compatible = "ti,omap3-gpio";
+			reg = <0x49056000 0x200>;
+			interrupts = <33>;
 			ti,hwmods = "gpio5";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -158,6 +168,8 @@
 
 		gpio6: gpio@49058000 {
 			compatible = "ti,omap3-gpio";
+			reg = <0x49058000 0x200>;
+			interrupts = <34>;
 			ti,hwmods = "gpio6";
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
1.7.10.4

