From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 9/9] ARM: dts: OMAP3: Add reg and interrupt properties for gpio
Date: Fri, 8 Mar 2013 11:27:33 -0600
Message-ID: <1362763654-9660-10-git-send-email-jon-hunter@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44481 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934283Ab3CHR2E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 12:28:04 -0500
In-Reply-To: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
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
index c9bedf7..f4651af 100644
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

