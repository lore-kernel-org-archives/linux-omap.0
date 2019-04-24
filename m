From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 06/11] dt-bindings: net: ti: add new cpsw switch driver bindings
Date: Thu, 25 Apr 2019 01:24:22 +0300
Message-ID: <1556144667-27997-7-git-send-email-grygorii.strashko@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Add bindings for the new TI CPSW switch driver. Comparing to the legacy
bindings (net/cpsw.txt):
- ports definition follows DSA bindings (net/dsa/dsa.txt) and ports can be
marked as "disabled" if not physically wired.
- ports definition follows DSA bindings (net/dsa/dsa.txt) and ports can be
marked as "disabled" if not physically wired.
- all deprecated properties dropped;
- all legacy propertiies dropped which represents constant HW cpapbilities
(cpdma_channels, ale_entries, bd_ram_size, mac_control, slaves,
active_slave)
- cpts properties grouped in "cpts" sub-node

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../bindings/net/ti,cpsw-switch.txt           | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,cpsw-switch.txt

diff --git a/Documentation/devicetree/bindings/net/ti,cpsw-switch.txt b/Documentation/devicetree/bindings/net/ti,cpsw-switch.txt
new file mode 100644
index 000000000000..d9c6480501b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,cpsw-switch.txt
@@ -0,0 +1,117 @@
+TI SoC Ethernet Switch Controller Device Tree Bindings (new)
+------------------------------------------------------
+
+The 3-port switch gigabit ethernet subsystem provides ethernet packet
+communication and can be configured as an ethernet switch. It provides the
+gigabit media independent interface (GMII),reduced gigabit media
+independent interface (RGMII), reduced media independent interface (RMII),
+the management data input output (MDIO) for physical layer device (PHY)
+management.
+
+Required properties:
+- compatible : be one of the below:
+	  "ti,cpsw-switch" for backward compatible
+	  "ti,am335x-cpsw-switch" for AM335x controllers
+	  "ti,am4372-cpsw-switch" for AM437x controllers
+	  "ti,dra7-cpsw-switch" for DRA7x controllers
+- reg : physical base address and size of the CPSW module IO range
+- ranges : shall contain the CPSW module IO range available for child devices
+- clocks : should contain the CPSW functional clock
+- clock-names : should be "fck"
+	See bindings/clock/clock-bindings.txt
+- interrupts : should contain CPSW RX, TX, MISC, RX_THRESH interrupts
+- interrupt-names : should contain "rx_thresh", "rx", "tx", "misc"
+	See bindings/interrupt-controller/interrupts.txt
+
+Optional properties:
+- syscon : phandle to the system control device node which provides access to
+	efuse IO range with MAC addresses
+
+Required Sub-nodes:
+- ports	: contains CPSW external ports descriptions
+	Required properties:
+	- #address-cells : Must be 1
+	- #size-cells : Must be 0
+	- reg : CPSW port number. Should be 1 or 2
+	- phys : phandle on phy-gmii-sel PHY (see phy/ti-phy-gmii-sel.txt)
+	- phy-mode : operation mode of the PHY interface [1]
+	- phy-handle : phandle to a PHY on an MDIO bus [1]
+
+	Optional properties:
+	- ti,label : Describes the label associated with this port
+	- mac-address : array of 6 bytes, specifies the MAC address. Always
+		accounted first if present [1]
+	- local-mac-address : See [1]
+
+- mdio : CPSW MDIO bus block description
+	- bus_freq : MDIO Bus frequency
+	See bindings/net/mdio.txt and davinci-mdio.txt
+
+- cpts : The Common Platform Time Sync (CPTS) module description
+	- clocks : should contain the CPTS reference clock
+	- clock-names : should be "cpts"
+	See bindings/clock/clock-bindings.txt
+
+	Optional properties - all ports:
+	- cpts_clock_mult : Numerator to convert input clock ticks into ns
+	- cpts_clock_shift : Denominator to convert input clock ticks into ns
+			  Mult and shift will be calculated basing on CPTS
+			  rftclk frequency if both cpts_clock_shift and
+			  cpts_clock_mult properties are not provided.
+
+[1] See Documentation/devicetree/bindings/net/ethernet.txt
+
+Examples:
+
+mac_sw: ethernet_switch@0 {
+	compatible = "ti,dra7-cpsw-switch","ti,cpsw-switch";
+	reg = <0x0 0x4000>;
+	ranges = <0 0 0x4000>;
+	clocks = <&gmac_main_clk>;
+	clock-names = "fck";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	syscon = <&scm_conf>;
+	status = "disabled";
+
+	interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "rx_thresh", "rx", "tx", "misc"
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpsw_port1: port@1 {
+			reg = <1>;
+			ti,label = "port1";
+			/* Filled in by U-Boot */
+			mac-address = [ 00 00 00 00 00 00 ];
+			phys = <&phy_gmii_sel 1>;
+		};
+
+		cpsw_port2: port@2 {
+			reg = <2>;
+			ti,label = "port2";
+			/* Filled in by U-Boot */
+			mac-address = [ 00 00 00 00 00 00 ];
+			phys = <&phy_gmii_sel 2>;
+		};
+	};
+
+	davinci_mdio_sw: mdio@1000 {
+		compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ti,hwmods = "davinci_mdio";
+		bus_freq = <1000000>;
+		reg = <0x1000 0x100>;
+	};
+
+	cpts {
+		clocks = <&gmac_clkctrl DRA7_GMAC_GMAC_CLKCTRL 25>;
+		clock-names = "cpts";
+	};
+};
-- 
2.17.1
