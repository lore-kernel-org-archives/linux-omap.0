From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2/3/4: serial: Half revert multiboot changes
Date: Thu, 25 Feb 2010 10:55:47 -0800
Message-ID: <20100225185547.GH28173@atomide.com>
References: <A24693684029E5489D1D202277BE8944538C6D68@dlee02.ent.ti.com>
 <A24693684029E5489D1D202277BE8944538C6D6A@dlee02.ent.ti.com>
 <20100224162129.GO28173@atomide.com>
 <A24693684029E5489D1D202277BE89445398E44D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56310 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390Ab0BYSyp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 13:54:45 -0500
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89445398E44D@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

* Aguirre, Sergio <saaguirre@ti.com> [100224 19:04]:
> 
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Wednesday, February 24, 2010 10:21 AM
> > To: Aguirre, Sergio
> > Cc: linux-omap@vger.kernel.org; Sonasath, Moiz; Pandita, Vikram
> > Subject: Re: [PATCH] omap2/3/4: serial: Half revert multiboot changes
> > 
> > * Aguirre, Sergio <saaguirre@ti.com> [100223 23:37]:
> > > Hmm..
> > >
> > > I think I sent this patch too soon...
> > >
> > > Please ignore it, this is not a proper solution I feel..
> > >
> > > But what it is true... is that, patch "omap2/3/4: Fix mach-
> > omap2/serial.c for multiboot" is definitely breaking Zoom3 boot, and needs
> > to be fixed.
> > 
> > Yes sounds like only zoom has the external uart, other 3630
> > boards may be using the internal uart4.
> 
> Actually, I don't see any patch to handle uart4 interface/functional clocks, so I assume the addition of uart4 for 3630 chip is incomplete.
> 
> Shall we apply my 2nd patch, until proper clock handling is in place?
> 
> I don't have an omap4 to test, but I think my patch shouldn't hurt the initial intention to make multiomap builds possible... agree?

See also the recent patch from Thomas. I'd say let's rather fix this
properly with your clock related patchset once it's been tested.

We already have all these temporary hacks still in place for omap4,
let's try not to add more.

Regards,

Tony
