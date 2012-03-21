From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Wed, 21 Mar 2012 15:26:10 +0530
Message-ID: <4F69A5BA.1080804@ti.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org> <CAMQu2gxit11dSbruPLCGx37TRwo9mwNCN9JXn0fZLDTVGu2GcA@mail.gmail.com> <4F69A4A5.5020208@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:60552 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753002Ab2CUJ4Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 05:56:16 -0400
Received: by mail-gy0-f174.google.com with SMTP id r11so899756ghr.5
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 02:56:15 -0700 (PDT)
In-Reply-To: <4F69A4A5.5020208@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On Wednesday 21 March 2012 03:21 PM, Daniel Lezcano wrote:
> On 03/21/2012 10:36 AM, Shilimkar, Santosh wrote:
>> On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
>> <daniel.lezcano@linaro.org>  wrote:
>>> This patchset is a proposition to improve a bit the code.
>>> The changes are code cleanup and does not change the behavior of the
>>> driver itself.
>>>
>> Thanks. Will have a look at your series.
> 
> Cool, thanks.
> 
>>> A couple a things call my intention. Why the cpuidle device is set
>>> for cpu0 only
>> Because the mainline code CPUIDLE is supported along with CPUhotplug.
>> This is going to change though with Couple CPUIDLE and corresponding
>> OMAP updates.
> 
> Ok, thanks for the information. I will look deeper. What happens to cpu1
> when it is online and has nothing to do ?
> 
>>> and why the WFI is not used ?
>>>
>> I didn't get this question. Do you mean the generic WFI?
> 
I execute default idle loop.

> yes.
> 
>> If yes, then, it's mainly because OMAP need additional
>> custom barriers.
> 
> Ah, ok. I am not sure if it is possible but that may be cool if we can
> call cpu_do_idle instead with additional barrier.
>
There is no need. Since code around WFI is customised, it make no sense
to call cpu_do_idle(0 ofr only that instruction sake.

Regards
Santosh
