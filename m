From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 8/9] ARM/dts: Add pinctrl driver entries for omap5
Date: Thu,  4 Oct 2012 14:57:27 +0300
Message-ID: <1349351848-12972-9-git-send-email-peter.ujfalusi@ti.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:55233 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755570Ab2JDL4e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 07:56:34 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so339763oag.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 04:56:33 -0700 (PDT)
In-Reply-To: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

These all use the generic pinctrl-single driver for the padconf registers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 9ac75b3..00ee987 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -65,6 +65,23 @@
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
 
+		omap5_pmx_core: pinmux@4a002840 {
+			compatible = "ti,omap4-padconf", "pinctrl-single";
+			reg = <0x4a002840 0x01b6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0x7fff>;
+		};
+		omap5_pmx_wkup: pinmux@4ae0c840 {
+			compatible = "ti,omap4-padconf", "pinctrl-single";
+			reg = <0x4ae0c840 0x0038>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <16>;
+			pinctrl-single,function-mask = <0x7fff>;
+		};
+
 		gic: interrupt-controller@48211000 {
 			compatible = "arm,cortex-a15-gic";
 			interrupt-controller;
-- 
1.7.12

