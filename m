From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 02/29] Documentation: nvmem: document lookup entries
Date: Fri, 31 Aug 2018 13:30:28 -0700
Message-ID: <20180831203028.GC62862@ban.mtv.corp.google.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180810080526.27207-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 10, 2018 at 10:04:59AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Describe the usage of nvmem cell lookup tables.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  Documentation/nvmem/nvmem.txt | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
> index 8d8d8f58f96f..9d5e3ca2b4f3 100644
> --- a/Documentation/nvmem/nvmem.txt
> +++ b/Documentation/nvmem/nvmem.txt
> @@ -58,6 +58,34 @@ static int qfprom_probe(struct platform_device *pdev)
>  It is mandatory that the NVMEM provider has a regmap associated with its
>  struct device. Failure to do would return error code from nvmem_register().
>  
> +Additionally it is possible to create nvmem cell lookup entries and register
> +them with the nvmem framework from machine code as shown in the example below:

Maybe it's partially a lacking in the existing documentation, but what
does the "name" and the "nvmem_name" mean here? AFAICT, "nvmem_name" is
akin to a provider identifier; and "name" is a key to match with the
consumer. It feels like this should be in either the header / kerneldoc
or this file. Or maybe both.

Does this mean there can only be a single "mac-address" cell in the
system? I have systems where there are multiple MACs provided in flash
storage, and we need to map them to ethernet0 and ethernet1. Is that
supported here?

Brian

> +static struct nvmem_cell_lookup foobar_lookup = {
> +	.info = {
> +		.name = "mac-address",
> +		.offset = 0xd000,
> +		.bytes = ERH_ALEN,
> +	},
> +	.nvmem_name = "foobar",
> +};
> +
> +static void foobar_register(void)
> +{
> +	...
> +	nvmem_add_lookup_table(&foobar_lookup, 1);
> +	...
> +}
> +
> +A lookup entry table can be later removed if needed:
> +
> +static void foobar_fini(void)
> +{
> +	...
> +	nvmem_del_lookup_table(&foobar_lookup, 1);
> +	...
> +}
> +
>  NVMEM Consumers
>  +++++++++++++++
>  
> -- 
> 2.18.0
> 
