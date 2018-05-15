From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next v2 0/2] of: mdio: Fall back to mdiobus_register() with NULL device_node
Date: Tue, 15 May 2018 16:56:17 -0700
Message-ID: <20180515235619.27773-1-f.fainelli@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Fugang Duan <fugang.duan@nxp.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Woojung Huh <woojung.huh@microchip.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Tobias Jordan <Tobias.Jordan@elektrobit.com>Russell King <r>
List-Id: linux-omap@vger.kernel.org

Hi all,

This patch series updates of_mdiobus_register() such that when the device_node
argument is NULL, it calls mdiobus_register() directly. This is consistent with
the behavior of of_mdiobus_register() when CONFIG_OF=n.

I only converted the most obvious drivers, there are others that have a much
less obvious behavior and specifically attempt to deal with CONFIG_ACPI.

Changes in v2:

- fixed build error in davincin_mdio.c (Grygorii)
- reworked first patch a bit: commit message, subject and removed useless
  code comment

Florian Fainelli (2):
  of: mdio: Fall back to mdiobus_register() with NULL device_node
  drivers: net: Remove device_node checks with of_mdiobus_register()

 drivers/net/dsa/bcm_sf2.c                         |  8 ++------
 drivers/net/dsa/mv88e6xxx/chip.c                  |  5 +----
 drivers/net/ethernet/cadence/macb_main.c          | 12 +++---------
 drivers/net/ethernet/freescale/fec_main.c         |  8 ++------
 drivers/net/ethernet/marvell/mvmdio.c             |  5 +----
 drivers/net/ethernet/renesas/sh_eth.c             | 11 +++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  5 +----
 drivers/net/ethernet/ti/davinci_mdio.c            |  8 +++-----
 drivers/net/phy/mdio-gpio.c                       |  6 +-----
 drivers/net/phy/mdio-mscc-miim.c                  |  6 +-----
 drivers/net/usb/lan78xx.c                         |  7 ++-----
 drivers/of/of_mdio.c                              |  3 +++
 12 files changed, 23 insertions(+), 61 deletions(-)

-- 
2.14.1
