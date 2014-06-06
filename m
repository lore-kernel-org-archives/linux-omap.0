From: Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 6/7] ARM: dts: OMAP5: add PRM interrupt
Date: Thu, 5 Jun 2014 22:36:00 -0500
Message-ID: <1402025761-16831-7-git-send-email-nm@ti.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44241 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbaFFDg1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jun 2014 23:36:27 -0400
In-Reply-To: <1402025761-16831-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

Provide OMAP5 interrupt number for PRM

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 3bfda16..ccced95 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -132,6 +132,7 @@
 		prm: prm@4ae06000 {
 			compatible = "ti,omap5-prm";
 			reg = <0x4ae06000 0x3000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 
 			prm_clocks: clocks {
 				#address-cells = <1>;
-- 
1.7.9.5

