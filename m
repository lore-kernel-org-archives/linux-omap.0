From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH] ARM: dts: AM4372: clk: efuse based crystal frequency detect
Date: Wed, 14 May 2014 17:06:37 +0530
Message-ID: <062e8a534b1e372db7ed3daa3df7e3c5b885ffab.1400062517.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44683 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbaENLhH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 May 2014 07:37:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>

From: Afzal Mohammed <afzal@ti.com>

Currently oscillator frequency is determined based on sysboot settings,
it may not be the case always. To determine it properly, efuse settings
also has to be read. CONTROL_STATUS register holds this information.
Bit 31:	if 0, frequency to be determined based on sysboot
	if 1, frequency to be determined based on efuse
Bit 29,30 - for efuse detection of frequency
Bit 22,23 - for sysboot detection of frequency

Add clock nodes (mux) to determine oscillator frequency as above.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 142009c..71b029c 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -11,6 +11,22 @@
 	sys_clkin_ck: sys_clkin_ck {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
+		clocks = <&sysboot_freq_sel_ck>, <&crystal_freq_sel_ck>;
+		ti,bit-shift = <31>;
+		reg = <0x0040>;
+	};
+
+	crystal_freq_sel_ck: crystal_freq_sel_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&virt_19200000_ck>, <&virt_24000000_ck>, <&virt_25000000_ck>, <&virt_26000000_ck>;
+		ti,bit-shift = <29>;
+		reg = <0x0040>;
+	};
+
+	sysboot_freq_sel_ck: sysboot_freq_sel_ck@44e10040 {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
 		clocks = <&virt_19200000_ck>, <&virt_24000000_ck>, <&virt_25000000_ck>, <&virt_26000000_ck>;
 		ti,bit-shift = <22>;
 		reg = <0x0040>;
-- 
1.7.10.1

