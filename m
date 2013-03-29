From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH v2] arm/dts: OMAP3: fix pinctrl-single configuration
Date: Fri, 29 Mar 2013 17:32:05 +0100
Message-ID: <1364574725.4634.51.camel@mars>
References: <1364458106.3757.11.camel@mars>
	 <20130328163854.GV10155@atomide.com> <1364549848.4634.13.camel@mars>
	 <20130329151759.GB10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:58971 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab3C2QcL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Mar 2013 12:32:11 -0400
Received: by mail-ea0-f180.google.com with SMTP id d10so278732eaj.11
        for <linux-omap@vger.kernel.org>; Fri, 29 Mar 2013 09:32:09 -0700 (PDT)
In-Reply-To: <20130329151759.GB10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

 - Fix 'function-mask' referring to TRM (Omap 36xx) Section 13.4.4:
   "Pad Functional Multiplexing and Configuration".
 - Fix 'omap3_pmx_wkup' referring to TRM Table 13-6:
   "Wkup Control Module Pad Configuration Register Fields".

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/boot/dts/omap3.dtsi |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..1997b41 100644
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
@@ -81,16 +81,16 @@
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
+			reg = <0x48002a00 0x5c>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
+			pinctrl-single,function-mask = <0x7f1f>;
 		};
 
 		gpio1: gpio@48310000 {
-- 
1.7.10.4



