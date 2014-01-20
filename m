From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 08/10] ARM: dts: omap4-panda: Provide USB PHY clock
Date: Mon, 20 Jan 2014 16:11:29 +0200
Message-ID: <1390227091-4523-9-git-send-email-rogerq@ti.com>
References: <1390227091-4523-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48524 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950AbaATOMt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jan 2014 09:12:49 -0500
In-Reply-To: <1390227091-4523-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: balbi@ti.com, lee.jones@linaro.org, arnd@arndb.de, sre@debian.org, mark.rutland@arm.com, m.paolino@virtualopensystems.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The USB PHY gets its clock from AUXCLK3. Provide this
information.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 88c6a05..50b72966 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -83,12 +83,8 @@
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;   /* gpio_62 */
 		vcc-supply = <&hsusb1_power>;
-	/**
-	 * FIXME:
-	 * put the right clock phandle here when available
-	 *	clocks = <&auxclk3>;
-	 *	clock-names = "main_clk";
-	 */
+		clocks = <&auxclk3_ck>;
+		clock-names = "main_clk";
 		clock-frequency = <19200000>;
 	};
 
-- 
1.8.3.2

