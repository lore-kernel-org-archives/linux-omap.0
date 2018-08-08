From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 06/28] mtd: Add support for reading MTD devices via the
 nvmem API
Date: Wed, 8 Aug 2018 18:20:42 +0200
Message-ID: <20180808162042.GG7275@lunn.ch>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808153150.23444-7-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808153150.23444-7-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 08, 2018 at 05:31:28PM +0200, Bartosz Golaszewski wrote:
> From: Alban Bedel <albeu@free.fr>
> 
> Allow drivers that use the nvmem API to read data stored on MTD devices.
> For this the mtd devices are registered as read-only NVMEM providers.
> On OF systems only devices that have the 'nvmem-provider' property
> are registered, on non-OF system all MTD devices are registered.
> @@ -570,6 +613,11 @@ int add_mtd_device(struct mtd_info *mtd)
>  	if (error)
>  		goto fail_added;
>  
> +	/* Add the nvmem provider */
> +	error = mtd_nvmem_add(mtd);
> +	if (error)
> +		goto fail_nvmem_add;
> +

Hi Bartosz

Maybe it is hiding somewhere, but i don't see any code looking into
device tree looking for the 'nvmem-provider' property.

       Andrew
