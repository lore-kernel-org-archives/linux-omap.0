From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/9] ARM: DTS: omap4: Set all audio related IP's status to disabled as default
Date: Fri, 24 Jan 2014 10:19:01 +0200
Message-ID: <1390551547-12406-4-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42015 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbaAXITm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jan 2014 03:19:42 -0500
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Board dts files will need to enable the IP nodes which they are using and
does not have to care about the not used ones (to disable them).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a1e05853afcd..78c19e30eca0 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -426,6 +426,7 @@
 			dmas = <&sdma 65>,
 			       <&sdma 66>;
 			dma-names = "up_link", "dn_link";
+			status = "disabled";
 		};
 
 		dmic: dmic@4012e000 {
@@ -437,6 +438,7 @@
 			ti,hwmods = "dmic";
 			dmas = <&sdma 67>;
 			dma-names = "up_link";
+			status = "disabled";
 		};
 
 		mcbsp1: mcbsp@40122000 {
@@ -451,6 +453,7 @@
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp2: mcbsp@40124000 {
@@ -465,6 +468,7 @@
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp3: mcbsp@40126000 {
@@ -479,6 +483,7 @@
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		mcbsp4: mcbsp@48096000 {
@@ -492,6 +497,7 @@
 			dmas = <&sdma 31>,
 			       <&sdma 32>;
 			dma-names = "tx", "rx";
+			status = "disabled";
 		};
 
 		keypad: keypad@4a31c000 {
-- 
1.8.5.3

