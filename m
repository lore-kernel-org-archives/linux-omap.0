From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 0/4] OMAP: DMA: mstandby mode and runtime pm support
Date: Fri, 18 Mar 2011 11:27:00 -0700
Message-ID: <87aagss2rv.fsf@ti.com>
References: <1299853215-8507-1-git-send-email-manjugk@ti.com>
	<87lj0dwi4x.fsf@ti.com> <20110318095925.GA13784@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:40537 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753937Ab1CRS1I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Mar 2011 14:27:08 -0400
Received: by pvg6 with SMTP id 6so652842pvg.7
        for <linux-omap@vger.kernel.org>; Fri, 18 Mar 2011 11:27:03 -0700 (PDT)
In-Reply-To: <20110318095925.GA13784@m-desktop> (Manjunath Kondaiah G.'s
	message of "Fri, 18 Mar 2011 15:30:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, paul@pwsan.com, tony@atomide.com

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> On Thu, Mar 17, 2011 at 02:29:18PM -0700, Kevin Hilman wrote:
>> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
>> 
>> > Patch series to support mstandby mode handling and enabling runtime PM
>> > support for DMA driver.
>> 
>> I still have the same problems as with the previous revision: 
>> 
>> 
>> This is still not runtime-suspending when I use my DMA test in linking
>> mode.
>> 
>> If I put a large enough period between transfers, it should autosuspend
>> during transfers.  It seems to do auto-suspend and resume once, but then
>> it never suspends again.
>> 
>> I tested with my dmatest module[1], and loaded with:
>> 
>>   # insmod ./dmatest.ko linking=1 forever=1 forever_period=1024
>> 
>> Not only does it not auto-suspend between transfers (which I expected),
>> it also doesn't suspend after removing the module which stops all active
>> channels.
>
> Tested again on 2.6.38 with patches pulled from patchworks and for me,
> the same test case seems to be passing. Here is the log:
> http://pastebin.com/ccEmTZS5
>
> The above test case is executed on blaze and same result is observed
> with other OMAP2+ boards also.

Can you try again with dmatest loaded without 'debug=1'

What's strange is that I noticed it worked with debug=1 also, but didn't
with debug disabled.

I *think* it's a bug in my test, which I fixed, but can you try the
above before pulling a new version of my test?

Kevin


