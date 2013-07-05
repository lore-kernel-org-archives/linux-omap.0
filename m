From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] arm: dts: am33xx: add USB phy nodes
Date: Fri,  5 Jul 2013 15:32:55 +0200
Message-ID: <1373031178-8871-3-git-send-email-bigeasy@linutronix.de>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45308 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3GENdF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jul 2013 09:33:05 -0400
In-Reply-To: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, george.cherian@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, b-cousson@ti.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The memory address contains three pieces that is the reset module which
is currently the only one used and two other pices which seem
interresting based on what the register.
The phy id (0 or 1) can be obtained via of_alias_get_id(). However once
we need this, we should used something for common register access.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0d4df90..a24f1cb 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -333,6 +333,22 @@
 			status = "disabled";
 		};
 
+		musb0_phy: phy0@47401000 {
+			compatible = "ti,am335x-usb-phy";
+			reg = <0x44e10620 0x2c		/* reset module */
+				0x47401000 0x200
+				0x47401300 0x100>;
+			status = "disabled";
+		};
+
+		musb1_phy: phy1@47401800 {
+			compatible = "ti,am335x-usb-phy";
+			reg = <0x44e10628 0x24		/* reset module */
+				0x47401800 0x200
+				0x47401b00 0x100>;
+			status = "disabled";
+		};
+
 		usb@47400000 {
 			compatible = "ti,musb-am33xx";
 			reg = <0x47400000 0x1000	/* usbss */
-- 
1.8.3.2

