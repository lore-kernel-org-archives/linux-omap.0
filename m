From: Aneesh V <aneesh@ti.com>
Subject: [RFC v3 PATCH 1/3] dt: device tree bindings for DDR memories
Date: Thu, 19 Jan 2012 20:01:59 +0530
Message-ID: <1326983521-373-2-git-send-email-aneesh@ti.com>
References: <1326983521-373-1-git-send-email-aneesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:57183 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752721Ab2ASOcV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 09:32:21 -0500
Received: by mail-yw0-f41.google.com with SMTP id p34so1428303yhp.28
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 06:32:19 -0800 (PST)
In-Reply-To: <1326983521-373-1-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aneesh V <aneesh@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Olof Johansson <olof@lixom.net>

device tree bindings for LPDDR2 SDRAM memories compliant
to JESD209-2 standard.

The 'lpddr2' binding in-turn uses another binding 'lpddr2-timings'
for specifying the AC timing parameters of the memory device at
different speed-bins.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Aneesh V <aneesh@ti.com>

Changes in RFC v2:
* Removed the "manufacturer" property and added it in
  compatible property instead
* Changed the DDR device names in example to indicate
  the part number

Changes in RFC v3:
* Removed DDR3 support
* Fixed review comments on RFC v2
---
 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   51 ++++++++++
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 ++++++++++++++++++++
 2 files changed, 153 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt

diff --git a/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt b/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
new file mode 100644
index 0000000..1483841
--- /dev/null
+++ b/Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
@@ -0,0 +1,51 @@
+* AC timing parameters of LPDDR2(JESD209-2) memories for a given speed-bin
+
+Required properties:
+- compatible : Should be "jedec,lpddr2-timings"
+- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
+- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
+
+Optional properties:
+
+The following properties represent AC timing parameters from the memory
+data-sheet of the device for a given speed-bin. All these properties are
+of type <u32> and the default unit is ps (pico seconds). Parameters with
+a different unit have a suffix indicating the unit such as 'tRAS-max-ns'
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
diff --git a/Documentation/devicetree/bindings/lpddr2/lpddr2.txt b/Documentation/devicetree/bindings/lpddr2/lpddr2.txt
new file mode 100644
index 0000000..9c175f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/lpddr2/lpddr2.txt
@@ -0,0 +1,102 @@
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

