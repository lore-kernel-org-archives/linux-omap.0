From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 0/2] of: mdio: Fall back to
 mdiobus_register() with NULL device_node
Date: Wed, 16 May 2018 14:27:52 +0200
Message-ID: <20180516122752.GC22000@lunn.ch>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
 <CAMuHMdXfOOgADe1my9Y3s3b9_OsXPjbqq1PPFR9izZWhtPuaFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXfOOgADe1my9Y3s3b9_OsXPjbqq1PPFR9izZWhtPuaFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev <netdev@vger.kernel.org>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Fugang Duan <fugang.duan@nxp.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Woojung Huh <woojung.huh@microchip.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Russell
List-Id: linux-omap@vger.kernel.org

On Wed, May 16, 2018 at 10:54:12AM +0200, Geert Uytterhoeven wrote:
> Hi Florian,
> 
> Thanks for your series!
> I like the effect on simplifying drivers.
> 
> On Wed, May 16, 2018 at 1:56 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > This patch series updates of_mdiobus_register() such that when the device_node
> > argument is NULL, it calls mdiobus_register() directly. This is consistent with
> > the behavior of of_mdiobus_register() when CONFIG_OF=n.
> 
> IMHO the CONFIG_OF=n behavior of of_mdiobus_register() (which I wasn't
> aware of) is inconsistent with the behavior of other of_*() functions,
> which are just empty stubs.
> 
> So I'm wondering if you should do it the other way around, and let
> mdiobus_register() call of_mdiobus_register() if dev->of_node exists?

Hi Geert

dev->of_node is often not the correct OF node. The mdio properties are
often embedded inside a MAC driver, and use an 'mdio' container
node. This container node is needed, not the device node.

> I haven't looked at the ACPI handling, but perhaps this can be moved
> inside mdiobus_register() as well?

The ACPI binding for MDIO and PHYs has not been defined yet.

    Andrew
