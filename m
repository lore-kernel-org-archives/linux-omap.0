From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/10] ARM: dts: Fix wrong GPMC size mappings for omaps
Date: Wed, 29 Oct 2014 17:29:00 -0700
Message-ID: <1414628948-30702-3-git-send-email-tony@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52183 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756446AbaJ3Aac (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 20:30:32 -0400
In-Reply-To: <1414628948-30702-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>

The GPMC binding is obviously very confusing as the values
are all over the place. People seem to confuse the GPMC partition
size for the chip select, and the device IO size within the GPMC
partition easily.

The ranges entry contains the GPMC partition size. And the
reg entry contains the size of the IO registers of the
device connected to the GPMC.

Let's fix the issue according to the following table:

Device          GPMC partition size     Device IO size
connected       in the ranges entry     in the reg entry

NAND            0x01000000 (16MB)       4
16550           0x01000000 (16MB)       8
smc91x          0x01000000 (16MB)       0xf
smc911x         0x01000000 (16MB)       0xff
OneNAND         0x01000000 (16MB)       0x20000 (128KB)
16MB NOR        0x01000000 (16MB)       0x01000000 (16MB)
32MB NOR        0x02000000 (32MB)       0x02000000 (32MB)
64MB NOR        0x04000000 (64MB)       0x04000000 (64MB)
128MB NOR       0x08000000 (128MB)      0x08000000 (128MB)
256MB NOR       0x10000000 (256MB)      0x10000000 (256MB)

Let's also add comments to the fixed entries while at it.

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-evm.dts            | 4 ++--
 arch/arm/boot/dts/am335x-igep0033.dtsi      | 4 ++--
 arch/arm/boot/dts/am43x-epos-evm.dts        | 4 ++--
 arch/arm/boot/dts/omap-zoom-common.dtsi     | 4 ++--
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 4 ++--
 arch/arm/boot/dts/omap3-devkit8000.dts      | 4 ++--
 arch/arm/boot/dts/omap3-evm-37xx.dts        | 4 ++--
 arch/arm/boot/dts/omap3-gta04.dtsi          | 4 ++--
 arch/arm/boot/dts/omap3-igep0020.dts        | 4 ++--
 arch/arm/boot/dts/omap3-igep0030.dts        | 4 ++--
 arch/arm/boot/dts/omap3-ldp.dts             | 2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi     | 2 +-
 arch/arm/boot/dts/omap3-n900.dts            | 6 ++----
 arch/arm/boot/dts/omap3-n950-n9.dtsi        | 4 ++--
 arch/arm/boot/dts/omap3-tao3530.dtsi        | 2 +-
 arch/arm/boot/dts/omap3430-sdp.dts          | 8 ++++----
 16 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e2156a5..43a536c 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -437,9 +437,9 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nandflash_pins_s0>;
-	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index a1a0cc5..c0e1135 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -126,10 +126,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&nandflash_pins>;
 
-	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,device-width = <1>;
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index ac3e485..bb4cb85 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -438,9 +438,9 @@
 	status = "okay";	/* Disable QSPI when enabling GPMC (NAND) */
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x8>;
-	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
+	ranges = <0 0 0x08000000 0x1000000>;	/* CS0: 16MB for NAND */
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		ti,nand-ecc-opt = "bch16";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/omap-zoom-common.dtsi b/arch/arm/boot/dts/omap-zoom-common.dtsi
index 68221fa..2889b50 100644
--- a/arch/arm/boot/dts/omap-zoom-common.dtsi
+++ b/arch/arm/boot/dts/omap-zoom-common.dtsi
@@ -5,7 +5,7 @@
 #include "omap-gpmc-smsc911x.dtsi"
 
 &gpmc {
-	ranges = <3 0 0x10000000 0x00000400>,
+	ranges = <3 0 0x10000000 0x1000000>,	/* CS3: 16MB for UART */
 		 <7 0 0x2c000000 0x01000000>;
 
 	/*
@@ -15,7 +15,7 @@
 	 */
 	uart@3,0 {
 		compatible = "ns16550a";
-		reg = <3 0 0x100>;
+		reg = <3 0 8>;	/* CS3, offset 0, IO size 8 */
 		bank-width = <2>;
 		reg-shift = <1>;
 		reg-io-width = <1>;
diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index 24c50db..c9f1e93 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -40,14 +40,14 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x04000000 0x10000000>;
+	ranges = <0 0 0x04000000 0x1000000>;	/* CS0: 16MB for OneNAND */
 
 	/* gpio-irq for dma: 26 */
 
 	onenand@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0 0 0x10000000>;
+		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
 
 		gpmc,sync-read;
 		gpmc,burst-length = <16>;
diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index da402f0..169037e 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -106,10 +106,10 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x30000000 0x04>;       /* CS0: NAND */
+	ranges = <0 0 0x30000000 0x1000000>;       /* CS0: 16MB for NAND */
 
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 
 		gpmc,sync-clk-ps = <0>;
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index a8bd434..f73385b 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -154,12 +154,12 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>,
+	ranges = <0 0 0x00000000 0x1000000>,	/* CS0: 16MB for NAND */
 		 <5 0 0x2c000000 0x01000000>;
 
 	nand@0,0 {
 		linux,mtd-name= "hynix,h8kds0un0mer-4em";
-		reg = <0 0 0>;
+		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index fd34f91..91bba85 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -397,10 +397,10 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x30000000 0x04>; /* CS0: NAND */
+	ranges = <0 0 0x30000000 0x1000000>; /* CS0: 16MB for NAND */
 
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index b22caaa..ff0b11d 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -197,12 +197,12 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>,
+	ranges = <0 0 0x00000000 0x1000000>,	/* CS0: 16MB for NAND */
 		 <5 0 0x2c000000 0x01000000>;
 
 	nand@0,0 {
 		linux,mtd-name= "micron,mt29c4g96maz";
-		reg = <0 0 0>;
+		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 2793749..fd7ed71 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -55,11 +55,11 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>;
+	ranges = <0 0 0x00000000 0x1000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
 		linux,mtd-name= "micron,mt29c4g96maz";
-		reg = <0 0 0>;
+		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 72dca0b..37d305a 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -101,7 +101,7 @@
 
 	nand@0,0 {
 		linux,mtd-name= "micron,nand";
-		reg = <0 0 0>;
+		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index d973088..e81fb65 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -363,7 +363,7 @@
 		<7 0 0x15000000 0x01000000>;
 
 	nand@0,0 {
-		reg = <0 0 0x1000000>;
+		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		ti,nand-ecc-opt = "bch8";
 		/* no elm on omap3 */
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index e7210d1..7cfc777 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -612,18 +612,16 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x04000000 0x10000000>; /* 256MB */
 	ranges = <0 0 0x01000000 0x01000000>,	/* 16 MB for OneNAND */
 		 <1 0 0x02000000 0x01000000>;	/* 16 MB for smc91c96 */
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpmc_pins>;
 
-	/* gpio-irq for dma: 65 */
-
+	/* sys_ndmareq1 could be used by the driver, not as gpio65 though */
 	onenand@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0 0 0x10000000>;
+		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
 
 		gpmc,sync-read;
 		gpmc,sync-write;
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 70addcb..1e49dfe 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -115,12 +115,12 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x04000000 0x20000000>;
+	ranges = <0 0 0x04000000 0x1000000>;	/* CS0: 16MB for OneNAND */
 
 	onenand@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <0 0 0x20000000>;
+		reg = <0 0 0x20000>;	/* CS0, offset 0, IO size 128K */
 
 		gpmc,sync-read;
 		gpmc,sync-write;
diff --git a/arch/arm/boot/dts/omap3-tao3530.dtsi b/arch/arm/boot/dts/omap3-tao3530.dtsi
index b30f387..e89820a 100644
--- a/arch/arm/boot/dts/omap3-tao3530.dtsi
+++ b/arch/arm/boot/dts/omap3-tao3530.dtsi
@@ -270,7 +270,7 @@
 	ranges = <0 0 0x00000000 0x01000000>;
 
 	nand@0,0 {
-		reg = <0 0 0>; /* CS0, offset 0 */
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;	/* GPMC_DEVWIDTH_16BIT */
 		ti,nand-ecc-opt = "sw";
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 9bad94e..16b0cdf 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -51,8 +51,8 @@
 
 &gpmc {
 	ranges = <0 0 0x10000000 0x08000000>,
-		 <1 0 0x28000000 0x08000000>,
-		 <2 0 0x20000000 0x10000000>;
+		 <1 0 0x28000000 0x1000000>,	/* CS1: 16MB for NAND */
+		 <2 0 0x20000000 0x1000000>;	/* CS2: 16MB for OneNAND */
 
 	nor@0,0 {
 		compatible = "cfi-flash";
@@ -106,7 +106,7 @@
 		linux,mtd-name= "micron,mt29f1g08abb";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <1 0 0x08000000>;
+		reg = <1 0 4>;	/* CS1, offset 0, IO size 4 */
 		ti,nand-ecc-opt = "sw";
 		nand-bus-width = <8>;
 		gpmc,cs-on-ns = <0>;
@@ -150,7 +150,7 @@
 		linux,mtd-name= "samsung,kfm2g16q2m-deb8";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		reg = <2 0 0x10000000>;
+		reg = <2 0 0x20000>;	/* CS2, offset 0, IO size 4 */
 
 		gpmc,device-width = <2>;
 		gpmc,mux-add-data = <2>;
-- 
2.1.1

