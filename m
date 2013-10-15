From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL 3/6] omap hwmod changes for v3.13 merge window
Date: Tue, 15 Oct 2013 07:28:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310150720030.4461@utopia.booyaka.com>
References: <5258a9a6.4a17e00a.5fb3.ffff9bf3SMTPIN_ADDED_MISSING@mx.google.com> <87a9ib4gmb.fsf@linaro.org> <20131015041130.GB25997@quad.lixom.net> <CAGa+x84a2b4DWqu0YT=NVt_SMYpyPkL1ZdzTXnocoZZjNzi9mw@mail.gmail.com>
 <CAOesGMiob0maOAG0pirB_0Rj2EeA-2ao++ZGf4Zg7SVbcmcOpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47552 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab3JOH2S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Oct 2013 03:28:18 -0400
In-Reply-To: <CAOesGMiob0maOAG0pirB_0Rj2EeA-2ao++ZGf4Zg7SVbcmcOpA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>, s-anna@ti.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi folks

On Mon, 14 Oct 2013, Olof Johansson wrote:

> On Mon, Oct 14, 2013 at 9:25 PM, Kevin Hilman <khilman@linaro.org> wrote:
> >
> > On Oct 14, 2013 9:12 PM, "Olof Johansson" <olof@lixom.net> wrote:
> >>
> >> On Mon, Oct 14, 2013 at 03:44:44PM -0700, Kevin Hilman wrote:
> >> > Tony Lindgren <tony@atomide.com> writes:
> >> >
> >> > > The following changes since commit
> >> > > d0e639c9e06d44e713170031fe05fb60ebe680af:
> >> > >
> >> > >   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
> >> > >
> >> > > are available in the git repository at:
> >> > >
> >> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap
> >> > > tags/omap-for-v3.13/hwmod-signed
> >> > >
> >> > > for you to fetch changes up to
> >> > > 254f57a92987b6cde6004f58d6b847813dfb9e0e:
> >> > >
> >> > >   ARM: OMAP5: hwmod: add missing ocp2scp hwmod data (2013-10-11
> >> > > 15:37:05 -0700)
> >> > >
> >> > > ----------------------------------------------------------------
> >> > > omap hwmod related changes via Paul Walmsley <paul@pwsan.com>:
> >> > >
> >> > > Some OMAP hwmod changes for 3.13.  Significant changes here include:
> >> > >
> >> > > - support for moving some of the hwmod flags to DT data
> >> > >
> >> > > - support for the SSI, hardware spinlock, USB host/TLL, and RNG IP
> >> > >   blocks for various OMAPs
> >> > >
> >> > > - a fix that again decouples hwmod data changes from unrelated DT data
> >> > >   patchsets
> >> > >
> >> > > Basic test logs are available at:
> >> > >
> >> > > http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/
> >> > >
> >> > > ----------------------------------------------------------------
> >> >
> >> > Pulled into next/soc,
> >> >
> >> > Thanks,
> >> >
> >> > Kevin
> >>
> >> Hm, looks like my BBB hit this on v3.12-rc4-493-g1a9df23, which is pushed
> >> to
> >> to-build but not for-next yet. I'm guessing this might be what Kevin
> >> pinged me
> >> about on IRC today but I was out and unavailable most of the day.
> >
> > Hmmm... mine seems to have booted fine on that build...
> > http://lists.linaro.org/pipermail/kernel-build-reports/2013-October/000666.html
> 
> Well, it's a WARN_ON() not a panic, so my script probably shouldn't
> have aborted the boot (and your script should have reported it :-).
> Check your local log to see if you have something in there?

The boot warnings can be seen here: (which is linked via the pull 
request above):

http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/boot/am335xbonelt/am335x-bone/am335xbonelt_log.txt

...

omap_hwmod: spinlock: doesn't have mpu register target base

...

omap_hwmod: rng: doesn't have mpu register target base

...

The spinlock warning on AM335x will be resolved when this patch is merged:

https://lkml.org/lkml/2013/10/10/650

The rng warning will be resolved when this patch is merged:

http://marc.info/?l=linux-arm-kernel&m=137778078331134&w=2


The WARN_ON() seems a bit heavy-handed, and I'd support replacing it with 
a pr_warn(); but on the other hand, it certainly seems to have attracted 
attention to a problem that prevents these devices from being usable :-)


- Paul
