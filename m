From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
 boot failure)
Date: Thu, 24 Feb 2011 09:38:40 -0800
Message-ID: <20110224173840.GC20560@atomide.com>
References: <20110106204053.GA7771@atomide.com>
 <20110107161230.GR1198@n2100.arm.linux.org.uk>
 <20110110185209.GC4957@atomide.com>
 <20110111231611.GX4957@atomide.com>
 <3c13ae6d9e13b94548bfcaaced7681e8@mail.gmail.com>
 <20110202011006.GP3358@atomide.com>
 <81ed58d7158cfa16007e141d0ac1f74c@mail.gmail.com>
 <20110202194855.GA3322@atomide.com>
 <cace62268ad657586f07ecbb0e6a99ab@mail.gmail.com>
 <84fafb82318b1287513d198c6535eb59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:24148 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab1BXRis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 12:38:48 -0500
Content-Disposition: inline
In-Reply-To: <84fafb82318b1287513d198c6535eb59@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Felipe Balbi <balbi@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110212 00:45]:
> Tony,
> > -----Original Message-----
> > From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> > Sent: Thursday, February 03, 2011 2:13 PM
> > To: Tony Lindgren
> > Cc: Anand Gadiyar; Russell King - ARM Linux; linux-arm-
> > kernel@lists.infradead.org; linux-omap@vger.kernel.org; Keshava
> > Munegowda; Felipe Balbi
> > Subject: RE: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re:
> > 4430SDP boot failure)
> >
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> > > Sent: Thursday, February 03, 2011 1:19 AM
> > > To: Santosh Shilimkar
> > > Cc: Anand Gadiyar; Russell King - ARM Linux; linux-arm-
> > > kernel@lists.infradead.org; linux-omap@vger.kernel.org; Keshava
> > > Munegowda; Felipe Balbi
> > > Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re:
> > > 4430SDP boot failure)
> > >
> > > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110201 22:04]:
> > > > >
> > > > > It's a ES1.0 blaze, with the patch below it reboots early
> > > > > during the boot. I also have to disable omap_l2_cache_init
> > > > > on this board to get it to boot.
> > > > >
> > > > Do you still get this problem with 'omap_l2_cache_init' ?
> > > > As reported earlier, we don't see this issue on ES1.0
> > > > SDP.
> > >
> > > Yeah I do, it rarely makes it to the userspace. Works reliably
> > > if I disable omap_l2_cache_init.
> > >
> > Ok. I shall try few experiments and try to reproduce it
> 
> Not sure if it's the same issue but I managed to reproduce the
> issue on ES2.0 itself. And after some experiments, it boiled
> down to the V6 and V7 issue. By disabling OMAP2 from the build,
> everything was fine again.

Was this with linux-omap master branch or mainline?

The V6 vs V7 issues should be sorted out with Russell's patches that
we also have now in linux-omap master branch.

Regards,

Tony
