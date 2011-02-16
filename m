From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] OMAP: PM: DMA: Enable runtime pm
Date: Wed, 16 Feb 2011 11:47:33 -0800
Message-ID: <87zkpvn4mi.fsf@ti.com>
References: <1297082286-8449-1-git-send-email-manjugk@ti.com>
	<87ipwm1daa.fsf@ti.com> <20110216140535.GA15484@m-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43594 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752726Ab1BPTsD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 14:48:03 -0500
Received: by mail-yx0-f176.google.com with SMTP id 8so843391yxm.35
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 11:47:37 -0800 (PST)
In-Reply-To: <20110216140535.GA15484@m-desktop> (Manjunath Kondaiah G.'s
	message of "Wed, 16 Feb 2011 19:35:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Hi Kevin,
>
> On Mon, Feb 14, 2011 at 02:06:53PM -0800, Kevin Hilman wrote:
>> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
>> 
>> > From: Manjunath G Kondaiah <manjugk@ti.com>
>> >
>> > Enable runtime pm and use pm_runtime_get_sync and pm_runtime_put_autosuspend
>> > for OMAP DMA driver.
>> >
>> > The DMA driver uses auto suspend feature of runtime pm framework through
>> > which the clock gets disabled automatically if there is no activity for
>> > more than one second.
>> >
>> > Testing:
>> > Compile: omap1_defconfig and omap2plus_defconfig
>> > Boot: OMAP1710(H3), OMAP2420(H4), OMAP3630(Zoom3), OMAP4(Blaze)
>> 
>> The normal DMA tests should also be run on these platforms.  Based on
>> the above, I can't tell any DMA tests were run.   Based on my tests,
>> this isn't working for chained xfers.
>> 
>> Using the runtime PM sysfs interface, you can check the runtime status
>> of the device:
>> 
>> # cat /sys/devices/platform/omap/omap_dma_system.0/power/runtime_status          
>> 
>> It should show 'active' during transfer, and after timeout expires it
>> will show 'suspended'.
>> 
>> Doing some tests using my dmatest module:
>> 
>>   git://gitorious.org/omap-test/dmatest.git
>> 
>> I noticed that it gets stuck in 'active' and never gets suspended when I
>> used DMA channel linking (load module using 'linking=1' as load-time option)
>> 
>> I'm not sure exactly why, but I will guess that the reason is that there
>> is an imbalance in get/put calls when using chaining, since 'get' is
>> only called once upon omap_start_dma() but 'put' is called for every
>> channel in the callback.
>
> Even I noticed this after running chaining test case and checking
> runtime status. But, I am wondering even with 'active' runtime status, 
> the core hits off and retention.

Probably because system DMA is auto-idle and clocked by the core_l3_iclk

> The complete log which has all the sequences of running chaining tests,
> enabling off mode and checking runtime status is available at:
> http://pastebin.com/YEHMEXUP
>
> Though I agree on the point that, it is mismatch with get/put calls with
> DMA chaining, I still need to analyze this in detail.

Yes.  The mismatch highlights an underlying problem.

> The other thing which is not considered here is, the get_sync is called
> inside start_dma only(request_dma will call get_sync and put after the
> getting requested channel). After request_dma and start_dma, there are
> API's called by user(dma_set_params, priority etc) which also require
> get_sync since those API's will access configuration registers. I am
> wondering if have get_sync and put in all the API's, this might result
> in over loading. 

I'm not sure what you mean by over loading.

You need to have all register accesses inside get/put calls.  As long as
they are balanced, this should not leed to problems.

>> 
>> > On zoom3 core retention is tested with following steps:
>> > echo 1 > /debug/pm_debug/sleep_while_idle
>> > echo 1 > /debug/pm_debug/enable_off_mode
>> > echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
>> > echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
>> > echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
>> > echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
>> >
>> > It is observed that(on pm branch), core retention count gets increasing if the
>> > board is left idle for more than 5 seconds. However, it doesnot enter off mode
>> > (even without DMA runtime changes).
>> 
>> What silicon rev is on your Zoom3?  
> It's 3630 ES1.0. 
>> Mainline kernels now disable core off-mode for 3630 revs < ES2.1 due to erratum 
>>i583.
>> 
>> If this happens, you should see something like this on the console:
>> 
>>            Core OFF disabled due to errata i583
>> 
> We can observe above message in mainline after enabling cpu idle in
> omap2plus_defconfig.
>
> I switched to zoom2 and able to hit core retention and
> off mode with mainline.

OK, good. 

Thanks for clarifying.


Kevin

