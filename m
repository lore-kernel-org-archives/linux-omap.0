From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/12] ARM: dts: Add support for Ethernet on some N900 macro boards
Date: Mon, 15 Sep 2014 20:12:00 -0700
Message-ID: <1410837126-31553-6-git-send-email-tony@atomide.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19976 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754369AbaIPDNJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 23:13:09 -0400
In-Reply-To: <1410837126-31553-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

As we have support for this in board-rx51-peripherals.c, let's
add it to the .dts files too.

Note that the reset GPIO will eventually go to the driver.
For now let's just pull it down and skip any further reset
in case the bootloader has configured the MAC address so
NFSroot works.

Also note that after 3430-sdp are using proper GPMC timings
we can remove the tests for smsc,lan91c94 in gpmc.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-n900.dts   | 42 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pdata-quirks.c |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index f0d8236..19a5857 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -134,6 +134,14 @@
 		>;
 	};
 
+	ethernet_pins: pinmux_ethernet_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x20b4, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* gpmc_ncs3.gpio_54 */
+			OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MODE4)		/* dss_data16.gpio_86 */
+			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE4)		/* uart3_rts_sd.gpio_164 */
+		>;
+	};
+
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
 			0x18a (PIN_INPUT | MUX_MODE0)		/* i2c1_scl */
@@ -578,6 +586,8 @@
 
 &gpmc {
 	ranges = <0 0 0x04000000 0x10000000>; /* 256MB */
+	ranges = <0 0 0x01000000 0x01000000>,	/* 16 MB for OneNAND */
+		 <1 0 0x02000000 0x01000000>;	/* 16 MB for smc91c96 */
 
 	/* gpio-irq for dma: 65 */
 
@@ -646,6 +656,38 @@
 			reg = <0x004c0000 0x0fb40000>;
 		};
 	};
+
+	ethernet@gpmc {
+		compatible = "smsc,lan91c94";
+		interrupt-parent = <&gpio2>;
+		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
+		reg = <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300 */
+		bank-width = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_pins>;
+		gpmc,device-width = <2>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <48>;
+		gpmc,cs-wr-off-ns = <24>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <0>;
+		gpmc,adv-wr-off-ns = <0>;
+		gpmc,we-on-ns = <12>;
+		gpmc,we-off-ns = <18>;
+		gpmc,oe-on-ns = <12>;
+		gpmc,oe-off-ns = <48>;
+		gpmc,page-burst-access-ns = <0>;
+		gpmc,access-ns = <42>;
+		gpmc,rd-cycle-ns = <180>;
+		gpmc,wr-cycle-ns = <180>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-access-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <12>;
+	};
 };
 
 &mcspi1 {
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index ead7736..540f3f8 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -252,6 +252,9 @@ static void __init nokia_n900_legacy_init(void)
 		platform_device_register(&omap3_rom_rng_device);
 
 	}
+
+	/* Only on some development boards */
+	gpio_request_one(164, GPIOF_OUT_INIT_LOW, "smc91x reset");
 }
 
 static void __init omap3_tao3530_legacy_init(void)
-- 
2.1.0

