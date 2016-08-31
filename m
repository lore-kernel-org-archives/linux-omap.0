From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 14/23] ARM: dts: omap4: Add missing unit name to memory nodes
Date: Wed, 31 Aug 2016 12:35:28 +0200
Message-ID: <1472639737-17586-15-git-send-email-javier@osg.samsung.com>
References: <1472639737-17586-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472639737-17586-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap4-duovero.dtsi      | 2 +-
 arch/arm/boot/dts/omap4-kc1.dts           | 2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi | 2 +-
 arch/arm/boot/dts/omap4-sdp.dts           | 2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/omap4-duovero.dtsi
index a90b582e4c3f..ec0bd9779e1a 100644
--- a/arch/arm/boot/dts/omap4-duovero.dtsi
+++ b/arch/arm/boot/dts/omap4-duovero.dtsi
@@ -12,7 +12,7 @@
 	model = "Gumstix Duovero";
 	compatible = "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
diff --git a/arch/arm/boot/dts/omap4-kc1.dts b/arch/arm/boot/dts/omap4-kc1.dts
index 2251bd54e4e6..e3763ac75719 100644
--- a/arch/arm/boot/dts/omap4-kc1.dts
+++ b/arch/arm/boot/dts/omap4-kc1.dts
@@ -13,7 +13,7 @@
 	model = "Amazon Kindle Fire (first generation)";
 	compatible = "amazon,omap4-kc1", "ti,omap4430", "ti,omap4";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index f8f13952cfeb..d48e45bd4b3d 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -8,7 +8,7 @@
 #include "elpida_ecb240abacn.dtsi"
 
 / {
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 10d73a784050..d728ec963111 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -14,7 +14,7 @@
 	model = "TI OMAP4 SDP board";
 	compatible = "ti,omap4-sdp", "ti,omap4430", "ti,omap4";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
diff --git a/arch/arm/boot/dts/omap4-var-som-om44.dtsi b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
index 873cfc87260c..758b6eb7ae43 100644
--- a/arch/arm/boot/dts/omap4-var-som-om44.dtsi
+++ b/arch/arm/boot/dts/omap4-var-som-om44.dtsi
@@ -12,7 +12,7 @@
 	model = "Variscite VAR-SOM-OM44";
 	compatible = "variscite,var-som-om44", "ti,omap4460", "ti,omap4";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
-- 
2.7.4
