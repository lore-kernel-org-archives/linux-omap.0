From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] net: ethernet: fix suspend/resume in davinci_emac
Date: Tue, 19 Jun 2018 15:52:19 +0200
Message-ID: <20180619135219.GA7312@wunner.de>
References: <20180619124400.11878-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619124400.11878-1-brgl@bgdev.pl>
Sender: stable-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 19, 2018 at 02:44:00PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This patch reverts commit 3243ff2a05ec ("net: ethernet: davinci_emac:
> Deduplicate bus_find_device() by name matching") and adds a comment
> which should stop anyone from reintroducing the same "fix" in the future.
> 
> We can't use bus_find_device_by_name() here because the device name is
> not guaranteed to be 'davinci_mdio'. On some systems it can be
> 'davinci_mdio.0' so we need to use strncmp() against the first part of
> the string to correctly match it.
> 
> Fixes: 3243ff2a05ec ("net: ethernet: davinci_emac: Deduplicate bus_find_device() by name matching")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Lukas Wunner <lukas@wunner.de>

My apologies Bartosz, it wasn't clear to me that the driver deliberately
only matched against the prefix of the name.  Sorry for the breakage.


> ---
>  drivers/net/ethernet/ti/davinci_emac.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> index 06d7c9e4dcda..a1a6445b5a7e 100644
> --- a/drivers/net/ethernet/ti/davinci_emac.c
> +++ b/drivers/net/ethernet/ti/davinci_emac.c
> @@ -1385,6 +1385,11 @@ static int emac_devioctl(struct net_device *ndev, struct ifreq *ifrq, int cmd)
>  		return -EOPNOTSUPP;
>  }
>  
> +static int match_first_device(struct device *dev, void *data)
> +{
> +	return !strncmp(dev_name(dev), "davinci_mdio", 12);
> +}
> +
>  /**
>   * emac_dev_open - EMAC device open
>   * @ndev: The DaVinci EMAC network adapter
> @@ -1484,8 +1489,14 @@ static int emac_dev_open(struct net_device *ndev)
>  
>  	/* use the first phy on the bus if pdata did not give us a phy id */
>  	if (!phydev && !priv->phy_id) {
> -		phy = bus_find_device_by_name(&mdio_bus_type, NULL,
> -					      "davinci_mdio");
> +		/* NOTE: we can't use bus_find_device_by_name() here because
> +		 * the device name is not guaranteed to be 'davinci_mdio'. On
> +		 * some systems it can be 'davinci_mdio.0' so we need to use
> +		 * strncmp() against the first part of the string to correctly
> +		 * match it.
> +		 */
> +		phy = bus_find_device(&mdio_bus_type, NULL, NULL,
> +				      match_first_device);
>  		if (phy) {
>  			priv->phy_id = dev_name(phy);
>  			if (!priv->phy_id || !*priv->phy_id)
> -- 
> 2.17.1
> 
