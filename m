From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: omap3 pm: dependency between opp layer and cpufreq
Date: Mon, 31 May 2010 07:19:02 +0300
Message-ID: <4C0338B6.6070803@gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>	 ,<4BFE9D7E.8020602@ti.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301E5828FC1@dbde02.ent.ti.com>	 <7A436F7769CA33409C6B44B358BFFF0C0132DE0A84@dlee02.ent.ti.com>	 <068A0169-7F7B-46D6-B3B6-462EEFB66026@student.utwente.nl>	 <4BFFC622.90904@ti.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301E71FE512@dbde02.ent.ti.com>	 <4BFFCB6B.50005@ti.com>	  <B85A65D85D7EB246BE421B3FB0FBB59301E71FE537@dbde02.ent.ti.com>,<1275065163.10319.5.camel@Nokia-N900-51-1> <B85A65D85D7EB246BE421B3FB0FBB59301E5828FC2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:54280 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab0EaETI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 00:19:08 -0400
Received: by ewy8 with SMTP id 8so860261ewy.28
        for <linux-omap@vger.kernel.org>; Sun, 30 May 2010 21:19:04 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E5828FC2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

On 05/30/2010 01:50 PM, Premi, Sanjeev wrote:
>
> ________________________________________
> From: Nishanth menon [menon.nishanth@gmail.com]
> Sent: Friday, May 28, 2010 10:16 PM
> To: Premi, Sanjeev; Menon, Nishanth
> Cc: Koen Kooi; linux-omap@vger.kernel.org; eduardo.valentin@nokia.com; Kevin Hilman
> Subject: Re: omap3 pm: dependency between opp layer and cpufreq
>
> ----- Original message -----
> (...)
>>>>>>>> [sp] I does - via bootarg - mpurate!
>>>>>>>>
>>>>>>>> When kernel boots, volatge must be set properly.
>>>>>>>> We cannot rely on u-boot to be settiing everything
>>>>> correctly. e.g. 720MHz
>>>>>>>> on OMAP3530 would fail at nominal 1.2V set by u-boot.
>>>>>>>
>>>>>>> I agree, but mpurate does not seem to use the cpufreq
>>>>> interfaces - so is
>>>>>>> kinda a question how it interfaces back ->     but note,
>>>>> mpurate tells us what
>>>>>>> the start freq is for the system - it still does no
>>>>> *dynamic* transitions -
>>>>>>> just a static startup frequency. But I agree, it assumes
>>>>> that if you provide
>>>>>>> mpurate, the system supposedly is operating at that
>>>>> frequency, aka all
>>>>>>> setups have been done for that operational
>>>>> frequency(including voltage)
>>>>>>
>>>>>> There's also a funny bug in the current (PSP)
>>>>> mpurate/cpufreq code. The mpurate code has a
>>>>>     >   check for 720MHz on 35xx silicon, but cpufreq doesnt.
>>> So I can do:
>>>>>>
>>>>>> setenv bootargs '<foo>     mpurate=720'
>>>>>>
>>>>>> And the kernel will say "unsupported" and not switch to
>>>>> 720MHz during boot. But if I do this after boot:
>>>>>>
>>>>>> cpufreq-set -f 720
>>>>>>
>>>>>> it *will* switch to 720MHz, even if the mpurate code
>>>>> explicitly forbids it. I tested on all the
>>>>>     >OMAP3 silicon I have and it will run at 720MHz fine, even
>>>>> if it's out
>>>>> of spec, so I'm happy with this bug :)
>>>>>
>>>>> :) on mainline, if you dont have the frequency in opp
>>> definitions and
>>>>> your board has not done an explicit opp_add, cpufreq will
>>>>> only set u to
>>>>> the nearest available freq - easy for mainline fix if someone
>>>>> would like
>>>>> to send a patch adding the OPPs and the detection logic
>>> involved for
>>>>> enabling them.
>>>>>
>>>>> Now, thinking aloud, the voltage setting by SR will
>>> probably occur in
>>>>> late_init, if mpurate is setting the clock earlier in the
>>>>> boot process,
>>>>> we might have a potential conflict in the mpurate expecting
>>>>> the system
>>>>> to be set in a certain voltage based on Sanjeev's argument, but not
>>>>> actually there.. we expect ondemand+cpufreq to do the job
>>> on runtime
>>>>> anyways.
>>>>
>>>> Nishanth,
>>>>
>>>> When setting via mpurate, we need to get the appropriate voltage
>>>> corresponding to the mpurate so that right combination can be done.
>>>>
>>>> This is where the mapping between freq and voltage needs to
>>> be queried.
>>>> And OPP layer is best placed to provide the info... without
>>> duplication.
>>>> The mechanism of changing the voltage itself can vary on the PMIC.
>>>>
>>>> BTW, I am getting ready to submit an updated patch for mpurate. Just
>>>> waiting for an early resolution to this discussion.
>>>
>>> aye, I am aware of the concept here, just questioning what
>>> does it mean
>>> by setting mpurate to the kernel - it could mean two things:
>>> a) mean this is mpurate that the system was working on (aka)
>>> - now setup
>>> the required stuff to continue to function at that rate.
>>> b) go to this rate and forget where you were running at.
>>>
>>> the job of ondemand and other governors is to adjust to an
>>> optimal OPP
>>> using cpufreq which would conflict IMHO with (b), which kinda
>>> questions
>>> if you dont use cpufreq, does mpurate mean actually (a)?
>>
>> 'mpurate' is usually used when cpufreq is not required. It
>> means - set me up for the specified freq and forget it. There
>> is no further change needed/ possible.
> That opens up the question - why not use cpufreq with userspace governor instead? Esp if u dont want a change in freq, ok i get the part where u'd like a single freq for the system to function at, but u also mention, mpurate is for systems that dont care abt any other dependencies. So, bit of a contradiction if it depends on scaling voltage to the right level aka u are selecting an freq from opp table.
>
> This in my mind means u shud modify mpurate to use opp layer aka another user beyond cpufreq.
>
> [sp] That what the discussion is all about. but currently the opp layer is hidden/ wrapped inside CONFIG_CPU_FREQ.
 > And I want to move it out. See an earlier patch that I send to this 
