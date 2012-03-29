From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for merge window
Date: Thu, 29 Mar 2012 07:41:52 -0700
Message-ID: <20120329144151.GS9859@atomide.com>
References: <20120321180536.GK9859@atomide.com>
 <CAOesGMiKc5Tc2e5X9=gSiFS87JtMWGmmtOLSStWJcO7ayoE6Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:18577 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab2C2Ol4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 10:41:56 -0400
Content-Disposition: inline
In-Reply-To: <CAOesGMiKc5Tc2e5X9=gSiFS87JtMWGmmtOLSStWJcO7ayoE6Rg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

* Olof Johansson <olof@lixom.net> [120328 22:04]:
> Hi Tony,
> 
> On Wed, Mar 21, 2012 at 11:05 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi Arnd & Olof,
> >
> > Here's a set of fixes that would be nice to get merged during
> > the merge window before the GPIO changes get merged to avoid
> > boot issues on many omap boards.
> >
> > The changes queued in the GPIO tree require getting rid of
> > OMAP_GPIO_IRQ and use gpio_to_irq() instead. This is needed for
> > dynamically allocated GPIO interrupt ranges.
> 
> Sorry for the slow response on this, we've been focused on getting the
> main pulls going in. I'm about to start a fixes branch now and looked
> at this pull request.
> 
> I replied to one of the original patches in this branch, they need to
> be fixed before they can go in:
> 
> http://marc.info/?l=linux-omap&m=133299716528617&w=2

Thanks, that's a good catch.
 
> Also, that way we can get a clean branch based on current mainline
> without merge conflicts.

Yes will do.

Regards,

Tony
