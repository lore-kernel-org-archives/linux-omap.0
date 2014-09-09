From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 10/12] ARM: dts: am4372: Add dcan raminit bits
Date: Tue, 9 Sep 2014 17:55:32 +0300
Message-ID: <1410274534-22826-11-git-send-email-rogerq@ti.com>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58424 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbaIIO4W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2014 10:56:22 -0400
In-Reply-To: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Add RAMINIT specific bits into the DCAN nodes.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d38a0ed..847f41b 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -899,7 +899,10 @@
 			clocks = <&dcan0_fck>;
 			clock-names = "fck";
 			reg = <0x481cc000 0x2000
-				0x44e10644 0x4>;
+				0x644 0x4>; /* index to RAMINIT reg within syscon */
+			ti,raminit-syscon = <&am43xx_control_module>;
+			ti,raminit-start-bit = <0>;
+			ti,raminit-done-bit = <8>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -910,7 +913,10 @@
 			clocks = <&dcan1_fck>;
 			clock-names = "fck";
 			reg = <0x481d0000 0x2000
-				0x44e10644 0x4>;
+				0x644 0x4>; /* index to RAMINIT reg within syscon */
+			ti,raminit-syscon = <&am43xx_control_module>;
+			ti,raminit-start-bit = <1>;
+			ti,raminit-done-bit = <9>;
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
-- 
1.8.3.2

