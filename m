From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH] ARM: dts: Fix WLAN interrupt line for AM335x EVM-SK
Date: Wed, 13 May 2015 09:37:35 +0200
Message-ID: <1431502655-23255-1-git-send-email-romain.izard.pro@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38654 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbEMHhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2015 03:37:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Romain Izard <romain.izard.pro@gmail.com>

While Sitara AM335x SoCs are very close to OMAP SoCs, the 32-line GPIO
controllers are numbered from 0 on AM335x and from 1 on OMAP. But when
the configuration for the TI WLAN controllers was converted from
platform data to device tree, this detail was overlooked, as 10 boards
were using OMAP with the WL12xx and WL18xx controllers, and only one
was based on AM335x.

This invalid configuration prevents the WL1271 module on the AM335x
EVM-SK from notifying interrupts to the SoC, and breaks the wlan driver.

The DTS must be corrected to use the correct GPIO controller.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 87fc7a35e802..156d05efcb70 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -654,7 +654,7 @@
 	wlcore: wlcore@2 {
 		compatible = "ti,wl1271";
 		reg = <2>;
-		interrupt-parent = <&gpio1>;
+		interrupt-parent = <&gpio0>;
 		interrupts = <31 IRQ_TYPE_LEVEL_HIGH>; /* gpio 31 */
 		ref-clock-frequency = <38400000>;
 	};
-- 
2.1.4

