From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 6/8] DSPBRIDGE: Use dspbridge to initialize platform data
Date: Fri, 8 Jan 2010 13:05:25 -0600
Message-ID: <4B4781F5.9060203@ti.com>
References: <1262912450-30100-1-git-send-email-omar.ramirez@ti.com> <4B469884.1080209@ti.com> <27F9C60D11D683428E133F85D2BB4A53042DC9524E@dlee03.ent.ti.com> <4B476297.9080705@ti.com> <27F9C60D11D683428E133F85D2BB4A53042DC95329@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55079 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371Ab0AHTFb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 14:05:31 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53042DC95329@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

Ramirez Luna, Omar had written, on 01/08/2010 11:58 AM, the following:
>> From: Menon, Nishanth
>>
>> Ramirez Luna, Omar had written, on 01/08/2010 10:48 AM, the following:
>>>> From: Menon, Nishanth
>>>>
>>>> Ramirez Luna, Omar had written, on 01/07/2010 07:00 PM, the following:
>>>>> Include dspbridge compilation whenever bridge driver is selected to
>>>>> be compiled, either as a module or part of the kernel. This will
>>>>> initialize platform data specific PM functions.
>>>> ?? are you intending to state that dspbridge.c can now not be a module?
>>> Yes, if bridge is selected it will include dspbridge as part of the kernel, leaving bridgedriver to
>> be installed depending on selected option (module or built in)
>>>> can you elaborate more as to why?
>>> Lately EXPORT_SYMBOL has been removed from pm functions, bridge depends on those symbols and now
>> that they can't be resolved at runtime (or insmod time), then dspbridge driver needs to be compiled
>> as part of the kernel to resolve them on its platform data structure, otherwise linking will break.
>>
>> might be good to know what these functions are and why they need to be
>> exported. we could see how the community thinks about exporting those
>> APIs. further, I thought your branch was based on l-o and not l-o pm. am
>> I wrong?
> 
> Branch is based on l-o, but I'm trying to keep the less differences between l-o-pm version...
 > as of now since DVFS doesn't exists on l-o, this problem is not 
shown, but bridge version based on l-o-pm has it.
alright, so please keep the patch for dspbridge-pm or equivalent branch 
that you maintain :).

> 
>>>>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>>>>> ---
>>>>>  arch/arm/mach-omap2/Makefile |    4 +++-
>>>>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>>>> index d1cf986..0881470 100644
>>>>> --- a/arch/arm/mach-omap2/Makefile
>>>>> +++ b/arch/arm/mach-omap2/Makefile
>>>>> @@ -75,7 +75,9 @@ obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
>>>>>  # Debobs
>>>>>  obj-$(CONFIG_OMAP3_DEBOBS)	+= debobs.o
>>>> ?? I dont find this in l-o master/2.6.32.. something I am missing?
>> You never answered this.is your patch based on PM branch?
> 
> Sorry, yes this version of the patch is based on PM, must have confused both versions. 
 > I'll resend master/2.6.32 which should change this reference lines...
> 
> Btw why do we have this "debobs" on l-o-pm and not on l-o?
due to patch in pm tree:
OMAP3: Add debug observablity (debobs) Kconfig item
this is adding debug observability signals over ETK lines (which is 
kinda cool ;) ).

[...]

-- 
Regards,
Nishanth Menon
