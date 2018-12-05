From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
Date: Wed, 5 Dec 2018 12:48:47 +0100
Message-ID: <CACRpkdZs0uSrsY66X67=h=BPy=P_5korWVM8kDbzTXrhrvKvcQ@mail.gmail.com>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com> <20181205113535.GX16508@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205113535.GX16508@imbe.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Cory Maccarrone <darkstar6262@gmail.com>, David Dajun Chen <dchen@diasemi.com>, Dong Aisheng <dong.aisheng@linaro.org>, Eric Miao <eric.miao@marvell.com>, Graeme Gregory <gg@slimlogic.co.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, jinyoungp@nvidia.com, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mattias NILSSON <mattias.i.nilsson@stericsson.com>, Michael Hennerich <michael.hennerich@analog.com>, Mike Rapoport <mike@compulab.co.il>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 5, 2018 at 12:36 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Sun, Dec 02, 2018 at 11:23:07PM -0500, Paul Gortmaker wrote:
> > The solution to #4 is similar - we delete the ".remove" function and
> > the binding into the platform_driver struct.  However, since the same
> > ".remove" function could also be triggered by an "unbind" (such as for
> > pass-through of a device to a guest instance)  - so we also explicitly
> > disable any unbind for the driver.
> >
> > The unbind mask allows us to ensure we will see if there was some odd
> > corner case out there that was relying on it.  Typically it would be a
> > multi-port ethernet card passing a port through to a guest, so a
> > sensible use case in MFD drivers seems highly unlikely.  This same
> > solution has already been used in multiple other mainline subsystems.
> >
>
> I guess if this is a general direction thing, but it does seem
> that module unload is not the only reason one might ever unbind a
> driver. So are we sure we want to remove the option to unbind
> these drivers? Certainly for testing it is sometimes useful.

I personally never understood why these attributes are even
present on non-modular drivers.

If testing is about exercising unbind/bind to reintialize
the code through a new call to .probe(), why would the developer
not take it all the way through and make it a module?
It just looks like a half-measure.

Yours,
Linus Walleij
