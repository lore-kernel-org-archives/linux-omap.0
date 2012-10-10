From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 3/3] ARM: dts: EMIF and LPDDR2 device tree data for OMAP5 boards
Date: Wed, 10 Oct 2012 17:35:16 +0530
Message-ID: <1349870716-25511-4-git-send-email-lokeshvutla@ti.com>
References: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51952 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab2JJMF4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Oct 2012 08:05:56 -0400
In-Reply-To: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, lokeshvutla@ti.com, santosh.shilimkar@ti.com

Device tree data for the EMIF sdram controllers in OMAP5
and LPDDR2 memory devices attached to OMAP5 boards.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/lpddr2_data.dtsi |   64 +++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/omap5-evm.dts    |   11 +++++++
 arch/arm/boot/dts/omap5.dtsi       |   18 ++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpddr2_data.dtsi b/arch/arm/boot/dts/lpddr2_data.dtsi
index f97f70f..8e8c1bc 100644
--- a/arch/arm/boot/dts/lpddr2_data.dtsi
+++ b/arch/arm/boot/dts/lpddr2_data.dtsi
@@ -3,7 +3,7 @@
  */
 
 / {
-	elpida_ECB240ABACN: lpddr2 {
+	elpida_ECB240ABACN: lpddr2@0 {
 		compatible	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
 		density		= <2048>;
 		io-width	= <32>;
@@ -64,4 +64,66 @@
 			tDQSCK-max-derated = <6000>;
 		};
 	};
+
+	samsung_K3PE0E000B: lpddr2@1 {
+		compatible	= "Samsung,K3PE0E000B","jedec,lpddr2-s4";
+		density		= <4096>;
+		io-width	= <32>;
+
+		tRPab-min-tck	= <3>;
+		tRCD-min-tck	= <3>;
+		tWR-min-tck	= <3>;
+		tRASmin-min-tck	= <3>;
+		tRRD-min-tck	= <2>;
+		tWTR-min-tck	= <2>;
+		tXP-min-tck	= <2>;
+		tRTP-min-tck	= <2>;
+		tCKE-min-tck	= <3>;
+		tCKESR-min-tck	= <3>;
+		tFAW-min-tck	= <8>;
+
+		timings_samsung_K3PE0E000B_533mhz: lpddr2-timings@0 {
+			compatible	= "jedec,lpddr2-timings";
+			min-freq	= <10000000>;
+			max-freq	= <533333333>;
+			tRPab		= <21000>;
+			tRCD		= <18000>;
+			tWR		= <15000>;
+			tRAS-min	= <42000>;
+			tRRD		= <10000>;
+			tWTR		= <7500>;
+			tXP		= <7500>;
+			tRTP		= <7500>;
+			tCKESR		= <15000>;
+			tDQSCK-max	= <5500>;
+			tFAW		= <50000>;
+			tZQCS		= <90000>;
+			tZQCL		= <360000>;
+			tZQinit		= <1000000>;
+			tRAS-max-ns	= <70000>;
+			tDQSCK-max-derated = <5620>;
+		};
+
+		timings_samsung_K3PE0E000B_266mhz: lpddr2-timings@1 {
+			compatible	= "jedec,lpddr2-timings";
+			min-freq	= <10000000>;
+			max-freq	= <266666666>;
+			tRPab		= <21000>;
+			tRCD		= <18000>;
+			tWR		= <15000>;
+			tRAS-min	= <42000>;
+			tRRD		= <10000>;
+			tWTR		= <7500>;
+			tXP		= <7500>;
+			tRTP		= <7500>;
+			tCKESR		= <15000>;
+			tDQSCK-max	= <5500>;
+			tFAW		= <50000>;
+			tZQCS		= <90000>;
+			tZQCL		= <360000>;
+			tZQinit		= <1000000>;
+			tRAS-max-ns	= <70000>;
+			tDQSCK-max-derated = <6000>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 6f87e1a..8a952f8 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap5.dtsi"
+/include/ "lpddr2_data.dtsi"
 
 / {
 	model = "TI OMAP5 EVM board";
@@ -82,3 +83,13 @@
 			0x020700d9>;	/* SEARCH */
 	linux,input-no-autorepeat;
 };
+
+&emif1 {
+	cs1-used;
+	device-handle = <&samsung_K3PE0E000B>;
+};
+
+&emif2 {
+	cs1-used;
+	device-handle = <&samsung_K3PE0E000B>;
+};
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 5db33f4..40b41c2 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -319,5 +319,23 @@
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3";
 		};
+
+		emif1: emif@0x4c000000 {
+			compatible	= "ti,emif-4d5";
+			ti,hwmods	= "emif1";
+			phy-type	= <2>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
+
+		emif2: emif@0x4d000000 {
+			compatible	= "ti,emif-4d5";
+			ti,hwmods	= "emif2";
+			phy-type	= <2>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
 	};
 };
-- 
1.7.10.4

