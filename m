From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 12/13] ARM: OMAP5: Add the build support
Date: Tue, 8 May 2012 11:19:33 +0200
Message-ID: <4FA8E525.50506@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <1336029982-31898-13-git-send-email-r.sricharan@ti.com> <20120504225857.GB5613@atomide.com> <CAJ7qFSeJc+F5xnW+P5r89yZEZXi8k-LqqnD8R1KEUONqravNBw@mail.gmail.com> <20120507173749.GE5088@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54782 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab2EHJTh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 05:19:37 -0400
In-Reply-To: <20120507173749.GE5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "R, Sricharan" <r.sricharan@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

Hi Tony,

On 5/7/2012 7:37 PM, Tony Lindgren wrote:
> * R, Sricharan<r.sricharan@ti.com>  [120506 20:39]:
>>>> +config MACH_OMAP5_SEVM
>>>> +     bool "OMAP5 sevm Board"
>>>> +     depends on ARCH_OMAP5
>>>> +
>>>>   config OMAP3_EMU
>>>>        bool "OMAP3 debugging peripherals"
>>>>        depends on ARCH_OMAP3
>>>
>>> No need for it here either. Actually, I think this whole chunk
>>> can be now left out since it's DT based?
>>> he
>>   ok, but the concern here was that without this macro
>>   the print from compress and subsequently early
>> prints appear broken.
>>
>> machine_is_omap5_sevm becomes zero without this config and
>> machine_is_xxxx is used by the macro _DEBUG_LL_ENTRY
>> uncompress.h.
>
> Ah I see.

Mmm, still, I guess this mechanism should be deprecated with DT?
We cannot keep creating fake board entry since we are not supposed to 
have MACHINE_ID anymore.
That will break DEBUG_LL for sure, but we knew about that current 
limitation with DT.

The point is that we should fix the code to stop relying on a machine id 
going forward.
And maybe we can parse the FDT at that time?

Regards,
Benoit
