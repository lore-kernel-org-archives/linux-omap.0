From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 27/28] ARM: davinci: mityomapl138: use device properties
 for at24 eeprom
Date: Wed, 8 Aug 2018 21:00:31 +0300
Message-ID: <CAHp75VejMix_CVETOiMMZsrOyMh+o=OGx4-A24QpBAYf_ka=FA@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-28-brgl@bgdev.pl>
 <CAHp75VdBkSHtqXkzRJgOHwaL5UhgV+TgySjEs57bisbKTpO4SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdBkSHtqXkzRJgOHwaL5UhgV+TgySjEs57bisbKTpO4SQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 8, 2018 at 8:58 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We want to work towards phasing out the at24_platform_data structure.
>> There are few users and its contents can be represented using generic
>> device properties. Using device properties only will allow us to
>> significantly simplify the at24 configuration code.
>>
>> Remove the at24_platform_data structure and replace it with an array
>> of property entries. Drop the byte_len/size property, as the model name
>> already implies the EEPROM's size.
>>
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/board-mityomapl138.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
>> index 17b67e26bc0e..be0fb7d17e25 100644
>> --- a/arch/arm/mach-davinci/board-mityomapl138.c
>> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
>> @@ -14,11 +14,11 @@
>>  #include <linux/init.h>
>>  #include <linux/console.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/property.h>
>>  #include <linux/mtd/partitions.h>
>>  #include <linux/notifier.h>
>>  #include <linux/regulator/machine.h>
>>  #include <linux/i2c.h>
>> -#include <linux/platform_data/at24.h>
>>  #include <linux/etherdevice.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/spi/flash.h>
>> @@ -185,10 +185,9 @@ static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
>>         }
>>  };
>>
>> -static struct at24_platform_data mityomapl138_fd_chip = {
>> -       .byte_len       = 256,
>> -       .page_size      = 8,
>> -       .flags          = AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
>> +static const struct property_entry mityomapl138_fd_chip_properties[] = {
>> +       PROPERTY_ENTRY_U32("pagesize", 8),
>> +       PROPERTY_ENTRY_BOOL("read-only"),

Missed terminator

>>  };
>>
>>  static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
>> @@ -317,7 +316,7 @@ static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
>>         },
>>         {
>>                 I2C_BOARD_INFO("24c02", 0x50),
>> -               .platform_data = &mityomapl138_fd_chip,
>> +               .properties = mityomapl138_fd_chip_properties,
>>         },
>>  };
>>
>> --
>> 2.18.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
