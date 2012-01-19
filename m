From: Aneesh V <aneesh@ti.com>
Subject: [PATCH 1/3] dt: device tree bindings for DDR memories
Date: Thu, 19 Jan 2012 19:58:39 +0530
Message-ID: <1326983321-319-2-git-send-email-aneesh@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:45128 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751800Ab2ASO3P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 09:29:15 -0500
Received: by mail-yw0-f52.google.com with SMTP id m50so3677917yhg.39
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 06:29:14 -0800 (PST)
In-Reply-To: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aneesh V <aneesh@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

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

Changes in RFC v2:
* Removed the "manufacturer" property and added it in
  compatible property instead
* Changed the DDR device names in example to indicate
  the part number
---
 .../devicetree/bindings/ddr/lpddr2-timings.txt     |   50 +++++++++
 Documentation/devicetree/bindings/ddr/lpddr2.txt   |  106 ++++++++++++++++++++
 2 files changed, 156 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2.txt

diff --git a/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt b/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
new file mode 100644
index 0000000..d4c1bff
--- /dev/null
+++ b/Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
@@ -0,0 +1,50 @@
+* AC timing parameters of LPDDR2(JESD209-2) memories for a given speed-bin
+
+Required properties:
+- compatible : Should be "jedec,lpddr2-timings"
+- min-freq : minimum DDR clock frequency for the speed-bin
+- max-freq : maximum DDR clock frequency for the speed-bin
+
+Optional properties:
+
+The following properties represent AC timing parameters from the memory
+data-sheet of the device for a given speed-bin. All these properties are
+of type <u32> and the default unit is ps (pico seconds).
+- tRCD
+- tWR
+- tRAS-min
+- tRRD
+- tWTR
+- tXP
+- tRTP
+- tDQSCK-max
+- tFAW
+- tZQCS
+- tZQinit
+- tRPab
+- tZQCL
+- tCKESR
+- tRAS-max-ns
+
+Example:
+
+timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
+	compatible 	= "jedec,lpddr2-timings";
+	min-freq	= <10000000>;
+	max-freq	= <400000000>;
+	tRPab		= <21000>;
+	tRCD		= <18000>;
+	tWR		= <15000>;
+	tRAS-min	= <42000>;
+	tRRD		= <10000>;
+	tWTR		= <7500>;
+	tXP		= <7500>;
+	tRTP		= <7500>;
+	tCKESR		= <15000>;
+	tDQSCK-max 	= <5500>;
+	tFAW		= <50000>;
+	tZQCS		= <90000>;
+	tZQCL		= <360000>;
+	tZQinit		= <1000000>;
+	tRAS-max-ns	= <70000>;
+};
diff --git a/Documentation/devicetree/bindings/ddr/lpddr2.txt b/Documentation/devicetree/bindings/ddr/lpddr2.txt
new file mode 100644
index 0000000..c03c62d
--- /dev/null
+++ b/Documentation/devicetree/bindings/ddr/lpddr2.txt
@@ -0,0 +1,106 @@
+* LPDDR2 SDRAM memories compliant to JEDEC JESD209-2
+
+Required properties:
+- compatible : Should be one of - "jedec,lpddr2-nvm", "jedec,lpddr2-s2",
+  "jedec,lpddr2-s4"
+
+  "ti,jedec-lpddr2-s2" should be listed if the memory part is LPDDR2-S2 type
+
+  "ti,jedec-lpddr2-s4" should be listed if the memory part is LPDDR2-S4 type
+
+  "ti,jedec-lpddr2-nvm" should be listed if the memory part is LPDDR2-NVM type
+
+- density  : <u32> representing density in Mb (Mega bits)
+
+- io-width : <u32> representing bus width. Possible values are 8, 16, and 32
+
+Optional properties:
+
+The following optional properties represent the minimum value of some AC
+timing parameters of the DDR device in terms of number of clock cycles.
+These values shall be obtained from the device data-sheet.
+
+The suffix 'tck' indicates that the unit for these parameters is number
+of DDR clock cycles.
+
+- tRRD-min-tck
+- tWTR-min-tck
+- tXP-min-tck
+- tRTP-min-tck
+- tCKE-min-tck
+- tRPab-min-tck
+- tRCD-min-tck
+- tWR-min-tck
+- tRASmin-min-tck
+- tCKESR-min-tck
+- tFAW-min-tck
+
+Child nodes:
+- The lpddr2 node may have one or more child nodes of type "lpddr2-timings".
+  "lpddr2-timings" provides AC timing parameters of the device for
+  a given speed-bin. The user may provide the timings for as many
+  speed-bins as is required. Please see Documentation/devicetree/
+  bindings/lpddr2/lpddr2-timings.txt for more information on "lpddr2-timings"
+
+Example:
+
+elpida_ECB240ABACN : lpddr2 {
+	compatible 	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
+	density		= <2048>;
+	io-width	= <32>;
+
+	tRPab-min-tck	= <3>;
+	tRCD-min-tck	= <3>;
+	tWR-min-tck	= <3>;
+	tRASmin-min-tck	= <3>;
+	tRRD-min-tck	= <2>;
+	tWTR-min-tck	= <2>;
+	tXP-min-tck	= <2>;
+	tRTP-min-tck	= <2>;
+	tCKE-min-tck	= <3>;
+	tCKESR-min-tck	= <3>;
+	tFAW-min-tck	= <8>;
+
+	timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
+		compatible 	= "jedec,lpddr2-timings";
+		min-freq	= <10000000>;
+		max-freq	= <400000000>;
+		tRP		= <21000>;
+		tRCD		= <18000>;
+		tWR		= <15000>;
+		tRAS-min	= <42000>;
+		tRRD		= <10000>;
+		tWTR		= <7500>;
+		tXP		= <7500>;
+		tRTP		= <7500>;
+		tCKESR		= <15000>;
+		tDQSCK-max 	= <5500>;
+		tFAW		= <50000>;
+		tZQCS		= <90000>;
+		tZQoper		= <360000>;
+		tZQinit		= <1000000>;
+		tRAS-max-ns	= <70000>;
+	};
+
+	timings_elpida_ECB240ABACN_200mhz: lpddr2-timings@1 {
+		compatible 	= "jedec,lpddr2-timings";
+		min-freq	= <10000000>;
+		max-freq	= <200000000>;
+		tRP		= <21000>;
+		tRCD		= <18000>;
+		tWR		= <15000>;
+		tRAS-min	= <42000>;
+		tRRD		= <10000>;
+		tWTR		= <10000>;
+		tXP		= <7500>;
+		tRTP		= <7500>;
+		tCKESR		= <15000>;
+		tDQSCK-max 	= <5500>;
+		tFAW		= <50000>;
+		tZQCS		= <90000>;
+		tZQoper		= <360000>;
+		tZQinit		= <1000000>;
+		tRAS-max-ns	= <70000>;
+	};
+
+}
-- 
1.7.1

