From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 00/29] at24: remove at24_platform_data
Date: Fri, 10 Aug 2018 10:04:57 +0200
Message-ID: <20180810080526.27207-1-brgl@bgdev.pl>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to the previously rejected series[1] which partially
removed the at24_platform_data structure. After further development and
taking reviews into account, this series finally removes that struct
completely but not without touching many different parts of the code
base.

Since I took over maintainership of the at24 driver I've been working
towards removing at24_platform_data in favor for device properties.

DaVinci is the only platform that's still using it - all other users
have already been converted.

One of the obstacles in case of DaVinci is removing the setup() callback
from the pdata struct, the only user of which are some davinci boards.

Most boards use the EEPROM to store the MAC address. This series adds
support for cell lookups to the nvmem framework, registers relevant
cells for all users, adds nvmem support to eth_platform_get_mac_address(),
converts davinci_emac driver to using it and replaces at24_platform_data
with device properties.

There's also one board (da850-evm) which uses MTD for reading the MAC
address. I used the patch from Alban Bedel's previous submission[2] to
add support for nvmem to the MTD framework. Since this user doesn't
need device tree, I dropped Alban's patches modifying the DT bindings.
We can add that later once an agreement is reached. For the time being
MTD devices are registered as nvmem devices and we're registering the
mac-address cell using the cell lookup mechanism.

This series adds a blocking notifier chain to the nvmem framework, so
that we can keep the EEPROM reading code in the mityomapl138 board file
with only slight modifications.

I also included some minor fixes to the modified code.

Tested on da850-evm & dm365-evm.

[1] https://lkml.org/lkml/2018/6/29/153
[2] https://lkml.org/lkml/2018/3/24/312

v1 -> v2:

  PATCH 4/29:
  - change name to nvmem_dev_name()
  - return NULL instead of ERR_PTR(-ENOSYS) from nvmem_dev_name() if nvmem is
    not configured

  PATCH 5/29:
  - s/nvmem_device_name/nvmem_dev_name/

  PATCH 6/29:
  - fix the commit message: remove the part mentioning the OF systems

  PATCH 7/29:
  - fix ordering of includes

  PATCH 8/29:
  - fix ordering of includes

  PATCH 9/29:
  - fix ordering of includes

  PATCH 10/29:
  - fix ordering of includes

  PATCH 11/29:
  - fix ordering of includes

  PATCH 14/29:
  - new patch

  PATCH 22/29:
  - added missing terminator

  PATCH 25/29:
  - removed unneeded coma

  PATCH 27/29:
  - s/nvmem_device_name/nvmem_dev_name/
  - fix ordering of includes

  PATCH 28/29:
  - added missing terminator

Alban Bedel (1):
  mtd: Add support for reading MTD devices via the nvmem API

Bartosz Golaszewski (28):
  nvmem: add support for cell lookups
  Documentation: nvmem: document lookup entries
  nvmem: add a notifier chain
  nvmem: provide nvmem_dev_name()
  nvmem: remove the name field from struct nvmem_device
  ARM: davinci: dm365-evm: use nvmem lookup for mac address
  ARM: davinci: dm644-evm: use nvmem lookup for mac address
  ARM: davinci: dm646x-evm: use nvmem lookup for mac address
  ARM: davinci: da830-evm: use nvmem lookup for mac address
  ARM: davinci: mityomapl138: add nvmem cells lookup entries
  ARM: davinci: da850-evm: use nvmem lookup for mac address
  ARM: davinci: da850-evm: remove unnecessary include
  net: simplify eth_platform_get_mac_address()
  net: split eth_platform_get_mac_address() into subroutines
  net: add support for nvmem to eth_platform_get_mac_address()
  net: davinci_emac: use eth_platform_get_mac_address()
  ARM: davinci: da850-evm: remove dead MTD code
  ARM: davinci: mityomapl138: don't read the MAC address from machine
    code
  ARM: davinci: dm365-evm: use device properties for at24 eeprom
  ARM: davinci: da830-evm: use device properties for at24 eeprom
  ARM: davinci: dm644x-evm: use device properties for at24 eeprom
  ARM: davinci: dm646x-evm: use device properties for at24 eeprom
  ARM: davinci: sffsdr: fix the at24 eeprom device name
  ARM: davinci: sffsdr: use device properties for at24 eeprom
  ARM: davinci: remove dead code related to MAC address reading
  ARM: davinci: mityomapl138: use nvmem notifiers
  ARM: davinci: mityomapl138: use device properties for at24 eeprom
  eeprom: at24: kill at24_platform_data

 Documentation/nvmem/nvmem.txt              |  28 +++++
 MAINTAINERS                                |   1 -
 arch/arm/mach-davinci/board-da830-evm.c    |  25 ++--
 arch/arm/mach-davinci/board-da850-evm.c    |  45 +++-----
 arch/arm/mach-davinci/board-dm365-evm.c    |  25 ++--
 arch/arm/mach-davinci/board-dm644x-evm.c   |  25 ++--
 arch/arm/mach-davinci/board-dm646x-evm.c   |  25 ++--
 arch/arm/mach-davinci/board-mityomapl138.c |  60 +++++++---
 arch/arm/mach-davinci/board-sffsdr.c       |  13 +--
 arch/arm/mach-davinci/common.c             |  15 ---
 drivers/misc/eeprom/at24.c                 | 127 +++++++++------------
 drivers/mtd/Kconfig                        |   1 +
 drivers/mtd/mtdcore.c                      |  50 ++++++++
 drivers/net/ethernet/ti/davinci_emac.c     |  12 +-
 drivers/nvmem/core.c                       | 106 ++++++++++++++++-
 include/linux/davinci_emac.h               |   2 -
 include/linux/mtd/mtd.h                    |   2 +
 include/linux/nvmem-consumer.h             |  31 +++++
 include/linux/nvmem-provider.h             |  10 ++
 include/linux/platform_data/at24.h         |  60 ----------
 net/ethernet/eth.c                         |  84 ++++++++++++--
 21 files changed, 492 insertions(+), 255 deletions(-)
 delete mode 100644 include/linux/platform_data/at24.h

-- 
2.18.0
