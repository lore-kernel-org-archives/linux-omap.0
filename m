From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 07/28] ARM: davinci: dm365-evm: use nvmem lookup for mac address
Date: Wed, 8 Aug 2018 20:43:54 +0300
Message-ID: <CAHp75VdXTS9kg5PF-YrTbi8f1U9qSKU+1D43-p0PgphKeJdVNA@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-8-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808153150.23444-8-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We now support nvmem lookups for machine code. Add a lookup for
> mac-address.

>  #include <linux/spi/spi.h>
>  #include <linux/spi/eeprom.h>
>  #include <linux/v4l2-dv-timings.h>
> +#include <linux/nvmem-provider.h>

It looks from this context that your patch broke the order.

P.S. Can you verify all in the series for this?

-- 
With Best Regards,
Andy Shevchenko
