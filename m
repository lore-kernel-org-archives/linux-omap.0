From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP: hmwod: Update the sysc_cache in case module context
 is lost
Date: Fri, 15 Oct 2010 09:01:54 +0200
Message-ID: <4CB7FC62.5070806@ti.com>
References: <1287080555-25399-1-git-send-email-rnayak@ti.com> <877hhkv2wb.fsf@deeprootsystems.com> <EAF47CD23C76F840A9E7FCE10091EFAB030D09A2FE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57141 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755977Ab0JOHB7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Oct 2010 03:01:59 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D09A2FE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Hi Santosh,

On 10/15/2010 7:48 AM, Shilimkar, Santosh wrote:
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Friday, October 15, 2010 3:44 AM
>>
>> Rajendra Nayak<rnayak@ti.com>  writes:
>>
>>> Do not skip the sysc programming in the hmwod framework based
>>> on the cached value alone, since at times the module might have lost
>>> context (due to the Powerdomain in which the module belongs
>>> transitions to either Open Switch RET or OFF).
>>
>> Shouldn't the driver for each IP be responsible for restoring it's
>> register contents after context loss, including it's SYSC?
>>
>> Seems to me that if SYSC is lost, it means the driver's save/restore
>> is buggy.
>>
> I am glad you asked this question. I had a same argument with Benoit
> that driver anyway does context save restore for other registers and
> it can do SYSC as well.
>
> But Benoit's point was that "sysconfig is a part of the PRCM located
> in the IP, but this is purely TI implementation specific. The same
> IP in another platform will not have this sysconfig entry. That's why
> its important to hide them from the driver "

I don't have anything to add :-)

Thanks Santosh,
Benoit

>
> This make sense too.
>
>>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>> Cc: Paul Walmsley<paul@pwsan.com>
>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>> ---
>>>   arch/arm/mach-omap2/omap_hwmod.c |    5 ++++-
>>>   1 files changed, 4 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-
>> omap2/omap_hwmod.c
>>> index cb911d7..e57fe21 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -115,7 +115,10 @@ static void _write_sysconfig(u32 v, struct
>> omap_hwmod *oh)
>>>
>>>   	/* XXX ensure module interface clock is up */
>>>
>>> -	if (oh->_sysc_cache != v) {
>>> +	if ((oh->_sysc_cache != v) ||
>>> +		/* Did the module go to off and loose context? */
>>> +		(oh->_sysc_cache !=
>>> +			 omap_hwmod_readl(oh, oh->class->sysc->sysc_offs))) {
>>>   		oh->_sysc_cache = v;
>>>   		omap_hwmod_writel(v, oh, oh->class->sysc->sysc_offs);
>>>   	}

