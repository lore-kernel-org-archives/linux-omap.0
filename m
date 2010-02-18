From: Tony Lindgren <tony@atomide.com>
Subject: Re: PATCH[V2 1/3]: Update Platform files for SPI
Date: Thu, 18 Feb 2010 09:09:47 -0800
Message-ID: <20100218170946.GO21755@atomide.com>
References: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
 <20100209222513.GJ21755@atomide.com>
 <fa686aa41002180828l378a9550u125752e1e972a345@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49891 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758604Ab0BRRJA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 12:09:00 -0500
Content-Disposition: inline
In-Reply-To: <fa686aa41002180828l378a9550u125752e1e972a345@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Hemanth V <hemanthv@ti.com>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net

* Grant Likely <grant.likely@secretlab.ca> [100218 08:26]:
> On Tue, Feb 9, 2010 at 3:25 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Hemanth V <hemanthv@ti.com> [100203 02:19]:
> >> From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:00 2001
> >> From: Hemanth V <hemanthv@ti.com>
> >> Date: Fri, 27 Nov 2009 14:22:30 +0530
> >> Subject: [PATCH] Update platform files
> >>
> >> This patch updates platform files for
> >> fifo, slave support
> >>
> >> Signed-off-by: Hemanth V <hemanthv@ti.com>
> >
> > This should get merged via the spi-devel list with the other patches.
> >
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Tony, do you want me to add your acked-by to patches 2 & 3?

No thanks, I've only looked at them briefly.
 
> Also, what is your feeling about patch 3/3, spi slave support.  spi
> slave usage model is still a matter under debate, but that patch
> doesn't touch core spi code, so I'm okay to merge it as a
> driver-specific feature.  However, I'm not convinced that it is
> actually a useful patch to merge yet, so I'll defer to you on this
> one.  Thoughts?

Up to you to decide. But here's my experience so far..

Based on my experience if temporary hacks are merged, then nobody
bothers to clean them up properly afterwards and the clean-up task
unfairly falls on the maintainer.

So IMHO, hacks like that are better floating on the mailing list
until they're properly done. It's best to concentrate on getting
the core things done right to make long term support easier.

Regards,

Tony
