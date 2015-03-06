From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: dts: omap3-beagle: Add NAND device
Date: Fri, 6 Mar 2015 17:10:05 +0200
Message-ID: <1425654605-5752-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39486 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbbCFPKL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 10:10:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The beagle board contains a 16-bit NAND device connected to
chip select 0 of the GPMC controller.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index c792391..bf28502 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -379,3 +379,55 @@
 		};
 	};
 };
+
+&gpmc {
+	status = "ok";
+	ranges = <0 0 0x30000000 0x1000000>;	/* CS0 space, 16MB */
+
+	/* Chip select 0 */
+	nand@0,0 {
+		reg = <0 0 4>;		/* NAND I/O window, 4 bytes */
+		interrupts = <20>;
+		ti,nand-ecc-opt = "ham1";
+		nand-bus-width = <16>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		gpmc,device-width = <2>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <36>;
+		gpmc,cs-wr-off-ns = <36>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <24>;
+		gpmc,adv-wr-off-ns = <36>;
+		gpmc,oe-on-ns = <6>;
+		gpmc,oe-off-ns = <48>;
+		gpmc,we-on-ns = <6>;
+		gpmc,we-off-ns = <30>;
+		gpmc,rd-cycle-ns = <72>;
+		gpmc,wr-cycle-ns = <72>;
+		gpmc,access-ns = <54>;
+		gpmc,wr-access-ns = <30>;
+
+		partition@0 {
+			label = "X-Loader";
+			reg = <0 0x80000>;
+		};
+		partition@80000 {
+			label = "U-Boot";
+			reg = <0x80000 0x1e0000>;
+		};
+		partition@1c0000 {
+			label = "U-Boot Env";
+			reg = <0x260000 0x20000>;
+		};
+		partition@280000 {
+			label = "Kernel";
+			reg = <0x280000 0x400000>;
+		};
+		partition@780000 {
+			label = "Filesystem";
+			reg = <0x680000 0xf980000>;
+		};
+	};
+};
-- 
2.1.0

