From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 2/2 v3] OMAP3: PM: SR: SmartReflex Refactor Rev4.0
Date: Mon, 26 Oct 2009 08:19:57 -0500
Message-ID: <4AE5A1FD.10308@ti.com>
References: <OMAP3:PM:SR: SmartReflex Refactor Rev3.0> <1256361352-9968-1-git-send-email-nm@ti.com> <1256361352-9968-2-git-send-email-nm@ti.com> <1256361352-9968-3-git-send-email-nm@ti.com> <74583B8642AB8841B30447520659FCA9DDDFCC3C@dnce01.ent.ti.com> <4AE4D85D.8030107@gmail.com> <74583B8642AB8841B30447520659FCA9DDDFD029@dnce01.ent.ti.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58821 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbZJZNTt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 09:19:49 -0400
Received: by yxe17 with SMTP id 17so9733842yxe.33
        for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 06:19:54 -0700 (PDT)
In-Reply-To: <74583B8642AB8841B30447520659FCA9DDDFD029@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Hogander Jouni <jouni.hogander@nokia.com>, "Sabatier, Sebastien" <s-sabatier1@ti.com>

Benoit,
thanks.. overall good discussion that is nice to take in.. more comments
follow:

Cousson, Benoit said the following on 10/26/2009 08:05 AM:
>> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
>>
>> Cousson, Benoit said the following on 10/25/2009 05:12 PM:
>>     
>>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-
>>>>
>>>>         
>> [...]
>>     
>>>> +     },
>>>> +             /* *INDENT-ON* */
>>>> +};
>>>> +
>>>> +/* SR list for 3430 */
>>>> +static __initdata struct omap_sr_list omap34xx_srlist = {
>>>> +     .num_sr = 2,
>>>> +     .sr_list = {&omap34xx_sr1, &omap34xx_sr2}
>>>> +};
>>>> +
>>>> +/* The final SR list */
>>>> +static struct omap_sr_list *omap_srlist;
>>>>
>>>>         
>>> I have a couple a suggestions regarding the code partitioning:
>>>
>>> - SmartReflex is one IP with several instances; it means that only the
>>>       
>> base address will change between SR1 and SR2. There is no need to
>> duplicate the mask and shift defines per SR.
>>     
>> might have been easier with a standard OCP wrapper and standard
>> INT/INTSTATUS regs for SR instead of the current integration.... but
>> yeah, I had been thinking of that- if O4/beyond could have the same IP
>> wrapped in a different register mapping, i should handle it then, not
>> dream about it now.. I get your point here.. there are a few places we
>> can kick it out and some places your are stuck with them!
>>     
>
> SR is a regular IP, with a dedicated PD, dedicated fclk and bound to the L4...
> VP/VC is not, that why I was proposing to separated them.
>   
I am not denying it, but VP/VC functions are already separated out where
I could do it (note the seperation of function names), only they dont
have a new file perse.. but that is not needed at the moment.
>   
>>> Moreover, SR being an IP, I think we can encode the one IP / several
>>>       
>> instance in a platform_device / platform_driver code. It will allow the
>> support of several drivers for the same devices in order to implement for
>> example class3, class2 or class1 drivers. SR can even be represented by an
>> HWMOD.
>>     
>> what is your intention in misusing platform_device for a SOC specific
>> code? I think you have an idea here that I am completely missing. can
>> you care to elaborate?
>>     
>
> AFAIK, platform_device is there in order to deal with SoC devices???
> Considering that SR is an IP that can be in several SoC, it looks to me the perfect candidate for platform_device/platform_driver.
> Am I missing something?
>   
Everything abstracted is a perfect candidate for device-driver model,
but that is beside the point. platform_device traditionally has been
platform aka board specific info, not SOC specific info..
>   
>>> - The smartreflex.c file contains 34xx specifics code; it should not be
>>>       
>> there, only SR specific code should be there.
>>     
>> read the TODO. which specific 3430 code does it have? other than using
>> macros which have 34xx prefix - that should be killed -yep.
>>     
>
> omap34xx_sr1, omap34xx_sr2, omap34xx_srlist... seem to be quite OMAP34xx specifics...
>   
please read the code carefully next time, look at how it is copied based
on cpu_is_ api in in __init??
yes, there are specific paramaters to SOC, you cannot avoid that. but
you can make the handling independent of the SOC. that is what I have
done.. let me know if you have a better idea.. :D..

