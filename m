From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
Date: Mon, 16 Jul 2018 14:10:05 +0200
Message-ID: <20180716121005.GA23309@kroah.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
 <20180704070919.GA14051@lenoch>
 <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
 <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
 <CAMRc=McO8H9Aw8a7h318a=hJjKBOgeC+9_hreBnOY3Tc3Fh7sg@mail.gmail.com>
 <d7f03763-982f-5e3e-d0ad-54e024b10f97@ti.com>
 <a70aebb0-408c-c61f-897a-227114888585@linaro.org>
 <3b53a8a7-3f3a-4341-35b0-e7b52854fa9b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3b53a8a7-3f3a-4341-35b0-e7b52854fa9b@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Ladislav Michl <ladis@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.orgBartosz Golaszewski <bg>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 16, 2018 at 05:27:00PM +0530, Sekhar Nori wrote:
> On Monday 16 July 2018 02:26 PM, Srinivas Kandagatla wrote:
> > 
> > 
> > On 16/07/18 09:50, Sekhar Nori wrote:
> >> On Friday 13 July 2018 11:30 PM, Bartosz Golaszewski wrote:
> >>
> >>> We're getting close to rc5 so I'd like to make a case for this series
> >>> again.
> >>>
> >>> I understand that there's more to do than just the changes introduced
> >>> here, but we shouldn't try to fix several problems in many different
> >>> places at once. There's just too many moving pieces. I'd rather start
> >>> merging small improvements right away.
> >>>
> >>> The idea behind this series is to remove (almost) all users of
> >>> at24_platform_data. The davinci_emac patches are there only because we
> >>> need to remove some MAC adress reading stuff from the board files.
> >>> Having this code there and calling it back from EEPROM/MTD drivers is
> >>> already wrong and we should work towards using nvmem for that anyway.
> >>>
> >>> Currently for MTD the nvmem support series seems to be dead and it's
> >>> going to take some time before anything gets upstream.
> >>>
> >>> So I'd like to again ask you to consider picking up the patches from
> >>> this series to your respective trees or at the very least: I'd like to
> >>> ask Srinivas to pick up the nvmem patches and Sekhar to take the
> >>> first, non-controversial batch of davinci platform changes so that
> >>> we'll have less code to carry for the next release.
> >>
> >> I think those are patches 3-7. I can take those if I get an immutable
> >> commit over v4.18-rc1 from Srinivas with patches 1 & 2 applied.
> 
> > nvmem patches go via Greg KH char-misc tree, if it makes things easy I
> > can provide Ack on nvmem patches, so that you can take these patches via
> > your tree?
> > 
> > Let me know.
> 
> I can do that.
> 
> Greg, are you fine with this? It will be great to have your ack for
> patches 1/8 and 2/18.

I'm not the nvmem maintainer :)
