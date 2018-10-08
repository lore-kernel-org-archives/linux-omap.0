From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 00/11] net: ethernet: ti: cpsw: replace cpsw-phy-sel with phy driver
Date: Mon, 8 Oct 2018 18:49:38 -0500
Message-ID: <20181008234949.15416-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
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

This series introduces attempt to drop custom CPSW Port interface selection
implementation (cpsw-phy-sel.c) and use well defined Linux PHY framework instead.
it introduces CPSW Port's PHY Interface Mode selection Driver (phy-gmii-sel)
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

The CPSW driver requests phy-gmii-sel PHY for each external port and uses newly
introduced API phy_set_netif_mode() (Patch 1) for port interface mode selection
when netdev is opened.

	slave->data->gmii_sel_phy = devm_of_phy_get(&pdev->dev, port_node, NULL);
	slave->data->phy_if = of_get_phy_mode(port_node);

cpsw_ndo_open()
	phy_set_netif_mode(slave->data->gmii_sel_phy, slave->data->phy_if);

Note. CPSW Port interface has to be reconfigured every time netdev is opened for
proper System Suspend support where CPSW can lose context.

I've considered two options while working on this series:
1) extend enum phy_mode {} and introduce more enum elements to cover missing,
required Network PHY's Interface Mode definitions, like MII/GMII/RGMII(-XID),
but it'd mean copy-past and data duplication from phy_interface_t -> phy_mode.
More over, phy_interface_t can still continue growing.

2) introduce new PHY API for network interface mode selection which will use
already defined set of modes from phy_interface_t.

Option 2 was selected for this series.

[1] https://www.mail-archive.com/netdev@vger.kernel.org/msg247135.html

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

Grygorii Strashko (11):
  phy: core add phy_set_netif_mode() api
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
 arch/arm/boot/dts/am335x-baltos-ir3220.dts         |   3 -
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |   3 -
 arch/arm/boot/dts/am335x-chiliboard.dts            |   3 -
 arch/arm/boot/dts/am335x-icev2.dts                 |   4 -
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   3 -
 arch/arm/boot/dts/am335x-lxm.dts                   |   3 -
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts     |   5 -
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |   3 -
 arch/arm/boot/dts/am33xx.dtsi                      |  14 +-
 arch/arm/boot/dts/am4372.dtsi                      |  16 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   5 +-
 arch/arm/boot/dts/dm814x.dtsi                      |  15 +-
 arch/arm/boot/dts/dra7.dtsi                        |  14 +-
 drivers/net/ethernet/ti/Kconfig                    |   6 +-
 drivers/net/ethernet/ti/cpsw.c                     |  18 +-
 drivers/net/ethernet/ti/cpsw.h                     |   6 +
 drivers/phy/phy-core.c                             |  15 +
 drivers/phy/ti/Kconfig                             |  10 +
 drivers/phy/ti/Makefile                            |   1 +
 drivers/phy/ti/phy-gmii-sel.c                      | 345 +++++++++++++++++++++
 include/linux/phy/phy.h                            |  12 +
 25 files changed, 520 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
 create mode 100644 drivers/phy/ti/phy-gmii-sel.c

-- 
2.10.5
