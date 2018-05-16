From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH net-next v2 2/2] drivers: net: Remove device_node checks
 with of_mdiobus_register()
Date: Wed, 16 May 2018 12:01:21 +0100
Message-ID: <2a70eb7c-7fc9-8bf6-a06a-87b4901d66ae@synopsys.com>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
 <20180515235619.27773-3-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515235619.27773-3-f.fainelli@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Fugang Duan <fugang.duan@nxp.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Woojung Huh <woojung.huh@microchip.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Russell King <rmk+kernel@armlinux.org.uk>, Geert
List-Id: linux-omap@vger.kernel.org

On 16-05-2018 00:56, Florian Fainelli wrote:
> A number of drivers have the following pattern:
>
> if (np)
> 	of_mdiobus_register()
> else
> 	mdiobus_register()
>
> which the implementation of of_mdiobus_register() now takes care of.
> Remove that pattern in drivers that strictly adhere to it.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/dsa/bcm_sf2.c                         |  8 ++------
>  drivers/net/dsa/mv88e6xxx/chip.c                  |  5 +----
>  drivers/net/ethernet/cadence/macb_main.c          | 12 +++---------
>  drivers/net/ethernet/freescale/fec_main.c         |  8 ++------
>  drivers/net/ethernet/marvell/mvmdio.c             |  5 +----
>  drivers/net/ethernet/renesas/sh_eth.c             | 11 +++--------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  5 +----

For stmmac:

Reviewed-by: Jose Abreu <joabreu@synopsys.com>

Thanks and Best Regards,
Jose Miguel Abreu

>  drivers/net/ethernet/ti/davinci_mdio.c            |  8 +++-----
>  drivers/net/phy/mdio-gpio.c                       |  6 +-----
>  drivers/net/phy/mdio-mscc-miim.c                  |  6 +-----
>  drivers/net/usb/lan78xx.c                         |  7 ++-----
>  11 files changed, 20 insertions(+), 61 deletions(-)
>
