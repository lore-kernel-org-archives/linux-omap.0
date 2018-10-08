From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 02/11] dt-bindings: phy: add cpsw port interface mode selection phy bindings
Date: Mon, 8 Oct 2018 18:49:40 -0500
Message-ID: <20181008234949.15416-3-grygorii.strashko@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008234949.15416-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
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
index 0000000..fd81421
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
+- #phy-cells		: must be 2.
+			  cell 1 - CPSW port number (starting from 1)
+			  cell 2 - RMII refclk mode
+- syscon-scm		: phandle on SCM node (mfd/syscon.txt)
+
+Examples:
+	phy_gmii_sel: phy-gmii-sel {
+		compatible = "ti,am3352-phy-gmii-sel";
+		syscon-scm = <&scm_conf>;
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
