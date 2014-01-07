From: Tony Lindgren <tony@atomide.com>
Subject: Re: [pandaboard] audio initialization fails due to TWL6040
Date: Tue, 7 Jan 2014 14:53:03 -0800
Message-ID: <20140107225302.GC5074@atomide.com>
References: <529E5EC9.10008@math.uni-bielefeld.de>
 <20131205185349.GH26766@atomide.com>
 <52C12226.6010404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25827 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbaAGWxI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jan 2014 17:53:08 -0500
Content-Disposition: inline
In-Reply-To: <52C12226.6010404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [131229 23:36]:
> Hi Tony,
> 
> I have missed this mail...
> 
> On 12/05/2013 08:53 PM, Tony Lindgren wrote:
> > * Tobias Jakobi <tjakobi@math.uni-bielefeld.de> [131203 14:45]:
> >> And another one!
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=66451
> > 
> > Maybe Peter can take a look at this one?
> 
> It has been already fixed (bug in the arch/arm/mm/dma-mapping.c)
> 
> > FYI, Peter, only slightly related to this, but can you also please
> > unravel the mcbsp and sidetone .dtsi entries to be separate
> > devices? I'm hoping to deprecate ti,hwmods for v3.15 and use
> > the compatible property instead, so we need to have 1-to-1
> > mapping of devices defined in the .dtsi files compared to the
> > real hardware devices mapped in the omap_hwmod_*_data.c files.
> > 
> > There's some more info regarding that in thread:
> > 
> > http://www.spinics.net/lists/arm-kernel/msg288036.html
> 
> How urgent this is?

Well we cannot sanely deprecate the "ti,hwmods" and move on to
matching hwmod data with DT data based on the compatible flag.
So it's a bit of a blocker for v3.15 or so time frame.

> Due to a 'hw feature' around the sidetone this is not as straight forward as
> it sounds...

OK. The driver(s) should still be able to coordinate things
to sort it out hopefully?

> I can put this to my to do list.

Thanks.

Regards,

Tony
