From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ARM: PMU: fix runtime PM enable
Date: Thu, 25 Oct 2012 09:42:21 -0700
Message-ID: <87vcdy33ma.fsf@deeprootsystems.com>
References: <1351024268-26734-1-git-send-email-jon-hunter@ti.com>
	<20121024093150.GA23775@mudshark.cambridge.arm.com>
	<5087F84B.9070705@ti.com>
	<20121024143204.GF7339@mudshark.cambridge.arm.com>
	<508803DF.7020902@ti.com>
	<20121024172325.GK7339@mudshark.cambridge.arm.com>
	<5088284D.40404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:43071 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933227Ab2JYQlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 12:41:50 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so866913dak.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 09:41:50 -0700 (PDT)
In-Reply-To: <5088284D.40404@ti.com> (Jon Hunter's message of "Wed, 24 Oct
	2012 12:41:33 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Jon Hunter <jon-hunter@ti.com> writes:

> On 10/24/2012 12:23 PM, Will Deacon wrote:
>> On Wed, Oct 24, 2012 at 04:06:07PM +0100, Jon Hunter wrote:
>>> On 10/24/2012 09:32 AM, Will Deacon wrote:
>>>> Hmmm, now I start to wonder whether your original idea of having separate
>>>> callbacks for enable/disable irq and resume/suspend doesn't make more sense.
>>>> Then the CTI magic can go in the irq management code and be totally separate
>>>> to the PM stuff.
>>>>
>>>> What do you reckon?
>>>
>>> The resume/suspend calls really replaced the enable/disable irq
>>> callbacks. That still seems like a good approach given that we need
>>> runtime PM for OMAP and PMU.
>> 
>> Ok, perhaps splitting it up isn't worth it then. I'm still not convinced
>> either way.
>
> Given that we needed to employ runtime PM for OMAP, adding the handlers
> is a natural progression and fits more with the PM framework model.
>
>>>> Nah, we should be able to fix this in the platdata, I'd just rather have
>>>> function pointers instead of state variables in there.
>>>
>>> Well, we could pass a pointer to pm_runtime_enable() function in the
>>> platdata.
>> 
>> What do other drivers do? Grepping around, I see calls to pm_runtime_enable
>> made in various drivers and, given that you pass the device in there, what's
>> the problem with us just calling that unconditionally from perf? I know you
>> said that will work for OMAP, but I'm trying to understand the effect that
>> has on PM-aware platforms that don't require this for the PMU (since this
>> seems to be per-device).
>
> I had done this initially when testing on OMAP platforms that do and
> don't require runtime PM for PMU. I don't see any side affect of this,
> however, may be Kevin could comment on if that is ok. It would be the
> best approach.

Unconditonally enabling runtime PM should be fine.  It may add a slight
bit of overhead calling runtime PM functions that ultimately do nothing
(because there are no callbacks), but it will be harmless.

Personally, I think that would be cleaner.  The less pdata we need, the
better, IMO.

Kevin

