From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP2/3 GPTIMER: skip unnecessary TLDR write during
	non-autoreload
Date: Fri, 21 Nov 2008 15:53:22 -0800
Message-ID: <20081121235321.GL4927@atomide.com>
References: <20081014172417.5459.36601.stgit@localhost.localdomain> <20081014172745.5459.1893.stgit@localhost.localdomain> <13B9B4C6EF24D648824FF11BE89671620365C448AB@dlee02.ent.ti.com> <20081121222232.GG4927@atomide.com> <13B9B4C6EF24D648824FF11BE8967162036CD41930@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64022 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbYKUXxZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 18:53:25 -0500
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036CD41930@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

* Woodruff, Richard <r-woodruff2@ti.com> [081121 14:53]:
> > * Woodruff, Richard <r-woodruff2@ti.com> [081014 12:47]:
> > > >       omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, load);
> > > > -     omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
> > > >       omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> > > >  }
> > >
> > > I seem to recall there was a missed interrupt condition which this worked
> > around.
> > >
> > > IIRC, the original code didn't bother with the load I added back as a work
> > around as a way to get posted mode working.
> >
> > Well these seem to be working based on some quick timer tests.
> > Pushing so we can verify it ;)
> 
> This kind of change might be better tested on the PM branch.  It's the kind of thing more likely to work with PM disabled.  Testing in both is good, PM for many things is less forgiving...

OK, let's not push them yet then. Kevin promised to run some timer
tests on them on Monday, so let's wait for that.

Regards,

Tony
