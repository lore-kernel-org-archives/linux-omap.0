From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] ARM: dts: omap5-uevm: Add Uart wakeup interrupt
Date: Fri, 15 May 2015 17:16:40 -0500
Message-ID: <1431728200-25486-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58146 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992435AbbEOWRI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 May 2015 18:17:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

UART3 wakeup takes place with iodaisy chain. enable the wakeup pin.

Reported-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Test on linus master (f0897f4cc0fc) with 8250  driver: http://pastebin.ubuntu.com/11154663/
Applies on next-20150515 and linus master (f0897f4cc0fc)

Changes in V2:
	- switched over to wakeupgen instead of GIC.
	- retested.
V1: https://patchwork.kernel.org/patch/6416981/

 arch/arm/boot/dts/omap5-uevm.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 74777a6e200a..c4dc487832ea 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -604,6 +604,8 @@
 &uart3 {
         pinctrl-names = "default";
         pinctrl-0 = <&uart3_pins>;
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+			      <&omap5_pmx_core 0x19c>;
 };
 
 &uart5 {
-- 
1.7.9.5

