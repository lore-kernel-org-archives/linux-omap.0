From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 1/2] ARM: dts: omap3: Remove all references to ti,codec property
Date: Thu, 12 Mar 2015 22:14:58 +0100
Message-ID: <1426194899-14037-2-git-send-email-marek@goldelico.com>
References: <1426194899-14037-1-git-send-email-marek@goldelico.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43426 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895AbbCLVPR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2015 17:15:17 -0400
In-Reply-To: <1426194899-14037-1-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, peter.ujfalusi@ti.com
Cc: eballetbo@gmail.com, javier@dowhile0.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jarkko.nikula@bitmer.com, hns@goldelico.com, Marek Belisko <marek@goldelico.com>

ti,codec property is not used (parsed) in omap-twl4030 driver. The ti,twl4030-audio
which ti,codec points by phandle is mfd driver and device for ASoC codec is created
w/o DT compatible string. Removing all references in DT files.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts   | 1 -
 arch/arm/boot/dts/omap3-beagle.dts      | 1 -
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi   | 1 -
 arch/arm/boot/dts/omap3-devkit8000.dts  | 1 -
 arch/arm/boot/dts/omap3-gta04.dtsi      | 1 -
 arch/arm/boot/dts/omap3-igep.dtsi       | 1 -
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi | 1 -
 arch/arm/boot/dts/omap3-overo-base.dtsi | 1 -
 arch/arm/boot/dts/omap3-tao3530.dtsi    | 1 -
 9 files changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 25f7b0a..da1464b 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -60,7 +60,6 @@
 		ti,model = "omap3beagle";
 
 		ti,mcbsp = <&mcbsp2>;
-		ti,codec = <&twl_audio>;
 	};
 
 	gpio_keys {
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index c792391..4d30eaf 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -71,7 +71,6 @@
 		ti,model = "omap3beagle";
 
 		ti,mcbsp = <&mcbsp2>;
-		ti,codec = <&twl_audio>;
 	};
 
 	gpio_keys {
diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
index d9e92b6..046cd77 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -16,7 +16,6 @@
 		ti,model = "cm-t35";
 
 		ti,mcbsp = <&mcbsp2>;
-		ti,codec = <&twl_audio>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 169037e..134d3f2 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -48,7 +48,6 @@
 		ti,model = "devkit8000";
 
 		ti,mcbsp = <&mcbsp2>;
-		ti,codec = <&twl_audio>;
 		ti,audio-routing =
 			"Ext Spk", "PREDRIVEL",
 			"Ext Spk", "PREDRIVER",
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index fb3a696..b9f6881 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -46,7 +46,6 @@
 		ti,model = "gta04";
 
 		ti,mcbsp = <&mcbsp2>;
-		ti,codec = <&twl_audio>;
 	};
 
 	spi_lcd {
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 8a63ad2..d5e5cd4 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -22,7 +22,6 @@
 		compatible = "ti,omap-twl4030";
 		ti,model = "igep2";
 		ti,mcbsp = <&mcbsp2>;
-		ti,codec = <&twl_audio>;
 	};
 
 	vdd33: regulator-vdd33 {
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index e81fb65..e631333 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -38,7 +38,6 @@
 		ti,model = "lilly-a83x";
 
 		ti,mcbsp = <&mcbsp2>;
-		ti,codec = <&twl_audio>;
 	};
 
 	reg_vcc3: vcc3 {
diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index d36bf02..18e1649 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -27,7 +27,6 @@
 		ti,model = "overo";
 
 		ti,mcbsp = <&mcbsp2>;
-		ti,codec = <&twl_audio>;
 	};
 
 	/* HS USB Port 2 Power */
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index e89820a..b3b24a5 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -45,7 +45,6 @@
 
 		/* McBSP2 is used for onboard sound, same as on beagle */
 		ti,mcbsp = <&mcbsp2>;
-		ti,codec = <&twl_audio>;
 	};
 
 	/* Regulator to enable/switch the vcc of the Wifi module */
-- 
1.9.1

