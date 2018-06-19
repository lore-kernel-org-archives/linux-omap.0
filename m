From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/3] net: phy: set the of_node in the mdiodev's struct
 device
Date: Tue, 19 Jun 2018 09:55:54 -0700
Message-ID: <284f2e59-da97-e907-690e-f75de376ff62@gmail.com>
References: <20180619160950.6283-1-brgl@bgdev.pl>
 <20180619160950.6283-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619160950.6283-3-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On 06/19/2018 09:09 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Copy the of_node over from mii_bus's struct device. This is needed
> for device-tree systems to be able to check the mdio device's
> compatible string.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/net/phy/phy_device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index bd0f339f69fd..a92d5ee61813 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -411,6 +411,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int phy_id,
>  	mdiodev->dev.parent = &bus->dev;
>  	mdiodev->dev.bus = &mdio_bus_type;
>  	mdiodev->dev.type = &mdio_bus_phy_type;
> +	mdiodev->dev.of_node = bus->dev.of_node;

That does not quite make sense to me, the mdio device's parent already
points to &bus->dev, which would get you the correct of_node. You are
breaking the parent/child relationship here. From patch 3, see my
comments there, it does not look like you are matching on the right
device level.

>  	mdiodev->bus = bus;
>  	mdiodev->bus_match = phy_bus_match;
>  	mdiodev->addr = addr;
> 


-- 
Florian
