From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Thu, 31 May 2012 09:22:56 -0700
Message-ID: <87bol42ucf.fsf@ti.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com>
	<87wr3uelgp.fsf@ti.com> <4FC548A3.2040906@ti.com>
	<4FC54D3B.10301@ti.com> <87pq9l7306.fsf@ti.com>
	<4FC78862.5010101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:59616 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754589Ab2EaQW5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 12:22:57 -0400
Received: by pbbrr4 with SMTP id rr4so1819397pbb.23
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 09:22:56 -0700 (PDT)
In-Reply-To: <4FC78862.5010101@ti.com> (Jon Hunter's message of "Thu, 31 May
	2012 10:04:02 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Jon Hunter <jon-hunter@ti.com> writes:

> Hi Kevin,
>
> On 05/30/2012 04:50 PM, Kevin Hilman wrote:
>
> [...]
>
>> I'm guessing you probably know my thoughts since you've already thought
>> through how this should probably look.
>> 
>> Basically, I don't like the result when we have to hack around missing
>> runtime PM support for a driver, so IMO, the driver should be updated.
>> 
>> IOW, it looks to me like the armpmu driver should grow runtime PM
>> support.  The current armpmu_release|reserve should probably be replaced
>> with runtime PM get/put, and the functionality in those functions would
>> be the runtime PM callbacks instead.
>> 
>> Will, any objections to armpmu growing runtime PM support?
>> 
>> Kevin
>> 
>> P.S.  Jon, for readability sake, any objections to  moving the PMU device init
>> out of devices.c into pmu.c?  devices.c is awful crowded.
>
> No objections. I am guessing that pmu was not supported back in the ARM9
> days and so this is only really specific to omap2 devices. That being
> said, should this still go into plat-omap dir or just mach-omap2?

I was referring to mach-omap2/devices.c.  Probably just pulling out the
PMU stuff into mach-omap2/pmu.c will be enough.

Kevin
