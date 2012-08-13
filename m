From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/5] ARM: dts: EMIF and LPDDR2 device tree data for OMAP4 boards
Date: Mon, 13 Aug 2012 16:30:21 +0530
Message-ID: <1344855623-14879-4-git-send-email-santosh.shilimkar@ti.com>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55896 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab2HMLAd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 07:00:33 -0400
In-Reply-To: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.or, tony@atomide.com, Aneesh V <aneesh@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Aneesh V <aneesh@ti.com>

Device tree data for the EMIF sdram controllers in OMAP4
and LPDDR2 memory devices attached to OMAP4 boards.

Reviewed-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
[santosh.shilimkar@ti.com: Rebased against 3.6-rc]
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
index 9880c12..80cd6cb 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap4.dtsi"
+/include/ "elpida_ecb240abacn.dtsi"
 
 / {
 	model = "TI OMAP4 PandaBoard";
@@ -56,6 +57,18 @@
 			"AFML", "Line In",
 			"AFMR", "Line In";
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
index 72216e9..b6f8ec2 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap4.dtsi"
+/include/ "elpida_ecb240abacn.dtsi"
 
 / {
 	model = "TI OMAP4 SDP board";
@@ -113,6 +114,18 @@
 			"DMic", "Digital Mic",
 			"Digital Mic", "Digital Mic1 Bias";
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
index 04cbbcb..6717c71 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -295,5 +295,23 @@
 			interrupt-parent = <&gic>;
 			ti,hwmods = "dmic";
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

