From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH net-next v2 2/2] drivers: net: Remove device_node checks
 with of_mdiobus_register()
Date: Wed, 16 May 2018 23:20:03 +0300
Message-ID: <72171a45-3c50-6550-9798-d13df72628ea@cogentembedded.com>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
 <20180515235619.27773-3-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515235619.27773-3-f.fainelli@gmail.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Fugang Duan <fugang.duan@nxp.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Woojung Huh <woojung.huh@microchip.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Russell King <rmk+kernel@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Petazzoni <tho>
List-Id: linux-omap@vger.kernel.org

Hello!

On 05/16/2018 02:56 AM, Florian Fainelli wrote:

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
[...]

> diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
> index ac621f44237a..02e8982519ce 100644
> --- a/drivers/net/dsa/bcm_sf2.c
> +++ b/drivers/net/dsa/bcm_sf2.c
> @@ -450,12 +450,8 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
>  	priv->slave_mii_bus->parent = ds->dev->parent;
>  	priv->slave_mii_bus->phy_mask = ~priv->indir_phy_mask;
>  
> -	if (dn)
> -		err = of_mdiobus_register(priv->slave_mii_bus, dn);
> -	else
> -		err = mdiobus_register(priv->slave_mii_bus);
> -
> -	if (err)
> +	err = of_mdiobus_register(priv->slave_mii_bus, dn);
> +	if (err && dn)

   of_node_put() checks for NULL.

>  		of_node_put(dn);
>  
>  	return err;
[...]
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index d4604bc8eb5b..f3e43db0d6cb 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2052,13 +2052,9 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>  	fep->mii_bus->parent = &pdev->dev;
>  
>  	node = of_get_child_by_name(pdev->dev.of_node, "mdio");
> -	if (node) {
> -		err = of_mdiobus_register(fep->mii_bus, node);
> +	err = of_mdiobus_register(fep->mii_bus, node);
> +	if (node)
>  		of_node_put(node);

   Same comment here.

[...]
> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index 5970d9e5ddf1..8dd41e08a6c6 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -3025,15 +3025,10 @@ static int sh_mdio_init(struct sh_eth_private *mdp,
>  		 pdev->name, pdev->id);
>  
>  	/* register MDIO bus */
> -	if (dev->of_node) {
> -		ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
> -	} else {
> -		if (pd->phy_irq > 0)
> -			mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
> -
> -		ret = mdiobus_register(mdp->mii_bus);
> -	}
> +	if (pd->phy_irq > 0)
> +		mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
>  
> +	ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
>  	if (ret)
>  		goto out_free_bus;
>  

   This part is:

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 91761436709a..8dff87ec6d99 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1843,12 +1843,9 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
>  	}
>  
>  	node = of_get_child_by_name(dev->udev->dev.of_node, "mdio");
> -	if (node) {
> -		ret = of_mdiobus_register(dev->mdiobus, node);
> +	ret = of_mdiobus_register(dev->mdiobus, node);
> +	if (node)
>  		of_node_put(node);

   of_node_put() checks for NULL, again...

MBR, Sergei
