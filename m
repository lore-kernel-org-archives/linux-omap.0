From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 00/29] at24: remove at24_platform_data
Date: Wed, 3 Oct 2018 22:30:44 +0200
Message-ID: <20181003203044.md7767we6nnjv4vh@wunner.de>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180831194643.GA62862@ban.mtv.corp.google.com>
 <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Brian Norris <computersforpeace@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, Florian Fainelli <f.fainelli>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 03, 2018 at 10:15:23PM +0200, Bartosz Golaszewski wrote:
> The only user of arch_get_platform_mac_address() is sparc. It returns
> an address that seems to be read from some kind of EEPROM. I'm not
> familiar with this arch though. I'm wondering if we could somehow
> seamlessly remove this call and then convert all users of
> eth_platform_get_mac_address() to using device_get_mac_address()?

My recollection is that '90s SparcStations had a battery-backed memory
containing the MAC address.  When the battery wore out, the machine
would fail to boot because the address was either all ones or all zeros.
I recall setting the MAC address in that memory using Forth from the
boot prompt.  Ah, the good old days!
