From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 00/29] at24: remove at24_platform_data
Date: Fri, 10 Aug 2018 09:41:49 +0100
Message-ID: <e3e2e350-f520-8af5-b5d7-6844a58ca479@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.com>, Flori
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org



On 10/08/18 09:04, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is a follow-up to the previously rejected series[1] which partially
> removed the at24_platform_data structure. After further development and
> taking reviews into account, this series finally removes that struct
> completely but not without touching many different parts of the code
> base.
> 
> Since I took over maintainership of the at24 driver I've been working
> towards removing at24_platform_data in favor for device properties.
> 
> DaVinci is the only platform that's still using it - all other users
> have already been converted.
> 
> One of the obstacles in case of DaVinci is removing the setup() callback
> from the pdata struct, the only user of which are some davinci boards.
> 
> Most boards use the EEPROM to store the MAC address. This series adds
> support for cell lookups to the nvmem framework, registers relevant
> cells for all users, adds nvmem support to eth_platform_get_mac_address(),
> converts davinci_emac driver to using it and replaces at24_platform_data
> with device properties.
> 
> There's also one board (da850-evm) which uses MTD for reading the MAC
> address. I used the patch from Alban Bedel's previous submission[2] to
> add support for nvmem to the MTD framework. Since this user doesn't
> need device tree, I dropped Alban's patches modifying the DT bindings.
> We can add that later once an agreement is reached. For the time being
> MTD devices are registered as nvmem devices and we're registering the
> mac-address cell using the cell lookup mechanism.
> 
> This series adds a blocking notifier chain to the nvmem framework, so
> that we can keep the EEPROM reading code in the mityomapl138 board file
> with only slight modifications.
> 
> I also included some minor fixes to the modified code.
> 
> Tested on da850-evm & dm365-evm.
> 
> [1] https://lkml.org/lkml/2018/6/29/153
> [2] https://lkml.org/lkml/2018/3/24/312
> 
...

> Bartosz Golaszewski (28):
>    nvmem: add support for cell lookups
>    Documentation: nvmem: document lookup entries
>    nvmem: add a notifier chain
>    nvmem: provide nvmem_dev_name()
>    nvmem: remove the name field from struct nvmem_device
> 
>   Documentation/nvmem/nvmem.txt              |  28 +++++
..
>   drivers/nvmem/core.c                       | 106 ++++++++++++++++-

nvmem parts looks good to me other then few trivial kernel doc comments!
I can either Ack those patches or Send them after rc3-4 to Greg KH as 
4.20 material.

Thanks
srini

> 
