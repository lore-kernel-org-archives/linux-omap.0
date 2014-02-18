From: Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 4/6] devicetree: bindings: add documentation for
 voltagedomain
Date: Tue, 18 Feb 2014 14:32:21 -0600
Message-ID: <1392755543-28335-5-git-send-email-nm@ti.com>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392755543-28335-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add documentation for voltage domain binding format. Specific
voltage domains will have bindings corresponding to them.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../bindings/power/voltdm/voltage_domain.txt       |   65 ++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/voltdm/voltage_domain.txt

diff --git a/Documentation/devicetree/bindings/power/voltdm/voltage_domain.txt b/Documentation/devicetree/bindings/power/voltdm/voltage_domain.txt
new file mode 100644
index 0000000..da48a19
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/voltdm/voltage_domain.txt
@@ -0,0 +1,65 @@
+Specifying Voltage Domain information for devices
+=================================================
+
+1. Specifying a voltage domain.
+
+SoCs may have multiple voltage domains under which various clocks operate.
+
+Mandatory Properties:
+- #voltdm-cells - indicates if there are specifiers needed to reference the
+  voltage domain
+
+Optional Properties:
+- voltage-tolerance: Specify the voltage tolerance in percentage
+
+2. Voltage domain consumer
+consumer nodes can be reference using the below binding:
+- <name>-voltdm: phandle to the voltage domain node.
+
+Examples:
+
+A. Voltage Domain controlling multiple regulator
+voltage_domain_mpu: voltdm@1 {
+	compatible = "xyz";
+	#voltdm-cells = <0>;
+	vdd-supply = <&vcc>;
+	vbb-supply = <&abb_mpu>;
+	...
+};
+
+voltage_domain_gpu: voltdm@2 {
+	compatible = "xyz";
+	#voltdm-cells = <0>;
+	vdd-supply = <&dcdc2>;
+	vbb-supply = <&abb_gpu>;
+	...
+};
+...
+&cpu0 {
+	cpu0-voltdm = <&voltage_domain_mpu>;
+	voltage-tolerance = <1>;
+};
+
+&gpu {
+	gpu-voltdm = <&voltage_domain_gpu>;
+};
+
+B. Indexed voltage domain device
+
+#define SOC_XYZ_VOLTAGE_DOMAIN_MPU	0
+#define SOC_XYZ_VOLTAGE_DOMAIN_GFX	1
+
+voltage_domain_socx: voltdm@1 {
+	compatible = "abc";
+	#voltdm-cells = <1>;
+	...
+};
+...
+&cpu0 {
+	cpu0-voltdm = <&voltage_domain_socx SOC_XYZ_VOLTAGE_DOMAIN_MPU>;
+	voltage-tolerance = <1>;
+};
+
+&gpu {
+	gpu-voltdm = <&voltage_domain_socx SOC_XYZ_VOLTAGE_DOMAIN_GFX>;
+};
-- 
1.7.9.5
