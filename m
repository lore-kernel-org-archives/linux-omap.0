From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/3] ARM: dts: am335x-evm: add SD card hotplug support
Date: Fri, 27 Dec 2013 21:59:04 +0530
Message-ID: <1388161746-24179-2-git-send-email-balajitk@ti.com>
References: <1388161746-24179-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58942 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3L0Q3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Dec 2013 11:29:14 -0500
In-Reply-To: <1388161746-24179-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Balaji T K <balajitk@ti.com>

Add card detect gpio for SD card slot

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 7e6c64e..5c6b009 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -260,6 +260,12 @@
 		>;
 	};
 
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+		>;
+	};
+
 	lcd_pins_s0: lcd_pins_s0 {
 		pinctrl-single,pins = <
 			0x20 0x01	/* gpmc_ad8.lcd_data16, OUTPUT | MODE1 */
@@ -643,6 +649,9 @@
 	status = "okay";
 	vmmc-supply = <&vmmc_reg>;
 	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 };
 
 &sham {
-- 
1.7.5.4

