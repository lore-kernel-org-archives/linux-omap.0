From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC/PATCH 3/7] ARM: OMAP3: clock data: treat all AM35x devices
 the same
Date: Fri, 6 Jan 2012 08:59:44 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8073B53@DBDE01.ent.ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
	<1325726206-11199-4-git-send-email-khilman@ti.com>
	<79CD15C6BA57404B839C016229A409A807195B@DBDE01.ent.ti.com>
 <87pqex7l2z.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51082 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752972Ab2AFI7v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 03:59:51 -0500
In-Reply-To: <87pqex7l2z.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, January 06, 2012 5:34 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Paul Walmsley
> Subject: Re: [RFC/PATCH 3/7] ARM: OMAP3: clock data: treat all AM35x
> devices the same
> 
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Hilman, Kevin
> >> Sent: Thursday, January 05, 2012 6:47 AM
> >> To: linux-omap@vger.kernel.org
> >> Cc: Paul Walmsley; Hiremath, Vaibhav
> >> Subject: [RFC/PATCH 3/7] ARM: OMAP3: clock data: treat all AM35x
> devices
> >> the same
> >>
> >> The init for 3505/3517 specific clocks depends on the ordering of
> >> cpu_is checks, is error prone and confusing (there are 2 separate
> >> checks for cpu_is_omap3505()).
> >>
> >> Remove the 3505-specific checking since CK_3505 flag is not used, and
> >> treat all AM35x clocks the same.
> >>
> >> This means that the SGX clock (the only AM35x clkdev not currently
> >> flagged for 3505) will now be registered on 3505, but that is
> >> harmless.  That can be cleaned up when the clkdev nodes are removed in
> >> favor of them being registered by hwmod.
> >>
> > [Hiremath, Vaibhav] How do you think we can use hwmod here?
> 
> I haven't thought in detail about the exact fix for this, but it
> shouldn't be difficult. For example, it could be as simple as creating
> some more per-family hwmod lists of optional hwmods.  Then, during init,
> register them based on the feature flag.
> 
> Longer term, it may be that we handle this using DT, but I'm not sure we
> will use DT to describe that level of SoC detail.
> 
> > Currently hwmod is also dependent on cpu_is_xxxx to register respective
> modules.
> 
> In mainline it is only done by CPU family (revision), not using cpu_is*
> 
Yeah, I missed this point (was referring different code base).

Thanks,
Vaibhav

> > I completely understand and agree to the fact that there may not be any
> harm
> > due to this, but this means, iva will be always registered for 3505
> devices.
> 
> Correct for today, but not difficult to remedy by fixing up the hwmod init.
> 
> Kevin
