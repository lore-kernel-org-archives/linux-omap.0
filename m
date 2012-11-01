From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/3] ARM: dts: Update OMAP4 timer addresses
Date: Thu, 1 Nov 2012 10:49:25 -0500
Message-ID: <1351784967-32520-2-git-send-email-jon-hunter@ti.com>
References: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47924 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933010Ab2KAPt7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Nov 2012 11:49:59 -0400
In-Reply-To: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

For OMAP4 devices, timers 5-8 have both a L3 bus address and a Cortex-A9
private bus address. Currently the device-tree source only contains the
L3 bus address for these timers. Update these timers to include the
Cortex-A9 private address and make the default address the Cortex-A9
private bus address to match the current HWMOD implementation.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 23ee149..739bb79 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -469,33 +469,37 @@
 			ti,hwmods = "timer4";
 		};
 
-		timer5: timer@49038000 {
+		timer5: timer@40138000 {
 			compatible = "ti,omap2-timer";
-			reg = <0x49038000 0x80>;
+			reg = <0x40138000 0x80>,
+			      <0x49038000 0x80>;
 			interrupts = <0 41 0x4>;
 			ti,hwmods = "timer5";
 			ti,timer-dsp;
 		};
 
-		timer6: timer@4903a000 {
+		timer6: timer@4013a000 {
 			compatible = "ti,omap2-timer";
-			reg = <0x4903a000 0x80>;
+			reg = <0x4013a000 0x80>,
+			      <0x4903a000 0x80>;
 			interrupts = <0 42 0x4>;
 			ti,hwmods = "timer6";
 			ti,timer-dsp;
 		};
 
-		timer7: timer@4903c000 {
+		timer7: timer@4013c000 {
 			compatible = "ti,omap2-timer";
-			reg = <0x4903c000 0x80>;
+			reg = <0x4013c000 0x80>,
+			      <0x4903c000 0x80>;
 			interrupts = <0 43 0x4>;
 			ti,hwmods = "timer7";
 			ti,timer-dsp;
 		};
 
-		timer8: timer@4903e000 {
+		timer8: timer@4013e000 {
 			compatible = "ti,omap2-timer";
-			reg = <0x4903e000 0x80>;
+			reg = <0x4013e000 0x80>,
+			      <0x4903e000 0x80>;
 			interrupts = <0 44 0x4>;
 			ti,hwmods = "timer8";
 			ti,timer-pwm;
-- 
1.7.9.5

