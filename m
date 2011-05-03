From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] omap: musb: introduce default baord config
Date: Tue, 3 May 2011 00:50:13 -0700
Message-ID: <20110503075013.GL2092@atomide.com>
References: <cover.1303682352.git.mike@compulab.co.il>
 <c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il>
 <FD6AF712-BD76-4E30-8ED8-6903987E5C2C@linuxhacker.ru>
 <20110428141818.GE19709@n2100.arm.linux.org.uk>
 <9B236748-29D6-4129-AFCD-5D223CE18ECD@linuxhacker.ru>
 <20110428162820.GF19709@n2100.arm.linux.org.uk>
 <9D42099B-0C25-4407-88B2-2574E9233B2A@linuxhacker.ru>
 <20110502142051.GC2092@atomide.com>
 <20110502142533.GJ2529@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42293 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750852Ab1ECHuT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 03:50:19 -0400
Content-Disposition: inline
In-Reply-To: <20110502142533.GJ2529@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Oleg Drokin <green@linuxhacker.ru>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

* Felipe Balbi <balbi@ti.com> [110502 07:22]:
> On Mon, May 02, 2011 at 07:20:52AM -0700, Tony Lindgren wrote:
> > * Oleg Drokin <green@linuxhacker.ru> [110428 09:33]:
> > > 
> > > So to me it looks like something totally in realm of musb driver itself.
> > > Nothing bad happens if you configure your MUSB as say OTG while in fact only
> > > peripheral mode was implemented, it continues to work as it did.
> > > Of course enabling HOST mode may not magically make things work, but
> > > I suspect this could be addressed from Kconfig itself instead.

So based on the discussion it sounds like we still the board specific
configuration for the mode in some cases.

> > I think Felipe already has some patches to remove the various Kconfig
> > options for musb?  In any case, the musb configuration should be a
> > runtime configuration passed in the platform data or cmdline.
> 
> Yeah, I'm planning to get rid of all the ifdeferry and always compile it
> with HOST and Peripheral support. It's only few extra tens of bytes
> anyway. Still, I doubt I can get that done for this merge window, I
> already have pending the debugging rework.

So care to ack the original patch then? It still allows overriding
the default mode from board-*.c file as needed.

Regards,

Tony
