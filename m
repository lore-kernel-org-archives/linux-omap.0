From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 00/14] ARM: davinci: step towards removing
 at24_platform_data
Date: Mon, 25 Jun 2018 19:40:24 +0200
Message-ID: <20180625174024.GB17417@lunn.ch>
References: <20180625155025.12567-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lukas Wunner <lukas@wunner.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 25, 2018 at 05:50:11PM +0200, Bartosz Golaszewski wrote:
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

Hi Bartosz

Nice code.

I've got a platform i want to add sometime soon using the at24. I
noticed you doing the cleanup, so i avoided the setup() call. But
using it would of helped...

My platform is x86 based, so no device tree. I instantiate a number of
AT24 devices from a platform driver, and then add nvmem cells so i can
access data in these eeproms. This new code will make this simpler.

> The only board that's still using this callback is now mityomapl138.
> Unfortunately it stores more info in EEPROM than just the MAC address
> and will require some more work. Unfortunately I don't have access
> to this board so I can't test any actual solutions on a live hardware.

Depending on what i find in the EEPROM, i need to instantiate other
i2c devices. So i have the problem of knowing when the EEPROM has
actually probed and i can use the nvmem API to retrieve the contents.

What i have done so far, is registers a bus notifier on i2c_bus_type,
and look for BUS_NOTIFY_BOUND_DRIVER. I can then check if the i2c
client in the notifier is the at24 client. But when i then add more
i2c clients from inside the notifier i get lockdep splats. They are
false positives, but it does suggest it is not a good idea to do this.

So it would be good to have some sort of recommended alternative to
the setup() callback. Ideally it would be specific to a particular
at24, and safe to call other i2c functions from.

Do you have any ideas?

   Andrew
