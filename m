From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: Flush posted write on 34xx to make 8250 work
	(Re: What happened to the serial console on BeagleBoard with
	2.6.28-rc2?)
Date: Mon, 3 Nov 2008 08:45:18 -0800
Message-ID: <20081103164516.GT28924@atomide.com>
References: <E1KwhIl-0001an-Ro@amazonia.comcast.net> <200811021126.13514.david-b@pacbell.net> <20081102205019.GJ28924@atomide.com> <d82e647a0811030459p2cccc76cxe93ea5a4c1386101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52229 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639AbYKCQp1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 11:45:27 -0500
Content-Disposition: inline
In-Reply-To: <d82e647a0811030459p2cccc76cxe93ea5a4c1386101@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, rick@efn.org, linux-omap@vger.kernel.org, nmonson@gmail.com, felipe.contreras@gmail.com

* Ming Lei <tom.leiming@gmail.com> [081103 04:59]:
> 2008/11/3 Tony Lindgren <tony@atomide.com>:
> > * David Brownell <david-b@pacbell.net> [081102 11:26]:
> >> On Sunday 02 November 2008, Rick Bronson wrote:
> >> > > Is that what you saw too?
> >> >
> >> >   Yep, that's what I saw, but only if I had DEBUG_LL=y.  Without that
> >> > I had nothing except "Uncompressing Linux........".
> >>
> >> I don't have DEBUG_LL=y ... if you had some kind of network
> >> link configured over USB, could you SSH in?  (I can.)
> >>
> >>
> >> >   I guess we don't see this problem on the other 2 ports since they
> >> > are mapped MT_MEMORY_SO and not MT_DEVICE (L4_34XX_PHYS).
> >>
> >> Hmm, inconsistency is to be avoided.  :)
> >>
> >> I wonder what the root cause is ... is the driver missing
> >> various barriers needed to make MT_DEVICE work?  Or is the
> >> MT_DEVICE incorrect in the first place?  "git whatchanged"
> >> didn't show any recent changes that seemed (on a quick
> >> glance) to affect I/O at that level.  Maybe it was one of
> >> the other TTY changes interacting here.
> >
> > Yeah I don't know what may have changed, or have things just
> > gotten faster now with cortex since 2.6.27?
> >
> > Anyways, this patch fixes the issue for me without marking
> > things strongly ordered. Rick, does this work for you?
> 
> This patch still works for me.
> Thanks!

Well the real problem has been found, there's a bug with the recent
ptebits patches, which causes section mappings to be just MT_MEMORY
instead of MT_DEVICE..

So let's put things on hold until we have a real fix for that on the
linux-arm-kernel mailing list, hopefully today.

Regards,

Tony
