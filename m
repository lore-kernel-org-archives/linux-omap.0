From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC][PATCH 2/2] OMAP4: PRCM: Fix usage of prm/cm accessor
 api's for OMAP4
Date: Mon, 18 Oct 2010 15:52:58 -0700
Message-ID: <20101018225258.GG13341@atomide.com>
References: <1281452576-5705-1-git-send-email-rnayak@ti.com>
 <1281452576-5705-2-git-send-email-rnayak@ti.com>
 <1281452576-5705-3-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1010141239170.21196@utopia.booyaka.com>
 <4CB87C39.5010100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51171 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756645Ab0JRWxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 18:53:04 -0400
Content-Disposition: inline
In-Reply-To: <4CB87C39.5010100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

* Cousson, Benoit <b-cousson@ti.com> [101015 08:58]:
> Hi Paul,
> 
> On 10/14/2010 8:44 PM, Paul Walmsley wrote:
> >Hello Rajendra,
> >
> >On Tue, 10 Aug 2010, Rajendra Nayak wrote:
> >
> >>OMAP's have always had PRCM split into PRM for power and reset
> >>management and CM for clock management.
> >>In OMAP4 the split (physically) is not very straight forward and
> >>there are instances of clock management control registers in PRM
> >>and vice versa.
> >>However it still makes sense, even on OMAP4 to logically split
> >>PRCM into PRM and CM for better understanding and to avoid adding
> >>additonal complexity in higher level frameworks which rely on the
> >>accessor api;s to do the low level register accesses.
> >>
> >>Hence this patch makes sure that any clock management code can
> >>use the cm_read/write* accessor apis (without knowing the physical split)
> >>and power and reset management code can use prm_read/write*
> >>accessor api;s.
> >>
> >>To do this the submodule offsets within PRM/CM1 and CM2 have additonal
> >>info embedded in them specifying what base address to use while
> >>trying to access registers in the given submodule.
> >>
> >>The 16 bit signed submodule offset is defined for OMAP4 as
> >><Bit 15>	|<Bit 14:13>  		|<Bit 12:0>
> >><Sign bit>	|<base identifier>	|<submodule offset from base>
> >
> >The concern that I have with embedding multiple parameters into a single
> >parameter is that it seems like a hack.  Why not add an extra parameter
> >for the base identifier, rather than packing it into an existing
> >parameter?
> 
> The primary constraint that lead us to that proposal was to minimize
> the impact on the existing code and API for previous OMAPs.
> That was clearly the goal #1.
> The other one was the relative simplicity of the implementation.
> 
> The user of these OMAP4430_XXXX_MOD macros does not have to care if
> this is a real offset or just an id.
> 
> >I am not necessarily opposed to your patch as it exists.  But I would like
> >to hear your opinions first on separating out the base identifier
> >parameter as a separate function parameter, and then adding an extra field
> >for it into any data structure that would need it.  Could you write
> >briefly if you see any significant advantages/disadvantages to that
> >approach?
> 
> The disadvantage is the relative complexity for the caller of this
> API, that will have to know what partition should be used.
> It is fine if the caller is the powerdomain or clockdomain fmwk, but
> what about all the other callers we have here and there?
> When we looked at that in Bangalore, we realized that a bunch of
> code is using these prm/cm APIs. Maybe some cleanup can be done,
> like in the save / restore part, but we still have some user of
> that.
> 
> For the moment, I do not really see any advantage of such approach.
> The partitioning is changing on every OMAPs, so we do have to
> abstract that. If it is not done at that level, we will have to
> define another API on top of that to do exactly the same job.

I think we should be able to deal with the partitions properly
by ioremapping them separately as needed. Might as well do it now.

Regards,

Tony
