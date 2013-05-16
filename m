From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH] ARM: OMAP3: Fix iva2_pwrdm settings for 3703
Date: Thu, 16 May 2013 12:19:20 +0200
Message-ID: <5194B2A8.8020608@visionsystems.de>
References: <20130515002537.GG5600@atomide.com> <20130515015212.GB3268@animalcreek.com> <20130515170734.GI5600@atomide.com> <20130515215028.GA11883@animalcreek.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:36600 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197Ab3EPMIY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 May 2013 08:08:24 -0400
In-Reply-To: <20130515215028.GA11883@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 15.05.2013 23:50, Mark A. Greer wrote:
> On Wed, May 15, 2013 at 10:07:35AM -0700, Tony Lindgren wrote:
>> * Mark A. Greer <mgreer@animalcreek.com> [130514 18:57]:
>>> On Tue, May 14, 2013 at 05:25:37PM -0700, Tony Lindgren wrote:
>>>> Commit a819c4f1 (ARM: OMAP3: PM: Only access IVA if one exists)
>>>> changed PM to not access IVA registers on omaps that don't have
>>>> them. Turns out we still need to idle iva2 as otherwise iva2_pwrdm
>>>> will stay on and block deeper idle states.
>>>>
>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>>
>>>> ---
>>>>
>>>> Paul & Kevin, do you have better ideas for fixing this?
>>>>
>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>> @@ -546,8 +546,10 @@ static void __init prcm_setup_regs(void)
>>>>  	/* Clear any pending PRCM interrupts */
>>>>  	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>>>>  
>>>> -	if (omap3_has_iva())
>>>> -		omap3_iva_idle();
>>>> +	/*
>>>> +	 * We need to idle iva2_pwrdm even on am3703 with no iva2.
>>>> +	 */
>>>> +	omap3_iva_idle();
>>>>  
>>>>  	omap3_d2d_idle();
>>>>  }
>>>
>>> [Kevin, Paul, some background: Tony discovered that the am3703 needs
>>> to have omap3_iva_idle() called even though its not supposed to have
>>> an IVA.]
>>>
>>> This is potentially bad for other SoC's that don't have an IVA so I don't
>>> think its the way to go.  My preference would be to set the OMAP3_HAS_IVA
>>> flag for the am3703 only since its the one with the bug.  Maybe something
>>> in id.c:omap3xxx_check_features() but I don't see any existing way to check
>>> for an am3703 vs. other am37xx SoCs.  Any ideas?
>>>
>>> Another option, I suppose, is a dts entry but I don't like that at all.
>>
>> It seems that iva2_pwrdm is there for all omap3 even if OMAP3_HAS_IVA
>> flag is unset. And if that's the case, iva2 clocks still need to be idled
>> in all cases.
> 
> Ahh, this takes us to the "Great TI Docs Mystery" :) -- its basically
> impossible to tell because despite what their docs may say, the hardware
> can be quite different.  I'm not sure how to proceed other than trial &
> error with as many different SoCs as we can find.
> 
>> It's possible that not all steps in omap3_iva_idle() are needed though.
>> I can debug further to see which part of the omap3_iva_idle() are needed.
>>
>> Mark, do you have some omap3 with no iva (other than am3703) to test the
>> idle states with?
> 
> I have an am35xx which isn't supposed to have an IVA so I can test with it
> (although, I'm not sure how well the kernel works on the am35xx these days).
> 
> I'm a bit busy today but I'll try booting the am35xx tomorrow and if it
> comes up, see what I can figure out.

I think this issue is relevant to am3517 as you can see from this thread: http://thread.gmane.org/gmane.linux.ports.arm.omap/97903
I could boot only with your patch http://www.spinics.net/lists/arm-kernel/msg168865.html

I have such a system running, so if you have any other patches/ideas to test, I would do it.

Yegor

