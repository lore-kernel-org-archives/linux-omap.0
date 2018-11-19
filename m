From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 00/25] at24: remove
Date: Mon, 19 Nov 2018 09:58:46 +0100
Message-ID: <CAMRc=MfXWW9siNZNkocxmTU7mnoQO0KpeHQ3JmLcEfNscqCbDQ@mail.gmail.com>
References: <20181113140133.17385-1-brgl@bgdev.pl> <20181118170329.788778a8@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181118170329.788778a8@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Nicolas Ferre <nicolas.ferre@microchip.com>, "David S . Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, netdev
List-Id: linux-omap@vger.kernel.org

niedz., 18 lis 2018 o 17:03 Boris Brezillon
<boris.brezillon@bootlin.com> napisa=C5=82(a):
>
> On Tue, 13 Nov 2018 15:01:08 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > As far as merging of this series goes: I'd like to avoid dragging it ov=
er
> > four releases. The series is logically split into five groups:
> >
> > patches 1-2: nvmem and mtd changes
> > patches 3-9: davinci arch-specific changes
> > patches 10-13: networking changes
> > patches 14-24: davinci specific again
> > patch 25: final at24 change
> >
> > With that I believe we can do the following: Greg KH could pick up the
> > first two patches into his char-misc tree.
>
> The char-misc tree? Why not the MTD or NVMEM tree?
>

There is no NVMEM tree - Srinivas sends his patches to Greg to be
applied to char-misc.

The second patch depends on the first one so in order to avoid more
merging problems I suggested that the MTD patch go through char-misc
as well. If you see a better solution, please let me know.

Bart
