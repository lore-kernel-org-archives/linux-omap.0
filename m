From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 21/28] ARM: davinci: dm644x-evm: use device properties for
 at24 eeprom
Date: Wed, 8 Aug 2018 20:55:46 +0300
Message-ID: <CAHp75VewdvD2D2BpyKAptFecr+hrW5O5YUcSzu9X4wGgV-oJ3A@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-22-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808153150.23444-22-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
>
> Remove the at24_platform_data structure and replace it with an array
> of property entries. Drop the byte_len/size property, as the model name
> already implies the EEPROM's size.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-dm644x-evm.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> index 6d35c6e1b0bd..abfcf42da6fb 100644
> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> @@ -16,8 +16,8 @@
>  #include <linux/gpio/machine.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_data/pcf857x.h>
> -#include <linux/platform_data/at24.h>
>  #include <linux/platform_data/gpio-davinci.h>
> +#include <linux/property.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
> @@ -486,12 +486,8 @@ static struct nvmem_cell_lookup dm6446evm_mac_address_cell = {
>         .nvmem_name = "1-00500",
>  };
>
> -static struct at24_platform_data eeprom_info = {
> -       .byte_len       = (256*1024) / 8,
> -       .page_size      = 64,
> -       .flags          = AT24_FLAG_ADDR16,
> -       .setup          = davinci_get_mac_addr,
> -       .context        = (void *)0x7f00,
> +static const struct property_entry eeprom_properties[] = {
> +       PROPERTY_ENTRY_U32("pagesize", 64),
>  };
>
>  /*
> @@ -601,7 +597,7 @@ static struct i2c_board_info __initdata i2c_info[] =  {
>         },
>         {
>                 I2C_BOARD_INFO("24c256", 0x50),
> -               .platform_data  = &eeprom_info,
> +               .properties = eeprom_properties,
>         },
>         {
>                 I2C_BOARD_INFO("tlv320aic33", 0x1b),
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
