From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v3 1/5] ARM: dts: OMAP2+: use #include for all device trees
Date: Mon, 27 May 2013 16:52:30 +0200
Message-ID: <1369666354-29152-2-git-send-email-florian.vaussard@epfl.ch>
References: <1369666354-29152-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:40738 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758165Ab3E0Oxf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 10:53:35 -0400
In-Reply-To: <1369666354-29152-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Replace /include/ by #include for OMAP2+ DT, in order to use the
C pre-processor, making use of #define features possible.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi              |    2 +-
 arch/arm/boot/dts/omap2420-h4.dts         |    2 +-
 arch/arm/boot/dts/omap2420.dtsi           |    2 +-
 arch/arm/boot/dts/omap2430.dtsi           |    2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts     |    4 ++--
 arch/arm/boot/dts/omap3-beagle.dts        |    4 ++--
 arch/arm/boot/dts/omap3-devkit8000.dts    |    4 ++--
 arch/arm/boot/dts/omap3-evm.dts           |    4 ++--
 arch/arm/boot/dts/omap3-igep.dtsi         |    4 ++--
 arch/arm/boot/dts/omap3-igep0020.dts      |    2 +-
 arch/arm/boot/dts/omap3-igep0030.dts      |    2 +-
 arch/arm/boot/dts/omap3-overo.dtsi        |    4 ++--
 arch/arm/boot/dts/omap3-tobi.dts          |    2 +-
 arch/arm/boot/dts/omap3.dtsi              |    2 +-
 arch/arm/boot/dts/omap3430-sdp.dts        |    4 ++--
 arch/arm/boot/dts/omap34xx.dtsi           |    2 +-
 arch/arm/boot/dts/omap36xx.dtsi           |    2 +-
 arch/arm/boot/dts/omap4-panda-a4.dts      |    4 ++--
 arch/arm/boot/dts/omap4-panda-common.dtsi |    4 ++--
 arch/arm/boot/dts/omap4-panda-es.dts      |    4 ++--
 arch/arm/boot/dts/omap4-panda.dts         |    4 ++--
 arch/arm/boot/dts/omap4-sdp-es23plus.dts  |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts           |    6 +++---
 arch/arm/boot/dts/omap4-var-som.dts       |    4 ++--
 arch/arm/boot/dts/omap4.dtsi              |    2 +-
 arch/arm/boot/dts/omap443x.dtsi           |    2 +-
 arch/arm/boot/dts/omap4460.dtsi           |    2 +-
 arch/arm/boot/dts/omap5-evm.dts           |    4 ++--
 arch/arm/boot/dts/omap5.dtsi              |    2 +-
 29 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 37aa748..e6e4587 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "ti,omap2430", "ti,omap2420", "ti,omap2";
diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
index 68282ee..224c08f 100644
--- a/arch/arm/boot/dts/omap2420-h4.dts
+++ b/arch/arm/boot/dts/omap2420-h4.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap2420.dtsi"
+#include "omap2420.dtsi"
 
 / {
 	model = "TI OMAP2420 H4 board";
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index da5b285..c8f9c55 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-/include/ "omap2.dtsi"
+#include "omap2.dtsi"
 
 / {
 	compatible = "ti,omap2420", "ti,omap2";
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 054bc44..c535a5a 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-/include/ "omap2.dtsi"
+#include "omap2.dtsi"
 
 / {
 	compatible = "ti,omap2430", "ti,omap2";
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 3046d1f..e0ce823 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap36xx.dtsi"
+#include "omap36xx.dtsi"
 
 / {
 	model = "TI OMAP3 BeagleBoard xM";
@@ -75,7 +75,7 @@
 	};
 };
 
-/include/ "twl4030.dtsi"
+#include "twl4030.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 6eec699..fcac96a 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap34xx.dtsi"
+#include "omap34xx.dtsi"
 
 / {
 	model = "TI OMAP3 BeagleBoard";
@@ -107,7 +107,7 @@
 	};
 };
 
-/include/ "twl4030.dtsi"
+#include "twl4030.dtsi"
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 8a5cdcc..8d0f5e4 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap34xx.dtsi"
+#include "omap34xx.dtsi"
 / {
 	model = "TimLL OMAP3 Devkit8000";
 	compatible = "timll,omap3-devkit8000", "ti,omap3";
@@ -80,7 +80,7 @@
 	status = "disabled";
 };
 
-/include/ "twl4030.dtsi"
+#include "twl4030.dtsi"
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index 96d1c20..d75759b 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap34xx.dtsi"
+#include "omap34xx.dtsi"
 
 / {
 	model = "TI OMAP3 EVM (OMAP3530, AM/DM37x)";
@@ -44,7 +44,7 @@
 	};
 };
 
