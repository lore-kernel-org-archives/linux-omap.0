From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv1 1/1] omap3: pm: Delink opp layer and cpufreq
Date: Mon, 26 Jul 2010 10:41:53 -0500
Message-ID: <4C4DACC1.8030902@ti.com>
References: <1275309542-26004-1-git-send-email-premi@ti.com> <4C03F1E3.9030202@gmail.com> <B85A65D85D7EB246BE421B3FB0FBB59301E7290649@dbde02.ent.ti.com> <4C05DFE2.70004@gmail.com> <B85A65D85D7EB246BE421B3FB0FBB59301E7DA1AB3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54632 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754646Ab0GZPlz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Jul 2010 11:41:55 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA1AB3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev had written, on 07/26/2010 10:35 AM, the following:
>> -----Original Message-----
>> From: Nishanth Menon [mailto:menon.nishanth@gmail.com] 
>> Sent: Wednesday, June 02, 2010 10:07 AM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCHv1 1/1] omap3: pm: Delink opp layer and cpufreq
>>
>> On 06/01/2010 03:01 PM, Premi, Sanjeev wrote:
>>>> -----Original Message-----
>>>> From: Nishanth Menon [mailto:menon.nishanth@gmail.com]
>>>> Sent: Monday, May 31, 2010 10:59 PM
>>>> To: Premi, Sanjeev
>>>> Cc: linux-omap@vger.kernel.org
>>>> Subject: Re: [PATCHv1 1/1] omap3: pm: Delink opp layer and cpufreq
>>>>
>>>> On 05/31/2010 03:39 PM, Sanjeev Premi wrote:
>>>>> The OPP layer was contained in the CONFIG_CPU_FREQ.
>>>>> This patch removes this containment relation.
>>>>>
>>>>> Signed-off-by: Sanjeev Premi<premi@ti.com>
>>>>> ---
>>>>>    arch/arm/mach-omap2/Makefile          |    6 +-
>>>>>    arch/arm/mach-omap2/board-omap3evm.c  |    2 +-
>>> [snip]--[snip]
>>>
>>>> you sure this is the only board file having "omap3-opp.h" ?
>>>> anyway.. the
>>>> need for board files to use opp_init is gone with my patch
>>>> http://marc.info/?l=linux-omap&m=127507237109393&w=2
>>>> so I wont harp on it, I would rather post a cleanup patch for
>>>> all board
>>>> files once the patch is in..(or mebbe kevin could drop the 
>> patch that
>>>> adds opp_init_table to board files ;) )..
>>>>
>>> [sp] You didn't reead the 0/1 of the patch series, where I 
>> have clearly
>>> mentioned that I will make changes to the other board specific files
>>> once there rest of the changes are well discussed. There 
>> may be, possibly,
>>> more changes in the board specific files and we can review 
>> them in the
>>> context of this file and then same can be repeated for 
>> other board files.
>> ok
>>
>>>>>    arch/arm/mach-omap2/cpufreq34xx.c     |  164
>>>> --------------------------------
>>>>>    arch/arm/mach-omap2/omap3-opp.h       |   20 ----
>>>>>    arch/arm/mach-omap2/opp34xx_data.c    |  166
>>>> +++++++++++++++++++++++++++++++++
>>>>>    arch/arm/mach-omap2/pm34xx.c          |    1 -
>>>>>    arch/arm/plat-omap/Makefile           |    7 +-
>>>>>    arch/arm/plat-omap/cpu-omap.c         |   47 +++++++++
>>>>>    arch/arm/plat-omap/include/plat/opp.h |   82 +---------------
>>>>>    arch/arm/plat-omap/opp.c              |   46 ---------
>>>>>    10 files changed, 225 insertions(+), 316 deletions(-)
>>>>>    delete mode 100644 arch/arm/mach-omap2/cpufreq34xx.c
>>>>>    delete mode 100644 arch/arm/mach-omap2/omap3-opp.h
>>>>>    create mode 100644 arch/arm/mach-omap2/opp34xx_data.c
>>>>>
>>> [sp]
>>>> finding it difficult to align with this change, you introduce
>>>> omap3_pm_init_opp_table later into plat/opp.h which defeats generic
>>>> nature of opp.h - as it was supposed to be used for other
>>>> omaps as well..
>>> In that case the function omap3_pm_init_opp_table() can be made
>>> generic by renaming to omap_pm_init_opp_table and can be implemented
>>> for each omap family.
>> Do you intend to handle multiomap case by calling
>> each omap[1234]_pm_init_opp_table() if cpu_is_omap34xx() etc? 
>> you will 
>> still need a custom omap family specific init_opp_table - 
>> that is what 
>> this header provides.
>>
>>> If opp table has to be implementyed for each family then why have
>>> different funtion with family specific prefixes?
>> opp table contents will be different for each family and they 
>> should all 
>> build and co-exist in a single uImage.
>>
>>> Also, what this headerf ile is/was doing? only defining the
>>> function to return -EINVAL when CONFIG_CPU_FREQ is not selected;
>>> which is not required. For OPP layer to be used this table needs
>>> to be populated. Now, there is only one place this function is
>>> used, so why do/should be need a header for the same.
>> To allow the the external function that triggers it to be able to use 
>> it.. :)
>>
>>> [snip]--[snip]
>>>
>>>> +obj-y				+= opp.o
>>>> +obj-$(CONFIG_TWL4030_POWER)	+= opp_twl_tps.o
>>> NAK. you just need TWL4030_CORE not power here. any reason to retain
>>> power? it has no dependency on power..
>>>
>>> [sp] Isn't this purpose of this opp to TWL linkage is to define
>>> the voltages in terms the PMIC connected; and later make sure
>>> that correct voltages are set via the PMIC? This is very 
>> much related
>> no it does not. these are just translation functions, as long 
>> as _CORE 
>> exists, it means that the system uses twl and we should be good to go.
>>
>>> to POWER. We could also do it on CORE; but I don't see this as a
>>> big issue.
>> ok.
>>
>>> But TWL4030 has more feature beyond PMIC but this is not the case
>>> with other simpler PMICs and I wanted to use CONFIG option that
>>> can be easier for someone else make the port easy to spot 
>> as a necessary
>>> change.
>> i am aligned with the change, except that I believe you should not be 
>> using POWER as the prefix for the config build dependency.
>>
>>> [snip]--[snip]
>>>
>>>>> +	freq_table[i].index = i;
>>>>> +	freq_table[i].frequency = CPUFREQ_TABLE_END;
>>>>> +
>>>>> +	*table =&freq_table[0];
>>>>> +}
>>>>> +#endif
>>>>> +
>>>> errrr.... why? it used to be here and was moved to opp.c - see
>>>> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-p
>>> m.git;a=commit;h=9a6b00f70e9f4bce30ad4f8fab41a24bd3706dbd
>>>> you are essentially reverting that patch!
>>> [sp] May be I am reverting the patch, but I don't see this function
>>>       being used anywhere else. Most of the other cpufreq related
>>>       initialization is happening at this place.
>>>
>>>       Only the function omap_cpu_init() calls this function and it
>>>       is in the same file.
>>>
>>>       It also helps in need of an additional header; which seem
>>>       to make "de-linking" more complex - in terms of #ifdefs.
>> the idea was to have a common function for ALL omaps to 
>> create the table 
>> and reuse it where ever needed, if you look beyond omap3 into omap1,2 
>> and 4, the ability to do this is invaluable. does it matter if a 
>> function exists in the library even if not used?
>>
>>> [snip]--[snip]
>>>
>>>>> +/**
>>>>> + * omap3_pm_init_opp_table() - Initialize the OPP table
>>>> for OMAP3 devices.
>>>>> + *
>>>>> + * Initializes the OPP table for the current OMAP3 device.
>>>>> + */
>>>>> +int __init omap3_pm_init_opp_table(void);
>>>> NAK. opp. is meant to be used by omap2, OMAP4 etc..
>>>> when you removed from omap3-opp.h, it kinda needed you to
>>>> have it here,
>>>> which breaks the generic nature of this header.
>>> [sp] See my comment earlier. The function for init-ing the OPP
>>>       table can be made generic. Then (after rename) this is a
>>>       generic function itself.
>>>
>>>       Rather than making sweelping changes, I am only delinking
>>>       the OPP layer and CPU freq. These changes can be done
>>>       separately.
>> replied above.
>>
>>>>> -#endif		/* CONFIG_CPU_FREQ */
>>>>>    #endif		/* __ASM_ARM_OMAP_OPP_H */
>>>>> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
>>>>> index 13da451..3ed3ec1 100644
>>>>> --- a/arch/arm/plat-omap/opp.c
>>>>> +++ b/arch/arm/plat-omap/opp.c
>>>>> @@ -351,49 +351,3 @@ int opp_disable(struct omap_opp *opp)
>>>>>    	opp->enabled = false;
>>>>>    	return 0;
>>>>>    }
>>>>> -
>>>>> -/* XXX document */
>>>>> -void opp_init_cpufreq_table(enum opp_t opp_type,
>>>>> -			    struct cpufreq_frequency_table **table)
>>>>> -{
>>>>> -	int i = 0, j;
>>>>> -	int opp_num;
>>>>> -	struct cpufreq_frequency_table *freq_table;
>>>>> -	struct omap_opp *opp;
>>>>> -
>>>>> -	if (opp_type>= OPP_TYPES_MAX) {
>>>>> -		pr_warning("%s: failed to initialize frequency"
>>>>> -				"table\n", __func__);
>>>>> -		return;
>>>>> -	}
>>>>> -
>>>>> -	opp_num = opp_get_opp_count(opp_type);
>>>>> -	if (opp_num<   0) {
>>>>> -		pr_err("%s: no opp table?\n", __func__);
>>>>> -		return;
>>>>> -	}
>>>>> -
>>>>> -	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) *
>>>>> -			     (opp_num + 1), GFP_ATOMIC);
>>>>> -	if (!freq_table) {
>>>>> -		pr_warning("%s: failed to allocate frequency"
>>>>> -				"table\n", __func__);
>>>>> -		return;
>>>>> -	}
>>>>> -
>>>>> -	opp = _opp_list[opp_type];
>>>>> -	opp += opp_num;
>>>>> -	for (j = opp_num; j>= 0; j--) {
>>>>> -		if (opp->enabled) {
>>>>> -			freq_table[i].index = i;
>>>>> -			freq_table[i].frequency = opp->rate / 1000;
>>>>> -			i++;
>>>>> -		}
>>>>> -		opp--;
>>>>> -	}
>>>>> -
>>>>> -	freq_table[i].index = i;
>>>>> -	freq_table[i].frequency = CPUFREQ_TABLE_END;
>>>>> -
>>>>> -	*table =&freq_table[0];
>>>>> -}
>>>> not sure why you removed this..
>>>>
>>> [sp] It isn't removed but simply moved to the only file in 
>> the code where it
>>>       is being used... along with rest of the code related 
>> to CPU_FREQ.
>>> The way I see, the OPP layer has been mixed with CPUFREQ 
>> usage in the
>>> cureent code; but if you look at OPP layer as as "real" 
>> layer then the
>>> CPUFREQ implementation should be the "client" to this later 
>> and use its
>>> services - not get 'mingled' into the layer itself. If you 
>> go by this
>>> reasoning, this init function belong outside the OPP layer.
>> I have explained on top, further, the only set of dependencies i see:
>> a) naming of the the files
>> b) build and #ifdef CPUFREQ dependencies
>> these are changes I liked from your patch.
> 
> [sp] Picking this thread after long time (vacation and other digressions)
>      I haven't understood the last part in your comments. The premise of
>      the patch your comments seems to apparent "reversal" done. But if it
>      is helping achieve desired independence, then shouldn't it be done?
> 
>      Regarding filenames, what eaxctly is the issue?
I believe it was omap3-opp.h - which is not relevant anymore since we 
moved to hwmods for opp layer as well.. overall, do leave the cpufreq 
api alone, rebase, rename to opp34xx_data.c, decouple from CPUFREQ seems 
to be the main items left to do here..

-- 
Regards,
Nishanth Menon
