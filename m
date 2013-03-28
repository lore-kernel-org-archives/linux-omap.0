From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] arm/dts: OMAP3: fix pinctrl-single configuration
Date: Thu, 28 Mar 2013 09:08:26 +0100
Message-ID: <1364458106.3757.11.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:57809 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab3C1IIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 04:08:32 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so674974bkc.2
        for <linux-omap@vger.kernel.org>; Thu, 28 Mar 2013 01:08:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

- Fix 'function-mask' referring to TRM Section 7.4.4:
  "Pad Functional Multiplexing and Configuration".
- Fix 'omap3_pmx_core' referring to TRM Table 7-4:
  "Core Control Module Pad Configuration Register Fields"
- Fix 'omap3_pmx_wkup' referring to TRM Table 7-6:
  "Wake-Up Control Module Pad Configuration Register Fields".

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/boot/dts/omap3.dtsi |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..6ce3b5c 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -27,7 +27,7 @@
 	};
 
 	/*
-	 * The soc node represents the soc top level view. It is uses for IPs
+	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
 	 */
 	soc {
@@ -77,20 +77,20 @@
 
 		omap3_pmx_core: pinmux@48002030 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002030 0x05cc>;
+			reg = <0x48002030 0x234>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
+			pinctrl-single,function-mask = <0x7f1f>;
 		};
 
-		omap3_pmx_wkup: pinmux@0x48002a58 {
+		omap3_pmx_wkup: pinmux@0x48002a00 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002a58 0x5c>;
+			reg = <0x48002a00 0x54>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
+			pinctrl-single,function-mask = <0x7f1f>;
 		};
 
 		gpio1: gpio@48310000 {
-- 
1.7.10.4



