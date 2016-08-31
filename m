From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 15/23] ARM: dts: omap5: Add missing unit name to memory nodes
Date: Wed, 31 Aug 2016 12:35:29 +0200
Message-ID: <1472639737-17586-16-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/omap5-cm-t54.dts   | 2 +-
 arch/arm/boot/dts/omap5-igep0050.dts | 2 +-
 arch/arm/boot/dts/omap5-uevm.dts     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index fe724da3ec0d..c9390fa9c362 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -11,7 +11,7 @@
 	model = "CompuLab CM-T54";
 	compatible = "compulab,omap5-cm-t54", "ti,omap5";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x7F000000>; /* 2048 MB */
 	};
diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
index f75ce02fb398..7aa2b0c813ab 100644
--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -13,7 +13,7 @@
 	model = "IGEPv5";
 	compatible = "isee,omap5-igep0050", "ti,omap5";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x7f000000>; /* 2032 MB */
 	};
diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index a51e60518eb6..5230ca00913a 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -13,7 +13,7 @@
 	model = "TI OMAP5 uEVM board";
 	compatible = "ti,omap5-uevm", "ti,omap5";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x7F000000>; /* 2032 MB */
 	};
-- 
2.7.4
