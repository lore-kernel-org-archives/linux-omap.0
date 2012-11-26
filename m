From: Archit Taneja <archit@ti.com>
Subject: Re: OMAP4430 produces boot warnings
Date: Mon, 26 Nov 2012 12:18:51 +0530
Message-ID: <50B310D3.9050202@ti.com>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>  <50AE1DC0.3030002@ti.com>  <50AE2BB6.8080406@ti.com>  <1353594842.786.45.camel@sokoban>  <50AE3A5B.5040603@ti.com> <1353663278.25248.4.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37101 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893Ab2KZGt1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 01:49:27 -0500
In-Reply-To: <1353663278.25248.4.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Rajendra Nayak <rnayak@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Friday 23 November 2012 03:04 PM, Tero Kristo wrote:
> On Thu, 2012-11-22 at 16:44 +0200, Tomi Valkeinen wrote:
>> On 2012-11-22 16:34, Tero Kristo wrote:
>>
>>> I guess you checked that DSS pwrdm is switching between RET and ON in
>>> your setup?
>>
>> Yes:
>>
>> # cat /debug/pm_debug/count |grep dss
>> [   35.356567] pwrdm state mismatch(l3init_pwrdm) 3 != 1
>> [   35.361938] pwrdm state mismatch(cam_pwrdm) 3 != 0
>> [   35.366973] pwrdm state mismatch(ivahd_pwrdm) 3 != 1
>> [   35.372253] pwrdm state mismatch(tesla_pwrdm) 3 != 1
>> [   35.377532] pwrdm state mismatch(abe_pwrdm) 3 != 1
>> dss_pwrdm (RET),OFF:1,RET:11,INA:0,ON:11,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
>> l3_dss_clkdm->dss_pwrdm (0)
>>
>> then I load and unload the dss modules, and then:
>>
>> # cat /debug/pm_debug/count |grep dss
>> [   60.813629] pwrdm state mismatch(l3init_pwrdm) 3 != 1
>> [   60.819000] pwrdm state mismatch(cam_pwrdm) 3 != 0
>> [   60.824127] pwrdm state mismatch(ivahd_pwrdm) 3 != 1
>> [   60.829376] pwrdm state mismatch(tesla_pwrdm) 3 != 1
>> [   60.834625] pwrdm state mismatch(abe_pwrdm) 3 != 1
>> dss_pwrdm (ON),OFF:1,RET:21,INA:0,ON:22,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
>> l3_dss_clkdm->dss_pwrdm (0)
>>
>>>> Does the pwrdm mistakenly think that in RET state the DSS still keeps
>>>> the register contents?
>>>
>>> This might be the case, however the pwrdm code should be generic and
>>> handle all domains properly. What is the tree / branch / commit you are
>>> using for testing this stuff? I can take a look at this also.
>>
>> arm-soc/for-next
>
> I guess this is caused because some of the patches are still not in the
> for-next branch, it looks like at least this is missing:
>
> https://patchwork.kernel.org/patch/1608901/
>
> ...or the latest update done by Paul to that one.
>
> The patch I posted appears to have a small merge induced bug, it is
> registering the context loss soc_ops for am33xx when it should actually
> register those for omap4. This might explain another bug I've been
> looking at in a different branch recently... The update Paul posted does
> not seem to have this problem, but I haven't tested it myself.


Applying the patch above, and registering the soc_ops for omap4 instead 
of am33xx doesn't seem to help. The context lost count now always returns 0.

And to verify Tomi's observation, if we don't rely on the context lost 
count, and restore the registers always, we don't see the problem.

Btw, we use the function omap_pm_get_dev_context_loss_count to get the 
count, do we use this or is there a new func to get the count?

Thanks,
Archit

