From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 13/22] input: omap: void using mach/*.h headers
Date: Thu, 8 Aug 2019 15:19:50 -0700
Message-ID: <20190808221950.GG178933@dtor-ws>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-14-arnd@arndb.de>
 <20190808214257.GF178933@dtor-ws>
 <CAK8P3a2TOcjxwCBGkZAhMAf9HuTL=FAB1e0=FAg+oHB0U1nJ0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2TOcjxwCBGkZAhMAf9HuTL=FAB1e0=FAg+oHB0U1nJ0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 08, 2019 at 11:46:45PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 8, 2019 at 11:43 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Arnd,
> >
> > On Thu, Aug 08, 2019 at 11:22:22PM +0200, Arnd Bergmann wrote:
> > > By using the new linux/soc/ti/omap1-io.h header instead,
> > > compile-testing can be enabled, and a CONFIG_ARCH_MULTIPLATFORM
> > > conversion of omap1 may eventually be possible.
> > >
> > > The warning in the header file gets removed in order to
> > > allow CONFIG_COMPILE_TEST.
> >
> > Given that we want to migrate people off this driver everywhere but
> > OMAP1 I wonder why we would want to improve compile coverage of it.
> 
> Mainly for consistency: I'm converting all omap1 drivers in this series to
> not rely on mach/* headers and to let them be compiled standalone.
> The other drivers don't have a replacement, so I could treat this different
> from the rest and skip the Kconfig and platform_data changes if you
> prefer.

Yes, because at least with the version you posted we are losing the
#warning telling people to move to matrix_keypad. We could do:

#ifndef CONFIG_COMPILE_TEST
#warning ...
#endif

if you really want to allow compiling standalone for testing.

Thanks.

-- 
Dmitry
