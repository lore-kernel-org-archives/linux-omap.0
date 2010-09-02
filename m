From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Thu, 2 Sep 2010 09:16:59 -0700
Message-ID: <20100902161659.GJ11597@atomide.com>
References: <20100817135205.GC20325@n2100.arm.linux.org.uk>
 <20100817141210.GJ12184@atomide.com>
 <20100817154035.GD20325@n2100.arm.linux.org.uk>
 <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61881 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab0IBQRJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 12:17:09 -0400
Content-Disposition: inline
In-Reply-To: <20100902133637.GJ26319@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 06:29]:
> On Mon, Aug 30, 2010 at 03:55:27PM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [100820 04:59]:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100819 13:13]:
> > > > On Thu, Aug 19, 2010 at 12:57:06PM +0300, Tony Lindgren wrote:
> > > > > Looks like something is not quite right with smp_on_up part of __fixup_smp,
> > > > > returning early before smp_on_up does not produce that.
> > > > 
> > > > It's probably overwriting some register it shouldn't be.  I might be
> > > > able to look at this sometime during the coming week... assuming that
> > > > the weather is as bad as they forecast and I have 'net connectivity.
> > 
> > This seems to fix it.
> 
> Thanks, merged that into my original patch - so here it is again with
> everything updated.

Your patch sure makes things simpler! The problem still is the
V6 vs V7 SMP code though.

Will post my six patches that apply on top of your patch as a reply to
this mail. With those, everything seems to work, at least after testing
on omap3630 (Cortex-A8 UP) and omap4430 (Cortex-A9 SMP).

Will, maybe see if there are some parts in your patchset that should
be used instead? I noticed pretty much all the earlier hacks are no
longer needed :)

Regards,

Tony
