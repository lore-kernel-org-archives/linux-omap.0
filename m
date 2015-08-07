From: Matthias Klein <matthias.klein@optimeas.de>
Subject: [PATCH] ARM: dts: am335x-phycore-som: Move NAND partition table into board files
Date: Fri,  7 Aug 2015 11:09:59 +0200
Message-ID: <1438938599-11252-1-git-send-email-matthias.klein@optimeas.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, support@phytec.de
Cc: matthias.klein@optimeas.de
List-Id: linux-omap@vger.kernel.org

Partitions which are defined in the som file can not be deleted in the
board file.

Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 37 -------------------------
 arch/arm/boot/dts/am335x-wega.dtsi        | 45 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 4d28fc3..8f12bd54 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -189,43 +189,6 @@
 
 		#address-cells = <1>;
 		#size-cells = <1>;
-
-		partition@0 {
-			label = "xload";
-			reg = <0x0 0x20000>;
-		};
-		partition@1 {
-			label = "xload_backup1";
-			reg = <0x20000 0x20000>;
-		};
-		partition@2 {
-			label = "xload_backup2";
-			reg = <0x40000 0x20000>;
-		};
-		partition@3 {
-			label = "xload_backup3";
-			reg = <0x60000 0x20000>;
-		};
-		partition@4 {
-			label = "barebox";
-			reg = <0x80000 0x80000>;
-		};
-		partition@5 {
-			label = "bareboxenv";
-			reg = <0x100000 0x40000>;
-		};
-		partition@6 {
-			label = "oftree";
-			reg = <0x140000 0x40000>;
-		};
-		partition@7 {
-			label = "kernel";
-			reg = <0x180000 0x800000>;
-		};
-		partition@8 {
-			label = "root";
-			reg = <0x980000 0x0>;
-		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 5e541bd..945a41d 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -149,3 +149,48 @@
 &usb1_phy {
 	status = "okay";
 };
+
+&nandflash {
+	partition@0 {
+		label = "xload";
+		reg = <0x0 0x20000>;
+	};
+
+	partition@1 {
+		label = "xload_backup1";
+		reg = <0x20000 0x20000>;
+	};
+
+	partition@2 {
+		label = "xload_backup2";
+		reg = <0x40000 0x20000>;
+	};
+
+	partition@3 {
+		label = "xload_backup3";
+		reg = <0x60000 0x20000>;
+	};
+
+	partition@4 {
+		label = "barebox";
+		reg = <0x80000 0x80000>;
+	};
+
+	partition@5 {
+		label = "bareboxenv";
+		reg = <0x100000 0x40000>;
+	};
+
+	partition@6 {
+		label = "oftree";
+		reg = <0x140000 0x40000>;
+	};
+	partition@7 {
+		label = "kernel";
+		reg = <0x180000 0x800000>;
+	};
+	partition@8 {
+		label = "root";
+		reg = <0x980000 0x0>;
+	};
+};
-- 
2.1.4
