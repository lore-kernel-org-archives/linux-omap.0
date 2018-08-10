From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 05/29] nvmem: remove the name field from struct
 nvmem_device
Date: Fri, 10 Aug 2018 09:33:39 +0100
Message-ID: <c54df79b-2491-61b0-6a91-12798a7ba3e0@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-6-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180810080526.27207-6-brgl@bgdev.pl>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>, Flori
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org



On 10/08/18 09:05, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This field is never set and is only used in a single error message.
> Remove the field and use nvmem_dev_name() instead.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
Looks good to me!

>   drivers/nvmem/core.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 31df2e6d6f72..ab3ced2d9a84 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -26,7 +26,6 @@
>   #include <linux/slab.h>
>   
>   struct nvmem_device {
> -	const char		*name;
>   	struct module		*owner;
>   	struct device		dev;
>   	int			stride;
> @@ -712,7 +711,7 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
>   	if (!try_module_get(nvmem->owner)) {
>   		dev_err(&nvmem->dev,
>   			"could not increase module refcount for cell %s\n",
> -			nvmem->name);
> +			nvmem_dev_name(nvmem));
>   
>   		mutex_lock(&nvmem_mutex);
>   		nvmem->users--;
> 
