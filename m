From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/29] at24: remove at24_platform_data
Date: Thu, 4 Oct 2018 16:38:51 +0200
Message-ID: <CAK8P3a3Z7CT3tV=mMB-qZFJfyamP0kTHK2PPCbqzh-WXDNdPZA@mail.gmail.com>
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180831194643.GA62862@ban.mtv.corp.google.com>
 <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
 <a4c2e6cf-749a-83a1-0bda-43ddb7e744cd@gmail.com> <CAMRc=MfwM7vODsnuV9eKS4Uf7M5ac59u7ao7KvyaxKzPv5FRvw@mail.gmail.com>
 <CAK8P3a1LufzR1_6mXH=1zDb34VQStLywGM1w5x5CDAMh_7uMyA@mail.gmail.com> <20181004143508.GG13299@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004143508.GG13299@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Florian Fainelli <f.fainelli@gmail.com>, Brian Norris <computersforpeace@gmail.com>, David Miller <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, gregkh <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, naren.kernel@gmail.com, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 4, 2018 at 4:36 PM Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
>
> Just catching up on this thread, so please excuse any unintentional
> misquotes here.
>
> > > > > David: I couldn't find a place in sparc code where any ethernet device
> > > > > would be registered, so is there a chance that nobody is using it?
> > > >
> > > > SPARC uses a true Open Firmware implementation, so it would register
> > > > drivers through the CONFIG_OF infrastructure.
>
> correct
>
> > The calls are not even that old, and clearly added intentionally for sparc,
> > see commit ba94272d08a7 ("i40e: use eth_platform_get_mac_address()")
> > which added the first one.
>
> Yes, correct again. Wouldn't PPC also end up doing the same thing?
>
> See also commit c762dff24c06 (for ixgbe) - without this fix sparc systems
> will come up with a bogus mac address and then you end up having to
> manually fix this in ugly ways.

The of_get_mac_address() portion is not controversial at all I think,
the question was whether we need the fallback to
arch_get_platform_mac_address() in any of the drivers that
call eth_platform_get_mac_address().

      Arnd
