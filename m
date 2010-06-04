From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: omap3 pm: dependency between opp layer and cpufreq
Date: Fri, 4 Jun 2010 18:04:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03232DA8BC@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>
	<4BFE9D7E.8020602@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>
	<7A436F7769CA33409C6B44B358BFFF0C0132DE0A84@dlee02.ent.ti.com>
	<068A0169-7F7B-46D6-B3B6-462EEFB66026@student.utwente.nl>
	<4BFFC622.90904@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E71FE512@dbde02.ent.ti.com>
	<4BFFCB6B.50005@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E71FE537@dbde02.ent.ti.com>
	<1275065163.10319.5.camel@Nokia-N900-51-1>
	<B85A65D85D7EB246BE421B3FB0FBB59301E5828FC2@dbde02.ent.ti.com>
	<4C0338B6.6070803@gmail.com> <87sk552ddx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48567 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800Ab0FDMe5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 08:34:57 -0400
In-Reply-To: <87sk552ddx.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "Menon, Nishanth" <nm@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Thursday, June 03, 2010 5:31 AM
>>To: Nishanth Menon
>>Cc: Premi, Sanjeev; Menon, Nishanth; Koen Kooi; linux-omap@vger.kernel.org;
>>eduardo.valentin@nokia.com
>>Subject: Re: omap3 pm: dependency between opp layer and cpufreq
>>
>>Nishanth Menon <menon.nishanth@gmail.com> writes:
>>
>>> On 05/30/2010 01:50 PM, Premi, Sanjeev wrote:
>>>>
>>[...]
>>
>>>> [sp] There is no mention of cpufreq not working; but specifically the support of bootarg "mpurate"
>>which is independent of cpufreq.
>>>>
>>>> The bootarg mpurate has been existing since quite sometime. I am neither creating a new layer /
>>replacement
>>>> for cpufreq not trying to duplicate the code. The intent is simply
>>>> as
>>> stated below:
>>>>
>>>> 1) Expose OPP layer - don't hinde it under CONFIG_CPU_FREQ.
>>> ok with this
>>>>
>>>> 2) Use OPP layer to:
>>>>      - Validate that the requested mpurate is defined in the OPP table for the device
>>>>      - And get the voltage corresponding to the OPP.
>>> sounds good too
>>>>
>>>> 3) Ensure that right freq and voltage is set - at init time - based on the mpurate.
>>> ok
>>>
>>>>
>>>> 4) And at some poit later break the linkage between op player amd PMIC.
>>>>
>>> aah you mean a simple patch as follows?
>>> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
>>> index 2b9ebf0..bfb3d0e 100644
>>> --- a/arch/arm/plat-omap/Makefile
>>> +++ b/arch/arm/plat-omap/Makefile
>>> @@ -16,7 +16,8 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
>>>  # XXX The OPP TWL/TPS code should only be included when a TWL/TPS
>>>  # PMIC is selected.
>>>  ifdef CONFIG_CPU_FREQ
>>> -obj-$(CONFIG_ARCH_OMAP3) += opp.o opp_twl_tps.o
>>> +obj-$(CONFIG_ARCH_OMAP3) += opp.o
>>> +obj-$(CONFIG_TWL4030_CORE) += opp_twl_tps.o
>>>  endif
>>>
>>>  # omap_device support (OMAP2+ only at the moment)
>>> --
>>> note - opp layer was never tied to pmic -> there is pmic voltage
>>> conversion apis in opp_twl_tps.c
>>>
>>> or is there more in your view?
>>>
>>>>>
>>>>>>
>>>>>> anyways for cpufreq to work at 720Mhz, you need to add that frequency
>>>>>> and corresponding voltage to the opptable, neither exists, further
>>>>>> mpurate should work with opp table as well, else
>>>>>> clockframework has no
>>>>>> direct mechanism to verify the valid OPPs on a runtime
>>>>>> system. that was
>>>>>> the intent of opp layer - to provide the rest of the users with a
>>>>>> mechanism to verify, query and use opps without functional
>>>>>> knowledge of
>>>>>> the silicon it works on..
>>>
>>> ofcourse, please feel free to post a patch for the missing frequencies.
>>>
>>
>>
>>OK, I must admit to not reading this whole thread since I've just
>>restructured OPP and CPUfreq support in the PM branch.
>>
>>OPP support is now in the pm-opp branch (based on mainline) and
>>CPUfreq support is now in the pm-cpufreq branch (based on mainline.)
>>
>>Please update this patch/series against one (or both) of those
>>branches for more discussion.
>>
>>FWIW, I like the name change from cpufreq34xx --> opp34xx_data, and
>>the Makefile change above makes sense.  Both of these changes should
>>be re-submitted against my pm-opp branch.
>>

Hi All, 

I was just going through the entire series. IMO, it is a good idea to take the opp layer
out of CONFIG_CPU_FREQ considering cpu freq  need not be the only layer using the opp
structures. Tomorrow we could have a l3 bus governor or a constraint framework
that will need to use the same framework. So it is best if the opp layer is not dependent on
the cpu freq layer.
Slightly off the topic but considering we are discussing opp layer here, I do not find API's
that take the OPP type (OPP_MPU or OPP_L3) and voltage/frequency as parameters and returns back the associated frequency/voltage. I do not want to get the opp table entry every time I do this. Any chance of introducing this in the framework? I could send a patch for the same.

Regards
