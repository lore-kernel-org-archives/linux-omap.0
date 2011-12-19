From: Aneesh V <aneesh@ti.com>
Subject: [RFC v2 PATCH 1/3] dt: device tree bindings for DDR memories
Date: Mon, 19 Dec 2011 19:35:31 +0530
Message-ID: <1324303533-17458-2-git-send-email-aneesh@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59118 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750880Ab1LSOFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Dec 2011 09:05:49 -0500
Received: by mail-gy0-f181.google.com with SMTP id r19so209428ghr.26
        for <linux-omap@vger.kernel.org>; Mon, 19 Dec 2011 06:05:48 -0800 (PST)
In-Reply-To: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aneesh V <aneesh@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

device tree bindings for DDR SDRAM memories compliant
to JEDEC standards. Currently only DDR3 and LPDDR2 have
been considered for this binding. Properties for other
memory types(DDR2 etc) could be added to this binding
on a need-basis.

The 'ddr' binding in-turn uses another binding 'ddr-timings'
for specifying the AC timing parameters of the memory device
at different speed-bins.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
---
 Documentation/devicetree/bindings/ddr/ddr.txt      |  114 ++++++++++++++++++++
 .../devicetree/bindings/ddr/ddr_timings.txt        |   62 +++++++++++
 2 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ddr/ddr.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/ddr_timings.txt

