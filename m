From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Wed, 1 Aug 2012 17:34:19 -0500
Message-ID: <5019AEEB.7010807@ti.com>
References: <4FD7C597.7060501@ti.com> <20120702095539.GD22239@mudshark.cambridge.arm.com> <4FF1D15E.7040301@ti.com> <20120702220117.GD25234@mudshark.cambridge.arm.com> <4FF6340A.6020409@ti.com> <50109233.3090302@ti.com> <20120726150534.GD6382@mudshark.cambridge.arm.com> <50115F3F.7050705@ti.com> <20120731151446.GK3903@mudshark.cambridge.arm.com> <50186524.6060903@ti.com> <20120801204731.GA9080@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59156 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075Ab2HAWec (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 18:34:32 -0400
In-Reply-To: <20120801204731.GA9080@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 08/01/2012 03:47 PM, Will Deacon wrote:
> On Wed, Aug 01, 2012 at 12:07:16AM +0100, Jon Hunter wrote:
>> I have just updated my pmu branch for omap3/4. You can pull my latest
>> patches from [1].
> 
> Great, thanks for that. I've pushed out to perf/omap4 and I've also
> included your runtime PM hooks in my perf/updates branch. I have a fair
> amount of cleanup sitting in there as well, so I'll post that to the list
> at -rc1 as a candidate for -next. I'll obviously leave the omap-specific
> bits for others to handle, although I'll continue maintaining my branch
> until that's hit mainline.

I just updated today with Paul's latest patch he sent. I don't think
much changed from what I had in there yesterday.

>> In the latest series I have:
>> 1. Pulled in an omap3 clock domain fix from Paul [2]
>> 2. Rebased Paul's patch [3] on top of [2]. I have also made a couple
>>    updates to this patch and I need to get Paul's feedback.
>> 3. I have removed the OMAP3 PMU dependency on ETM from the Kconfig.
> 
> Fantastic! I actually already removed the OMAP3 Kconfig dependency in my
> perf/updates branch as part of removing CPU_HAS_PMU entirely, so you
> probably don't need to pursue that patch.

Great! Glad I don't have to worry about that.

>> I will probably send out the series once I align with Paul on the above
>> changes and the HWMOD stuff I have added for OMAP3 with Benoit.
> 
> Okey doke. If you need me to update my copy of your runtime PM patch,
> please shout (that seems to be a done deal afaict).

Yes it is good as far as I am concerned.

I am going to be out for a couple weeks, but when I get back I will get
the OMAP stuff out. I should probably doing some testing on -next too
with your latest changes.

Cheers
Jon


