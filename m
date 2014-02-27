From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 7/8] ARM: dts: omap3-tobi: Use include file omap-gpmc-smsc9221
Date: Thu, 27 Feb 2014 21:30:31 +0100
Message-ID: <1393533032-1619-8-git-send-email-florian.vaussard@epfl.ch>
References: <1393533032-1619-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:39937 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbaB0Uay (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 15:30:54 -0500
In-Reply-To: <1393533032-1619-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Use the timings provided by omap-gpmc-smsc9221. This does not change
the timings, but it avoids code duplication.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi | 30 +++-----------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
index da7d85b..caddb8c 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
@@ -44,39 +44,15 @@
 	};
 };
 
+#include "omap-gpmc-smsc9221.dtsi"
+
 &gpmc {
 	ranges = <5 0 0x2c000000 0x1000000>;	/* CS5 */
 
-	ethernet@5,0 {
-		compatible = "smsc,lan9221", "smsc,lan9115";
+	ethernet@gpmc {
 		reg = <5 0 0xff>;
-		bank-width = <2>;
-
-		gpmc,mux-add-data;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <42>;
-		gpmc,cs-wr-off-ns = <36>;
-		gpmc,adv-on-ns = <6>;
-		gpmc,adv-rd-off-ns = <12>;
-		gpmc,adv-wr-off-ns = <12>;
-		gpmc,oe-on-ns = <0>;
-		gpmc,oe-off-ns = <42>;
-		gpmc,we-on-ns = <0>;
-		gpmc,we-off-ns = <36>;
-		gpmc,rd-cycle-ns = <60>;
-		gpmc,wr-cycle-ns = <54>;
-		gpmc,access-ns = <36>;
-		gpmc,page-burst-access-ns = <0>;
-		gpmc,bus-turnaround-ns = <0>;
-		gpmc,cycle2cycle-delay-ns = <0>;
-		gpmc,wr-data-mux-bus-ns = <18>;
-		gpmc,wr-access-ns = <42>;
-		gpmc,cycle2cycle-samecsen;
-		gpmc,cycle2cycle-diffcsen;
-
 		interrupt-parent = <&gpio6>;
 		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;	/* GPIO 176 */
-		reg-io-width = <4>;
 	};
 };
 
-- 
1.8.5.3

