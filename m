From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v5 2/4] Documentation: dt: add bindings for ti-cpufreq
Date: Fri, 3 Feb 2017 11:29:27 -0600
Message-ID: <20170203172929.23940-3-d-gerlach@ti.com>
References: <20170203172929.23940-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170203172929.23940-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, linux-pm@vger.kernel.org, Lukasz Majewski <lukma@denx.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add the device tree bindings document for the TI CPUFreq/OPP driver
on AM33xx, AM43xx, DRA7xx, and AM57xx SoCs. The operating-points-v2
binding allows us to provide an opp-supported-hw property for each OPP
to define when it is available. This driver is responsible for reading
and parsing registers to determine which OPPs can be selectively enabled
based on the specific SoC in use by matching against the opp-supported-hw
data.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
new file mode 100644
index 000000000000..d35b87a2e33f
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
@@ -0,0 +1,128 @@
+TI CPUFreq and OPP bindings
+================================
+
+Certain TI SoCs, like those in the am335x, am437x, am57xx, and dra7xx
+families support different OPPs depending on the silicon variant in use.
+The ti-cpufreq driver can use revision and an efuse value from the SoC to
+provide the OPP framework with supported hardware information. This is
+used to determine which OPPs from the operating-points-v2 table get enabled
+when it is parsed by the OPP framework.
+
+Required properties:
+--------------------
+In 'cpus' nodes:
+- operating-points-v2: Phandle to the operating-points-v2 table to use.
+
+In 'operating-points-v2' table:
+- compatible: Should be
+	- 'operating-points-v2-ti-cpu' for am335x, am43xx, and dra7xx/am57xx SoCs
+- syscon: A phandle pointing to a syscon node representing the control module
+	  register space of the SoC.
+
+Optional properties:
+--------------------
+For each opp entry in 'operating-points-v2' table:
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
+cpu0_opp_table: opp_table {
+	compatible = "operating-points-v2-ti-cpu";
+	syscon = <&scm_conf>;
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
2.11.0
