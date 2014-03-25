From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 0/4] clk: dt: add support for default rate/parent
Date: Tue, 25 Mar 2014 09:28:01 +0200
Message-ID: <20140325072801.GH6922@tbergstrom-lnx.Nvidia.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
 <53172239.3030705@ti.com> <20140320212308.21989.36094@quantum>
 <20140321081217.GD26674@tbergstrom-lnx.Nvidia.com>
 <20140325003847.32624.58084@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14627 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaCYH2F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2014 03:28:05 -0400
Content-Disposition: inline
In-Reply-To: <20140325003847.32624.58084@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Mar 25, 2014 at 01:38:47AM +0100, Mike Turquette wrote:
> Quoting Peter De Schrijver (2014-03-21 01:12:17)
> > On Thu, Mar 20, 2014 at 10:23:08PM +0100, Mike Turquette wrote:
> > > Quoting Tero Kristo (2014-03-05 05:10:17)
> > > > Ping.
> > > > 
> > > > Mike, any feedback on this?
> > > 
> > > Hi Tero,
> > > 
> > > Have you seen Sylwester's approach[1]? I prefer it since it is more
> > > device-oriented and less "centralized". The clock consumer enumerates
> > > the default parent or rate of a consumed clock. This can be made to work
> > 
> > That assumes driver writers are aware of the clock tree topology. IME that's
> > seldomly the case.
> 
> It assumes no such thing.
> 
> The point of Sylwester's patch is that if a driver consumes a clock and
> needs to do the very typical setup regarding that clock's rate or
> parent, then we now have a sensible way to express that in DT.
> 
> One of the strengths of DT is that the C code does not have to know all
> of the details about topology or how things are hooked up. We can hide
> some of those cute embedded nonsense hacks in DTS and the device
> integrator can manage it there.

It would be much better to specify this as part of the clock provider binding
though, as the person writing those, generally knows what topology needs to be
setup. The driver writer writing the consumer node often doesn't.

Cheers,

Peter.