>   
>>> - If we want to go further, I think that the VP/VC code should not be in
>>>       
>> SR code either. It is located in the PRM, and can be used independently of
>> SR.
>>     
>>>   - In a SR class 2 mode, the smartreflex driver will not use the direct
>>>     connection to the VP.
>>>   - If we don't want SR we can still use the VP/VC for device voltage
>>>     control.
>>>
>>>       
>>       - How about adding - Smart reflex  should actually fit in a
>> voltage control infrastructure so that the system can manipulate and set
>> voltage with and without SR..
>>     
>
> Fully agree, that was one of the proposals I had in mind, but since it will require some more works, it should be done in a second pass.
>
>   
>> that is what is really missing in our code base today -> SR and VP comes
>> plugged in close as buddies in all silicons, so if your recommendation
>> has an silicon example where OMAP SR talks not to VP, let me know and I
>> will second splitting the code :D. till then sorry.. you dont have a case.
>>     
>
> We had the case in several chips that unfortunately are not there anymore
> :-(
> The SR IP was done to handle several config, having SR tied to VP/VC is a chip dependant implementation.
>   
lets bring in a proper voltage control infrastructure then worry about
SR class2/class3 implementation. class2 is inferior to class 3 and the
overhead of cpu intervention should be balanced with a proper latency
heuristics, the infrastructure is sadly missing at this point of time..

>   
>> now, it is a different case where you want to use SR as a pure
>> monitoring engine -> that is not an implementation that is exactly
>> better than class 3 operation.. why support it at all?
>>     
>
> It is not a matter or being better, it is just having HW vs. SW implementation. The point is Class 3 is not usable with non SR compliant power IC. In that case you should rely on a Class 2 implementation.
>   
yep, I am aware of it.. but see my previous comment -> just thinking
PMIC is not enough, there is a tradeoff involved for Class 2 operation -
for continuous monitoring - hwmod etc might be a better option in that
case.. but most of the folks do use PMICs and can benefit.. for proper
values, you need NVALUES - dont forget that NOT all ICs have them burnt
in.. and cant use SR anyways properly..

>   
>>>  [snip]
>>>
>>>
>>>       
>>>> +/****************** PMIC WEAK FUNCTIONS FOR TWL4030 derivatives
>>>> **********/
>>>> +
>>>> +/**
>>>> + * @brief pmic_srinit - Power management IC initialization
>>>> + * for smart reflex. The current code is written for TWL4030
>>>> + * derivatives, replace in board file if PMIC requires
>>>> + * a different sequence
>>>> + *
>>>> + * @return result of operation
>>>> + */
>>>> +int __weak __init omap_pmic_srinit(void)
>>>> +{
>>>> +     int ret = -ENODEV;
>>>> +#ifdef CONFIG_TWL4030_CORE
>>>> +     u8 reg;
>>>> +     /* Enable SR on T2 */
>>>> +     ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &reg,
>>>> +                               R_DCDC_GLOBAL_CFG);
>>>> +
>>>> +     reg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
>>>> +     ret |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, reg,
>>>> +                                 R_DCDC_GLOBAL_CFG);
>>>> +#endif                               /* End of CONFIG_TWL4030_CORE */
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +/**
>>>> + * @brief omap_pmic_voltage_ramp_delay - how much should this pmic
>>>>         
>> ramp
>>     
>>>> delay
>>>> + * Various PMICs have different ramp up and down delays. choose to
>>>> implement
>>>> + * in required pmic file to override this function.
>>>> + * On TWL4030 derivatives:
>>>> + *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
>>>> + *  2us added as buffer.
>>>> + *
>>>> + * @param srid - which SR is this for?
>>>> + * @param target_vsel - targetted voltage selction
>>>> + * @param current_vsel - current voltage selection
>>>> + *
>>>> + * @return delay in uSeconds
>>>> + */
>>>> +u32 __weak omap_pmic_voltage_ramp_delay(u8 srid, u8 target_vsel,
>>>> +                                     u8 current_vsel)
>>>> +{
>>>> +     u32 t2_smps_steps = abs(target_vsel - current_vsel);
>>>> +     u32 t2_smps_delay = ((t2_smps_steps * 125) / 40) + 2;
>>>> +     return t2_smps_delay;
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_OMAP_VC_BYPASS_UPDATE
>>>> +/**
>>>> + * @brief omap_pmic_voltage_cmds - hook for pmic command sequence
>>>> + * to be send out which are specific to pmic to set a specific voltage.
>>>> + * this should inturn call vc_send_command with the required sequence
>>>> + * The current implementation is for TWL4030 derivatives
>>>> + *
>>>> + * @param srid - which SR is this for?
>>>> + * @param target_vsel - what voltage is desired to be set?
>>>> + *
>>>> + * @return specific value to set.
>>>> + */
>>>> +int __weak omap_pmic_voltage_cmds(u8 srid, u8 target_vsel)
>>>> +{
>>>> +     u8 reg_addr = (srid == SR1) ? R_VDD1_SR_CONTROL :
>>>>         
>> R_VDD2_SR_CONTROL;
>>     
>>>> +     u16 timeout = COUNT_TIMEOUT_TWL4030_VCBYPASS;
>>>> +     return vc_send_command(R_SRI2C_SLAVE_ADDR, reg_addr, target_vsel,
>>>> +                            &timeout);
>>>> +}
>>>> +#endif                               /* ifdef
>>>>         
>> CONFIG_OMAP_VC_BYPASS_UPDATE */
>>     
>>>> +
>>>>
>>>>         
>>> The TWL4030 specific code should not be there even if this is the
>>>       
>> default PMIC, it should be in TWL4030 driver code.
>>     
>>> The usage of weak functions will prevent a multiple OMAP build with
>>>       
>> different PMIC to work.
>>     
>>> The mapping between omap and TWL4030 should be done in the board
>>>       
>> specific code.
>>     
>> hmm good point.. have a recommendation here?
>>     
>
> We can define a struct with these methods. The struct will be implemented inside the PMIC code. The binding will be done in the board setup code. The SR driver will use the struct pointer to dereference the methods.
>   
I like words, but prefer a patch instead ;).. This is not something I
want to do over my lunch hour ;).. maybe we should take it up as a
follow up patch?

Regards,
NM
