From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+ boards
Date: Fri, 10 May 2013 19:35:58 -0700
Message-ID: <20130511023557.GB28602@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17773 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab3EKCgB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 May 2013 22:36:01 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-usb <linux-usb@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>

Commit ad871c10 (ARM: dts: OMAP: Add usb_otg and glue data to
OMAP3+ boards) added support for MUSB on omap3 for device tree,
but added the interrupts the wrong way probably as they were
copied from the omap4.dtsi file. On omap3 we have TI specific
interrupt controller, not GIC.

Fix this by specifying the interrupt following the TI INTC
binding.

Without this fix MUSB won't work as it is trying to use
irq0 instead of irq92.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -516,7 +516,7 @@
 		usb_otg_hs: usb_otg_hs@480ab000 {
 			compatible = "ti,omap3-musb";
 			reg = <0x480ab000 0x1000>;
-			interrupts = <0 92 0x4>, <0 93 0x4>;
+			interrupts = <92>, <93>;
 			interrupt-names = "mc", "dma";
 			ti,hwmods = "usb_otg_hs";
 			multipoint = <1>;
