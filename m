From: Tony Lindgren <tony@atomide.com>
Subject: Re: [pandaboard] audio initialization fails due to TWL6040
Date: Wed, 8 Jan 2014 08:49:45 -0800
Message-ID: <20140108164944.GB31686@atomide.com>
References: <529E5EC9.10008@math.uni-bielefeld.de>
 <20131205185349.GH26766@atomide.com>
 <52C12226.6010404@ti.com>
 <20140107225302.GC5074@atomide.com>
 <52CD513D.8010403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40595 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928AbaAHQtu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jan 2014 11:49:50 -0500
Content-Disposition: inline
In-Reply-To: <52CD513D.8010403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-omap@vger.kernel.org, "Kristo, Tero" <t-kristo@ti.com>

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140108 05:25]:
> On 01/08/2014 12:53 AM, Tony Lindgren wrote:
> > Well we cannot sanely deprecate the "ti,hwmods" and move on to
> > matching hwmod data with DT data based on the compatible flag.
> > So it's a bit of a blocker for v3.15 or so time frame.
> >
> >> Due to a 'hw feature' around the sidetone this is not as straight forward as
> >> it sounds...
> > 
> > OK. The driver(s) should still be able to coordinate things
> > to sort it out hopefully?
> 
> After a quick look at the code:
> - sidetone _is_ broken when we boot with DT for sure already.
> - sidetone works only if we boot in legacy mode.
> 
> While it is true that ST block has it's own address space and even dedicated
> irq line, but..
> ST can be enabled from the McBSP address space (via SSELCR_REG).
> When ST is enabled we need to disable the corresponding McBSP's autoidle. The
> reason for this is that the ST block is clocked from the McBSP IP's interface
> clock. If the interface clock of the McBSP is idling there will be glitches in
> the sidetone generation due to not having continuously running clock for it's
> internals.

It seems that this you may be able to sort out just by exporting a function
from the ST code for the McBSP to call, and for the autoidle, can't you..
 
> For legacy boot we had this handled by a custom callback to disable autoidle
> for the McBSP when the ST starts and enable it back when ST is stopped:
> arch/arm/mach-omap2/mcbsp.c:omap3_enable_st_clock() is the callback we call.

..just use runtime PM calls from the ST module?
 
> Normal audio will work via McBSP if we get rid of hwmod, the driver can load
> and operate that way. As for the sidetone functionality: it is broken when we
> boot with DT and the removal of hwmod will have no effect on this.

OK
 
> The Sidetone address space also have sysconfig register with AUTOIDLE bit, but
> it has no effect on the McBSP_ICLK autoidle itself.

Yes that's because they're separate hardware modules like we have them in
the hwmod code :)

> In theory we can handle the sidetone as we do right now, but we need one
> thing: an API so drivers can disable/enable autoidle of an already enabled clock.
> 
> CCing Tero for this, he might have pointers or idea on how we can do this.

It seems that runtime PM should be able to do that. But maybe I'm missing
something here.

Regards,

Tony
