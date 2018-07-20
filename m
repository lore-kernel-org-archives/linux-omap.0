From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 3/3] net: add MTD support to
 eth_platform_get_mac_address()
Date: Fri, 20 Jul 2018 16:28:31 +0200
Message-ID: <20180720142831.GB1034@lunn.ch>
References: <20180719153243.20944-1-brgl@bgdev.pl>
 <20180719153243.20944-4-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180719153243.20944-4-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 19, 2018 at 05:32:43PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> MTD doesn't support nvmem yet. Some platforms use MTD to read the MAC
> address from SPI flash. If we want this function to generalize reading
> the MAC address, we need to separately try to use MTD.

How many board files are doing this? It is only worth generlizing if
there are a number of board files, all just pulling 6 bytes out from
the beginning of an MTD partition.

It is also normal to actually add a user of a new feature at the same
time as the new feature. It can be messy when it is across subsystem
boundaries, but please at least try.

    Andrew
