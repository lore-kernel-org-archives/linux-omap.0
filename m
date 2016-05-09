From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 1/6] Documentation: sram: ti: Add TI SRAM bindings
Date: Mon, 9 May 2016 16:49:21 -0500
Message-ID: <1462830566-28708-2-git-send-email-d-gerlach@ti.com>
References: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Add binding document for TI use of mmio-sram driver for purposes like
mapping the region as executable or reserving space needed by secure
silicon.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 Documentation/devicetree/bindings/sram/ti-sram.txt | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sram/ti-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/ti-sram.txt b/Documentation/devicetree/bindings/sram/ti-sram.txt
new file mode 100644
index 000000000000..68c4b733c78c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sram/ti-sram.txt
@@ -0,0 +1,47 @@
+TI SRAM Node:
+-------------
+
+Many TI SoC's rely on SRAM for running low-level PM code as part of the
+suspend or cpuidle path. Because of this, regions in sram must be mapped
+as "memory-exec" or "memory-exec-nocache" in order for the region to be
+executable.
+
+Optional sub-node
+-----------------
+Some TI SoCs have secure variants that require a certain portion of
+the SRAM to be reserved for use by secure software. This can be
+marked in the parent SRAM node with a subnode as described in
+Documentation/devicetree/bindings/sram/sram.txt. This node can be
+added in two ways:
+
+- From board dts files for secure platforms to avoid adding it
+  for all SoC variants with a fixed size defined.
+- As a dummy node in the .dtsi sram node with any size that will be
+  modified by a bootloader to the correct size needed.
+
+Sub-node properties:
+- compatible : should be "ti,secure-sram"
+
+The rest of the properties should follow the generic mmio-sram discription
+found in Documentation/devicetree/bindings/sram/sram.txt
+
+Example:
+	/* In parent SoC .dtsi */
+	ocmcram: ocmcram@40200000 {
+		compatible = "mmio-sram";
+		reg = <0x40200000 0x10000>; /* 64k */
+		memory-exec-nocache;
+		ranges = <0x0 0x40200000 0x10000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+	};
+
+	/* In board .dts where secure silicon is present */
+	&ocmcram {
+		sram-hs@0 {
+			compatible = "ti,secure-ram";
+			reg = <0x0 0xC000>;
+		};
+	};
-- 
2.7.3
