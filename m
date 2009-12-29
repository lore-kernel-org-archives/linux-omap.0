From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: L4 interconnect memory mapping
Date: Wed, 30 Dec 2009 01:50:10 +0200
Message-ID: <1262130610.28789.116.camel@gandalf>
References: <1262129134.28789.96.camel@gandalf>
	 <1262129299.28789.97.camel@gandalf>  <20091229234657.GO3512@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60972 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbZL2XuP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 18:50:15 -0500
In-Reply-To: <20091229234657.GO3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org

On Tue, 2009-12-29 at 15:46 -0800, Tony Lindgren wrote:
> * Felipe Balbi <me@felipebalbi.com> [091229 15:26]:
> > Hi,
> > 
> > On Wed, 2009-12-30 at 01:25 +0200, Felipe Balbi wrote:
> > > Hi Tony and Paul,
> > > 
> > > maybe a silly question, but here it goes:
> > > 
> > > Do we have any piece of code handling the L4 interconnect memory space ?
> > > I mean, looking at omap3 TRM pages 212 - 219, I see that e.g. for the
> > > musb block we have:
> > > 
> > > HS USB OTG	0x480AB000 - 0x480ABFFF	4KB	Module
> > > 		0x480AC000 - 0x480ACFFF	4KB	L4 interconnect
> > > 
> > > So the first 4K is what we pass down to drivers via struct resource and
> > > the second 4K ? What do we do with that ?
> > 
> > no with Paul's address correct.
> 
> Looks like you might want to update your earlier patch to just comment
> that the 8K address space for musb is 4K + 4K for L4 interconnect :)

was thinking about that just now heh, but what do we do with the extra
4k ? It's the same for all other modules. Is omap_hwmod taking care of
that ?

-- 
balbi

