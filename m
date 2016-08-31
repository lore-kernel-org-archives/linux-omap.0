From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 12/23] ARM: dts: omap2: Add missing unit name to memory nodes
Date: Wed, 31 Aug 2016 12:35:26 +0200
Message-ID: <1472639737-17586-13-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/omap2420-h4.dts           | 2 +-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 2 +-
 arch/arm/boot/dts/omap2430-sdp.dts          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
index 34cdecb4fdda..9265c0b9c3f3 100644
--- a/arch/arm/boot/dts/omap2420-h4.dts
+++ b/arch/arm/boot/dts/omap2420-h4.dts
@@ -13,7 +13,7 @@
 	model = "TI OMAP2420 H4 board";
 	compatible = "ti,omap2420-h4", "ti,omap2420", "ti,omap2";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x4000000>; /* 64 MB */
 	};
diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index db95aadcca70..7e5ffc583c90 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -1,7 +1,7 @@
 #include "omap2420.dtsi"
 
 / {
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x8000000>; /* 128 MB */
 	};
diff --git a/arch/arm/boot/dts/omap2430-sdp.dts b/arch/arm/boot/dts/omap2430-sdp.dts
index 6b36ede58488..4f7d9d7c00c7 100644
--- a/arch/arm/boot/dts/omap2430-sdp.dts
+++ b/arch/arm/boot/dts/omap2430-sdp.dts
@@ -13,7 +13,7 @@
 	model = "TI OMAP2430 SDP";
 	compatible = "ti,omap2430-sdp", "ti,omap2430", "ti,omap2";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x8000000>; /* 128 MB */
 	};
-- 
2.7.4
