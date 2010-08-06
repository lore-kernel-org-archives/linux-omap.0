From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PM-SR][PATCH 01/12] omap3: voltage: cleanup pr_xxxx
Date: Fri, 06 Aug 2010 06:08:03 -0500
Message-ID: <4C5BED13.6080702@gmail.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com> <1281047052-21346-2-git-send-email-nm@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401CE69@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50423 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740Ab0HFLII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 07:08:08 -0400
Received: by gxk23 with SMTP id 23so2802734gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Aug 2010 04:08:07 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032401CE69@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On 08/06/2010 02:42 AM, Gopinath, Thara wrote:
>
>
>>> -----Original Message-----
>>> From: Menon, Nishanth
>>> Sent: Friday, August 06, 2010 3:54 AM
>>> To: linux-omap
>>> Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara
>>> Subject: [PM-SR][PATCH 01/12] omap3: voltage: cleanup pr_xxxx
>>>
>>> Few more pr_xxxx need cleanup for printing the function name and
>>> not using multiline prints when c allows us to do "".
>>>
>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>> Cc: Thara Gopinath<thara@ti.com>
>>>
>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>> ---
>>> arch/arm/mach-omap2/voltage.c |    7 ++++---
>>> 1 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
>>> index 148e4d4..3431fa3 100644
>>> --- a/arch/arm/mach-omap2/voltage.c
>>> +++ b/arch/arm/mach-omap2/voltage.c
>>> @@ -253,8 +253,9 @@ static int vp_debug_set(void *data, u64 val)
>>> 		u32 *option = data;
>>> 		*option = val;
>>> 	} else {
>>> -		pr_notice("DEBUG option not enabled!\n	\
>>> -			echo 1>  pm_debug/enable_sr_vp_debug - to enable\n");
>>> +		pr_notice("%s: DEBUG option not enabled! "
>>> +			"echo 1>  pm_debug/enable_sr_vp_debug - to enable\n",
>>> +			__func__);
>>> 	}
>
> I do not think this is needed as these fns get called only from user space.
>

have you tried working on someone else's unfamiliar code and grepping 
for a warning message at the middle of the night because some developer 
forgot to give a "%s:...", __func__ with half a dozen people watching 
behind your back to know it's meaning because the product is hitting the 
shelves the next day? Instead of being able to use cscope and pop the 
function in and go straight to it and understand what is happening?? I 
believe there are few in this list who had the fortune to be in that sitn..


Well that is my motivation here. if driver reports a warning to kernel 
syslog, well, I expect the log to contain the function name for me to 
maintain faster.

> Regards
> Thara
>
>>> 	return 0;
>>> }
>>> @@ -265,7 +266,7 @@ static int vp_volt_debug_get(void *data, u64 *val)
>>> 	u8 vsel;
>>>
>>> 	vsel = voltage_read_reg(info->vp_offs.voltage_reg);
>>> -	pr_notice("curr_vsel = %x\n", vsel);
>>> +	pr_notice("%s: curr_vsel = %x\n", __func__, vsel);
>>> 	*val = vsel * 12500 + 600000;
>>>
>>> 	return 0;
>>> --
>>> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

