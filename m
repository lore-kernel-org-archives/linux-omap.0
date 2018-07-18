From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/5] net: add an info message to
 eth_platform_get_mac_address()
Date: Wed, 18 Jul 2018 18:31:09 +0200
Message-ID: <20180718163109.GB12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180718161035.7005-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 18, 2018 at 06:10:32PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Many drivers that read the MAC address from EEPROM or MTD emit a log
> message when they succeed. Since this function is meant to be reused
> in those drivers instead of reimplementing the same operation
> everywhere, add an info message when we successfully read the MAC
> address.

Hi Bartosz

This makes eth_platform_get_mac_address() generally more verbose,
which i guess people won't like. To keep it backwards compatible, it
would be better to issue the message just when EEPROM to MTD is used.

      Andrew
