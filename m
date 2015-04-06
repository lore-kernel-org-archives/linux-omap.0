From: Ryan <ryanphilips19@googlemail.com>
Subject: Re: omap voltage management
Date: Mon, 6 Apr 2015 21:06:29 +0530
Message-ID: <CANMsd00+fRi=gwXh-jdXQ0NhxPzzUf4-DHY8k8ZK1LBni0YFYQ@mail.gmail.com>
References: <CAJ2oMhKGG9YrM4+rVdi2wZP=y4OBmCkw3GjgwBq-HpvtbWyNVg@mail.gmail.com>
	<20150319202750.GM31346@atomide.com>
	<CAJ2oMhLTH5ix0-6i=bzyqsGVuhf3aJUY5RhYyDLacdKOTCLNRg@mail.gmail.com>
	<CAJ2oMhKLL8O2Pngg4=YwLmOMApvnJm9UPUhu+SJ421H72ONhTg@mail.gmail.com>
	<20150325214725.GC31346@atomide.com>
	<CAGo_u6rjAfzZ9YO0xDFcZQi1Su6fThn8xaKUAJ2xH_jK-Lf8mw@mail.gmail.com>
	<CANMsd02X43ZpL3PkLJKYKXtTutfi9t=-CUYvxET0DA1jgVm7DA@mail.gmail.com>
	<551BF6EA.6060900@ti.com>
	<CANMsd02ULXNRT7fpX=Ry+AADosY2OAbdTxGKb2WhJnMXv2zVwQ@mail.gmail.com>
	<55228570.9040504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36581 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbbDFPga (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2015 11:36:30 -0400
Received: by igblo3 with SMTP id lo3so23885548igb.1
        for <linux-omap@vger.kernel.org>; Mon, 06 Apr 2015 08:36:29 -0700 (PDT)
In-Reply-To: <55228570.9040504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ran Shalit <ranshalit@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Nishanth,

On Mon, Apr 6, 2015 at 6:39 PM, Nishanth Menon <nm@ti.com> wrote:
> On 04/06/2015 06:42 AM, Ryan wrote:
>>
>> On Wed, Apr 1, 2015 at 7:17 PM, Nishanth Menon <nm@ti.com> wrote:
>>>
>>> On 04/01/2015 08:18 AM, Ryan wrote:
>>>>
>>>> Hi,
>>>>
>>>> I would like to ask a related question here
>>>
>>> Please try not to top post :).
>>>
>>>>
>>>> If i use performance governor alone - constantly running at the
>>>> highest frequency. Does the smart reflex still has a role to play?
>>>
>>> Yes. cpufreq governor are just policies - cpufreq policies just
>>> selects a frequency to run the CPU from a list of frequencies. for
>>> each frequency to be achieved, there is ABB, AVS configuration needed
>>> (strategy specific to SoC).
>>
>>
>> I was trying to find out where exactly the voltages for core and IVA
>> are set in the code.
>
>
> The generic layer for dvfs is yet to be implemented in k.org.
>

I am using a older TI Kernel. I thought this will a good starting
point to understand
as the platform i am working on uses this. if you could provide some pointers
on who initiates the voltage transition and how for each freq. It
would be highly helpful. I did add prints and start tracing
It became too complex for me to fully get a understanding.

http://git.omapzoom.org/?p=kernel/omap.git;a=tree;h=refs/heads/p-android-omap-3.0;hb=refs/heads/p-android-omap-3.0

>> Are they set whenever for every frequency change? - I see that the
>
>
> yes.
>
>> table is divided into OPP50, OPP100 and
>> so on but was not able to trace the entire path.
>>

Say if i use a lower freq (OPP50) - Apart from MPU - Should both core
and iva voltages should
also be set to opp50 voltages as listed in omap446x_vdd_core_volt_data
and omap446x_vdd_core_volt_data?

>> Also, does smartreflex framework uses the same path to change the
>> voltages (omap446x_vdd_core_volt_data,
>> omap446x_vdd_core_volt_data)
>
>
> 4460 on Panda-es does not have an implementation yet.
> --
> Regards,
> Nishanth Menon
>
