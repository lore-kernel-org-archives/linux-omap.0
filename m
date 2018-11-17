From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 12/25] of: net: kill of_get_nvmem_mac_address()
Date: Sat, 17 Nov 2018 09:45:31 -0600
Message-ID: <20181117154531.GA7306@bogus>
References: <20181113140133.17385-1-brgl@bgdev.pl>
 <20181113140133.17385-13-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181113140133.17385-13-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Nicolas Ferre <nicolas.ferre@microchip.com>, "David S . Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Frank Rowand <frowand.list@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-arm-ke
List-Id: linux-omap@vger.kernel.org

On Tue, 13 Nov 2018 15:01:20 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We've switched all users to nvmem_get_mac_address(). Remove the now
> dead code.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/of/of_net.c    | 39 ---------------------------------------
>  include/linux/of_net.h |  6 ------
>  2 files changed, 45 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