effect.

http://marc.info/?l=linux-omap&m=127496850617818&w=2 ? or did i miss the 
link? might be good to point to the right patch.. the opp layer 
initially was not under CONFIG_CPU_FREQ, it was moved after debate in 
this list. if there is a reason to move it out, i dont see why we cant 
do it..

>
>>
>> You could always argue that it can be done in u-boot; but this
>> bootarg helps people choose target freq keeping the u-boot same.
>
> Errr..... Makes me feel that u shud really be using cpufreq instead!
> [sp] This bootarg is meant for setting frequency. without baggage of cpufreq; so why not use it?
>
>   Either way i am not completely convinced u shud be doing voltage scaling when using mpurate given ur description-
> [sp] So how would I run the 3530 at 720MHZ when the VDD1 is only 1.2V OR 3630 at 1GHz via 'mpurate'? Do you expect it to run magically :)

I dont really care either way in reality, for me, cpufreq can:
a) set a single freq,
b) change frequencies dynamically.
Vs:
mpurate sets a single freq.

the way to set voltage will be to use the new voltage layer, if we 
isolate the frequencies to the opp layer, no reason why mpurate cant 
query for valid ones and use them.


my point of contention was: is mpurate meant for bootloader telling what 
configuration it is on to kernel, hence kernel continuing that 
configuration Vs, bootloader using mpurate to tell kernel what frequency 
it should run on. thanks it is clarified now that it is the later of the 
two.

>
> if u are trying to write a new cpufreq layer, why not fix why cpufreq doesn't work for u and help the rest of us as well ;)
> [sp] There is no mention of cpufreq not working; but specifically the support of bootarg "mpurate" which is independent of cpufreq.
>
> The bootarg mpurate has been existing since quite sometime. I am neither creating a new layer / replacement
 >for cpufreq not trying to duplicate the code. The intent is simply as 
stated below:
>
> 1) Expose OPP layer - don't hinde it under CONFIG_CPU_FREQ.
ok with this
>
> 2) Use OPP layer to:
>      - Validate that the requested mpurate is defined in the OPP table for the device
>      - And get the voltage corresponding to the OPP.
sounds good too
>
> 3) Ensure that right freq and voltage is set - at init time - based on the mpurate.
ok

>
> 4) And at some poit later break the linkage between op player amd PMIC.
>
aah you mean a simple patch as follows?
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 2b9ebf0..bfb3d0e 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -16,7 +16,8 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
  # XXX The OPP TWL/TPS code should only be included when a TWL/TPS
  # PMIC is selected.
  ifdef CONFIG_CPU_FREQ
-obj-$(CONFIG_ARCH_OMAP3) += opp.o opp_twl_tps.o
+obj-$(CONFIG_ARCH_OMAP3) += opp.o
+obj-$(CONFIG_TWL4030_CORE) += opp_twl_tps.o
  endif

  # omap_device support (OMAP2+ only at the moment)
--
note - opp layer was never tied to pmic -> there is pmic voltage 
conversion apis in opp_twl_tps.c

or is there more in your view?

>>
>>>
>>> anyways for cpufreq to work at 720Mhz, you need to add that frequency
>>> and corresponding voltage to the opptable, neither exists, further
>>> mpurate should work with opp table as well, else
>>> clockframework has no
>>> direct mechanism to verify the valid OPPs on a runtime
>>> system. that was
>>> the intent of opp layer - to provide the rest of the users with a
>>> mechanism to verify, query and use opps without functional
>>> knowledge of
>>> the silicon it works on..

ofcourse, please feel free to post a patch for the missing frequencies.


Regards,
Nishanth Menon
