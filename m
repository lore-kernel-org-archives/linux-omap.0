From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/4] MFD: DT bindings for the TPS65917 family MFD
Date: Tue, 20 May 2014 14:41:36 +0530
Message-ID: <1400577099-8743-2-git-send-email-j-keerthy@ti.com>
References: <1400577099-8743-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400577099-8743-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sameo@linux.intel.com, grant.likely@linaro.org, ian@slimlogic.co.uk, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@linaro.org, swarren@nvidia.com, lee.jones@linaro.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the various binding files for the TPS65917 family of chips. There is a
top level MFD binding then a seperate binding for regulators IP blocks on chips.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 Documentation/devicetree/bindings/mfd/tps65917.txt |   35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/tps65917.txt

diff --git a/Documentation/devicetree/bindings/mfd/tps65917.txt b/Documentation/devicetree/bindings/mfd/tps65917.txt
new file mode 100644
index 0000000..287a713
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/tps65917.txt
@@ -0,0 +1,35 @@
+* TPS65917 device tree bindings
+
+The TI TPS65917 family of PMICs.
+
+Required properties:
+- compatible : Should be from the list
+  ti,tps65917
+- interrupt-controller : TPS65917 has its own internal IRQs
+- #interrupt-cells : should be set to 2 for IRQ number and flags
+  The first cell is the IRQ number.
+  The second cell is the flags, encoded as the trigger masks from
+  Documentation/devicetree/bindings/interrupts.txt
+- interrupt-parent : The parent interrupt controller.
+
+Optional properties:
+  ti,mux-padX : set the pad register X (1-2) to the correct muxing for the
+		hardware, if not set will use muxing in OTP.
+
+Example:
+
+tps65917 {
+	compatible = "ti,tps65917";
+	reg = <0x58>
+	interrupt-parent = <&intc>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	pmic {
+		compatible = "ti,tps65917-pmic";
+		....
+	};
+}
-- 
1.7.9.5
