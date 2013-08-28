From: Tero Kristo <t-kristo@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Wed, 28 Aug 2013 14:40:22 +0300
Message-ID: <521DE1A6.6030005@ti.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41935 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755130Ab3H1Lka (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Aug 2013 07:40:30 -0400
In-Reply-To: <521DCD80.1060600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, Stefan Roese <sr@denx.de>

On 08/28/2013 01:14 PM, Tomi Valkeinen wrote:
> On 28/08/13 12:48, Tero Kristo wrote:
>> On 08/28/2013 12:22 PM, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> I'm seeing odd clock behavior with Beagle, booting with DT. I'm using
>>> v3.11-rc7 + DSS DT patches.
>>
>> I guess you are not using the clock DT patches? Just making sure I
>> didn't break anything. :)
>
> No, plain rc7 with my DSS DT patches.
>
>>> So, for some reason, the first clk_set_rate goes wrong. Any ideas?
>>
>> Hmm, strange. I am not seeing similar behavior, but I am calling
>> clk_set_rate in different location.... also I am using clock DT patches
>> (don't try the current version though, as I am reworking them.)
>>
>> [    0.000000] dpll4_ck: 432000000
>> [    0.000000] dpll4_m4_ck: 72000000
>> [    0.000000] dpll4_m4x2_ck: 144000000
>> [    0.000000] dss1_alwon_fck_3430es2: 144000000
>> [    0.000000] dpll4_ck: 432000000
>> [    0.000000] dpll4_m4_ck: 86400000
>> [    0.000000] dpll4_m4x2_ck: 172800000
>> [    0.000000] dss1_alwon_fck_3430es2: 172800000
>>
>> Do you see the error only when setting to some specific rate (86400000)
>> or it doesn't matter?
>
> I also tried setting to 72000000, with the same result.
>
> Do you know if I can somehow easily get debug prints from the clock
> framework, that could lighten up the issue?

There isn't any good config option for that, I would suggest add prints 
to the clk_set_rate and then for the clocks you are interested in, print 
results for the recalc_rate / set_rate ops also.

-Tero

>
>   Tomi
>
>

