From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Wed, 1 Aug 2012 21:47:31 +0100
Message-ID: <20120801204731.GA9080@mudshark.cambridge.arm.com>
References: <4FD7C597.7060501@ti.com>
 <20120702095539.GD22239@mudshark.cambridge.arm.com>
 <4FF1D15E.7040301@ti.com>
 <20120702220117.GD25234@mudshark.cambridge.arm.com>
 <4FF6340A.6020409@ti.com>
 <50109233.3090302@ti.com>
 <20120726150534.GD6382@mudshark.cambridge.arm.com>
 <50115F3F.7050705@ti.com>
 <20120731151446.GK3903@mudshark.cambridge.arm.com>
 <50186524.6060903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:54844 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751662Ab2HAUrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 16:47:42 -0400
Content-Disposition: inline
In-Reply-To: <50186524.6060903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 01, 2012 at 12:07:16AM +0100, Jon Hunter wrote:
> I have just updated my pmu branch for omap3/4. You can pull my latest
> patches from [1].

Great, thanks for that. I've pushed out to perf/omap4 and I've also
included your runtime PM hooks in my perf/updates branch. I have a fair
amount of cleanup sitting in there as well, so I'll post that to the list
at -rc1 as a candidate for -next. I'll obviously leave the omap-specific
bits for others to handle, although I'll continue maintaining my branch
until that's hit mainline.

> In the latest series I have:
> 1. Pulled in an omap3 clock domain fix from Paul [2]
> 2. Rebased Paul's patch [3] on top of [2]. I have also made a couple
>    updates to this patch and I need to get Paul's feedback.
> 3. I have removed the OMAP3 PMU dependency on ETM from the Kconfig.

Fantastic! I actually already removed the OMAP3 Kconfig dependency in my
perf/updates branch as part of removing CPU_HAS_PMU entirely, so you
probably don't need to pursue that patch.

> I will probably send out the series once I align with Paul on the above
> changes and the HWMOD stuff I have added for OMAP3 with Benoit.

Okey doke. If you need me to update my copy of your runtime PM patch,
please shout (that seems to be a done deal afaict).

Will
