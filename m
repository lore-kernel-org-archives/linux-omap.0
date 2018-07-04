From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
Date: Wed, 4 Jul 2018 10:29:48 +0200
Message-ID: <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
References: <20180629094039.7543-1-brgl@bgdev.pl> <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com> <20180704070919.GA14051@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180704070919.GA14051@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz
List-Id: linux-omap@vger.kernel.org

2018-07-04 9:09 GMT+02:00 Ladislav Michl <ladis@linux-mips.org>:
> On Tue, Jul 03, 2018 at 09:39:51AM -0700, Florian Fainelli wrote:
>>
>>
>> On 06/29/2018 02:40 AM, Bartosz Golaszewski wrote:
>> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> >
>> > On da850-evm board we can read the MAC address from MTD. It's currently
>> > done in the relevant board file, but we want to get rid of all the MAC
>> > reading callbacks from the board file (SPI and NAND). Move the reading
>> > of the MAC address from SPI to the emac driver's probe function.
>>
>> This should be made something generic to all drivers, not just something
>> the davinci_emac driver does, something like this actually:
>>
>> https://lkml.org/lkml/2018/3/24/312
>
> ...and that's would also make it work when MAC address is stored
> in 24c08 EEPROM, which is quite common.
>

This is what the second patch for davinci_emac in this series does. I
agree that this should become more generic at some point - we should
probably have a routine somewhere in net that would try to get the MAC
address from all possible sources (nvmem, of etc.). This is somewhat
related to the work I want to do on nvmem to make the at24 setup()
callback more generic.

Unfortunately we don't have it yet and I will not have time to work on
it before v4.20 so if there are no serious objections, I'd like to get
this series merged for v4.19 and then we can refactor the MAC reading
later.

How does it sound?

Best regards,
Bartosz Golaszewski

>> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> > ---
>> >  drivers/net/ethernet/ti/davinci_emac.c | 20 ++++++++++++++++++--
>> >  1 file changed, 18 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
>> > index a1a6445b5a7e..48e6a7755811 100644
>> > --- a/drivers/net/ethernet/ti/davinci_emac.c
>> > +++ b/drivers/net/ethernet/ti/davinci_emac.c
>> > @@ -67,7 +67,7 @@
>> >  #include <linux/of_irq.h>
>> >  #include <linux/of_net.h>
>> >  #include <linux/mfd/syscon.h>
>> > -
>> > +#include <linux/mtd/mtd.h>
>> >  #include <asm/irq.h>
>> >  #include <asm/page.h>
>> >
>> > @@ -1783,7 +1783,10 @@ static int davinci_emac_probe(struct platform_device *pdev)
>> >     struct cpdma_params dma_params;
>> >     struct clk *emac_clk;
>> >     unsigned long emac_bus_frequency;
>> > -
>> > +#ifdef CONFIG_MTD
>> > +   size_t mac_addr_len;
>> > +   struct mtd_info *mtd;
>> > +#endif /* CONFIG_MTD */
>> >
>> >     /* obtain emac clock from kernel */
>> >     emac_clk = devm_clk_get(&pdev->dev, NULL);
>> > @@ -1815,6 +1818,19 @@ static int davinci_emac_probe(struct platform_device *pdev)
>> >             goto err_free_netdev;
>> >     }
>> >
>> > +#ifdef CONFIG_MTD
>> > +   mtd = get_mtd_device_nm("MAC-Address");
>> > +   if (!IS_ERR(mtd)) {
>> > +           rc = mtd_read(mtd, 0, ETH_ALEN,
>> > +                         &mac_addr_len, priv->mac_addr);
>> > +           if (rc == 0)
>> > +                   dev_info(&pdev->dev,
>> > +                            "Read MAC addr from SPI Flash: %pM\n",
>> > +                            priv->mac_addr);
>> > +           put_mtd_device(mtd);
>> > +   }
>> > +#endif /* CONFIG_MTD */
>> > +
>> >     /* MAC addr and PHY mask , RMII enable info from platform_data */
>> >     memcpy(priv->mac_addr, pdata->mac_addr, ETH_ALEN);
>> >     priv->phy_id = pdata->phy_id;
>> >
>>
>> --
>> Florian
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
