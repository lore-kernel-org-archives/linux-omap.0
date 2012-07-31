From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Tue, 31 Jul 2012 18:07:16 -0500
Message-ID: <50186524.6060903@ti.com>
References: <4FD7B1DC.30108@ti.com> <20120612213150.GC24380@mudshark.cambridge.arm.com> <4FD7C597.7060501@ti.com> <20120702095539.GD22239@mudshark.cambridge.arm.com> <4FF1D15E.7040301@ti.com> <20120702220117.GD25234@mudshark.cambridge.arm.com> <4FF6340A.6020409@ti.com> <50109233.3090302@ti.com> <20120726150534.GD6382@mudshark.cambridge.arm.com> <50115F3F.7050705@ti.com> <20120731151446.GK3903@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32901 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755522Ab2GaXHT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 19:07:19 -0400
In-Reply-To: <20120731151446.GK3903@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi  Will,

On 07/31/2012 10:14 AM, Will Deacon wrote:
> On Thu, Jul 26, 2012 at 04:16:15PM +0100, Jon Hunter wrote:
>> On 07/26/2012 10:05 AM, Will Deacon wrote:
>>> Ok, thanks for updating me. I've pushed the patches out onto my
>>> perf/omap4-dev branch as that seems to be a good place to collate the
>>> current state of things. I've not tried doing anything with it yet though.
>>
>> Ok, great. Let me know if you have any problems. I have ran some initial
>> testing on omap3430, omap4430 and omap4460 and it seems ok (AFAICT).
> 
> Just an FYI that I gave up maintaining the old perf/omap4 branch and instead
> moved everything from perf/omap4-dev onto that as the rebase was getting
> painful.

I have just updated my pmu branch for omap3/4. You can pull my latest
patches from [1].

In the latest series I have:
1. Pulled in an omap3 clock domain fix from Paul [2]
2. Rebased Paul's patch [3] on top of [2]. I have also made a couple
   updates to this patch and I need to get Paul's feedback.
3. I have removed the OMAP3 PMU dependency on ETM from the Kconfig.

I have tested this on OMAP3430, OMAP4430 and OMAP4460. Seems to be
working well my end so let me know if you have chance to try.

I will probably send out the series once I align with Paul on the above
changes and the HWMOD stuff I have added for OMAP3 with Benoit.

Cheers
Jon

[1] git@gitorious.org:linux-omap-dev/linux-omap-dev.git -b dev-pmu
[2] http://marc.info/?l=linux-omap&m=134333691309305&w=2
[3] http://marc.info/?l=linux-omap&m=134212809112530&w=2
