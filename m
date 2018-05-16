From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH net-next v2 0/2] of: mdio: Fall back to mdiobus_register()
 with NULL device_node
Date: Wed, 16 May 2018 10:54:12 +0200
Message-ID: <CAMuHMdXfOOgADe1my9Y3s3b9_OsXPjbqq1PPFR9izZWhtPuaFg@mail.gmail.com>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515235619.27773-1-f.fainelli@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Fugang Duan <fugang.duan@nxp.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Woojung Huh <woojung.huh@microchip.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Russell King <rmk+kernel@armlin>
List-Id: linux-omap@vger.kernel.org

Hi Florian,

Thanks for your series!
I like the effect on simplifying drivers.

On Wed, May 16, 2018 at 1:56 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> This patch series updates of_mdiobus_register() such that when the device_node
> argument is NULL, it calls mdiobus_register() directly. This is consistent with
> the behavior of of_mdiobus_register() when CONFIG_OF=n.

IMHO the CONFIG_OF=n behavior of of_mdiobus_register() (which I wasn't
aware of) is inconsistent with the behavior of other of_*() functions,
which are just empty stubs.

So I'm wondering if you should do it the other way around, and let
mdiobus_register() call of_mdiobus_register() if dev->of_node exists?

This does mean mdiobus_register() should gain a struct device * parameter,
and thus changes to many more drivers are needed.

> I only converted the most obvious drivers, there are others that have a much
> less obvious behavior and specifically attempt to deal with CONFIG_ACPI.

I haven't looked at the ACPI handling, but perhaps this can be moved
inside mdiobus_register() as well?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
