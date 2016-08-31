From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 13/23] ARM: dts: omap3: Add missing unit name to memory nodes
Date: Wed, 31 Aug 2016 12:35:27 +0200
Message-ID: <1472639737-17586-14-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/logicpd-torpedo-som.dtsi     | 2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts          | 2 +-
 arch/arm/boot/dts/omap3-beagle.dts             | 2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi            | 2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi | 2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts           | 2 +-
 arch/arm/boot/dts/omap3-evm.dts                | 2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi             | 2 +-
 arch/arm/boot/dts/omap3-igep.dtsi              | 2 +-
 arch/arm/boot/dts/omap3-ldp.dts                | 2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi        | 2 +-
 arch/arm/boot/dts/omap3-n900.dts               | 2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi           | 2 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi        | 2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi    | 2 +-
 arch/arm/boot/dts/omap3-sniper.dts             | 2 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi           | 2 +-
 arch/arm/boot/dts/omap3-zoom3.dts              | 2 +-
 arch/arm/boot/dts/omap3430-sdp.dts             | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
index 5a63a8d8e177..731ec37aed5b 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -13,7 +13,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0 0>;
 	};
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 8ffde06281ad..85e297ed0ea1 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -19,7 +19,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index a19d907d4850..4be85ce59dd1 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -19,7 +19,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 6a0df13fa0f3..57b9a028a49a 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -4,7 +4,7 @@
 
 / {
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
index 586010179752..f330c69cc683 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
@@ -10,7 +10,7 @@
 
 #include "omap34xx.dtsi"
 / {
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>;	/* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index ed449827c3d3..4f9a76544602 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -15,7 +15,7 @@
 	model = "TI OMAP37XX EVM (TMDSEVM3730)";
 	compatible = "ti,omap3-evm-37xx", "ti,omap3630", "ti,omap3";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index e10dcd0fa539..99b2bfcd1059 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -14,7 +14,7 @@
 	model = "TI OMAP35XX EVM (TMDSEVM3530)";
 	compatible = "ti,omap3-evm", "ti,omap3";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index c09a0574af90..5563e2533ebd 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -21,7 +21,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index f4f2ce46d681..54c4c07bbe4a 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -13,7 +13,7 @@
 #include "omap36xx.dtsi"
 
 / {
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 2f353dadfa40..e28fe13cb007 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -15,7 +15,7 @@
 	model = "TI OMAP3430 LDP (Zoom1 Labrador)";
 	compatible = "ti,omap3-ldp", "ti,omap3";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x8000000>; /* 128 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index eff816e0bc0a..fa611a5e4850 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -17,7 +17,7 @@
 			bootargs = "console=ttyO0,115200n8 vt.global_cursor_default=0 consoleblank=0";
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x8000000>;   /* 128 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 2a6078a8422c..87ca50b53002 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -54,7 +54,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 284849008fc5..5d8c4b4a4205 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -24,7 +24,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 91b2e423c7c0..401fae838fe9 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -12,7 +12,7 @@
 
 / {
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0 0>;
 	};
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index af30d4d99307..53e007abdc71 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -18,7 +18,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3-sniper.dts
index 78a1184cb312..bc4498e77bc9 100644
--- a/arch/arm/boot/dts/omap3-sniper.dts
+++ b/arch/arm/boot/dts/omap3-sniper.dts
@@ -20,7 +20,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index 644d3c8ea66a..dc80886b5329 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -26,7 +26,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index c29b41dc7b95..45e2ce0803de 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -20,7 +20,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index a0dc8d854142..abd6921143be 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -13,7 +13,7 @@
 	model = "TI OMAP3430 SDP";
 	compatible = "ti,omap3430-sdp", "ti,omap3";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
-- 
2.7.4
