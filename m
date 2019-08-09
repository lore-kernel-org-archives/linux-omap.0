From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/22] input: omap: void using mach/*.h headers
Date: Fri, 9 Aug 2019 13:23:23 +0200
Message-ID: <CAK8P3a1QUo=qCGMdojN2RZmpr_kmkqBcJXAOab06yRgSzz4VzQ@mail.gmail.com>
References: <20190808212234.2213262-1-arnd@arndb.de> <20190808212234.2213262-14-arnd@arndb.de>
 <20190808214257.GF178933@dtor-ws> <CAK8P3a2TOcjxwCBGkZAhMAf9HuTL=FAB1e0=FAg+oHB0U1nJ0A@mail.gmail.com>
 <20190808221950.GG178933@dtor-ws> <20190808233941.v6elo2mdji5awylu@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808233941.v6elo2mdji5awylu@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 9, 2019 at 1:39 AM Sebastian Reichel <sre@kernel.org> wrote:
> On Thu, Aug 08, 2019 at 03:19:50PM -0700, Dmitry Torokhov wrote:
> > On Thu, Aug 08, 2019 at 11:46:45PM +0200, Arnd Bergmann wrote:
> > > On Thu, Aug 8, 2019 at 11:43 PM Dmitry Torokhov wrote:
> > > > On Thu, Aug 08, 2019 at 11:22:22PM +0200, Arnd Bergmann wrote:
> > > > > By using the new linux/soc/ti/omap1-io.h header instead,
> > > > > compile-testing can be enabled, and a CONFIG_ARCH_MULTIPLATFORM
> > > > > conversion of omap1 may eventually be possible.
> > > > >
> > > > > The warning in the header file gets removed in order to
> > > > > allow CONFIG_COMPILE_TEST.
> > > >
> > > > Given that we want to migrate people off this driver everywhere but
> > > > OMAP1 I wonder why we would want to improve compile coverage of it.
> > >
> > > Mainly for consistency: I'm converting all omap1 drivers in this series to
> > > not rely on mach/* headers and to let them be compiled standalone.
> > > The other drivers don't have a replacement, so I could treat this different
> > > from the rest and skip the Kconfig and platform_data changes if you
> > > prefer.
> >
> > Yes, because at least with the version you posted we are losing the
> > #warning telling people to move to matrix_keypad. We could do:
> >
> > #ifndef CONFIG_COMPILE_TEST
> > #warning ...
> > #endif
> >
> > if you really want to allow compiling standalone for testing.

No, I'll just drop the compile-test portion and leave the warning
untouched, leaving only the header file include as a preparation
for multiplatform support then.

> FWIW the driver depends on ARCH_OMAP1 and the warning is
> only printed for !ARCH_OMAP1. In other words: The warning
> is never printed at the moment. All OMAP2+ boards moved to
> matrix-keypad long time ago and the driver does not support
> OMAP2+ anymore since f799a3d8fe170 from 2012.

Right, it also seems extremely unlikely that any new platform
would start using the header, and it also doesn't look like
anyone is interested in moving omap1 over to matrix-keypad.

       Arnd
