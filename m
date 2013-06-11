From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 3/3] ARM: dts: OMAP3: Use MTD constants for OMAP3 boards
Date: Tue, 11 Jun 2013 16:48:58 +0200
Message-ID: <1370962138-9631-4-git-send-email-florian.vaussard@epfl.ch>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:42772 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752528Ab3FKOtO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 10:49:14 -0400
In-Reply-To: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Anil Kumar <anilk4.v@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Use the MTD constants for NAND and OneNAND nodes used in OMAP3
DTS.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-devkit8000.dts |   10 +++++-----
 arch/arm/boot/dts/omap3-igep0020.dts   |   10 +++++-----
 arch/arm/boot/dts/omap3-igep0030.dts   |   10 +++++-----
 arch/arm/boot/dts/omap3430-sdp.dts     |   28 ++++++++++++++--------------
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 5be71b1..08699cb 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -143,27 +143,27 @@
 
 		x-loader@0 {
 			label = "X-Loader";
-			reg = <0 0x80000>;
+			reg = <(0 * SZ_128K) (4 * SZ_128K)>;
 		};
 
 		bootloaders@80000 {
 			label = "U-Boot";
-			reg = <0x80000 0x1e0000>;
+			reg = <(4 * SZ_128K) (15 * SZ_128K)>;
 		};
 
 		bootloaders_env@260000 {
 			label = "U-Boot Env";
-			reg = <0x260000 0x20000>;
+			reg = <(19 * SZ_128K) (1 * SZ_128K)>;
 		};
 
 		kernel@280000 {
 			label = "Kernel";
-			reg = <0x280000 0x400000>;
+			reg = <(20 * SZ_128K) (32 * SZ_128K)>;
 		};
 
 		filesystem@680000 {
 			label = "File System";
-			reg = <0x680000 0xf980000>;
+			reg = <(52 * SZ_128K) MTDPART_SIZ_FULL>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index e8c4828..3476b3c 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -97,23 +97,23 @@
 
 		partition@0 {
 			label = "SPL";
-			reg = <0 0x100000>;
+			reg = <(0 * SZ_256K) (4 * SZ_256K)>;
 		};
 		partition@0x80000 {
 			label = "U-Boot";
-			reg = <0x100000 0x180000>;
+			reg = <(4 * SZ_256K) (6 * SZ_256K)>;
 		};
 		partition@0x1c0000 {
 			label = "Environment";
-			reg = <0x280000 0x100000>;
+			reg = <(10 * SZ_256K) (4 * SZ_256K)>;
 		};
 		partition@0x280000 {
 			label = "Kernel";
-			reg = <0x380000 0x300000>;
+			reg = <(14 * SZ_256K) (12 * SZ_256K)>;
 		};
 		partition@0x780000 {
 			label = "Filesystem";
-			reg = <0x680000 0x1f980000>;
+			reg = <(26 * SZ_256K) MTDPART_SIZ_FULL>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 644d053..e4f078c 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -72,23 +72,23 @@
 
 		partition@0 {
 			label = "SPL";
-			reg = <0 0x100000>;
+			reg = <(0 * SZ_256K) (4 * SZ_256K)>;
 		};
 		partition@0x80000 {
 			label = "U-Boot";
-			reg = <0x100000 0x180000>;
+			reg = <(4 * SZ_256K) (6 * SZ_256K)>;
 		};
 		partition@0x1c0000 {
 			label = "Environment";
-			reg = <0x280000 0x100000>;
+			reg = <(10 * SZ_256K) (4 * SZ_256K)>;
 		};
 		partition@0x280000 {
 			label = "Kernel";
-			reg = <0x380000 0x300000>;
+			reg = <(14 * SZ_256K) (12 * SZ_256K)>;
 		};
 		partition@0x780000 {
 			label = "Filesystem";
-			reg = <0x680000 0x1f980000>;
+			reg = <(26 * SZ_256K) MTDPART_SIZ_FULL>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 2a725a0..dd69ee0 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -81,19 +81,19 @@
 
 		partition@0 {
 			label = "bootloader-nor";
-			reg = <0 0x40000>;
+			reg = <(0 * SZ_128K) (2 * SZ_128K)>;
 		};
 		partition@0x40000 {
 			label = "params-nor";
-			reg = <0x40000 0x40000>;
+			reg = <(2 * SZ_128K) (2 * SZ_128K)>;
 		};
 		partition@0x80000 {
 			label = "kernel-nor";
-			reg = <0x80000 0x200000>;
+			reg = <(4 * SZ_128K) (16 * SZ_128K)>;
 		};
 		partition@0x280000 {
 			label = "filesystem-nor";
-			reg = <0x240000 0x7d80000>;
+			reg = <(18 * SZ_128K) (1004 * SZ_128K)>;
 		};
 	};
 
@@ -123,23 +123,23 @@
 
 		partition@0 {
 			label = "xloader-nand";
-			reg = <0 0x80000>;
+			reg = <(0 * SZ_128K) (4 * SZ_128K)>;
 		};
 		partition@0x80000 {
 			label = "bootloader-nand";
-			reg = <0x80000 0x140000>;
+			reg = <(4 * SZ_128K) (10 * SZ_128K)>;
 		};
 		partition@0x1c0000 {
 			label = "params-nand";
-			reg = <0x1c0000 0xc0000>;
+			reg = <(14 * SZ_128K) (6 * SZ_128K)>;
 		};
 		partition@0x280000 {
 			label = "kernel-nand";
-			reg = <0x280000 0x500000>;
+			reg = <(20 * SZ_128K) (40 * SZ_128K)>;
 		};
 		partition@0x780000 {
 			label = "filesystem-nand";
-			reg = <0x780000 0x7880000>;
+			reg = <(60 * SZ_128K) (964 * SZ_128K)>;
 		};
 	};
 
@@ -168,23 +168,23 @@
 
 		partition@0 {
 			label = "xloader-onenand";
-			reg = <0 0x80000>;
+			reg = <(0 * SZ_128K) (4 * SZ_128K)>;
 		};
 		partition@0x80000 {
 			label = "bootloader-onenand";
-			reg = <0x80000 0x40000>;
+			reg = <(4 * SZ_128K) (2 * SZ_128K)>;
 		};
 		partition@0xc0000 {
 			label = "params-onenand";
-			reg = <0xc0000 0x20000>;
+			reg = <(6 * SZ_128K) (1 * SZ_128K)>;
 		};
 		partition@0xe0000 {
 			label = "kernel-onenand";
-			reg = <0xe0000 0x200000>;
+			reg = <(7 * SZ_128K) (16 * SZ_128K)>;
 		};
 		partition@0x2e0000 {
 			label = "filesystem-onenand";
-			reg = <0x2e0000 0xfd20000>;
+			reg = <(23 * SZ_128K) (2025 * SZ_128K)>;
 		};
 	};
 };
-- 
1.7.5.4

