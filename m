From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 19/23] ARM: dts: am572x: Add missing unit name to memory nodes
Date: Wed, 31 Aug 2016 12:35:33 +0200
Message-ID: <1472639737-17586-20-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am572x-idk.dts          | 2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts   | 2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index e3acb99703e1..87bbc66f0f21 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -18,7 +18,7 @@
 	compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74",
 		     "ti,dra7";
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 8b115e1b48a3..9067ca092dc5 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -23,7 +23,7 @@
 		display0 = &hdmi0;
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 832d766cd31e..203266f88480 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -19,7 +19,7 @@
 	model = "CompuLab CL-SOM-AM57x";
 	compatible = "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7";
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x20000000>; /* 512 MB - minimal configuration */
 	};
-- 
2.7.4
