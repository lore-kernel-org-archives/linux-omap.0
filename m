From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH v4? 0/7] Adaptive Body-Bias for OMAP
Date: Tue, 16 Oct 2012 09:32:25 -0700
Message-ID: <20121016163225.GQ15569@atomide.com>
References: <1349313974-5473-1-git-send-email-mturquette@ti.com>
 <20121011133304.GA19170@kahuna>
 <20121011222107.2941.62545@nucleus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:27994 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754814Ab2JPQca (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 12:32:30 -0400
Content-Disposition: inline
In-Reply-To: <20121011222107.2941.62545@nucleus>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: Nishanth Menon <nm@ti.com>, khilman@deeprootsystems.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Mike Turquette <mturquette@ti.com> [121011 15:27]:
> Quoting Nishanth Menon (2012-10-11 06:33:04)
> > On 18:26-20121003, Mike Turquette wrote:
> > > From: Mike Turquette <mturquette@linaro.org>
> > [...]
> > > 
> > >  arch/arm/mach-omap2/Makefile                  |    8 +-
> > >  arch/arm/mach-omap2/abb.c                     |  322 +++++++++++++++++++++++++
> > >  arch/arm/mach-omap2/abb.h                     |   94 ++++++++
> > [...]
> > >  arch/arm/plat-omap/include/plat/voltage.h     |    1 +
> > >  18 files changed, 699 insertions(+), 37 deletions(-)
> > >  create mode 100644 arch/arm/mach-omap2/abb.c
> > >  create mode 100644 arch/arm/mach-omap2/abb.h
> > >  create mode 100644 arch/arm/mach-omap2/abb36xx_data.c
> > >  create mode 100644 arch/arm/mach-omap2/abb44xx_data.c
> > 
> > dumb question: with the request to move everything out of mach-omap2
> > directory, do we still want to add more files into mach-omap2?
> > 
> 
> Not a dumb question at all.  I approached this problem by modeling it
> after existing voltage layer code (in particular the vp and vc drivers).
> 
> My hope is to get it merged as-is and then bundle the abb code up with
> the vp/vc migration to drivers/* when that happens some day.  People
> using omap36xx and above need this code now, so it seems prudent to take
> this approach today.

This is needed, but makes moving the vc code to drivers a bit
more complex.

So we also need a plan to move this all to drivers in the follow
up patches. And we need a maintainer for the code. Who is going to
be doing all that?

Regards,

Tony
