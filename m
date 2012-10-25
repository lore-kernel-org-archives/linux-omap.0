From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: PMU: fix runtime PM enable
Date: Thu, 25 Oct 2012 11:50:15 -0500
Message-ID: <50896DC7.80704@ti.com>
References: <1351024268-26734-1-git-send-email-jon-hunter@ti.com> <20121024093150.GA23775@mudshark.cambridge.arm.com> <5087F84B.9070705@ti.com> <20121024143204.GF7339@mudshark.cambridge.arm.com> <508803DF.7020902@ti.com> <20121024172325.GK7339@mudshark.cambridge.arm.com> <5088284D.40404@ti.com> <87vcdy33ma.fsf@deeprootsystems.com> <20121025164714.GK11267@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52085 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755511Ab2JYQuW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 12:50:22 -0400
In-Reply-To: <20121025164714.GK11267@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 10/25/2012 11:47 AM, Will Deacon wrote:
> On Thu, Oct 25, 2012 at 05:42:21PM +0100, Kevin Hilman wrote:
>> Jon Hunter <jon-hunter@ti.com> writes:
>>> On 10/24/2012 12:23 PM, Will Deacon wrote:
>>>> What do other drivers do? Grepping around, I see calls to pm_runtime_enable
>>>> made in various drivers and, given that you pass the device in there, what's
>>>> the problem with us just calling that unconditionally from perf? I know you
>>>> said that will work for OMAP, but I'm trying to understand the effect that
>>>> has on PM-aware platforms that don't require this for the PMU (since this
>>>> seems to be per-device).
>>>
>>> I had done this initially when testing on OMAP platforms that do and
>>> don't require runtime PM for PMU. I don't see any side affect of this,
>>> however, may be Kevin could comment on if that is ok. It would be the
>>> best approach.
>>
>> Unconditonally enabling runtime PM should be fine.  It may add a slight
>> bit of overhead calling runtime PM functions that ultimately do nothing
>> (because there are no callbacks), but it will be harmless.
>>
>> Personally, I think that would be cleaner.  The less pdata we need, the
>> better, IMO.
> 
> Thanks Kevin, I'm fine with that. Jon: want me to write a patch or do you
> have something I can take into the ARM perf tree (if the latter, please
> base against perf/updates)?

I can easily spin this. Will base on top of your branch.

Cheers
Jon
