From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Mon, 06 Sep 2010 10:28:53 +0100
Message-ID: <1283765333.1926.2.camel@e102109-lin.cambridge.arm.com>
References: <20100817135205.GC20325@n2100.arm.linux.org.uk>
	 <20100817141210.GJ12184@atomide.com>
	 <20100817154035.GD20325@n2100.arm.linux.org.uk>
	 <20100819073810.GR12184@atomide.com><4C6CFBAF.6020407@canonical.com>
	 <20100819095705.GU12184@atomide.com>
	 <20100819102025.GA32151@n2100.arm.linux.org.uk>
	 <20100820120622.GL25742@atomide.com><20100830225527.GC11597@atomide.com>
	 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
	 <20100902161659.GJ11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37170 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752554Ab0IFJ3P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 05:29:15 -0400
In-Reply-To: <20100902161659.GJ11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>

On Thu, 2010-09-02 at 17:16 +0100, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 06:29]:
> > On Mon, Aug 30, 2010 at 03:55:27PM -0700, Tony Lindgren wrote:
> > > * Tony Lindgren <tony@atomide.com> [100820 04:59]:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100819 13:13]:
> > > > > On Thu, Aug 19, 2010 at 12:57:06PM +0300, Tony Lindgren wrote:
> > > > > > Looks like something is not quite right with smp_on_up part of __fixup_smp,
> > > > > > returning early before smp_on_up does not produce that.
> > > > >
> > > > > It's probably overwriting some register it shouldn't be.  I might be
> > > > > able to look at this sometime during the coming week... assuming that
> > > > > the weather is as bad as they forecast and I have 'net connectivity.
> > >
> > > This seems to fix it.
> >
> > Thanks, merged that into my original patch - so here it is again with
> > everything updated.
> 
> Your patch sure makes things simpler! The problem still is the
> V6 vs V7 SMP code though.

I haven't followed your patches closely but can we restrict the ARMv6
SMP/UP support to only those cores that have TEX remapping (most of them
probably)?

-- 
Catalin

