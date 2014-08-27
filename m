From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Rearm wake-up interrupts for DT when
 MUSB is idled
Date: Wed, 27 Aug 2014 10:00:26 -0700
Message-ID: <20140827170025.GD16006@atomide.com>
References: <20140825171446.GL17254@atomide.com>
 <alpine.DEB.2.02.1408271632550.21249@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47827 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbaH0RAa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2014 13:00:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1408271632550.21249@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140827 09:38]:
> On Mon, 25 Aug 2014, Tony Lindgren wrote:
> 
> > Looks like MUSB cable removal can cause wake-up interrupts to
> > stop working for device tree based booting at least for UART3
> > even as nothing is dynamically remuxed. This can be fixed by
> > calling reconfigure_io_chain() for device tree based booting
> > in hwmod code. 
> 
> Weird, nice find.  Do you know if this applies to all OMAPs, or just 
> OMAP3?

I guess it may also apply to others too, but so far I've only
seen this on omap3 occasionally.

> > Note that we already do that for legacy booting
> > if the legacy mux is configured.
> > 
> > My guess is that this is related to UART3 and MUSB ULPI
> > hsusb0_data0 and hsusb0_data1 support for Carkit mode that
> > somehow affect the configured IO chain for UART3 and require
> > rearming the wake-up interrupts.
> > 
> > In general, for device tree based booting, pinctrl-single
> > calls the rearm hook that in turn calls reconfigure_io_chain
> > so calling reconfigure_io_chain should not be needed from the
> > hwmod code for other events.
> > 
> > So let's limit the hwmod rearming of iochain only to
> > HWMOD_FORCE_MSTANDBY where MUSB is currently the only user
> > of it. If we see other devices needing similar changes we can
> > add more checks for it.
> 
> Could you please add a new hwmod flag for this case?  Maybe something like 
> HWMOD_RECONFIG_IO_CHAIN?  I think that would make the code easier to read 
> and more maintainable, since the workaround would then be explicitly 
> connected with that particular workaround's flag.  Looks like we have 
> several flag bits left.  Plus if we wind up having to set 
> HWMOD_FORCE_MSTANDBY for other devices that might not need the I/O chain 
> reconfiguration, we won't have to reimplement this flag workaround.

OK that's a good idea as this may not be always HWMOD_FORCE_MSTANDBY.
I guess I initially assumed that this was always related to
HWMOD_FORCE_MSTANDBY as that's what seemed to hang the system until
I figured it was just the wake-up events that stopped working :)

I'll do that as a follow-up patch as I already sent the pull request
for the $subject one as it was hanging my tests occasionally.

Regards,

Tony
