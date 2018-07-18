From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/5] net: extend eth_platform_get_mac_address()
Date: Wed, 18 Jul 2018 18:10:30 +0200
Message-ID: <20180718161035.7005-1-brgl@bgdev.pl>
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

The first patch only visually shrinks the code because this routine
will grow significantly in the next patches.

The second patch adds an info message on success so that we keep
getting notifications from users who already are verbose.

The third patch calls is_valid_ether_addr() on the read address so
that we're sure it's correct.

The last two patches add nvmem and MTD support to the function. In
order to stay compatible with existing users, nvmem and MTD will be
tried last - after device tree and arch-specific callback.

If this series gets accepted I will modify my previous patches to
use it instead of handcoding the same operations in davinci_emac.

Bartosz Golaszewski (5):
  net: visually shrink eth_platform_get_mac_address()
  net: add an info message to eth_platform_get_mac_address()
  net: fortify eth_platform_get_mac_address()
  net: add support for nvmem to eth_platform_get_mac_address()
  net: add MTD support to eth_platform_get_mac_address()

 net/ethernet/eth.c | 77 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 12 deletions(-)

-- 
2.17.1
