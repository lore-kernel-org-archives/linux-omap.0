From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next v2 2/2] drivers: net: Remove device_node checks
 with of_mdiobus_register()
Date: Tue, 15 May 2018 19:01:28 -0500
Message-ID: <f965090d-fd1c-9507-77f6-878e08dd2fb6@ti.com>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
 <20180515235619.27773-3-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515235619.27773-3-f.fainelli@gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Fugang Duan <fugang.duan@nxp.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Woojung Huh <woojung.huh@microchip.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Russell King <rmk+kernel@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, Thomas
List-Id: linux-omap@vger.kernel.org



On 05/15/2018 06:56 PM, Florian Fainelli wrote:
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
>   drivers/net/dsa/bcm_sf2.c                         |  8 ++------
>   drivers/net/dsa/mv88e6xxx/chip.c                  |  5 +----
>   drivers/net/ethernet/cadence/macb_main.c          | 12 +++---------
>   drivers/net/ethernet/freescale/fec_main.c         |  8 ++------
>   drivers/net/ethernet/marvell/mvmdio.c             |  5 +----
>   drivers/net/ethernet/renesas/sh_eth.c             | 11 +++--------
>   drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  5 +----
>   drivers/net/ethernet/ti/davinci_mdio.c            |  8 +++-----

for drivers/net/ethernet/ti/davinci_mdio.c:
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

>   drivers/net/phy/mdio-gpio.c                       |  6 +-----
>   drivers/net/phy/mdio-mscc-miim.c                  |  6 +-----
>   drivers/net/usb/lan78xx.c                         |  7 ++-----
>   11 files changed, 20 insertions(+), 61 deletions(-)

-- 
regards,
-grygorii
