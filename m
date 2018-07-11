From: Adam Ford <aford173@gmail.com>
Subject: [PATCH] ARM: DTS: am3517.dtsi:  Disable reference to OMAP3 OTG controller
Date: Wed, 11 Jul 2018 12:54:54 -0500
Message-ID: <20180711175454.9464-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adam.ford@logicpd.com
Cc: Adam Ford <aford173@gmail.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The AM3517 has a different OTG controller location than the OMAP3,
which is included from omap3.dtsi.  This results in a hwmod error.
Since the AM3517 has a different OTG controller address, this patch
disabes one that is isn't available.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index c17cfe6a2132..cb264220dcb8 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -87,6 +87,11 @@
 	};
 };
 
+/* Table Table 5-79 of the TRM shows 480ab000 is reserved */
+&usb_otg_hs {
+	status = "disabled";
+};
+
 &iva {
 	status = "disabled";
 };
-- 
2.17.1
