From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 00/18] mfd: demodularization of non-modular drivers
Date: Thu, 7 Mar 2019 08:11:40 -0800
Message-ID: <20190307161140.GJ39872@atomide.com>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
 <20190116132431.GE23399@dell>
 <20190306231003.GD7915@amd>
 <20190307041808.GK26690@windriver.com>
 <20190307082524.GB4634@dell>
 <20190307083518.GA8052@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307083518.GA8052@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee.jones@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@gnudd.com>, Arnd Bergmann <arnd@arndb.de>, Charles Keepax <ckeepax@opensource.cirrus.com>, Cory Maccarrone <darkstar6262@gmail.com>, Davide Ciminaghi <ciminaghi@gnudd.com>, Dong Aisheng <dong.aisheng@linaro.org>, Graeme Gregory <gg@slimlogic.co.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, Jin Park <jinyoungp@nvidia.com>, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mattias Nilsson <mattias.i.nilsson@stericsson.com>, Michael
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190307 08:35]:
> 
> > > Pavel, I hope this more extended explanation makes sense to you, and
> > > that you simply have not seen me write these same details in the past.
> > 
> > Blimey.  That's a really long winded way of saying:
> > 
> >   "Modular-ness is actually broken in these drivers; [Paul]'s patches
> >    make that point clear for all to see.  If people (authors/distros)
> >    wish them to be modular, they need to fix them properly."
> 
> Has that been checked?
> 
> I mean... when I saw the patch I thought "perhaps it should be doing
> bool->tristate instead"?

Thinking distors and loadable modules,  for PMICs, only regulators need
to be built-in in most cases. That's at least the case for example with
drivers/mfd/motorola-cpcap.c.

I'd say applying these patches makes sense unless we have people
step up and fix their drivers.

Regards,

Tony
