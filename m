From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP completely
Date: Fri, 12 Sep 2014 12:46:11 +0200
Message-ID: <1410518771.31130.22.camel@x220>
References: <1406551632.5397.17.camel@x220> <1410511111.31130.4.camel@x220>
	 <CAGo_u6r3jXX2FS-PO5_-+zhHM3i3pVzGYumSYLh7YPNXGV98eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGo_u6r3jXX2FS-PO5_-+zhHM3i3pVzGYumSYLh7YPNXGV98eg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Brown <broonie@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Simon Horman <horms+renesas@verge.net.au>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Magnus Damm <magnus.damm@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2014-09-12 at 05:20 -0500, Nishanth Menon wrote:
> On Fri, Sep 12, 2014 at 3:38 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> > The Kconfig symbol ARCH_HAS_OPP became redundant in v3.16: commit
> > 049d595a4db3 ("PM / OPP: Make OPP invisible to users in Kconfig")
> > removed the only dependency that used it. Setting it had no effect
> > anymore.
> >
> > So commit 78c5e0bb145d ("PM / OPP: Remove ARCH_HAS_OPP") removed it. For
> > some reason that commit did not remove all select statements for that
> > symbol. These statements are useless. Remove them too.
> >
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > Done on top of next-20140912. Tested with git grep only!
> >
> >  arch/arm/mach-omap2/Kconfig    | 5 -----
> 
> there can be conflict here:
> https://patchwork.kernel.org/patch/4857231/
> 
> http://marc.info/?l=linux-omap&m=141047815520894&w=2

Thanks.

> >  arch/arm/mach-shmobile/Kconfig | 1 -
> >  drivers/devfreq/Kconfig        | 1 -

Were patches submitted for these two files too? If so, we can probably
just drop my patch.


Paul Bolle
