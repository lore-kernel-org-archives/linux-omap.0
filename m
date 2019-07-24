From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: Remove unconfigured midlemode for am3
 lcdc
Date: Wed, 24 Jul 2019 13:28:57 -0500
Message-ID: <d2414422-3ca5-4883-c94a-d3acdca70c87@ti.com>
References: <20190723112811.44381-1-tony@atomide.com>
 <20190723112811.44381-3-tony@atomide.com>
 <bcc130a5-f7e0-e182-9f4b-5a48fc3d6e17@ti.com>
 <52328e14-58b2-2ea1-8b0a-33548a1c6a7a@ti.com>
 <20190724063110.GT5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724063110.GT5447@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 7/24/19 1:31 AM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [190724 05:50]:
>>
>> On 24/07/19 12:33 AM, Suman Anna wrote:
>>> + Jyri
>>>
>>> On 7/23/19 6:28 AM, Tony Lindgren wrote:
>>>> We currently get a warning for lcdc because of a difference
>>>> with dts provided configuration compared to the legacy platform
>>>> data. This is because lcdc has SYSC_HAS_MIDLEMODE configured in
>>>> the platform data without configuring the modes.
>>>
>>> Hi Tony,
>>> While I understand that you are trying to match the DT data with the
>>> existing legacy data, do you know if there was a reason why this was
>>> omitted in the first place? Should we be really adding the MSTANDBY_
>>> flags and fix up the DTS node accordingly? I tried looking through the
>>> git log, and the initial commit itself didn't add the MSTANDBY_ flags
>>> but used the SYSC_HAS_MIDLEMODE.
> 
> Yes the goal is to get rid of all errors and warnings in dmesg output
> so we can spot the real issues.
> 
>>> Jyri,
>>> Do you know the history?
>>
>> Tony/Suman,
>>
>> This patch breaks DS0 on am3.
> 
> OK thanks for testing. Let's drop this for now, sounds like there is
> some midlemode configuration happening even with no flags set.

You were dropping the ti,sysc-midle property in patch 8, is that still
ok without this patch?

> 
> Probably the right fix is to configure the usable midlemodes instead
> both for platform data and dts data and then drop the platform data.

Yeah, that's probably better and more accurate unless we actually have
some h/w issues that require them to be dropped.

regards
Suman

> 
> Regards,
> 
> Tony
> 
> 
> 
>>>> Let's fix the warning by removing SYSC_HAS_MIDLEMODE. Note that
>>>> the am335x TRM lists SYSC_HAS_MIDLEMODE, but it is unused.
>>>
>>>
>>>
>>>>
>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>> ---
>>>>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>>>> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>>>> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>>>> @@ -231,7 +231,7 @@ static struct omap_hwmod am33xx_control_hwmod = {
>>>>   static struct omap_hwmod_class_sysconfig lcdc_sysc = {
>>>>   	.rev_offs	= 0x0,
>>>>   	.sysc_offs	= 0x54,
>>>> -	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_MIDLEMODE),
>>>> +	.sysc_flags	= SYSC_HAS_SIDLEMODE,
>>>>   	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>>>>   	.sysc_fields	= &omap_hwmod_sysc_type2,
>>>>   };
>>>>
>>>
