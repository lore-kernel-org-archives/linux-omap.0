From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 03/10] ARM: dts: am335x/am437x: remove unneeded unit name for gpio-matrix-keypad
Date: Mon,  1 Aug 2016 12:46:57 -0400
Message-ID: <1470070024-30281-4-git-send-email-javier@osg.samsung.com>
References: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470070024-30281-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for many boards:

"Node /matrix_keypad@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am335x-evm.dts     | 2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts  | 2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts  | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 5d28712ad253..d5e6da5a782a 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -53,7 +53,7 @@
 		enable-active-high;
 	};
 
-	matrix_keypad: matrix_keypad@0 {
+	matrix_keypad: matrix_keypad0 {
 		compatible = "gpio-matrix-keypad";
 		debounce-delay-ms = <5>;
 		col-scan-delay-us = <2>;
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 14677d599595..128dbefa77e7 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -58,7 +58,7 @@
 		default-brightness-level = <8>;
 	};
 
-	matrix_keypad: matrix_keypad@0 {
+	matrix_keypad: matrix_keypad0 {
 		compatible = "gpio-matrix-keypad";
 		debounce-delay-ms = <5>;
 		col-scan-delay-us = <2>;
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 5687d6b4da60..9d71246d31ad 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -64,7 +64,7 @@
 		};
 	};
 
-	matrix_keypad: matrix_keypad@0 {
+	matrix_keypad: matrix_keypad0 {
 		compatible = "gpio-matrix-keypad";
 
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index ad32e55532f8..3ce23f2920e6 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -67,7 +67,7 @@
 		};
 	};
 
-	matrix_keypad: matrix_keypad@0 {
+	matrix_keypad: matrix_keypad0 {
 		compatible = "gpio-matrix-keypad";
 		debounce-delay-ms = <5>;
 		col-scan-delay-us = <2>;
-- 
2.5.5
