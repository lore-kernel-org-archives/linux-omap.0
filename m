From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 3/8] ARM/dts: omap3: Add McBSP entries
Date: Wed,  5 Sep 2012 14:58:51 +0300
Message-ID: <1346846336-27321-4-git-send-email-peter.ujfalusi@ti.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:44314 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757421Ab2IEL7B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 07:59:01 -0400
Received: by yenl14 with SMTP id l14so51374yen.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 04:58:55 -0700 (PDT)
In-Reply-To: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Create the needed sections to be able to probe McBSP ports via DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 8109471..f024bb3 100644
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
+			interrupts = <16>, /* OCP compliant interrupt */
+				     <59>, /* TX interrupt */
+				     <60>; /* RX interrupt */
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
+			interrupts = <17>, /* OCP compliant interrupt */
+				     <62>, /* TX interrupt */
+				     <63>, /* RX interrupt */
+				     <4>;  /* Sidetone */
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
+			interrupts = <22>, /* OCP compliant interrupt */
+				     <89>, /* TX interrupt */
+				     <90>, /* RX interrupt */
+				     <5>;  /* Sidetone */
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
+			interrupts = <23>, /* OCP compliant interrupt */
+				     <54>, /* TX interrupt */
+				     <55>; /* RX interrupt */
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
+			interrupts = <27>, /* OCP compliant interrupt */
+				     <81>, /* TX interrupt */
+				     <82>; /* RX interrupt */
+			interrupt-names = "common", "tx", "rx";
+			interrupt-parent = <&intc>;
+			ti,buffer-size = <128>;
+			ti,hwmods = "mcbsp5";
+		};
 	};
 };
-- 
1.7.12

