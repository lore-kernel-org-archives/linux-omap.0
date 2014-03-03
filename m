From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [RESEND Patch 5/9] ARM: dts: OMAP4: Add device nodes for ABB
Date: Mon, 3 Mar 2014 20:20:22 +0530
Message-ID: <1393858226-32595-7-git-send-email-mugunthanvnm@ti.com>
References: <1393858226-32595-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393858226-32595-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: linux@arm.linux.org.uk, akpm@linux-foundation.org, nm@ti.com, balajitk@ti.com, r.sricharan@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Add ABB device nodes for OMAP443x family of devices. abb_iva is
populated, but disabled as it is not used on current OMAP443x family,
but the node is used on OMAP446x family. Data is based on OMAP443x
Technical Reference Manual revision AN (April 2013).

ABB device nodes for OMAP4460 device Data is based on OMAP4460
Technical Reference Manual revision Z (April 2013)

[nm@ti.com: co-developer]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi    | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/omap443x.dtsi | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4460.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index afa23bc..c18f0fd 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -776,6 +776,32 @@
 			dmas = <&sdma 117>, <&sdma 116>;
 			dma-names = "tx", "rx";
 		};
+
+		abb_mpu: regulator-abb-mpu {
+			compatible = "ti,abb-v2";
+			regulator-name = "abb_mpu";
+			#address-cells = <0>;
+			#size-cells = <0>;
+			ti,tranxdone-status-mask = <0x80>;
+			clocks = <&sys_clkin_ck>;
+			ti,settling-time = <50>;
+			ti,clock-cycles = <16>;
+
+			status = "disabled";
+		};
+
+		abb_iva: regulator-abb-iva {
+			compatible = "ti,abb-v2";
+			regulator-name = "abb_iva";
+			#address-cells = <0>;
+			#size-cells = <0>;
+			ti,tranxdone-status-mask = <0x80000000>;
+			clocks = <&sys_clkin_ck>;
+			ti,settling-time = <50>;
+			ti,clock-cycles = <16>;
+
+			status = "disabled";
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index 8c1cfad..0adfa1d 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -43,6 +43,32 @@
 			#thermal-sensor-cells = <0>;
 		};
 	};
+
+	ocp {
+		abb_mpu: regulator-abb-mpu {
+			status = "okay";
+
+			reg = <0x4a307bd0 0x8>, <0x4a306014 0x4>;
+			reg-names = "base-address", "int-address";
+
+			ti,abb_info = <
+			/*uV		ABB	efuse	rbb_m	fbb_m	vset_m*/
+			1025000		0	0	0	0	0
+			1200000		0	0	0	0	0
+			1313000		0	0	0	0	0
+			1375000		1	0	0	0	0
+			1389000		1	0	0	0	0
+			>;
+		};
+
+		/* Default unused, just provide register info for record */
+		abb_iva: regulator-abb-iva {
+			reg = <0x4a307bd8 0x8>, <0x4a306010 0x4>;
+			reg-names = "base-address", "int-address";
+		};
+
+	};
+
 };
 
 /include/ "omap443x-clocks.dtsi"
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 6b32f52..194f9ef 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -50,7 +50,44 @@
 
 			#thermal-sensor-cells = <0>;
 		};
+
+		abb_mpu: regulator-abb-mpu {
+			status = "okay";
+
+			reg = <0x4a307bd0 0x8>, <0x4a306014 0x4>,
+			      <0x4A002268 0x4>;
+			reg-names = "base-address", "int-address",
+				    "efuse-address";
+
+			ti,abb_info = <
+			/*uV		ABB	efuse	rbb_m	fbb_m	vset_m*/
+			1025000		0	0	0	0	0
+			1200000		0	0	0	0	0
+			1313000		0	0	0x100000 0x40000 0
+			1375000		1	0	0	0	0
+			1389000		1	0	0	0	0
+			>;
+		};
+
+		abb_iva: regulator-abb-iva {
+			status = "okay";
+
+			reg = <0x4a307bd8 0x8>, <0x4a306010 0x4>,
+			      <0x4A002268 0x4>;
+			reg-names = "base-address", "int-address",
+				    "efuse-address";
+
+			ti,abb_info = <
+			/*uV		ABB	efuse	rbb_m	fbb_m	vset_m*/
+			950000		0	0	0	0	0
+			1140000		0	0	0	0	0
+			1291000		0	0	0x200000 0	0
+			1375000		1	0	0	0	0
+			1376000		1	0	0	0	0
+			>;
+		};
 	};
+
 };
 
 /include/ "omap446x-clocks.dtsi"
-- 
1.9.0
