From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V3 3/3] ARM: dts: omap5-evm: LPDDR2 memory device details for EVM
Date: Mon, 5 Nov 2012 18:22:52 +0530
Message-ID: <1352119972-13710-4-git-send-email-lokeshvutla@ti.com>
References: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39968 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281Ab2KEMxI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 07:53:08 -0500
In-Reply-To: <1352119972-13710-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, devicetree-discuss@lists.ozlabs.org, lokeshvutla@ti.com

Samsung's K3PE0E000B memory part is used in OMAP5-evm board.
Adding timings and geometry details for Samsung's memory part and
attaching the same to device-handle of EMIF1/2.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/omap5-evm.dts           |   11 +++++
 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi |   67 +++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi

diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
index 88d3d9b8..8722c15 100644
--- a/arch/arm/boot/dts/omap5-evm.dts
+++ b/arch/arm/boot/dts/omap5-evm.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap5.dtsi"
+/include/ "samsung_k3pe0e000b.dtsi"
 
 / {
 	model = "TI OMAP5 EVM board";
@@ -140,3 +141,13 @@
 &mcbsp3 {
 	status = "disabled";
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
diff --git a/arch/arm/boot/dts/samsung_k3pe0e000b.dtsi b/arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
new file mode 100644
index 0000000..9657a5c
--- /dev/null
+++ b/arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
@@ -0,0 +1,67 @@
+/*
+ * Timings and Geometry for Samsung K3PE0E000B memory part
+ */
+
+/ {
+	samsung_K3PE0E000B: lpddr2 {
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
+		timings_samsung_K3PE0E000B_533MHz: lpddr2-timings@0 {
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
+			tDQSCK-max-derated = <6000>;
+		};
+
+		timings_samsung_K3PE0E000B_266MHz: lpddr2-timings@1 {
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
+};
-- 
1.7.9.5

