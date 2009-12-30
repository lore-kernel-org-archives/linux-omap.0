From: Paul Walmsley <paul@pwsan.com>
Subject: Re: L4 interconnect memory mapping
Date: Wed, 30 Dec 2009 02:16:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912300213530.24862@utopia.booyaka.com>
References: <1262129134.28789.96.camel@gandalf>  <1262129299.28789.97.camel@gandalf>  <20091229234657.GO3512@atomide.com> <1262130610.28789.116.camel@gandalf>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36783 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZL3JQI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 04:16:08 -0500
In-Reply-To: <1262130610.28789.116.camel@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Wed, 30 Dec 2009, Felipe Balbi wrote:

> On Tue, 2009-12-29 at 15:46 -0800, Tony Lindgren wrote:
> > * Felipe Balbi <me@felipebalbi.com> [091229 15:26]:
> > > Hi,
> > > 
> > > On Wed, 2009-12-30 at 01:25 +0200, Felipe Balbi wrote:
> > > > Hi Tony and Paul,
> > > > 
> > > > maybe a silly question, but here it goes:
> > > > 
> > > > Do we have any piece of code handling the L4 interconnect memory space ?
> > > > I mean, looking at omap3 TRM pages 212 - 219, I see that e.g. for the
> > > > musb block we have:
> > > > 
> > > > HS USB OTG	0x480AB000 - 0x480ABFFF	4KB	Module
> > > > 		0x480AC000 - 0x480ACFFF	4KB	L4 interconnect
> > > > 
> > > > So the first 4K is what we pass down to drivers via struct resource and
> > > > the second 4K ? What do we do with that ?
> > > 
> > > no with Paul's address correct.
> > 
> > Looks like you might want to update your earlier patch to just comment
> > that the 8K address space for musb is 4K + 4K for L4 interconnect :)
> 
> was thinking about that just now heh, but what do we do with the extra
> 4k ? It's the same for all other modules. Is omap_hwmod taking care of
> that ?

That second 4KiB range is the interconnect target agent between the 
interconnect and the HS USB OTG IP block.  No need to deal with it.  At 
some point either omap_hwmod or an interconnect driver will probably 
reserve it for bookkeeping purposes.


- Paul
