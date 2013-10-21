From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] input: touchscreen: fix spelling mistake in TSC/ADC DT binding
Date: Mon, 21 Oct 2013 15:13:23 -0500
Message-ID: <1382386404-6659-2-git-send-email-balbi@ti.com>
References: <1382386404-6659-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60418 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185Ab3JUUNQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Oct 2013 16:13:16 -0400
In-Reply-To: <1382386404-6659-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, devicetree@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>

There was a spelling mistake on TSC/ADC binding where
"coordinate" was spelled as "coordiante".

We can't simply fix the error due to DT being an ABI,
the approach taken was to first use correct spelling
and if that fails, fallback to miss-spelled version.

It's unfortunate that has creeped into the tree.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt         | 2 +-
 arch/arm/boot/dts/am335x-evm.dts                                 | 2 +-
 drivers/input/touchscreen/ti_am335x_tsc.c                        | 9 ++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
index 491c97b..878549b 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
@@ -6,7 +6,7 @@ Required properties:
 	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
 		  support on the platform.
 	ti,x-plate-resistance: X plate resistance
-	ti,coordiante-readouts: The sequencer supports a total of 16
+	ti,coordinate-readouts: The sequencer supports a total of 16
 				programmable steps each step is used to
 				read a single coordinate. A single
                                 readout is enough but multiple reads can
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e8ec875..c5b73bc 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -509,7 +509,7 @@
 	tsc {
 		ti,wires = <4>;
 		ti,x-plate-resistance = <200>;
-		ti,coordiante-readouts = <5>;
+		ti,coordinate-readouts = <5>;
 		ti,wire-config = <0x00 0x11 0x22 0x33>;
 	};
 
diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index e1c5300..b61df9d 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -348,9 +348,16 @@ static int titsc_parse_dt(struct platform_device *pdev,
 	if (err < 0)
 		return err;
 
-	err = of_property_read_u32(node, "ti,coordiante-readouts",
+	/*
+	 * try with new binding first. If it fails, still try with
+	 * bogus, miss-spelled version.
+	 */
+	err = of_property_read_u32(node, "ti,coordinate-readouts",
 			&ts_dev->coordinate_readouts);
 	if (err < 0)
+		err = of_property_read_u32(node, "ti,coordiante-readouts",
+				&ts_dev->coordinate_readouts);
+	if (err < 0)
 		return err;
 
 	return of_property_read_u32_array(node, "ti,wire-config",
-- 
1.8.4.GIT

