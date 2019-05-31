From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/3] dt-bindings: hwlock: Update OMAP binding for TI K3 SoCs
Date: Thu, 30 May 2019 21:13:19 -0500
Message-ID: <20190531021321.14025-2-s-anna@ti.com>
References: <20190531021321.14025-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190531021321.14025-1-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The TI K3 AM65x and J721E family of SoCs have a HwSpinlock IP that
is similar to the existing HwSpinlock IP present in OMAP architecture
based SoCs with minor differences. Update the existing OMAP HwSpinlock
binding for this IP on TI K3 AM65x and J721E SoCs. The same compatible
from AM65x SoCs is reused for J721E SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 .../bindings/hwlock/omap-hwspinlock.txt       | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
index 2c9804f4f4ac..8d365f89694c 100644
--- a/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
+++ b/Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
@@ -1,12 +1,16 @@
-OMAP4+ HwSpinlock Driver
-========================
+TI HwSpinlock for OMAP and K3 based SoCs
+=========================================
 
 Required properties:
-- compatible:		Should be "ti,omap4-hwspinlock" for
-			    OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs
+- compatible:		Should be one of the following,
+			  "ti,omap4-hwspinlock" for
+				OMAP44xx, OMAP54xx, AM33xx, AM43xx, DRA7xx SoCs
+			  "ti,am654-hwspinlock" for
+				K3 AM65x and J721E SoCs
 - reg:			Contains the hwspinlock module register address space
 			(base address and length)
 - ti,hwmods:		Name of the hwmod associated with the hwspinlock device
+			(for OMAP architecture based SoCs only)
 - #hwlock-cells:	Should be 1. The OMAP hwspinlock users will use a
 			0-indexed relative hwlock number as the argument
 			specifier value for requesting a specific hwspinlock
@@ -17,10 +21,21 @@ Please look at the generic hwlock binding for usage information for consumers,
 
 Example:
 
-/* OMAP4 */
+1. OMAP4 SoCs
 hwspinlock: spinlock@4a0f6000 {
 	compatible = "ti,omap4-hwspinlock";
 	reg = <0x4a0f6000 0x1000>;
 	ti,hwmods = "spinlock";
 	#hwlock-cells = <1>;
 };
+
+2. AM65x SoCs and J721E SoCs
+&cbass_main {
+	cbass_main_navss: interconnect0 {
+		hwspinlock: spinlock@30e00000 {
+			compatible = "ti,am654-hwspinlock";
+			reg = <0x00 0x30e00000 0x00 0x1000>;
+			#hwlock-cells = <1>;
+		};
+	};
+};
-- 
2.21.0
