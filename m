From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 5/5] ARM: dts: OMAP5: Add mailbox dt node
Date: Mon, 22 Jul 2013 16:27:16 -0500
Message-ID: <1374528436-59626-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34958 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932388Ab3GVVeO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Jul 2013 17:34:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Suman Anna <s-anna@ti.com>

Add the mailbox device DT node for OMAP5 SoC.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index e643620..a08f1ca 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -505,6 +505,17 @@
 			dma-names = "tx", "rx";
 		};
 
+		mailbox: mailbox@4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4a0f4000 0x200>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <3>;
+			ti,mbox-num-fifos = <8>;
+			ti,mbox-names = "mbox-ipu", "mbox-dsp";
+			ti,mbox-data = <0 1 0 0>, <3 2 0 0>;
+		};
+
 		timer1: timer@4ae18000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x4ae18000 0x80>;
-- 
1.8.3.3

