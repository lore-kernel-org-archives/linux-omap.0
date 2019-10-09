From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch 1/3] dt-bindings: media: ti-vpe: Document VPE driver
Date: Wed, 9 Oct 2019 12:56:26 -0500
Message-ID: <20191009175628.20570-2-bparrot@ti.com>
References: <20191009175628.20570-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009175628.20570-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Device Tree bindings for the Video Processing Engine (VPE) driver.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 .../devicetree/bindings/media/ti-vpe.txt      | 48 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/ti-vpe.txt

diff --git a/Documentation/devicetree/bindings/media/ti-vpe.txt b/Documentation/devicetree/bindings/media/ti-vpe.txt
new file mode 100644
index 000000000000..b2942fa8c3ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/ti-vpe.txt
@@ -0,0 +1,48 @@
+Texas Instruments DRA7x VIDEO PROCESSING ENGINE (VPE)
+------------------------------------------------------
+
+The Video Processing Engine (VPE) is a key component for image post
+processing applications. VPE consist of a single memory to memory
+path which can perform chroma up/down sampling, deinterlacing,
+scaling and color space conversion.
+
+Required properties:
+- compatible: must be "ti,vpe"
+- reg:	physical base address and length of the registers set for the 4
+	memory regions required;
+- reg-names: name associated with the memory regions described is <reg>;
+- interrupts: should contain IRQ line for VPE;
+
+Example:
+
+	target-module@1d0010 {                  /* 0x489d0000, ap 27 30.0 */
+		compatible = "ti,sysc-omap4", "ti,sysc";
+		reg = <0x1d0010 0x4>;
+		reg-names = "sysc";
+		ti,sysc-midle = <SYSC_IDLE_FORCE>,
+				<SYSC_IDLE_NO>,
+				<SYSC_IDLE_SMART>;
+		ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+				<SYSC_IDLE_NO>,
+				<SYSC_IDLE_SMART>;
+		clocks = <&vpe_clkctrl DRA7_VPE_VPE_CLKCTRL 0>;
+		clock-names = "fck";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x1d0000 0x10000>;
+
+		vpe: vpe@0 {
+			compatible = "ti,vpe";
+			reg = <0x0000 0x120>,
+			      <0x0700 0x80>,
+			      <0x5700 0x18>,
+			      <0xd000 0x400>;
+			reg-names = "vpe_top",
+				    "sc",
+				    "csc",
+				    "vpdma";
+			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 8598f49fa2c8..63dcda51f8ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16299,6 +16299,7 @@ W:	http://linuxtv.org/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 S:	Maintained
 F:	drivers/media/platform/ti-vpe/
+F:	Documentation/devicetree/bindings/media/ti-vpe.txt
 
 TI WILINK WIRELESS DRIVERS
 L:	linux-wireless@vger.kernel.org
-- 
2.17.1
