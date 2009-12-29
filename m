From: Tony Lindgren <tony@atomide.com>
Subject: Re: L4 interconnect memory mapping
Date: Tue, 29 Dec 2009 15:46:57 -0800
Message-ID: <20091229234657.GO3512@atomide.com>
References: <1262129134.28789.96.camel@gandalf>
 <1262129299.28789.97.camel@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49607 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZL2XrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 18:47:03 -0500
Content-Disposition: inline
In-Reply-To: <1262129299.28789.97.camel@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [091229 15:26]:
> Hi,
> 
> On Wed, 2009-12-30 at 01:25 +0200, Felipe Balbi wrote:
> > Hi Tony and Paul,
> > 
> > maybe a silly question, but here it goes:
> > 
> > Do we have any piece of code handling the L4 interconnect memory space ?
> > I mean, looking at omap3 TRM pages 212 - 219, I see that e.g. for the
> > musb block we have:
> > 
> > HS USB OTG	0x480AB000 - 0x480ABFFF	4KB	Module
> > 		0x480AC000 - 0x480ACFFF	4KB	L4 interconnect
> > 
> > So the first 4K is what we pass down to drivers via struct resource and
> > the second 4K ? What do we do with that ?
> 
> no with Paul's address correct.

Looks like you might want to update your earlier patch to just comment
that the 8K address space for musb is 4K + 4K for L4 interconnect :)

Tony
