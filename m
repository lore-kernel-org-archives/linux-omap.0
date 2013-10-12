From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V5] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ
 register
Date: Fri, 11 Oct 2013 20:37:05 -0400
Message-ID: <525899B1.7040206@ti.com>
References: <1381391028-4189-1-git-send-email-r.sricharan@ti.com> <5256A7AE.6000605@ti.com> <20131010171540.GG29913@atomide.com> <20131012003433.GJ29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab3JLAhf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 20:37:35 -0400
In-Reply-To: <20131012003433.GJ29913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, nm@ti.com, Rajendra Nayak <rnayak@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>

On Friday 11 October 2013 08:34 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [131010 10:23]:
>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [131010 06:20]:
>>> On Thursday 10 October 2013 03:43 AM, Sricharan R wrote:
>>>> From: R Sricharan <r.sricharan@ti.com>
>>>>
>>>> The realtime counter called master counter, produces the count
>>>> used by the private timer peripherals in the MPU_CLUSTER. The
>>>> CNTFRQ per cpu register is used to denote the frequency of the counter.
>>>> Currently the frequency value is passed from the
>>>> DT file, but this is not scalable when we have other non-DT guest
>>>> OS. This register must be set to the right value by the
>>>> secure rom code. Setting this register helps in propagating the right
>>>> frequency value across OSes.
>>>>
>>>> More discussions and the reason for adding this in a non-DT
>>>> way can be seen from below.
>>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg93832.html
>>>>
>>>> So configuring this secure register for all the cpus here.
>>>>
>>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Cc: Nishanth Menon <nm@ti.com>
>>>> Cc: Rajendra Nayak <rnayak@ti.com>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>> Tested-by: Nishanth Menon <nm@ti.com>
>>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>>>> ---
>>>>  [V5] Removed the use of extern variable in omap-smp.c
>>>>       as per suggestion from Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>
>>> Thanks for the updates Sricharan. Looks fine now.
>>>
>>> Tony, Can you apply this version if you are fine with it.
>>
>> Yes thanks looks good to me now. Applying into omap-for-v3.13/soc.
> 
> Grr, had to apply the following fix on top of this for some configs.
> 
Looks like Sricharan missed some builds. Sorry for the trouble Tony.

> 
> 8< ---------------------------
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 11 Oct 2013 17:28:04 -0700
> Subject: [PATCH] ARM: OMAP2+: Fix build error for realtime counter init if not enabled
> 
> Otherwise we can get an error with some configs:
> 
> arch/arm/mach-omap2/timer.c:73: undefined reference to `omap_smc1'
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
Looks fine to me. Thanks 

Regards,
Santosh

