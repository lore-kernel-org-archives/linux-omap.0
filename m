From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] omap2/3/4: serial: Half revert multiboot changes
Date: Thu, 25 Feb 2010 14:36:11 -0600
Message-ID: <A24693684029E5489D1D202277BE89445398EBB1@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944538C6D68@dlee02.ent.ti.com>
 <A24693684029E5489D1D202277BE8944538C6D6A@dlee02.ent.ti.com>
 <20100224162129.GO28173@atomide.com>
 <A24693684029E5489D1D202277BE89445398E44D@dlee02.ent.ti.com>
 <20100225185547.GH28173@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54624 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933362Ab0BYUgR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 15:36:17 -0500
In-Reply-To: <20100225185547.GH28173@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hi,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, February 25, 2010 12:56 PM
> To: Aguirre, Sergio
> Cc: linux-omap@vger.kernel.org; Sonasath, Moiz; Pandita, Vikram
> Subject: Re: [PATCH] omap2/3/4: serial: Half revert multiboot changes
> 
> * Aguirre, Sergio <saaguirre@ti.com> [100224 19:04]:
> >
> >
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > Sent: Wednesday, February 24, 2010 10:21 AM
> > > To: Aguirre, Sergio
> > > Cc: linux-omap@vger.kernel.org; Sonasath, Moiz; Pandita, Vikram
> > > Subject: Re: [PATCH] omap2/3/4: serial: Half revert multiboot changes
> > >
> > > * Aguirre, Sergio <saaguirre@ti.com> [100223 23:37]:
> > > > Hmm..
> > > >
> > > > I think I sent this patch too soon...
> > > >
> > > > Please ignore it, this is not a proper solution I feel..
> > > >
> > > > But what it is true... is that, patch "omap2/3/4: Fix mach-
> > > omap2/serial.c for multiboot" is definitely breaking Zoom3 boot, and
> needs
> > > to be fixed.
> > >
> > > Yes sounds like only zoom has the external uart, other 3630
> > > boards may be using the internal uart4.
> >
> > Actually, I don't see any patch to handle uart4 interface/functional
> clocks, so I assume the addition of uart4 for 3630 chip is incomplete.
> >
> > Shall we apply my 2nd patch, until proper clock handling is in place?
> >
> > I don't have an omap4 to test, but I think my patch shouldn't hurt the
> initial intention to make multiomap builds possible... agree?
> 
> See also the recent patch from Thomas. I'd say let's rather fix this
> properly with your clock related patchset once it's been tested.
> 
> We already have all these temporary hacks still in place for omap4,
> let's try not to add more.

Ok, sure. I agree.

I'll try to get a 3630SDP, which I believe has physical access to UART4. With just my Zoom3 I can't do much :/

Regards,
Sergio
> 
> Regards,
> 
> Tony
