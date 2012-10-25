From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM: PMU: fix runtime PM enable
Date: Thu, 25 Oct 2012 17:47:14 +0100
Message-ID: <20121025164714.GK11267@mudshark.cambridge.arm.com>
References: <1351024268-26734-1-git-send-email-jon-hunter@ti.com>
 <20121024093150.GA23775@mudshark.cambridge.arm.com>
 <5087F84B.9070705@ti.com>
 <20121024143204.GF7339@mudshark.cambridge.arm.com>
 <508803DF.7020902@ti.com>
 <20121024172325.GK7339@mudshark.cambridge.arm.com>
 <5088284D.40404@ti.com>
 <87vcdy33ma.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44972 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759958Ab2JYQrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 12:47:25 -0400
Content-Disposition: inline
In-Reply-To: <87vcdy33ma.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 25, 2012 at 05:42:21PM +0100, Kevin Hilman wrote:
> Jon Hunter <jon-hunter@ti.com> writes:
> > On 10/24/2012 12:23 PM, Will Deacon wrote:
> >> What do other drivers do? Grepping around, I see calls to pm_runtime_enable
> >> made in various drivers and, given that you pass the device in there, what's
> >> the problem with us just calling that unconditionally from perf? I know you
> >> said that will work for OMAP, but I'm trying to understand the effect that
> >> has on PM-aware platforms that don't require this for the PMU (since this
> >> seems to be per-device).
> >
> > I had done this initially when testing on OMAP platforms that do and
> > don't require runtime PM for PMU. I don't see any side affect of this,
> > however, may be Kevin could comment on if that is ok. It would be the
> > best approach.
> 
> Unconditonally enabling runtime PM should be fine.  It may add a slight
> bit of overhead calling runtime PM functions that ultimately do nothing
> (because there are no callbacks), but it will be harmless.
> 
> Personally, I think that would be cleaner.  The less pdata we need, the
> better, IMO.

Thanks Kevin, I'm fine with that. Jon: want me to write a patch or do you
have something I can take into the ARM perf tree (if the latter, please
base against perf/updates)?

Cheers,

Will
