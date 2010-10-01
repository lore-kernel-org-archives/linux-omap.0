From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not
 finish
Date: Fri, 1 Oct 2010 10:02:13 -0700
Message-ID: <20101001170213.GU3117@atomide.com>
References: <1285915146-18511-1-git-send-email-peter.ujfalusi@nokia.com>
 <201010011151.52547.peter.ujfalusi@nokia.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C2C0@dbde02.ent.ti.com>
 <201010011341.22238.peter.ujfalusi@nokia.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C3A9@dbde02.ent.ti.com>
 <20101001144345.d5225789.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64015 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab0JARCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 13:02:19 -0400
Content-Disposition: inline
In-Reply-To: <20101001144345.d5225789.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>

* Jarkko Nikula <jhnikula@gmail.com> [101001 04:34]:
> On Fri, 1 Oct 2010 16:39:42 +0530
> "G, Manjunath Kondaiah" <manjugk@ti.com> wrote:
> 
> > > On Friday 01 October 2010 12:29:54 ext G, Manjunath Kondaiah wrote:
> > > > > But yes, it would make the code much more readable, and we can 
> > > > > easily track, which errata has been already addressed.
> > > > 
> > > > This is already done as a part of dma hwmod which is under review.
> > > 
> > > OK, so we shall not bother with this in the 'legacy' code, right?
> > > 
> > 
> > That's correct but these patches needs to be ported on top of dma
> > driver with hwmod changes.
> > 
> Priority must be opposite. Hwmod change is upcoming cleanup but these
> two patches are fixing existing problem.

That's right, fixes are the highest priority and we need to get those
into the mainline kernel ASAP. Otherwise there will be insane amounts
of wasted duplicate effort with people tracking the same bugs over
and over again like we've seen with omap over the years.

If you have fixes, get them into the mainline kernel.

Do not pile up fixes in some development tree where nobody will
find them.

Regards,

Tony
