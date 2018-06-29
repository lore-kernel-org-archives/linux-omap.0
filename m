From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 00/18] ARM: davinci: step towards removing at24_platform_data
Date: Fri, 29 Jun 2018 11:42:23 +0200
Message-ID: <CAMRc=MdPhiqqCQUm0JAANeZeqMJajdDVfHPLv=xWtO7T0cnDCw@mail.gmail.com>
References: <20180628143244.4561-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

2018-06-28 16:32 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
> cells for all users, converts the davinci_emac driver to using them
> and replaces at24_platform_data with device properties.
>
> The only board that's still using this callback is now mityomapl138.
> Unfortunately it stores more info in EEPROM than just the MAC address
> and will require some more work. Unfortunately I don't have access
> to this board so I can't test any actual solutions on a live hardware.
>
> Tested on a dm365-evm board.
>
> v1 -> v2:
> - for backward compatiblity: fall back to using of_get_mac_address() if
>   we can't get an nvmem cell in patch 7
> - add patch 15 which removes dead code
>
> v2 -> v3:
> - documented new nvmem cell lookup API
> - renamed the nvmem cell lookup routines
> - in order to completly remove the mac_addr from davinci's soc_info
>   added a patch that moves reading the MAC address from SPI to the emac
>   driver
> - removed more dead code
>
> Bartosz Golaszewski (18):
>   nvmem: add support for cell lookups
>   Documentation: nvmem: document lookup entries
>   ARM: davinci: dm365-evm: use nvmem lookup for mac address
>   ARM: davinci: dm644-evm: use nvmem lookup for mac address
>   ARM: davinci: dm646x-evm: use nvmem lookup for mac address
>   ARM: davinci: da830-evm: use nvmem lookup for mac address
>   ARM: davinci: mityomapl138: add nvmem cells lookup entries
>   net: davinci_emac: potentially get the MAC address from MTD
>   ARM: davinci: da850-evm: remove dead MTD code
>   net: davinci_emac: use nvmem to retrieve the mac address
>   ARM: davinci: mityomapl138: don't read the MAC address from machine
>     code
>   ARM: davinci: dm365-evm: use device properties for at24 eeprom
>   ARM: davinci: da830-evm: use device properties for at24 eeprom
>   ARM: davinci: dm644x-evm: use device properties for at24 eeprom
>   ARM: davinci: dm646x-evm: use device properties for at24 eeprom
>   ARM: davinci: sffsdr: fix the at24 eeprom device name
>   ARM: davinci: sffsdr: use device properties for at24 eeprom
>   ARM: davinci: remove dead code related to MAC address reading
>
>  Documentation/nvmem/nvmem.txt              | 28 ++++++++
>  arch/arm/mach-davinci/board-da830-evm.c    | 25 +++++---
>  arch/arm/mach-davinci/board-da850-evm.c    | 28 --------
>  arch/arm/mach-davinci/board-dm365-evm.c    | 25 +++++---
>  arch/arm/mach-davinci/board-dm644x-evm.c   | 24 ++++---
>  arch/arm/mach-davinci/board-dm646x-evm.c   | 25 +++++---
>  arch/arm/mach-davinci/board-mityomapl138.c | 30 ++++++---
>  arch/arm/mach-davinci/board-sffsdr.c       | 13 ++--
>  arch/arm/mach-davinci/common.c             | 15 -----
>  drivers/net/ethernet/ti/davinci_emac.c     | 50 ++++++++++++---
>  drivers/nvmem/core.c                       | 75 +++++++++++++++++++++-
>  include/linux/davinci_emac.h               |  2 -
>  include/linux/nvmem-consumer.h             |  6 ++
>  include/linux/nvmem-provider.h             | 10 +++
>  14 files changed, 253 insertions(+), 103 deletions(-)
>
> --
> 2.17.1
>

Superseded by v4 - I noticed some more issues with the series that
needed fixing.

Bart
