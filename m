From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 5/5] net: add MTD support to
 eth_platform_get_mac_address()
Date: Fri, 20 Jul 2018 16:15:30 +0200
Message-ID: <20180720141530.GA1034@lunn.ch>
References: <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch>
 <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
 <20180718170352.GF12477@lunn.ch>
 <CAMRc=Md3oeEktzrA9UZyNPX6pB4bG+Gv0o6cjbs0UUKb3sYTsA@mail.gmail.com>
 <20180719150138.GC9119@lunn.ch>
 <CAMRc=MfKedvD2OXes02op2ErGR2HKkzJwjHtv5i4NkbJAVg3dw@mail.gmail.com>
 <20180719152712.GE9119@lunn.ch>
 <CAMRc=MeqnRXF_R1J5G8ySvCr8pZhZMHiV3WHNFun=d8GjiOT9A@mail.gmail.com>
 <0355bdd8-f544-c462-99e8-da94488067bb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0355bdd8-f544-c462-99e8-da94488067bb@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 20, 2018 at 10:47:51AM +0530, Sekhar Nori wrote:
> On Thursday 19 July 2018 09:05 PM, Bartosz Golaszewski wrote:
> > 2018-07-19 17:27 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> >>> Unfortunately: this would effectively block me from improving the
> >>> support for older davinci boards.
> >>
> >> Is there something blocking you from converting the board to device
> >> tree? This is something i did with a lot of the Marvell boards a few
> >> years ago. For a while, we had both DT and board setup files. After a
> >> couple of cycles, we killed off the setup files.
> >>
> >>        Andrew
> > 
> > Actually some board are supported both in DT and board files
> > (da850-evm) right now, but Sekhar wants to keep the support via board
> > files in the kernel so that's a no go.
> 
> Its not that I want it that way, but we cannot get rid of board files
> till DT has equivalent support.
> 
> The bigger issue is not on DA850, but on the 5 older DaVinci SoCs which
> do not support device-tree based boot today.

The nice thing about board files is they keep any ugly code near to
where it is needed. The proposal here is to put some 'temporary' code
in the net core. And it is assumed at some point somebody will write
nvmem over MTD, which can be used to replace this temporary code, but
that in itself needs an ugly list of special cases when using board
files?

I would prefer somebody just did the work to convert these 5 boards to
DT, with a clean design of how nvmem over MTD would work. Having
converted a number of Marvell boards to DT, i have an idea of the
effort required. If most of the drivers already support DT, it can be
done quickly. So the big job here is probably nvmem over MTD.

     Andrew
