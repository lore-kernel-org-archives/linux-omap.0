From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 2/3] gpio-twl4030: new dt properties for BeagleBoard and omap3-EVM
Date: Mon,  3 Sep 2012 15:54:50 +0200
Message-ID: <1346680491-4211-3-git-send-email-florian.vaussard@epfl.ch>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:40814 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756442Ab2ICNzQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Sep 2012 09:55:16 -0400
In-Reply-To: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Benoit Cousson <b-cousson@ti.com>, Rob Herring <rob.herring@calxeda.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Add device tree properties for twl4030/gpio, according to the
platform data of corresponding boards. This enables the led
connected to LEDB output for both boards, as well as
pullups/pulldowns on GPIO for the BeagleBoard.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-beagle.dts |   20 ++++++++++++++++++++
 arch/arm/boot/dts/omap3-evm.dts    |   13 +++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index cdcb98c..16bff8b 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -17,6 +17,14 @@
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pmu_stat {
+			label = "beagleboard::pmu_stat";
+			gpios = <&twl_gpio 19 0>; /* LEDB */
+		};
+	};
 };
 
 &i2c1 {
@@ -67,3 +75,15 @@
 &mmc3 {
 	status = "disabled";
 };
+
+&twl_gpio {
+	ti,use-leds = "true";
+	/* pullups: BIT(1) */
+	ti,pullups = <2>;
+	/*
+	 * pulldowns:
+	 * BIT(2), BIT(6), BIT(7), BIT(8), BIT(13)
+	 * BIT(15), BIT(16), BIT(17)
+	 */
+	ti,pulldowns = <238020>;
+};
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index f349ee9..f1e18fe 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -17,6 +17,15 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		ledb {
+			label = "omap3evm::ledb";
+			gpios = <&twl_gpio 19 0>; /* LEDB */
+			linux,default-trigger = "default-on";
+		};
+	};
 };
 
 &i2c1 {
@@ -46,3 +55,7 @@
 		reg = <0x5c>;
 	};
 };
+
+&twl_gpio {
+	ti,use-leds = "true";
+};
-- 
1.7.5.4

