From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 16/23] ARM: dts: am335x: Add missing unit name to memory nodes
Date: Wed, 31 Aug 2016 12:35:30 +0200
Message-ID: <1472639737-17586-17-git-send-email-javier@osg.samsung.com>
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

 arch/arm/boot/dts/am335x-baltos.dtsi      | 2 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi | 2 +-
 arch/arm/boot/dts/am335x-chilisom.dtsi    | 2 +-
 arch/arm/boot/dts/am335x-cm-t335.dts      | 2 +-
 arch/arm/boot/dts/am335x-evm.dts          | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts        | 2 +-
 arch/arm/boot/dts/am335x-icev2.dts        | 2 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi    | 2 +-
 arch/arm/boot/dts/am335x-lxm.dts          | 2 +-
 arch/arm/boot/dts/am335x-nano.dts         | 2 +-
 arch/arm/boot/dts/am335x-pepper.dts       | 2 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 2 +-
 arch/arm/boot/dts/am335x-shc.dts          | 2 +-
 arch/arm/boot/dts/am335x-sl50.dts         | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index df0dd2a54b00..dd45d172a892 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -24,7 +24,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 8d21aca69f37..007b5e5a51a9 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -13,7 +13,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index 1d647358f1c1..f9ee5859c154 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -19,7 +19,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 4c0d6d7a37c2..947c81b7aaaf 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -17,7 +17,7 @@
 	model = "CompuLab CM-T335";
 	compatible = "compulab,cm-t335", "ti,am33xx";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x8000000>;	/* 128 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 944914e5b15a..3cf896a2a204 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -20,7 +20,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index c9b11107803d..0e5e8dcdcc24 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -27,7 +27,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index bc0190e4f10f..a06f01dcb911 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -19,7 +19,7 @@
 	model = "TI AM3359 ICE-V2";
 	compatible = "ti,am3359-icev2", "ti,am33xx";
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index df95818b4f67..a5769a8f5fc8 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -20,7 +20,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index 6594ce7449f3..1d6c6fa703e4 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -19,7 +19,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 71e082ca3f34..483d585c8908 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -19,7 +19,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index ddfdf3ca3d66..30e2f8770aaf 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -20,7 +20,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 29c2ea7950f6..75e24add3f13 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -25,7 +25,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index f9a15afb66c7..bf8727a19ece 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -102,7 +102,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index e3be7a6bf8f1..b0dfa6f14cd5 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -19,7 +19,7 @@
 		};
 	};
 
-	memory {
+	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
-- 
2.7.4
