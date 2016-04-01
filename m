From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 4/5] ARM: dts: omap: remove unneeded unit name for sound nodes
Date: Fri,  1 Apr 2016 16:20:21 -0400
Message-ID: <1459542022-17246-5-git-send-email-javier@osg.samsung.com>
References: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warning:

"sound@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am437x-gp-evm.dts       | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts      | 2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts   | 2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 2 +-
 arch/arm/boot/dts/dra7-evm.dts            | 2 +-
 arch/arm/boot/dts/dra72-evm.dts           | 2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 8889be1ca1c3..95ec82a77e67 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -119,7 +119,7 @@
 		clock-frequency = <32768>;
 	};
 
-	sound0: sound@0 {
+	sound0: sound0 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "AM437x-GP-EVM";
 		simple-audio-card,widgets =
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index d5dd72047a7e..04125b43e3a9 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -107,7 +107,7 @@
 		default-brightness-level = <8>;
 	};
 
-	sound0: sound@0 {
+	sound0: sound0 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "AM43-EPOS-EVM";
 		simple-audio-card,widgets =
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 0a5fc5d02ce2..75bd09b175cd 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -151,7 +151,7 @@
 		};
 	};
 
-	sound0: sound@0 {
+	sound0: sound0 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "BeagleBoard-X15";
 		simple-audio-card,widgets =
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 14f912a1b4fd..378b142ef88c 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -51,7 +51,7 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
-	sound0: sound@0 {
+	sound0: sound0 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "CL-SOM-AM57x-Sound-Card";
 		simple-audio-card,format = "i2s";
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index d9b87236019d..074d70b191e2 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -67,7 +67,7 @@
 		gpio = <&gpio7 11 GPIO_ACTIVE_HIGH>;
 	};
 
-	sound0: sound@0 {
+	sound0: sound0 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DRA7xx-EVM";
 		simple-audio-card,widgets =
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 6affe2d137da..6006ced8f6b3 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -104,7 +104,7 @@
 		};
 	};
 
-	sound0: sound@0 {
+	sound0: sound0 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "DRA7xx-EVM";
 		simple-audio-card,widgets =
diff --git a/arch/arm/boot/dts/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
index 49d032b846be..a17997f4e9aa 100644
--- a/arch/arm/boot/dts/omap4-var-som-om44.dtsi
+++ b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
@@ -17,7 +17,7 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 
-	sound: sound@0 {
+	sound: sound {
 		compatible = "ti,abe-twl6040";
 		ti,model = "VAR-SOM-OM44";
 
-- 
2.5.0
