From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 31/35] ARM: dts: omap3: split l3-smx node out of ocp bus node
Date: Wed, 15 Apr 2015 15:53:18 +0300
Message-ID: <1429102402-5276-32-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42536 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101AbbDOMxV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:53:21 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

ocp bus node will be needed for hwmod data module init, so it can't be
reserved by l3-smx driver. Thus, split l3-smx as its own separate node
under the ocp bus, and add a new compatible string for the l3-bus.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 3fdc84f..4ff8685 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -79,13 +79,17 @@
 	 * hierarchy.
 	 */
 	ocp {
-		compatible = "ti,omap3-l3-smx", "simple-bus";
-		reg = <0x68000000 0x10000>;
-		interrupts = <9 10>;
+		compatible = "simple-bus", "ti,omap3-l3";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-		ti,hwmods = "l3_main";
+
+		l3_smx: l3_smx@68000000 {
+			compatible = "ti,omap3-l3-smx";
+			reg = <0x68000000 0x10000>;
+			interrupts = <9 10>;
+			ti,hwmods = "l3_main";
+		};
 
 		aes: aes@480c5000 {
 			compatible = "ti,omap3-aes";
-- 
1.7.9.5

