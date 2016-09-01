From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/2] Documentation: dt: add bindings for ti-cpufreq
Date: Wed, 31 Aug 2016 21:53:27 -0500
Message-ID: <20160901025328.376-2-d-gerlach@ti.com>
References: <20160901025328.376-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160901025328.376-1-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the device tree bindings document for the TI CPUFreq/OPP driver
on AM33xx, AM43xx, DRA7, and AM57 SoCs. The operating-points-v2 binding
allows us to provide an opp-supported-hw property for each OPP to define
when it is available. This driver is responsible for reading and parsing
registers to determine which OPPs can be selectively enabled based
on the specific SoC in use by matching against the opp-supported-hw
data.

Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
v1->v2:
	- Dropped all driver/linux specific documentation
	- Fixed some typos
	- Add new compatibles for each SoC family to match against
	- Switched to use am335x example to better demonstrate field one of
	  opp-supported-hw.

 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 130 +++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
new file mode 100644
index 000000000000..6276ae494121
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
@@ -0,0 +1,130 @@
+TI CPUFreq and OPP bindings
+================================
+
+Certain TI SoCs, like those in the am335x, am437x, am57xx, and dra7xx
+families support different OPPs depending on the silicon variant in use.
+The ti_cpufreq driver can use revision and an efuse value from the SoC to
+provide the OPP framework with supported hardware information. This is
+used to determine which OPPs from the operating-points-v2 table get enabled
+when it is parsed by the OPP framework.
+
+Required properties:
+--------------------
+In 'cpus' nodes:
+- operating-points-v2: Phandle to the operating-points-v2 table to use.
+- ti,syscon-efuse: Syscon phandle, offset to efuse register, efuse register
+		   mask, and efuse register shift to get the relevant bits
+		   that describe OPP availability.
+- ti,syscon-rev: Syscon and offset used to look up revision value on SoC.
+
+In 'operating-points-v2' table:
+- compatible: Should be
+	- 'operating-points-v2-ti-am3352-cpu' for am335x SoCs
+	- 'operating-points-v2-ti-am4372-cpu' for am43xx SoCs
+	- 'operating-points-v2-ti-dra7-cpu' for dra7xx/am57xx SoCs
+
+- opp-supported-hw: Two bitfields indicating:
+	1. Which revision of the SoC the OPP is supported by
+	2. Which eFuse bits indicate this OPP is available
+
+	A bitwise AND is performed against these values and if any bit
+	matches, the OPP gets enabled.
+
+Example:
+--------
+
+/* From arch/arm/boot/dts/am33xx.dtsi */
+cpus {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cpu@0 {
+		compatible = "arm,cortex-a8";
+		device_type = "cpu";
+		reg = <0>;
+
+		operating-points-v2 = <&cpu0_opp_table>;
+		ti,syscon-efuse = <&scm_conf 0x7fc 0x1fff 0>;
+		ti,syscon-rev = <&scm_conf 0x600>;
+
+		clocks = <&dpll_mpu_ck>;
+		clock-names = "cpu";
+
+		clock-latency = <300000>; /* From omap-cpufreq driver */
+	};
+};
+
+/*
+ * cpu0 has different OPPs depending on SoC revision and some on revisions
+ * 0x2 and 0x4 have eFuse bits that indicate if they are available or not
+ */
+cpu0_opp_table: opp_table0 {
+	compatible = "operating-points-v2-ti-am3352-cpu";
+
+	/*
+	 * The three following nodes are marked with opp-suspend
+	 * because they can not be enabled simultaneously on a
+	 * single SoC.
+	 */
+	opp50@300000000 {
+		opp-hz = /bits/ 64 <300000000>;
+		opp-microvolt = <950000 931000 969000>;
+		opp-supported-hw = <0x06 0x0010>;
+		opp-suspend;
+	};
+
+	opp100@275000000 {
+		opp-hz = /bits/ 64 <275000000>;
+		opp-microvolt = <1100000 1078000 1122000>;
+		opp-supported-hw = <0x01 0x00FF>;
+		opp-suspend;
+	};
+
+	opp100@300000000 {
+		opp-hz = /bits/ 64 <300000000>;
+		opp-microvolt = <1100000 1078000 1122000>;
+		opp-supported-hw = <0x06 0x0020>;
+		opp-suspend;
+	};
+
+	opp100@500000000 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <1100000 1078000 1122000>;
+		opp-supported-hw = <0x01 0xFFFF>;
+	};
+
+	opp100@600000000 {
+		opp-hz = /bits/ 64 <600000000>;
+		opp-microvolt = <1100000 1078000 1122000>;
+		opp-supported-hw = <0x06 0x0040>;
+	};
+
+	opp120@600000000 {
+		opp-hz = /bits/ 64 <600000000>;
+		opp-microvolt = <1200000 1176000 1224000>;
+		opp-supported-hw = <0x01 0xFFFF>;
+	};
+
+	opp120@720000000 {
+		opp-hz = /bits/ 64 <720000000>;
+		opp-microvolt = <1200000 1176000 1224000>;
+		opp-supported-hw = <0x06 0x0080>;
+	};
+
+	oppturbo@720000000 {
+		opp-hz = /bits/ 64 <720000000>;
+		opp-microvolt = <1260000 1234800 1285200>;
+		opp-supported-hw = <0x01 0xFFFF>;
+	};
+
+	oppturbo@800000000 {
+		opp-hz = /bits/ 64 <800000000>;
+		opp-microvolt = <1260000 1234800 1285200>;
+		opp-supported-hw = <0x06 0x0100>;
+	};
+
+	oppnitro@1000000000 {
+		opp-hz = /bits/ 64 <1000000000>;
+		opp-microvolt = <1325000 1298500 1351500>;
+		opp-supported-hw = <0x04 0x0200>;
+	};
+};
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
