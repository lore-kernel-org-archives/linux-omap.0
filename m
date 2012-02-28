From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 4/5] arm/dts: OMAP3: Add SPI controller nodes
Date: Tue, 28 Feb 2012 23:19:09 +0100
Message-ID: <1330467550-20474-5-git-send-email-b-cousson@ti.com>
References: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40105 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756307Ab2B1WUA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 17:20:00 -0500
In-Reply-To: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Add the 4 McSPI controller nodes present in an OMAP3 device.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap3.dtsi |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 216c331..c47cd59 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -90,5 +90,37 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
+
+		mcspi1: spi@48098000 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi1";
+			ti,spi-num-cs = <4>;
+		};
+
+		mcspi2: spi@4809a000 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi2";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi3: spi@480b8000 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi3";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi4: spi@480ba000 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi4";
+			ti,spi-num-cs = <1>;
+		};
 	};
 };
-- 
1.7.0.4

