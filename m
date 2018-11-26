From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 01/10] dt-bindings: phy: add cpsw port interface
 mode selection phy bindings
Date: Sun, 25 Nov 2018 18:15:22 -0600
Message-ID: <20181126001531.12974-2-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "David S. Miller" <davem@davemloft.net>, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add CPSW Port's Interface Mode Selection PHY (phy-gmii-sel) DT Bindings

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../devicetree/bindings/phy/ti-phy-gmii-sel.txt    | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt

diff --git a/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt b/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
new file mode 100644
index 0000000..50ce9ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
@@ -0,0 +1,68 @@
+CPSW Port's Interface Mode Selection PHY Tree Bindings
+-----------------------------------------------
+
+TI am335x/am437x/dra7(am5)/dm814x CPSW3G Ethernet Subsystem supports
+two 10/100/1000 Ethernet ports with selectable G/MII, RMII, and RGMII interfaces.
+The interface mode is selected by configuring the MII mode selection register(s)
+(GMII_SEL) in the System Control Module chapter (SCM). GMII_SEL register(s) and
+bit fields placement in SCM are different between SoCs while fields meaning
+is the same.
+                                               +--------------+
+        +-------------------------------+      |SCM           |
+        |                     CPSW      |      |  +---------+ |
+        |        +--------------------------------+gmii_sel | |
+        |        |                      |      |  +---------+ |
+        |   +----v---+     +--------+   |      +--------------+
+        |   |Port 1..<--+-->GMII/MII<------->
+        |   |        |  |  |        |   |
+        |   +--------+  |  +--------+   |
+        |               |               |
+        |               |  +--------+   |
+        |               |  | RMII   <------->
+        |               +-->        |   |
+        |               |  +--------+   |
+        |               |               |
+        |               |  +--------+   |
+        |               |  | RGMII  <------->
+        |               +-->        |   |
+        |                  +--------+   |
+        +-------------------------------+
+
+CPSW Port's Interface Mode Selection PHY describes MII interface mode between
+CPSW Port and Ethernet PHY which depends on Eth PHY and board configuration.
+
+CPSW Port's Interface Mode Selection PHY device should defined as child device
+of SCM node (scm_conf) and can be attached to each CPSW port node using standard
+PHY bindings (See phy/phy-bindings.txt).
+
+Required properties:
+- compatible		: Should be "ti,am3352-phy-gmii-sel" for am335x platform
+			  "ti,dra7xx-phy-gmii-sel" for dra7xx/am57xx platform
+			  "ti,am43xx-phy-gmii-sel" for am43xx platform
+			  "ti,dm814-phy-gmii-sel" for dm814x platform
+- reg			: Address and length of the register set for the device
+- #phy-cells		: must be 2.
+			  cell 1 - CPSW port number (starting from 1)
+			  cell 2 - RMII refclk mode
+
+Examples:
+	phy_gmii_sel: phy-gmii-sel {
+		compatible = "ti,am3352-phy-gmii-sel";
+		reg = <0x650 0x4>;
+		#phy-cells = <2>;
+	};
+
+	mac: ethernet@4a100000 {
+		compatible = "ti,am335x-cpsw","ti,cpsw";
+		...
+
+		cpsw_emac0: slave@4a100200 {
+			...
+			phys = <&phy_gmii_sel 1 1>;
+		};
+
+		cpsw_emac1: slave@4a100300 {
+			...
+			phys = <&phy_gmii_sel 2 1>;
+		};
+	};
-- 
2.10.5