-/include/ "twl4030.dtsi"
+#include "twl4030.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index f8fe3b7..54588b0 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -10,7 +10,7 @@
  */
 /dts-v1/;
 
-/include/ "omap34xx.dtsi"
+#include "omap34xx.dtsi"
 
 / {
 	memory {
@@ -80,7 +80,7 @@
 	};
 };
 
-/include/ "twl4030.dtsi"
+#include "twl4030.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index e2b9849..2f96a5c 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -9,7 +9,7 @@
  * published by the Free Software Foundation.
  */
 
-/include/ "omap3-igep.dtsi"
+#include "omap3-igep.dtsi"
 
 / {
 	model = "IGEPv2";
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 9dc48d2..f3a1bf0 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -9,7 +9,7 @@
  * published by the Free Software Foundation.
  */
 
-/include/ "omap3-igep.dtsi"
+#include "omap3-igep.dtsi"
 
 / {
 	model = "IGEP COM Module";
diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index a626c50..e112a42 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -11,7 +11,7 @@
  */
 /dts-v1/;
 
-/include/ "omap34xx.dtsi"
+#include "omap34xx.dtsi"
 
 / {
 	pwmleds {
@@ -49,7 +49,7 @@
 	};
 };
 
-/include/ "twl4030.dtsi"
+#include "twl4030.dtsi"
 
 /* i2c2 pins are used for gpio */
 &i2c2 {
diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index a13d12d..5df894f 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -10,7 +10,7 @@
  * Tobi expansion board is manufactured by Gumstix Inc.
  */
 
-/include/ "omap3-overo.dtsi"
+#include "omap3-overo.dtsi"
 
 / {
 	model = "TI OMAP3 Gumstix Overo on Tobi";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 82a404d..7c7d494 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "ti,omap3430", "ti,omap3";
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 144ae43..2a725a0 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap34xx.dtsi"
+#include "omap34xx.dtsi"
 
 / {
 	model = "TI OMAP3430 SDP";
@@ -28,7 +28,7 @@
 	};
 };
 
-/include/ "twl4030.dtsi"
+#include "twl4030.dtsi"
 
 &mmc1 {
 	vmmc-supply = <&vmmc1>;
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 75ed4ae..5355d61 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-/include/ "omap3.dtsi"
+#include "omap3.dtsi"
 
 / {
 	cpus {
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index f3447bc..f8b3765 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-/include/ "omap3.dtsi"
+#include "omap3.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/omap4-panda-a4.dts b/arch/arm/boot/dts/omap4-panda-a4.dts
index e30cdf0..f18fb5c 100644
--- a/arch/arm/boot/dts/omap4-panda-a4.dts
+++ b/arch/arm/boot/dts/omap4-panda-a4.dts
@@ -7,8 +7,8 @@
  */
 /dts-v1/;
 
-/include/ "omap443x.dtsi"
-/include/ "omap4-panda-common.dtsi"
+#include "omap443x.dtsi"
+#include "omap4-panda-common.dtsi"
 
 /* Pandaboard Rev A4+ have external pullups on SCL & SDA */
 &dss_hdmi_pins {
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 03bd60d..63148d1 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -5,7 +5,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-/include/ "elpida_ecb240abacn.dtsi"
+#include "elpida_ecb240abacn.dtsi"
 
 / {
 	model = "TI OMAP4 PandaBoard";
@@ -164,7 +164,7 @@
 	};
 };
 
-/include/ "twl6030.dtsi"
+#include "twl6030.dtsi"
 
 &i2c2 {
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
index f1d8c21..c6f012e 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -7,8 +7,8 @@
  */
 /dts-v1/;
 
-/include/ "omap4460.dtsi"
-/include/ "omap4-panda-common.dtsi"
+#include "omap4460.dtsi"
+#include "omap4-panda-common.dtsi"
 
 /* Audio routing is differnet between PandaBoard4430 and PandaBoardES */
 &sound {
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index f8b221f..6189a8b 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -7,5 +7,5 @@
  */
 /dts-v1/;
 
-/include/ "omap443x.dtsi"
-/include/ "omap4-panda-common.dtsi"
+#include "omap443x.dtsi"
+#include "omap4-panda-common.dtsi"
diff --git a/arch/arm/boot/dts/omap4-sdp-es23plus.dts b/arch/arm/boot/dts/omap4-sdp-es23plus.dts
index b4a40ff..4f26355 100644
--- a/arch/arm/boot/dts/omap4-sdp-es23plus.dts
+++ b/arch/arm/boot/dts/omap4-sdp-es23plus.dts
@@ -5,7 +5,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-/include/ "omap4-sdp.dts"
+#include "omap4-sdp.dts"
 
 /* SDP boards with 4430 ES2.3+ or 4460 have external pullups on SCL & SDA */
 &dss_hdmi_pins {
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index a35d9cd..5edd08e 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -7,8 +7,8 @@
  */
 /dts-v1/;
 
-/include/ "omap443x.dtsi"
-/include/ "elpida_ecb240abacn.dtsi"
+#include "omap443x.dtsi"
+#include "elpida_ecb240abacn.dtsi"
 
 / {
 	model = "TI OMAP4 SDP board";
@@ -316,7 +316,7 @@
 	};
 };
 
-/include/ "twl6030.dtsi"
+#include "twl6030.dtsi"
 
 &i2c2 {
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/omap4-var-som.dts b/arch/arm/boot/dts/omap4-var-som.dts
index 7e04103..6593607 100644
--- a/arch/arm/boot/dts/omap4-var-som.dts
+++ b/arch/arm/boot/dts/omap4-var-som.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap443x.dtsi"
+#include "omap443x.dtsi"
 
 / {
 	model = "Variscite OMAP4 SOM";
@@ -39,7 +39,7 @@
 	};
 };
 
-/include/ "twl6030.dtsi"
+#include "twl6030.dtsi"
 
 &i2c2 {
 	clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2a56428..53d80aa 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -14,7 +14,7 @@
  */
 /memreserve/ 0x9d000000 0x03000000;
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "ti,omap4430", "ti,omap4";
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index cccf39a..a81f8df 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-/include/ "omap4.dtsi"
+#include "omap4.dtsi"
 
 / {
 	cpus {
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 2cf227c..41762c2 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -7,7 +7,7 @@
  * version 2.  This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
  */
-/include/ "omap4.dtsi"
+#include "omap4.dtsi"
 
 / {
 	cpus {
diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 982acd1..f5f55d1 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -7,8 +7,8 @@
  */
 /dts-v1/;
 
-/include/ "omap5.dtsi"
-/include/ "samsung_k3pe0e000b.dtsi"
+#include "omap5.dtsi"
+#include "samsung_k3pe0e000b.dtsi"
 
 / {
 	model = "TI OMAP5 EVM board";
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 3dd7ff8..e8e6653 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -15,7 +15,7 @@
  */
 /memreserve/ 0x9d000000 0x03000000;
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	#address-cells = <1>;
-- 
1.7.5.4

