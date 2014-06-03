From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH 1/2] ARM: dts: DRA7: Add routable-irqs property for gic node
Date: Tue, 3 Jun 2014 14:40:34 +0530
Message-ID: <1401786635-5778-2-git-send-email-r.sricharan@ti.com>
References: <1401786635-5778-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33469 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbaFCJMs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jun 2014 05:12:48 -0400
In-Reply-To: <1401786635-5778-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, tglx@linutronix.de, linux@arm.linux.org.uk, r.sricharan@ti.com, Benoit Cousson <bcousson@baylibre.com>

From: R Sricharan <r.sricharan@ti.com>

There is a IRQ crossbar device in the soc, which maps the
irq requests from the peripherals to the mpu interrupt
controller's inputs. The gic provides the support for such
IPs in the form of routable-irqs. So adding the property
here to gic node.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Tested-by: Darren Etheridge <detheridge@ti.com>
Tested-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c29945e..1cf4ee1 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -45,6 +45,7 @@
 		compatible = "arm,cortex-a15-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
+		arm,routable-irqs = <192>;
 		reg = <0x48211000 0x1000>,
 		      <0x48212000 0x1000>,
 		      <0x48214000 0x2000>,
-- 
1.7.9.5

