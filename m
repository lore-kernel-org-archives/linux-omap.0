From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 1/7] dt-bindings: gpu: pvrsgx: add initial bindings
Date: Fri, 18 Oct 2019 20:46:24 +0200
Message-ID: <f0fb68dc7bc027e5e911721852f6bc6fa2d77a63.1571424390.git.hns@goldelico.com>
References: <cover.1571424390.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1571424390.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

The Imagination PVR/SGX GPU is part of several SoC from
multiple vendors, e.g. TI OMAP, Ingenic JZ4780, Intel Poulsbo
and others.

Here we describe how the SGX processor is interfaced to
the SoC (registers, interrupt etc.).

Clock, Reset and power management should be handled
by the parent node.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../devicetree/bindings/gpu/img,pvrsgx.txt    | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/img,pvrsgx.txt

diff --git a/Documentation/devicetree/bindings/gpu/img,pvrsgx.txt b/Documentation/devicetree/bindings/gpu/img,pvrsgx.txt
new file mode 100644
index 000000000000..4ad87c075791
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/img,pvrsgx.txt
@@ -0,0 +1,76 @@
+Imagination PVR/SGX GPU
+
+Only the Imagination SGX530, SGX540 and SGX544 GPUs are currently covered by this binding.
+
+Required properties:
+- compatible:	Should be one of
+		"img,sgx530-121", "img,sgx530", "ti,omap-omap3-sgx530-121";
+		  - BeagleBoard ABC, OpenPandora 600MHz
+		"img,sgx530-125", "img,sgx530", "ti,omap-omap3-sgx530-125";
+		  - BeagleBoard XM, GTA04, OpenPandora 1GHz
+		"img,sgx530-125", "img,sgx530", "ti,omap-am3517-sgx530-125";
+		"img,sgx530-125", "img,sgx530", "ti,omap-am335x-sgx530-125";
+		  - BeagleBone Black
+		"img,sgx540-120", "img,sgx540", "ti,omap-omap4-sgx540-120";
+		  - Pandaboard (ES)
+		"img,sgx544-112", "img,sgx544", "ti,omap-omap4-sgx544-112";
+		"img,sgx544-116", "img,sgx544", "ti,omap-omap5-sgx544-116";
+		  - OMAP5 UEVM, Pyra Handheld
+		"img,sgx544-116", "img,sgx544", "ti,omap-dra7-sgx544-116";
+
+		For further study:
+			"ti,omap-am3517-sgx530-?"
+			"ti,omap-am43xx-sgx530-?"
+			"ti,ti43xx-sgx"
+			"ti,ti81xx-sgx"
+			"img,jz4780-sgx5??-?"
+			"intel,poulsbo-sgx?"
+			"intel,cedarview-sgx?"
+			"sunxi,sgx-544-?" - Banana-Pi-M3 (Allwinner A83T)
+
+		The "ti,omap..." entries are needed temporarily to handle SoC
+		specific builds of the kernel module.
+
+		In the long run, only the "img,sgx..." entry should suffice
+		to match a generic driver for all architectures and driver
+		code can dynamically find out on which SoC it is running.
+
+
+- reg:		Physical base addresses and lengths of the register areas.
+- reg-names:	Names for the register areas.
+- interrupts:	The interrupt numbers.
+
+Optional properties:
+- timer:	the timer to be used by the driver.
+- img,cores:	number of cores. Defaults to <1>.
+
+/ {
+	ocp {
+		sgx_module: target-module@56000000 {
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			reg = <0x5600fe00 0x4>,
+			      <0x5600fe10 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			clocks = <&gpu_clkctrl OMAP5_GPU_CLKCTRL 0>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x56000000 0x2000000>;
+
+			sgx@fe00 {
+				compatible = "img,sgx544-116", "img,sgx544", "ti,omap-omap5-sgx544-116";
+				reg = <0xfe00 0x200>;
+				reg-names = "sgx";
+				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+				timer = <&timer11>;
+				img,cores = <2>;
+			};
+		};
+	};
+};
-- 
2.19.1
