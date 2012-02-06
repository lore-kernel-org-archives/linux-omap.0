From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Mon, 6 Feb 2012 10:13:15 -0800
Message-ID: <20120206181314.GQ1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205012556.GG1426@atomide.com>
 <20120205125904.GB11372@n2100.arm.linux.org.uk>
 <20120205172925.GS20333@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18759 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab2BFSNS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 13:13:18 -0500
Content-Disposition: inline
In-Reply-To: <20120205172925.GS20333@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Tony Lindgren <tony@atomide.com> [120205 08:58]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 04:28]:
> > On Sat, Feb 04, 2012 at 05:25:57PM -0800, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 12:03]:
> > > > 
> > > > Another problem (some build errors for OMAP3) do seem to be solved, but
> > > > not the section mismatch warnings.  They're easy to verify before code
> > > > gets pushed anywhere upstream, especially if you're doing one giant OMAP
> > > > build - just enable CONFIG_DEBUG_SECTION_MISMATCH in your build
> > > > configuration.  Refuse patches which introduce section mismatches - at
> > > > least without an explanation backing up why they do.
> > > >
> > > > My OMAP3 and OMAP4 configurations spit out these - I've not even tried
> > > > my OMAP2 configuration yet:
> > > 
> > > Weird. The warnings you're seeing all seem valid to me, but I'm not seeing
> > > any the section warnings with the following compilers I have:
> > > 
> > > gcc version 4.3.5 (Debian 4.3.5-4)
> > > gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203)
> > > gcc version 4.6.1 (Sourcery CodeBench Lite 2011.09-70)
> > > 
> > > I see _different_ warnings if I compile with an older gcc:
> > > gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)
> > > 
> > > Any ideas why that would be?
> > 
> > Different inlining behaviour maybe?  I'm using stock gcc 4.3.5 here.
> 
> Hmm I'd assume the Emdebian gcc 4.3.5-4 would be very close to the
> stock gcc, need to investigate.

FYI, I'm now seeing the same warning as Igor posted with
omap2plus_defconfig using the same compiler as Igor:

gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) 

Still no other warnings though.

Regards,

Tony
