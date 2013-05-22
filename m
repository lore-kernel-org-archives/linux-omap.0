From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 4/5] ARM: dts: OMAP3: fix incorrect notation for musb-hdrc interrupt
Date: Wed, 22 May 2013 16:27:43 +0200
Message-ID: <1369232864-14460-5-git-send-email-florian.vaussard@epfl.ch>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:35818 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755063Ab3EVO2S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 May 2013 10:28:18 -0400
In-Reply-To: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

On OMAP3, the INTC interrupt controller has only 1 cell.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 15049b8..0f3be20 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -518,7 +518,7 @@
 		usb_otg_hs: usb_otg_hs@480ab000 {
 			compatible = "ti,omap3-musb";
 			reg = <0x480ab000 0x1000>;
-			interrupts = <0 92 0x4>, <0 93 0x4>;
+			interrupts = <92>, <93>;
 			interrupt-names = "mc", "dma";
 			ti,hwmods = "usb_otg_hs";
 			multipoint = <1>;
-- 
1.7.5.4

