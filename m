From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH v4? 0/7] Adaptive Body-Bias for OMAP
Date: Tue, 16 Oct 2012 14:59:00 -0700
Message-ID: <20121016215859.GO15569@atomide.com>
References: <1349313974-5473-1-git-send-email-mturquette@ti.com>
 <20121011133304.GA19170@kahuna>
 <20121011222107.2941.62545@nucleus>
 <20121016163225.GQ15569@atomide.com>
 <20121016170620.21731.52746@nucleus>
 <87a9vmnl1n.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:21312 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753938Ab2JPV7F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 17:59:05 -0400
Content-Disposition: inline
In-Reply-To: <87a9vmnl1n.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Mike Turquette <mturquette@ti.com>, Nishanth Menon <nm@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121016 14:51]:
> Mike Turquette <mturquette@ti.com> writes:
> 
> > Quoting Tony Lindgren (2012-10-16 09:32:25)
> >> * Mike Turquette <mturquette@ti.com> [121011 15:27]:
> >> > Quoting Nishanth Menon (2012-10-11 06:33:04)
> >> > > On 18:26-20121003, Mike Turquette wrote:
> >> > > > From: Mike Turquette <mturquette@linaro.org>
> >> > > [...]
> >> > > > 
> >> > > >  arch/arm/mach-omap2/Makefile                  |    8 +-
> >> > > >  arch/arm/mach-omap2/abb.c                     |  322 +++++++++++++++++++++++++
> >> > > >  arch/arm/mach-omap2/abb.h                     |   94 ++++++++
> >> > > [...]
> >> > > >  arch/arm/plat-omap/include/plat/voltage.h     |    1 +
> >> > > >  18 files changed, 699 insertions(+), 37 deletions(-)
> >> > > >  create mode 100644 arch/arm/mach-omap2/abb.c
> >> > > >  create mode 100644 arch/arm/mach-omap2/abb.h
> >> > > >  create mode 100644 arch/arm/mach-omap2/abb36xx_data.c
> >> > > >  create mode 100644 arch/arm/mach-omap2/abb44xx_data.c
> >> > > 
> >> > > dumb question: with the request to move everything out of mach-omap2
> >> > > directory, do we still want to add more files into mach-omap2?
> >> > > 
> >> > 
> >> > Not a dumb question at all.  I approached this problem by modeling it
> >> > after existing voltage layer code (in particular the vp and vc drivers).
> >> > 
> >> > My hope is to get it merged as-is and then bundle the abb code up with
> >> > the vp/vc migration to drivers/* when that happens some day.  People
> >> > using omap36xx and above need this code now, so it seems prudent to take
> >> > this approach today.
> >> 
> >> This is needed, but makes moving the vc code to drivers a bit
> >> more complex.
> >> 
> >> So we also need a plan to move this all to drivers in the follow
> >> up patches. And we need a maintainer for the code. Who is going to
> >> be doing all that?
> >> 
> >
> > Is there already somebody committed to moving vp/vc code out to drivers?
> 
> Yes, VC/VP is part of the bigger PRM/CM move in progress.
> 
> For now, I'm ok with adding a little more VC/VP stuff since it's already
> well isolated in the prmXXXX.c files (though it might need a rebase on
> Paul's recent PRM/CM cleanup stuff.)
> 
> > If so then I can take responsibility for moving the abb code and
> > coordinate with that person.  

Thanks Mike & Kevin, sounds good to me.

Regards,

Tony
