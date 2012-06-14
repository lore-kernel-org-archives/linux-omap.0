From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v3 3/4] arm: dts: EMIF and LPDDR2 device tree data for OMAP4 boards
Date: Thu, 14 Jun 2012 15:59:23 +0530
Message-ID: <1339669764-27244-4-git-send-email-santosh.shilimkar@ti.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42152 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab2FNK3m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 06:29:42 -0400
In-Reply-To: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Aneesh V <aneesh@ti.com>

Device tree data for the EMIF sdram controllers in OMAP4
and LPDDR2 memory devices attached to OMAP4 boards.

Reviewed-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
[santosh.shilimkar@ti.com: Rebased against 3.5-rc]
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi |   67 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts         |   13 ++++++
 arch/arm/boot/dts/omap4-sdp.dts           |   13 ++++++
 arch/arm/boot/dts/omap4.dtsi              |   18 ++++++++
 4 files changed, 111 insertions(+)
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi

diff --git a/arch/arm/boot/dts/elpida_ecb240abacn.dtsi b/arch/arm/boot/dts/elpida_ecb240abacn.dtsi
new file mode 100644
index 0000000..f97f70f
--- /dev/null
+++ b/arch/arm/boot/dts/elpida_ecb240abacn.dtsi
@@ -0,0 +1,67 @@
+/*
+ * Common devices used in different OMAP boards
+ */
+
+/ {
+	elpida_ECB240ABACN: lpddr2 {
+		compatible	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
+		density		= <2048>;
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
+		timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
+			compatible	= "jedec,lpddr2-timings";
+			min-freq	= <10000000>;
+			max-freq	= <400000000>;
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
+
+		timings_elpida_ECB240ABACN_200mhz: lpddr2-timings@1 {
+			compatible	= "jedec,lpddr2-timings";
+			min-freq	= <10000000>;
+			max-freq	= <200000000>;
+			tRPab		= <21000>;
+			tRCD		= <18000>;
+			tWR		= <15000>;
+			tRAS-min	= <42000>;
+			tRRD		= <10000>;
+			tWTR		= <10000>;
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
+};
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 1efe0c5..08a0b21 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap4.dtsi"
+/include/ "elpida_ecb240abacn.dtsi"
 
 / {
 	model = "TI OMAP4 PandaBoard";
@@ -32,6 +33,18 @@
 			linux,default-trigger = "mmc0";
 		};
 	};
+
+	ocp {
+		emif1: emif@0x4c000000 {
+			cs1-used;
+			device-handle = <&elpida_ECB240ABACN>;
+		};
+
+		emif2: emif@0x4d000000 {
+			cs1-used;
+			device-handle = <&elpida_ECB240ABACN>;
+		};
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index d08c4d1..562f03e 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap4.dtsi"
+/include/ "elpida_ecb240abacn.dtsi"
 
 / {
 	model = "TI OMAP4 SDP board";
@@ -70,6 +71,18 @@
 			gpios = <&gpio5 11 0>; /* 139 */
 		};
 	};
+
+	ocp {
+		emif1: emif@0x4c000000 {
+			cs1-used;
+			device-handle = <&elpida_ECB240ABACN>;
+		};
+
+		emif2: emif@0x4d000000 {
+			cs1-used;
+			device-handle = <&elpida_ECB240ABACN>;
+		};
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..08813c4 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,23 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		emif1: emif@0x4c000000 {
+			compatible	= "ti,emif-4d";
+			ti,hwmods	= "emif1";
+			phy-type	= <1>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
+
+		emif2: emif@0x4d000000 {
+			compatible	= "ti,emif-4d";
+			ti,hwmods	= "emif2";
+			phy-type	= <1>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
 	};
 };
-- 
1.7.9.5

