From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 2/4] ARM: dts: omap3-tobi: Add SMSC911X node
Date: Tue, 11 Jun 2013 16:49:47 +0200
Message-ID: <1370962189-9689-3-git-send-email-florian.vaussard@epfl.ch>
References: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:50931 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752585Ab3FKOuD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 10:50:03 -0400
In-Reply-To: <1370962189-9689-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

The Tobi expansion boards embeds a SMSC LAN8700 PHY. Add the
corresponding node into the DT. The regulators are not designed
to be turned off.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-tobi.dts |   48 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index c7eebbf..dea726f 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -24,6 +24,54 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	vddvario: regulator-vddvario {
+		  compatible = "regulator-fixed";
+		  regulator-name = "vddvario";
+		  regulator-always-on;
+	};
+
+	vdd33a: regulator-vdd33a {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd33a";
+		regulator-always-on;
+	};
+};
+
+&gpmc {
+	ranges = <5 0 0x2c000000 0x1000000>;	/* CS5 */
+
+	ethernet@5,0 {
+		compatible = "smsc,lan9221", "smsc,lan9115";
+		reg = <5 0 0xff>;
+		bank-width = <2>;
+
+		gpmc,mux-add-data;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <42>;
+		gpmc,cs-wr-off-ns = <36>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <12>;
+		gpmc,adv-wr-off-ns = <12>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <42>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <36>;
+		gpmc,rd-cycle-ns = <60>;
+		gpmc,wr-cycle-ns = <54>;
+		gpmc,access-ns = <36>;
+		gpmc,page-burst-access-ns = <0>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <18>;
+		gpmc,wr-access-ns = <42>;
+		gpmc,cycle2cycle-samecsen;
+		gpmc,cycle2cycle-diffcsen;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;	/* GPIO 176*/
+		reg-io-width = <4>;
+	};
 };
 
 &i2c3 {
-- 
1.7.5.4

