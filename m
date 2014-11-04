From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 08/10] ARM: dts: am33xx: Add control module syscon node
Date: Tue, 4 Nov 2014 12:48:52 +0200
Message-ID: <1415098134-26405-9-git-send-email-rogerq@ti.com>
References: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60106 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbaKDKtm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Nov 2014 05:49:42 -0500
In-Reply-To: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

Use syscon regmap to expose the Control module register space.
This register space is shared between many users e.g. DCAN, USB, display, etc.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 8318105..9f3058c 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -83,6 +83,11 @@
 		};
 	};
 
+	am33xx_control_module: control_module@4a002000 {
+		compatible = "syscon";
+		reg = <0x44e10000 0x7fc>;
+	};
+
 	am33xx_pinmux: pinmux@44e10800 {
 		compatible = "pinctrl-single";
 		reg = <0x44e10800 0x0238>;
-- 
1.8.3.2

