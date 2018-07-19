From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 0/3] net: extend eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 17:32:40 +0200
Message-ID: <20180719153243.20944-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-omap@vger.kernel.org

This is a follow-up to a series I posted a while ago the goal of which
was to replace the at24 platform data with device properties. To do so
we need to somehow remove reading the MAC address from relevant board
files.

In my patches I used nvmem and MTD to read the MAC address from within
the davinci emac driver. It was suggested that we generalize it further
but since MTD doesn't support nvmem yet, the best we can do is to move
this code over to net core code.

The following patches modify the eth_platform_get_mac_address()
function which seems to be the best candidate for this code.

The first patch splits the function into two subroutines.

The last two patches add nvmem and MTD support to the function. In
order to stay compatible with existing users, nvmem and MTD will be
tried last - after device tree and arch-specific callback.

If this series gets accepted I will modify my previous patches to
use it instead of handcoding the same operations in davinci_emac.

v1 -> v2:
- dropped patches 1 & 2
- improved the MAC address verification and fixed a potential buffer
  overflow in patch 2/3

v2 -> v3:
- in patch 1: split the function into subroutines in preparation
  for nvmem and MTD support
- modify patches 2 & 3 so that they have a separate function for
  each new MAC address source

Bartosz Golaszewski (3):
  net: split eth_platform_get_mac_address() into subroutines
  net: add support for nvmem to eth_platform_get_mac_address()
  net: add MTD support to eth_platform_get_mac_address()

 net/ethernet/eth.c | 117 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 11 deletions(-)

-- 
2.17.1
