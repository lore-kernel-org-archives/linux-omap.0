From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Fri, 12 Jan 2018 11:00:46 -0800
Message-ID: <20180112190046.GD4821@atomide.com>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112012019.GA4059@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180112 01:20]:
> * Andrew Morton <akpm@linux-foundation.org> [180112 00:45]:
> > On Thu, 11 Jan 2018 16:23:22 -0800 Tony Lindgren <tony@atomide.com> wrote:
> > 
> > > * Andrew Morton <akpm@linux-foundation.org> [180112 00:18]:
> > > > On Thu, 11 Jan 2018 16:01:13 -0800 Tony Lindgren <tony@atomide.com> wrote:
> > > > 
> > > > > Hi all,
> > > > > 
> > > > > I'm seeing a considerable idle power consumption regression in
> > > > > Linux next, with power consumption for my idle test system going
> > > > > to 17.5mW compared to the usual 8mW on my test device.
> > > > > 
> > > > > Git bisect points to merge commit e130bc1d00a4 ("Merge branch
> > > > > 'akpm-current/current'") being the first bad commit.
> > > > > 
> > > > > I have also verified that commit 70286688e5ad ("ipc/mqueue.c:
> > > > > have RT tasks queue in by priority in wq_add()") is good, and
> > > > > commit e2d7fe89e8ae ("Merge remote-tracking branch
> > > > > 'init_task/init_task'") is good.
> > > > 
> > > > Do you mean that everything up to and including 70286688e5ad
> > > > ("ipc/mqueue.c: have RT tasks queue in by priority in wq_add()") is
> > > > good?
> > > 
> > > Yes I'm not seeing the regression in your branch at commit
> > > 70286688e5ad. I'm seeing it only with the merge commit
> > > e130bc1d00a4.
> > > 
> > 
> > That's weird.  All I'm seeing between 70286688e5ad and end-of-mm is:
...

> Well there are some changes in merge commit e130bc1d00a4..

So it seems that the Makefile changes in Linux next merge commit
e130bc1d00a4 cause changes with CONFIG_CC_STACKPROTECTOR_AUTO=y.
With next-20180112 out now, that's now commit  3823b7cc7a5e
("Merge branch 'akpm-current/current'"). Not sure if that's a
bug or not..

Anyways, I reran my "bisect boot wait-idle measure" test with
CONFIG_CC_STACKPROTECTOR_STRONG=y selected to rule out the AUTO
option, and bisect now points to a different commit that makes
more sense for my test case.

It's commit 3bb0f7c31b1a ("ASoC: don't use snd_soc_write/read
on twl4030"). And that is for the PMIC on my test system, so
adding Kuninori and Mark to the thread :)

Kuninori, it seems that commit 3bb0f7c31b1a causes higher
power consumption on an idle system on omap3 using twl4030.
Reverting 3bb0f7c31b1a makes things behave again. My guess
is that twl4030_read does not do the same as snd_soc_read
in the driver?

Regards,

Tony
