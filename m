From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 06/10] ARM: dts: omap4: Update omap-usb-host node
Date: Mon, 20 Jan 2014 16:11:27 +0200
Message-ID: <1390227091-4523-7-git-send-email-rogerq@ti.com>
References: <1390227091-4523-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390227091-4523-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: balbi@ti.com, lee.jones@linaro.org, arnd@arndb.de, sre@debian.org, mark.rutland@arm.com, m.paolino@virtualopensystems.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The omap-usb-host driver expects a certain name for internal
and external reference clocks. Provide these clocks.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index d3f8a6e..39a05ce 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -697,6 +697,12 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			clocks = <&init_60m_fclk>,
+				 <&xclk60mhsp1_ck>,
+				 <&xclk60mhsp2_ck>;
+			clock-names = "refclk_60m_int",
+				      "refclk_60m_ext_p1",
+				      "refclk_60m_ext_p2";
 
 			usbhsohci: ohci@4a064800 {
 				compatible = "ti,ohci-omap3", "usb-ohci";
-- 
1.8.3.2
