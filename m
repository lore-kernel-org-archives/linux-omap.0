From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers
Date: Thu, 7 Mar 2019 08:25:24 +0000
Message-ID: <20190307082524.GB4634@dell>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
 <20190116132431.GE23399@dell>
 <20190306231003.GD7915@amd>
 <20190307041808.GK26690@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307041808.GK26690@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@gnudd.com>, Arnd Bergmann <arnd@arndb.de>, Charles Keepax <ckeepax@opensource.cirrus.com>, Cory Maccarrone <darkstar6262@gmail.com>, Davide Ciminaghi <ciminaghi@gnudd.com>, Dong Aisheng <dong.aisheng@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Jin Park <jinyoungp@nvidia.com>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mattias Nilsson <mattias.i.nilsson@stericsson.com>, Michael Hennerich <michael.hennerich@analog.com>, Tony Lindgren <to>
List-Id: linux-omap@vger.kernel.org

On Wed, 06 Mar 2019, Paul Gortmaker wrote:

> [Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers] On 07/03/2019 (Thu 00:10) Pavel Machek wrote:
> 
> > On Wed 2019-01-16 13:24:31, Lee Jones wrote:
> > > [...]
> > > 
> > > > Paul Gortmaker (18):
> > > >   mfd: aat2870-core: Make it explicitly non-modular
> > > >   mfd: adp5520: Make it explicitly non-modular
> > > >   mfd: as3711: Make it explicitly non-modular
> > > >   mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
> > > >   mfd: htc-i2cpld: Make it explicitly non-modular
> > > >   mfd: max8925-core: drop unused MODULE_ tags from non-modular code
> > > >   mfd: rc5t583: Make it explicitly non-modular
> > > >   mfd: sta2x11: drop unused MODULE_ tags from non-modular code
> > > >   mfd: syscon: Make it explicitly non-modular
> > > >   mfd: tps65090: Make it explicitly non-modular
> > > >   mfd: tps65910: Make it explicitly non-modular
> > > >   mfd: tps80031: Make it explicitly non-modular
> > > >   mfd: wm831x-spi: Make it explicitly non-modular
> > > >   mfd: wm831x-i2c: Make it explicitly non-modular
> > > >   mfd: wm831x-core: drop unused module infrastructure from non-modular code
> > > >   mfd: wm8350-i2c: Make it explicitly non-modular
> > > >   mfd: wm8350-core: drop unused module infrastructure from non-modular code
> > > >   mfd: wm8400-core: Make it explicitly non-modular
> > > > 
> > > >  drivers/mfd/aat2870-core.c      | 40 +++-------------------------------------
> > > >  drivers/mfd/adp5520.c           | 30 +++++++-----------------------
> > > >  drivers/mfd/as3711.c            | 14 --------------
> > > >  drivers/mfd/db8500-prcmu.c      | 10 ++++------
> > > >  drivers/mfd/htc-i2cpld.c        | 18 +-----------------
> > > >  20 files changed, 41 insertions(+), 332 deletions(-)
> > > 
> > > All applied!
> > 
> > Is it good idea?
> 
> Pavel, I think yes it is good, and I hope you will allow me the chance
> to convince you of the same.  It removes dead code, and removes the
> chance that people mistakenly believe any of these drivers were
> currently possible as modules, when they were really NOT at all modular.
> 
> > We want distro kernels on ARM, too, which means people will eventually
> > want these as a modules, no?
> 
> And at the risk of repeating something I've said a lot already, this
> is fine, and I 100% support people converting drivers to being modular,
> in the case where there is demand, and where people with the hardware
> who are willing to test that the modular use-case actually works.
> 
> If people want it to be modular, then this work actually helps.  You
> don't have drivers "hiding in the shadows" that pretend to be modules.
> Such drivers do not at all help with the "distro kernels" use case.
> 
> If a driver author responds and says they intended to make their driver
> a module, I 100% support them, and will drop the code removal patch and
> also have supported them in making their work tristate.  If the choice
> to convert to tristate happens a year or more from now, it is trivial to
> reclaim the unused-but-deleted code from git.
> 
> But, again as I have said many times -- I can't know every detail of
> each driver to know if module/tristate makes any sense, as a use-case or
> if even technically possible (such as in DMA/IOMMU or similar low level
> core systems).   So the right option is to remove the dead code and not
> impact the existing driver behaviour, and make it clear in the process
> to the authors and users, that the driver was never modular to begin
> with --  and in doing so, give them all a chance to comment and react.
> 
> Pavel, I hope this more extended explanation makes sense to you, and
> that you simply have not seen me write these same details in the past.

Blimey.  That's a really long winded way of saying:

  "Modular-ness is actually broken in these drivers; [Paul]'s patches
   make that point clear for all to see.  If people (authors/distros)
   wish them to be modular, they need to fix them properly."

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
