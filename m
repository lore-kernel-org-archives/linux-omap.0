From: Tony Lindgren <tony@atomide.com>
Subject: ARM: dts: Add missing vmmc2 regulator for twl
Date: Fri, 7 Jun 2013 15:01:58 -0700
Message-ID: <20130607220157.GM3331@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33990 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3FGWCA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 18:02:00 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

For some reason vmmc2 regulator is missing for twl.
Let's add it.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -47,6 +47,12 @@
 		regulator-max-microvolt = <3150000>;
 	};
 
+	vmmc2: regulator-vmmc2 {
+		compatible = "ti,twl4030-vmmc2";
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <3150000>;
+	};
+
 	vusb1v5: regulator-vusb1v5 {
 		compatible = "ti,twl4030-vusb1v5";
 	};
