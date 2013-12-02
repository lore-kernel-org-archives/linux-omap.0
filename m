From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH] ARM: dts: Fix the name of supplies for smsc911x shared by OMAP
Date: Mon,  2 Dec 2013 13:53:02 +0100
Message-ID: <1385988782-21731-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:33832 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab3LBMxX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Dec 2013 07:53:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, florian.vaussard@epfl.ch

drivers/net/ethernet/smsc/smsc911x.c is expecting supplies named
"vdd33a" and "vddvario". Currently the shared DTS file provides
"vmmc" and "vmmc_aux", and the supply lookup will fail:

smsc911x 2c000000.ethernet: Looking up vdd33a-supply from device tree
smsc911x 2c000000.ethernet: Looking up vdd33a-supply property in node /ocp/gpmc@6e000000/ethernet@gpmc failed
smsc911x 2c000000.ethernet: Looking up vddvario-supply from device tree
smsc911x 2c000000.ethernet: Looking up vddvario-supply property in node /ocp/gpmc@6e000000/ethernet@gpmc failed

Fix it!

Tested on OMAP3 Overo platform.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
index 9c18adf..f577b7d 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
@@ -44,8 +44,8 @@
 		gpmc,wr-access-ns = <186>;
 		gpmc,cycle2cycle-samecsen;
 		gpmc,cycle2cycle-diffcsen;
-		vmmc-supply = <&vddvario>;
-		vmmc_aux-supply = <&vdd33a>;
+		vddvario-supply = <&vddvario>;
+		vdd33a-supply = <&vdd33a>;
 		reg-io-width = <4>;
 		smsc,save-mac-address;
 	};
-- 
1.8.1.2

