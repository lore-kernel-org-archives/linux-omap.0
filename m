From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 3/5] arm/dts: OMAP4: Add SPI controller nodes
Date: Tue, 28 Feb 2012 23:19:08 +0100
Message-ID: <1330467550-20474-4-git-send-email-b-cousson@ti.com>
References: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40106 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756429Ab2B1WUA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 17:20:00 -0500
In-Reply-To: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Add the 4 McSPI controller nodes present in an OMAP4 device.

Remove SPI static device initialisation if DT is populated.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap4.dtsi  |   32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c |    4 +++-
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index e8fe75f..82830f5 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -127,5 +127,37 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
+
+		mcspi1: spi@48098000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi1";
+			ti,spi-num-cs = <4>;
+		};
+
+		mcspi2: spi@4809a000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi2";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi3: spi@480b8000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi3";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi4: spi@480ba000 {
+			compatible = "ti,omap4-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi4";
+			ti,spi-num-cs = <1>;
+		};
 	};
 };
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 283d11e..8a489ba 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -725,7 +725,9 @@ static int __init omap2_init_devices(void)
 	omap_init_dmic();
 	omap_init_camera();
 	omap_init_mbox();
-	omap_init_mcspi();
+	/* If dtb is there, the devices will be created dynamically */
+	if (!of_have_populated_dt())
+		omap_init_mcspi();
 	omap_init_pmu();
 	omap_hdq_init();
 	omap_init_sti();
-- 
1.7.0.4

