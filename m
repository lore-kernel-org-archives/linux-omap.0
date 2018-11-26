From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 00/10] net: ethernet: ti: cpsw: replace cpsw-phy-sel with phy driver
Date: Sun, 25 Nov 2018 18:15:21 -0600
Message-ID: <20181126001531.12974-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

TI am335x/am437x/dra7(am5)/dm814x CPSW3G Ethernet Subsystem supports 
two 10/100/1000 Ethernet ports with selectable G/MII, RMII, and RGMII interfaces.
The interface mode is selected by configuring the MII mode selection register(s)
(GMII_SEL) in the System Control Module chapter (SCM).
                                               +--------------+
        +-------------------------------+      |SCM           |
        |                     CPSW      |      |  +---------+ |
        |        +--------------------------------+gmii_sel | |
        |        |                      |      |  +---------+ |
        |   +----v---+     +--------+   |      +--------------+
        |   |Port 1..<--+-->GMII/MII<------->
        |   |        |  |  |        |   |
        |   +--------+  |  +--------+   |
        |               |               |
        |               |  +--------+   |
        |               |  | RMII   <------->
        |               +-->        |   |
        |               |  +--------+   |
        |               |               |
        |               |  +--------+   |
        |               |  | RGMII  <------->
        |               +-->        |   |
        |                  +--------+   |
        +-------------------------------+

GMII_SEL register(s) and bit fields placement in SCM are different between SoCs
while fields meaning is the same. GMII_SEL(s) allows to select -
Port GMII/MII/RMII/RGMII Mode; RGMII Internal Delay Mode (SoC dependant) and
RMII Reference Clock Output mode (SoC dependant).

Historically CPSW external Port's interface mode selection configuartion was
introduced using custom driver and API cpsw-phy-sel.c.
This leads to unnecessary driver, DT binding and custom API support effort.
Moreover, even definition of cpsw-phy-sel node in DTs is logically incorrect [1]

mac: ethernet@4a100000 {
	compatible = "ti,am4372-cpsw","ti,cpsw";
	...

	phy_sel: cpsw-phy-sel@44e10650 {
		compatible = "ti,am43xx-cpsw-phy-sel";
		reg= <0x44e10650 0x4>;
		reg-names = "gmii-sel";
	};
};

This series replaces custom CPSW Port interface selection implementation
(cpsw-phy-sel.c) with well defined Linux PHY framework interface instead.
It introduces CPSW Port's PHY Interface Mode selection Driver (phy-gmii-sel)
which implements standard Linux PHY interface. The phy-gmii-sel PHY device
should defined as child device of SCM node (scm_conf) and can be attached to
each CPSW port node using standard PHY bindings (cell 1 - port number,
cell 2 - RMII refclk mode).

scm_conf: scm_conf@0 {
	compatible = "syscon", "simple-bus";

	gmii_sel_phy: cpsw-sel-netif {
		compatible = "ti,am43xx-gmii-sel-phy";
		syscon-scm = <&scm_conf>;
		#phy-cells = <2>;
	};
};

mac: ethernet@4a100000 {
	compatible = "ti,am4372-cpsw","ti,cpsw";

	cpsw_emac0: slave@4a100200 {
		phy-mode = "rgmii";
		phys = <&gmii_sel_phy 1 0>;
	};
};

The CPSW driver requests phy-gmii-sel PHY for each external port and uses
recently introduced PHY API phy_set_mode_ext() [1] for port interface mode
selection when netdev is opened.

	slave->data->gmii_sel_phy = devm_of_phy_get(&pdev->dev, port_node, NULL);
	slave->data->phy_if = of_get_phy_mode(port_node);

cpsw_ndo_open()
	phy_set_mode_ext(slave->data->gmii_sel_phy, PHY_MODE_ETHERNET, slave->data->phy_if);

Note. CPSW Port interface has to be reconfigured every time netdev is opened for
proper System Suspend support where CPSW can lose context.

[1] https://patchwork.kernel.org/cover/10689739/

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

Grygorii Strashko (10):
  dt-bindings: phy: add cpsw port interface mode selection phy bindings
  phy: ti: introduce phy-gmii-sel driver
  dt-bindings: net: ti: cpsw: switch to use phy-gmii-sel phy
  net: ethernet: ti: cpsw: add support for port interface mode selection
    phy
  ARM: dts: dra7: switch to use phy-gmii-sel
  ARM: dts: dm814x: switch to use phy-gmii-sel
  ARM: dts: am4372: switch to use phy-gmii-sel
  ARM: dts: am335x: switch to use phy-gmii-sel
  dt-bindings: net: ti: deprecate cpsw-phy-sel bindings
  net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver

 .../devicetree/bindings/net/cpsw-phy-sel.txt       |   2 +-
 Documentation/devicetree/bindings/net/cpsw.txt     |   8 +-
 .../devicetree/bindings/phy/ti-phy-gmii-sel.txt    |  68 ++++
 arch/arm/boot/dts/am335x-baltos-ir2110.dts         |   4 -
 arch/arm/boot/dts/am335x-baltos-ir3220.dts         |   4 -
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |   4 -
 arch/arm/boot/dts/am335x-chiliboard.dts            |   4 -
 arch/arm/boot/dts/am335x-icev2.dts                 |   4 -
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   4 -
 arch/arm/boot/dts/am335x-lxm.dts                   |   4 -
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi  |   5 -
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts     |   5 -
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |   4 -
 arch/arm/boot/dts/am33xx-l4.dtsi                   |  15 +-
 arch/arm/boot/dts/am437x-l4.dtsi                   |  17 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   5 +-
 arch/arm/boot/dts/dm814x.dtsi                      |  15 +-
 arch/arm/boot/dts/dra7-l4.dtsi                     |  15 +-
 drivers/net/ethernet/ti/Kconfig                    |   6 +-
 drivers/net/ethernet/ti/cpsw.c                     |  19 +-
 drivers/net/ethernet/ti/cpsw.h                     |   6 +
 drivers/phy/ti/Kconfig                             |  10 +
 drivers/phy/ti/Makefile                            |   1 +
 drivers/phy/ti/phy-gmii-sel.c                      | 349 +++++++++++++++++++++
 24 files changed, 498 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
 create mode 100644 drivers/phy/ti/phy-gmii-sel.c

-- 
2.10.5
