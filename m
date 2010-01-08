From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 6/8] DSPBRIDGE: Use dspbridge to initialize platform data
Date: Fri, 8 Jan 2010 11:58:09 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DC95329@dlee03.ent.ti.com>
References: <1262912450-30100-1-git-send-email-omar.ramirez@ti.com>
 <4B469884.1080209@ti.com>
 <27F9C60D11D683428E133F85D2BB4A53042DC9524E@dlee03.ent.ti.com>
 <4B476297.9080705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56352 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562Ab0AHR6N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:58:13 -0500
In-Reply-To: <4B476297.9080705@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

>From: Menon, Nishanth
>
>Ramirez Luna, Omar had written, on 01/08/2010 10:48 AM, the following:
>>> From: Menon, Nishanth
>>>
>>> Ramirez Luna, Omar had written, on 01/07/2010 07:00 PM, the following:
>>>> Include dspbridge compilation whenever bridge driver is selected to
>>>> be compiled, either as a module or part of the kernel. This will
>>>> initialize platform data specific PM functions.
>>> ?? are you intending to state that dspbridge.c can now not be a module?
>>
>> Yes, if bridge is selected it will include dspbridge as part of the kernel, leaving bridgedriver to
>be installed depending on selected option (module or built in)
>>
>>> can you elaborate more as to why?
>>
>> Lately EXPORT_SYMBOL has been removed from pm functions, bridge depends on those symbols and now
>that they can't be resolved at runtime (or insmod time), then dspbridge driver needs to be compiled
>as part of the kernel to resolve them on its platform data structure, otherwise linking will break.
>
>might be good to know what these functions are and why they need to be
>exported. we could see how the community thinks about exporting those
>APIs. further, I thought your branch was based on l-o and not l-o pm. am
>I wrong?

Branch is based on l-o, but I'm trying to keep the less differences between l-o-pm version... as of now since DVFS doesn't exists on l-o, this problem is not shown, but bridge version based on l-o-pm has it.

>
>>
>>>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>>>> ---
>>>>  arch/arm/mach-omap2/Makefile |    4 +++-
>>>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>>> index d1cf986..0881470 100644
>>>> --- a/arch/arm/mach-omap2/Makefile
>>>> +++ b/arch/arm/mach-omap2/Makefile
>>>> @@ -75,7 +75,9 @@ obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
>>>>  # Debobs
>>>>  obj-$(CONFIG_OMAP3_DEBOBS)	+= debobs.o
>>> ?? I dont find this in l-o master/2.6.32.. something I am missing?
>
>You never answered this.is your patch based on PM branch?

Sorry, yes this version of the patch is based on PM, must have confused both versions. I'll resend master/2.6.32 which should change this reference lines...

Btw why do we have this "debobs" on l-o-pm and not on l-o?

>
>>>
>>>> -obj-$(CONFIG_MPU_BRIDGE)		+= dspbridge.o
>>>> +ifneq ($(CONFIG_MPU_BRIDGE),)
>>>> +obj-y					+= dspbridge.o
>>>> +endif
>>>>  # Specific board support
>>>>  obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
>>>
>>> --
>>> Regards,
>>> Nishanth Menon
>
>
>--
>Regards,
>Nishanth Menon
