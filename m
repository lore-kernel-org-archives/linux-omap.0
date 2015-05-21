From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Subject: [PATCH 1/2] ARM: dts: omap3-devkit8000: Add dm9000 support
Date: Thu, 21 May 2015 21:52:16 +0200
Message-ID: <1432237937-16691-1-git-send-email-anthoine.bourgeois@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33723 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422671AbbEUTwv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2015 15:52:51 -0400
Received: by wgez8 with SMTP id z8so6269468wge.0
        for <linux-omap@vger.kernel.org>; Thu, 21 May 2015 12:52:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

Support dm9000 network interface in the device tree of devkit8000 board.

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
---
 arch/arm/boot/dts/omap3-devkit8000.dts | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 283db1d..b32eeda 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -158,3 +158,44 @@
 		};
 	};
 };
+
+&gpmc {
+	ranges = <6 0 0x2c000000 0x1000000>;       /* CS6: 16MB for DM9000 */
+
+	ethernet@0,0 {
+		compatible = "davicom,dm9000";
+		reg = <6 0x000 3
+		       6 0x400 3>;
+		bank-width = <2>;
+		interrupt-parent = <&gpio1>;		/* CS6 -> DM9000 */
+		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+		davicom,no-eeprom;
+
+		gpmc,mux-add-data = <0>;
+		gpmc,device-width = <1>;
+		gpmc,wait-pin = <0>;
+		gpmc,cycle2cycle-samecsen = <1>;
+		gpmc,cycle2cycle-diffcsen = <1>;
+
+		gpmc,cs-on-ns = <6>;
+		gpmc,cs-rd-off-ns = <180>;
+		gpmc,cs-wr-off-ns = <180>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <18>;
+		gpmc,adv-wr-off-ns = <48>;
+		gpmc,oe-on-ns = <54>;
+		gpmc,oe-off-ns = <168>;
+		gpmc,we-on-ns = <54>;
+		gpmc,we-off-ns = <168>;
+		gpmc,rd-cycle-ns = <186>;
+		gpmc,wr-cycle-ns = <186>;
+		gpmc,access-ns = <144>;
+		gpmc,page-burst-access-ns = <24>;
+		gpmc,bus-turnaround-ns = <90>;
+		gpmc,cycle2cycle-delay-ns = <90>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		gpmc,wr-access-ns = <0>;
+	};
+};
-- 
2.0.5

