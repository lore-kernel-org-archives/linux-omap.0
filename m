From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
Date: Wed, 4 Jul 2018 09:09:19 +0200
Message-ID: <20180704070919.GA14051@lenoch>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lukas Wunner <lukas@wunner.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 03, 2018 at 09:39:51AM -0700, Florian Fainelli wrote:
> 
> 
> On 06/29/2018 02:40 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > On da850-evm board we can read the MAC address from MTD. It's currently
> > done in the relevant board file, but we want to get rid of all the MAC
> > reading callbacks from the board file (SPI and NAND). Move the reading
> > of the MAC address from SPI to the emac driver's probe function.
> 
> This should be made something generic to all drivers, not just something
> the davinci_emac driver does, something like this actually:
> 
> https://lkml.org/lkml/2018/3/24/312

...and that's would also make it work when MAC address is stored
in 24c08 EEPROM, which is quite common.

> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/net/ethernet/ti/davinci_emac.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
> > index a1a6445b5a7e..48e6a7755811 100644
> > --- a/drivers/net/ethernet/ti/davinci_emac.c
> > +++ b/drivers/net/ethernet/ti/davinci_emac.c
> > @@ -67,7 +67,7 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/of_net.h>
> >  #include <linux/mfd/syscon.h>
> > -
> > +#include <linux/mtd/mtd.h>
> >  #include <asm/irq.h>
> >  #include <asm/page.h>
> >  
> > @@ -1783,7 +1783,10 @@ static int davinci_emac_probe(struct platform_device *pdev)
> >  	struct cpdma_params dma_params;
> >  	struct clk *emac_clk;
> >  	unsigned long emac_bus_frequency;
> > -
> > +#ifdef CONFIG_MTD
> > +	size_t mac_addr_len;
> > +	struct mtd_info *mtd;
> > +#endif /* CONFIG_MTD */
> >  
> >  	/* obtain emac clock from kernel */
> >  	emac_clk = devm_clk_get(&pdev->dev, NULL);
> > @@ -1815,6 +1818,19 @@ static int davinci_emac_probe(struct platform_device *pdev)
> >  		goto err_free_netdev;
> >  	}
> >  
> > +#ifdef CONFIG_MTD
> > +	mtd = get_mtd_device_nm("MAC-Address");
> > +	if (!IS_ERR(mtd)) {
> > +		rc = mtd_read(mtd, 0, ETH_ALEN,
> > +			      &mac_addr_len, priv->mac_addr);
> > +		if (rc == 0)
> > +			dev_info(&pdev->dev,
> > +				 "Read MAC addr from SPI Flash: %pM\n",
> > +				 priv->mac_addr);
> > +		put_mtd_device(mtd);
> > +	}
> > +#endif /* CONFIG_MTD */
> > +
> >  	/* MAC addr and PHY mask , RMII enable info from platform_data */
> >  	memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
> >  	priv->phy_id = pdata->phy_id;
> > 
> 
> -- 
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
