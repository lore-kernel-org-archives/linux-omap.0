From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 14/28] net: split eth_platform_get_mac_address() into subroutines
Date: Thu, 9 Aug 2018 13:12:47 +0200
Message-ID: <CAMRc=MfgoCt1BvRx1jJrYp_258_Z9NTNs7waEiOCvdTsK+KWFg@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-15-brgl@bgdev.pl>
 <CAHp75VfxVOPzAtBgTe4RSax1Ki+323WDBTSmh=j7LV_c+vsXDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfxVOPzAtBgTe4RSax1Ki+323WDBTSmh=j7LV_c+vsXDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
List-Id: linux-omap@vger.kernel.org

2018-08-08 19:50 GMT+02:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We want do add more sources from which to read the MAC address. In
>> order to avoid bloating this function too much, start by splitting it
>> into subroutines, each of which takes care of reading the MAC from
>> one source.
>
>> +static int mac_address_from_of(struct device *dev, u8 *mac_addr)
>>  {
>>         const unsigned char *addr;
>> +       struct device_node *np;
>>
>
>> +       np = dev_is_pci(dev) ? pci_device_to_OF_node(to_pci_dev(dev))
>> +                            : dev->of_node;
>
> I didn't get these manipulations.
>
> What the scenario when pci_dev->dev.of_node != dev->of_node?
>
> --
> With Best Regards,
> Andy Shevchenko

I'll add an additional patch that addresses it.

Bart
