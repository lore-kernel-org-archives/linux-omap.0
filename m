From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] arm/dts: Fix missing entries for am3517
Date: Tue,  3 Dec 2013 15:23:15 -0800
Message-ID: <1386112999-17271-2-git-send-email-tony@atomide.com>
References: <1386112999-17271-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51117 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411Ab3LCXXW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 18:23:22 -0500
In-Reply-To: <1386112999-17271-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On am3517 there are some extra devices compared to omap3.dtsi that
we currently have not defined. Let's fix that by adding am3517.dtsi
file.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am3517.dtsi | 63 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 arch/arm/boot/dts/am3517.dtsi

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
new file mode 100644
index 0000000..2fbe02f
--- /dev/null
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -0,0 +1,63 @@
+/*
+ * Device Tree Source for am3517 SoC
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include "omap3.dtsi"
+
+/ {
+	aliases {
+		serial3 = &uart4;
+	};
+
+	ocp {
+		am35x_otg_hs: am35x_otg_hs@5c040000 {
+			compatible = "ti,omap3-musb";
+			ti,hwmods = "am35x_otg_hs";
+			status = "disabled";
+			reg = <0x5c040000 0x1000>;
+			interrupts = <71>;
+			interrupt-names = "mc";
+		};
+
+		davinci_emac: ethernet@0x5c000000 {
+			compatible = "ti,am3517-emac";
+			ti,hwmods = "davinci_emac";
+			status = "disabled";
+			reg = <0x5c000000 0x30000>;
+			interrupts = <67 68 69 70>;
+			ti,davinci-ctrl-reg-offset = <0x10000>;
+			ti,davinci-ctrl-mod-reg-offset = <0>;
+			ti,davinci-ctrl-ram-offset = <0x20000>;
+			ti,davinci-ctrl-ram-size = <0x2000>;
+			ti,davinci-rmii-en = /bits/ 8 <1>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+		};
+
+		davinci_mdio: ethernet@0x5c030000 {
+			compatible = "ti,davinci_mdio";
+			ti,hwmods = "davinci_mdio";
+			status = "disabled";
+			reg = <0x5c030000 0x1000>;
+			bus_freq = <1000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		uart4: serial@4809e000 {
+			compatible = "ti,omap3-uart";
+			ti,hwmods = "uart4";
+			status = "disabled";
+			reg = <0x4809e000 0x400>;
+			interrupts = <84>;
+			dmas = <&sdma 55 &sdma 54>;
+			dma-names = "tx", "rx";
+			clock-frequency = <48000000>;
+		};
+	};
+};
-- 
1.8.1.1

