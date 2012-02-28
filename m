From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 5/5] arm/dts: omap4-sdp: Add ks8851 ethernet SPI device
Date: Tue, 28 Feb 2012 23:19:10 +0100
Message-ID: <1330467550-20474-6-git-send-email-b-cousson@ti.com>
References: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36024 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307Ab2B1WTx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 17:19:53 -0500
In-Reply-To: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Add an ethernet SPI chip in the OMAP4 SDP/Blaze board DTS file.

Add a fixed regulator node controlled by a GPIO line to supply
the ethernet chip.

Based on original code from Rajendra.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 066e28c..6584109 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -13,17 +13,29 @@
 	model = "TI OMAP4 SDP board";
 	compatible = "ti,omap4-sdp", "ti,omap4430", "ti,omap4";
 
-	/*
-	 * Since the initial device tree board file does not create any
-	 * devices (MMC, network...), the only way to boot is to provide a
-	 * ramdisk.
-	 */
-	chosen {
-		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug";
-	};
-
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+
+	vdd_eth: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_ETH";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 16 0>;  /* gpio line 48 */
+		enable-active-high;
+		regulator-boot-on;
+	};
+};
+
+&mcspi1 {
+	eth@0 {
+		compatible = "ks8851";
+		spi-max-frequency = <24000000>;
+		reg = <0>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <2>; /* gpio line 34 */
+		vdd-supply = <&vdd_eth>;
+	};
 };
-- 
1.7.0.4

