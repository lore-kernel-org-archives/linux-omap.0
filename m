From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 24/28] ARM: davinci: sffsdr: use device properties for
 at24 eeprom
Date: Wed, 8 Aug 2018 20:57:02 +0300
Message-ID: <CAHp75VfU6Dsge0XX5h18zjY9kJ73kFPevLT9j7vZBO__tNronw@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-25-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808153150.23444-25-brgl@bgdev.pl>
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
>  arch/arm/mach-davinci/board-sffsdr.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
> index f6a4d094cbc3..680e5d7628a8 100644
> --- a/arch/arm/mach-davinci/board-sffsdr.c
> +++ b/arch/arm/mach-davinci/board-sffsdr.c
> @@ -26,7 +26,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
> -#include <linux/platform_data/at24.h>
> +#include <linux/property.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
> @@ -92,16 +92,15 @@ static struct platform_device davinci_sffsdr_nandflash_device = {
>         .resource       = davinci_sffsdr_nandflash_resource,
>  };
>
> -static struct at24_platform_data eeprom_info = {
> -       .byte_len       = (64*1024) / 8,
> -       .page_size      = 32,
> -       .flags          = AT24_FLAG_ADDR16,
> +static const struct property_entry eeprom_properties[] = {
> +       PROPERTY_ENTRY_U32("pagesize", 32),
> +       { },
>  };
>
>  static struct i2c_board_info __initdata i2c_info[] =  {
>         {
>                 I2C_BOARD_INFO("24c64", 0x50),
> -               .platform_data  = &eeprom_info,
> +               .properties = eeprom_properties,
>         },
>         /* Other I2C devices:
>          * MSP430,  addr 0x23 (not used)
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
