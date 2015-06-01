From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] ARM: dts: AM35xx: fix system control module clocks
Date: Mon, 1 Jun 2015 18:30:27 +0300
Message-ID: <1433172627-28052-1-git-send-email-t-kristo@ti.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40692 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbbFAPad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2015 11:30:33 -0400
In-Reply-To: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

New system control module layout for omap3 overlooked parts of the am35xx
configuration. Basically the am35xx clocks were not converted to use the
changed offsets, which caused weird boot warnings. The errors were not
fatal so far, so they were not caught earlier. Fixed by applying the
proper offsets for the AM35xx scm clocks.

Fixes: b8845074cf ("ARM: dts: omap3: add minimal l4 bus layout with...")

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reported-by: Jeroen Hofstee <linux-arm@myspectrum.nl>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am35xx-clocks.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am35xx-clocks.dtsi b/arch/arm/boot/dts/am35xx-clocks.dtsi
index 518b8fd..18cc826 100644
--- a/arch/arm/boot/dts/am35xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am35xx-clocks.dtsi
@@ -12,7 +12,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-gate-clock";
 		clocks = <&ipss_ick>;
-		reg = <0x059c>;
+		reg = <0x032c>;
 		ti,bit-shift = <1>;
 	};
 
@@ -20,7 +20,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&rmii_ck>;
-		reg = <0x059c>;
+		reg = <0x032c>;
 		ti,bit-shift = <9>;
 	};
 
@@ -28,7 +28,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-gate-clock";
 		clocks = <&ipss_ick>;
-		reg = <0x059c>;
+		reg = <0x032c>;
 		ti,bit-shift = <2>;
 	};
 
@@ -36,7 +36,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&pclk_ck>;
-		reg = <0x059c>;
+		reg = <0x032c>;
 		ti,bit-shift = <10>;
 	};
 
@@ -44,7 +44,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-gate-clock";
 		clocks = <&ipss_ick>;
-		reg = <0x059c>;
+		reg = <0x032c>;
 		ti,bit-shift = <0>;
 	};
 
@@ -52,7 +52,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_ck>;
-		reg = <0x059c>;
+		reg = <0x032c>;
 		ti,bit-shift = <8>;
 	};
 
@@ -60,7 +60,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-gate-clock";
 		clocks = <&sys_ck>;
-		reg = <0x059c>;
+		reg = <0x032c>;
 		ti,bit-shift = <3>;
 	};
 };
-- 
1.7.9.5

