From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/3] ARM: dts: am335x-evmsk: add SD card hotplug support
Date: Fri, 27 Dec 2013 21:59:05 +0530
Message-ID: <1388161746-24179-3-git-send-email-balajitk@ti.com>
References: <1388161746-24179-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45002 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052Ab3L0Q3Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Dec 2013 11:29:16 -0500
In-Reply-To: <1388161746-24179-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Balaji T K <balajitk@ti.com>

Add card detect gpio for SD card slot

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 4718ec4..6d0c70f 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -256,6 +256,12 @@
 		>;
 	};
 
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+		>;
+	};
+
 	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
 			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
@@ -456,6 +462,9 @@
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

