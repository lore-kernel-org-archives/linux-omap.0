From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/6] ARM/dts: OMAP3: Add McBSP entries
Date: Thu, 23 Aug 2012 12:29:10 +0300
Message-ID: <1345714153-13094-4-git-send-email-peter.ujfalusi@ti.com>
References: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:49749 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758264Ab2HWJ3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 05:29:30 -0400
Received: by obbta17 with SMTP id ta17so1185711obb.8
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 02:29:29 -0700 (PDT)
In-Reply-To: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Create the needed sections to be able to probe McBSP ports via DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   69 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 8109471..5c14b00 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -220,5 +220,74 @@
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
 		};
+
+		mcbsp1: mcbsp@48074000 {
+			compatible = "ti,omap3-mcbsp";
+			reg = <0x48074000 0xff>;
+			reg-names = "mpu";
+			interrupts = <0 16 0x4>, /* OCP compliant interrupt */
+				     <0 59 0x4>, /* TX interrupt */
+				     <0 60 0x4>; /* RX interrupt */
+			interrupt-names = "common", "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp1";
+		};
+
+		mcbsp2: mcbsp@49022000 {
+			compatible = "ti,omap3-mcbsp";
+			reg = <0x49022000 0xff>,
+			      <0x49028000 0xff>;
+			reg-names = "mpu", "sidetone";
+			interrupts = <0 17 0x4>, /* OCP compliant interrupt */
+				     <0 62 0x4>, /* TX interrupt */
+				     <0 63 0x4>, /* RX interrupt */
+				     <0 4 0x4>;  /* Sidetone */
+			interrupt-names = "common", "tx", "rx", "sidetone";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <1280>;
+			ti,hwmods = "mcbsp2";
+		};
+
+		mcbsp3: mcbsp@49024000 {
+			compatible = "ti,omap3-mcbsp";
+			reg = <0x49024000 0xff>,
+			      <0x4902a000 0xff>;
+			reg-names = "mpu", "sidetone";
+			interrupts = <0 22 0x4>, /* OCP compliant interrupt */
+				     <0 89 0x4>, /* TX interrupt */
+				     <0 90 0x4>, /* RX interrupt */
+				     <0 5 0x4>;  /* Sidetone */
+			interrupt-names = "common", "tx", "rx", "sidetone";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp3";
+		};
+
+		mcbsp4: mcbsp@49026000 {
+			compatible = "ti,omap3-mcbsp";
+			reg = <0x49026000 0xff>;
+			reg-names = "mpu";
+			interrupts = <0 23 0x4>, /* OCP compliant interrupt */
+				     <0 54 0x4>, /* TX interrupt */
+				     <0 55 0x4>; /* RX interrupt */
+			interrupt-names = "common", "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp4";
+		};
+
+		mcbsp5: mcbsp@48096000 {
+			compatible = "ti,omap3-mcbsp";
+			reg = <0x48096000 0xff>;
+			reg-names = "mpu";
+			interrupts = <0 27 0x4>, /* OCP compliant interrupt */
+				     <0 81 0x4>, /* TX interrupt */
+				     <0 82 0x4>; /* RX interrupt */
+			interrupt-names = "common", "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp5";
+		};
 	};
 };
-- 
1.7.8.6

