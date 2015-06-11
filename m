From: Tony Lindgren <tony@atomide.com>
Subject: Re: EDMA oftree entry for AM335x
Date: Thu, 11 Jun 2015 07:13:31 -0700
Message-ID: <20150611141330.GC2740@atomide.com>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com>
 <5548CB54.1040302@ti.com>
 <20150505145828.GB21061@atomide.com>
 <5549F95B.8090905@ti.com>
 <20150506143951.GG21061@atomide.com>
 <20150608105957.GT26523@pengutronix.de>
 <20150610051037.GA2740@atomide.com>
 <55781BDA.9020705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:57240 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbbFKONe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jun 2015 10:13:34 -0400
Content-Disposition: inline
In-Reply-To: <55781BDA.9020705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150610 04:18]:
> On 06/10/2015 08:10 AM, Tony Lindgren wrote:
> > * Robert Schwebel <r.schwebel@pengutronix.de> [150608 04:01]:
> >> On Wed, May 06, 2015 at 07:39:52AM -0700, Tony Lindgren wrote:
> >>>
> >>> That may never happen considering that davinci is using it too.. It's
> >>> best to not count on that happening anytime soon at least.
> >>
> >> So my current understanding is that we have the situation that the
> >> kernel warns about the oftree being wrong, but isn't able to handle an
> >> oftree that would be right.
> >>
> >> Shouldn't the warning being added when the kernel driver supports that
> >> new mechanism?
> > 
> > This particular driver is broken and it needs to be fixed properly.
> >  
> >> I had a warning free mainline kernel without patches on my customer
> >> hardware before, so this smells a bit like a regression ... :-/
> > 
> > Yes sorry I'm not patching away the warning as it does not fix the
> > driver. Peter, I assume you are busy fixing it?
> 
> Well, I was not.
> But I'm now ;)

OK good to hear!

Tony