diff --git a/Documentation/devicetree/bindings/ddr/ddr.txt b/Documentation/devicetree/bindings/ddr/ddr.txt
new file mode 100644
index 0000000..f15c4dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/ddr/ddr.txt
@@ -0,0 +1,114 @@
+* DDR SDRAM memories compliant to JEDEC specifications JESD209-2(LPDDR2)
+  or JESD79-3(DDR3).
+
+Required properties:
+- compatible : Should be one of - "jedec,ddr3", "jedec,lpddr2-nvm",
+  "jedec,lpddr2-s2", "jedec,lpddr2-s4"
+
+  "ti,jedec-ddr3" should be listed if the memory part is DDR3 type
+
+  "ti,jedec-lpddr2-s2" should be listed if the memory part is LPDDR2-S2 type
+
+  "ti,jedec-lpddr2-s4" should be listed if the memory part is LPDDR2-S4 type
+
+  "ti,jedec-lpddr2-nvm" should be listed if the memory part is LPDDR2-NVM type
+
+- density  : string representing the density of the device in terms of
+  Mb (mega bits). Following are the allowed values: "64Mb", "128Mb",
+  "256Mb", "512Mb", "1Gb", "2Gb", "4Gb", "8Gb", "16Gb", or "32Gb"
+
+- io-width : string representing the io width: "x8", "x16" or "x32".
+
+Optional properties:
+
+The following optional properties represent the minimum value of some AC
+timing parameters of the DDR device in terms of number of clock cycles.
+These values shall be obtained from the device data-sheet.
+
+The suffix nCK indicates that the unit for these parameters is number
+of DDR clock cycles. Note: In LPDDR2 spec and data-sheets tCK is used
+inter-changeably for nCK. Both are equivalent in this context.
+
+- tRRD-min-nCK
+- tWTR-min-nCK
+- tXP-min-nCK
+- tRTP-min-nCK
+- tCKE-min-nCK
+- tRPab-min-nCK		/* LPDDR2 only */
+- tRCD-min-nCK		/* LPDDR2 only */
+- tWR-min-nCK		/* LPDDR2 only */
+- tRASmin-min-nCK	/* LPDDR2 only */
+- tCKESR-min-nCK	/* LPDDR2 only */
+- tFAW-min-nCK		/* LPDDR2 only */
+- tZQCS-min-nCK		/* DDR3 only */
+- tZQoper-min-nCK	/* DDR3 only */
+- tZQinit-min-nCK	/* DDR3 only */
+- tXS-min-nCK		/* DDR3 only */
+
+Child nodes:
+- The ddr node may have one or more child nodes of type "ddr-timings".
+  "ddr-timings" provides AC timing parameters of the device for
+  a given speed-bin. The user may provide the timings for as many
+  speed-bins as is required. Please see Documentation/devicetree/
+  bindings/ddr/ddr-timings.txt for more information on "ddr-timings"
+
+Example:
+
+elpida_ECB240ABACN : ddr {
+	compatible 	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
+	density		= "2Gb";
+	io-width	= "x32";
+
+	tRPab-min-nCK	= <3>;
+	tRCD-min-nCK	= <3>;
+	tWR-min-nCK	= <3>;
+	tRASmin-min-nCK	= <3>;
+	tRRD-min-nCK	= <2>;
+	tWTR-min-nCK	= <2>;
+	tXP-min-nCK	= <2>;
+	tRTP-min-nCK	= <2>;
+	tCKE-min-nCK	= <3>;
+	tCKESR-min-nCK	= <3>;
+	tFAW-min-nCK	= <8>;
+
+	timings_elpida_ECB240ABACN_400mhz: ddr-timings {
+		min-freq	= <10000000>;
+		max-freq	= <400000000>;
+		tRP-ps		= <21000>;
+		tRCD-ps		= <18000>;
+		tWR-ps		= <15000>;
+		tRAS-min-ps	= <42000:;
+		tRRD-ps		= <10000>;
+		tWTR-ps		= <7500>;
+		tXP-ps		= <7500>;
+		tRTP-ps		= <7500>;
+		tCKESR-ps	= <15000>;
+		tDQSCK-max-ps 	= <5500>;
+		tFAW-ps		= <50000>;
+		tZQCS-ps	= <90000>;
+		tZQoper-ps	= <360000>;
+		tZQinit-ps	= <1000000>;
+		tRAS-max-ns	= <70000>;
+	};
+
+	timings_elpida_ECB240ABACN_200mhz: ddr-timings {
+		min-freq	= <10000000>;
+		max-freq	= <200000000>;
+		tRP-ps		= <21000>;
+		tRCD-ps		= <18000>;
+		tWR-ps		= <15000>;
+		tRAS-min-ps	= <42000:;
+		tRRD-ps		= <10000>;
+		tWTR-ps		= <10000>;
+		tXP-ps		= <7500>;
+		tRTP-ps		= <7500>;
+		tCKESR-ps	= <15000>;
+		tDQSCK-max-ps 	= <5500>;
+		tFAW-ps		= <50000>;
+		tZQCS-ps	= <90000>;
+		tZQoper-ps	= <360000>;
+		tZQinit-ps	= <1000000>;
+		tRAS-max-ns	= <70000>;
+	};
+
+}
diff --git a/Documentation/devicetree/bindings/ddr/ddr_timings.txt b/Documentation/devicetree/bindings/ddr/ddr_timings.txt
new file mode 100644
index 0000000..38fcdec
--- /dev/null
+++ b/Documentation/devicetree/bindings/ddr/ddr_timings.txt
@@ -0,0 +1,62 @@
+* AC timing parameters of DDR memories for a given speed-bin
+  At the moment properties for only LPDDR2 and DDR3 have been added
+
+Required properties:
+- min-freq : minimum DDR clock frequency for the speed-bin
+- max-freq : maximum DDR clock frequency for the speed-bin
+
+Optional properties:
+
+The following properties represent AC timing parameters from the memory
+data-sheet of the device for a given speed-bin. All these properties are
+of type <u32> and "-ps", "-ns", "-nCK" etc in the name indicates the
+unit of the corresponding parameter:
+  ps - pico seconds
+  ns - nano seconds
+  nCK - number of DDR clock cycles. Please note that in LPDDR2 spec and
+  data-sheets tCK is used inter-changeably for nCK. Both are equivalent
+  in this context.
+
+- tRCD-ps
+- tWR-ps
+- tRAS-min-ps
+- tRRD-ps
+- tWTR-ps
+- tXP-ps
+- tRTP-ps
+- tDQSCK-max-ps
+- tFAW-ps
+- tZQCS-ps
+- tZQinit-ps
+- tRP-ps	/* DDR3 only */
+- tRC-ps	/* DDR3 only */
+- tXSDLL-nCK	/* DDR3 only */
+- tCKE-ps	/* DDR3 only */
+- tZQoper-ps	/* DDR3 only */
+- tRPab-ps	/* LPDDR2 only */
+- tZQCL-ps	/* LPDDR2 only */
+- tCKESR-ps	/* LPDDR2 only */
+- tRAS-max-ns	/* LPDDR2 only */
+
+Example:
+
+timings_elpida_ECB240ABACN_400mhz: ddr-timings {
+	min-freq	= <10000000>;
+	max-freq	= <400000000>;
+	tRPab-ps	= <21000>;
+	tRCD-ps		= <18000>;
+	tWR-ps		= <15000>;
+	tRAS-min-ps	= <42000:;
+	tRRD-ps		= <10000>;
+	tWTR-ps		= <7500>;
+	tXP-ps		= <7500>;
+	tRTP-ps		= <7500>;
+	tCKESR-ps	= <15000>;
+	tDQSCK-max-ps 	= <5500>;
+	tFAW-ps		= <50000>;
+	tZQCS-ps	= <90000>;
+	tZQCL-ps	= <360000>;
+	tZQinit-ps	= <1000000>;
+	tRAS-max-ns	= <70000>;
+};
+
-- 
1.7.1

