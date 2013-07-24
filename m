From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/4] ARM: dts: omap5-uevm: Provide USB PHY clock
Date: Wed, 24 Jul 2013 17:32:36 +0300
Message-ID: <1374676356-31286-5-git-send-email-rogerq@ti.com>
References: <1374676356-31286-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49078 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab3GXOdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jul 2013 10:33:11 -0400
In-Reply-To: <1374676356-31286-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, benoit.cousson@linaro.org
Cc: t-kristo@ti.com, mturquette@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The HS USB 2 PHY gets its clock from AUXCLK1. Provide this
information.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 08b7267..a366cde 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -42,12 +42,8 @@
 	hsusb2_phy: hsusb2_phy {
 		compatible = "usb-nop-xceiv";
 		reset-supply = <&hsusb2_reset>;
-	/**
-	  * FIXME
-	  * Put the right clock phandle here when available
-	  *	clocks = <&auxclk1>;
-	  *	clock-names = "main_clk";
-	  */
+		clocks = <&auxclk1_ck>;
+		clock-names = "main_clk";
 		clock-frequency = <19200000>;
 	};
 
-- 
1.7.4.1

