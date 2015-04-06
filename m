From: Nishanth Menon <nm@ti.com>
Subject: Re: omap voltage management
Date: Mon, 06 Apr 2015 08:09:04 -0500
Message-ID: <55228570.9040504@ti.com>
References: <CAJ2oMhKGG9YrM4+rVdi2wZP=y4OBmCkw3GjgwBq-HpvtbWyNVg@mail.gmail.com>	<20150319202750.GM31346@atomide.com>	<CAJ2oMhLTH5ix0-6i=bzyqsGVuhf3aJUY5RhYyDLacdKOTCLNRg@mail.gmail.com>	<CAJ2oMhKLL8O2Pngg4=YwLmOMApvnJm9UPUhu+SJ421H72ONhTg@mail.gmail.com>	<20150325214725.GC31346@atomide.com>	<CAGo_u6rjAfzZ9YO0xDFcZQi1Su6fThn8xaKUAJ2xH_jK-Lf8mw@mail.gmail.com>	<CANMsd02X43ZpL3PkLJKYKXtTutfi9t=-CUYvxET0DA1jgVm7DA@mail.gmail.com>	<551BF6EA.6060900@ti.com> <CANMsd02ULXNRT7fpX=Ry+AADosY2OAbdTxGKb2WhJnMXv2zVwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36013 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbbDFNJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2015 09:09:06 -0400
Received: by obbec2 with SMTP id ec2so39082516obb.3
        for <linux-omap@vger.kernel.org>; Mon, 06 Apr 2015 06:09:06 -0700 (PDT)
In-Reply-To: <CANMsd02ULXNRT7fpX=Ry+AADosY2OAbdTxGKb2WhJnMXv2zVwQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>, Ran Shalit <ranshalit@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 04/06/2015 06:42 AM, Ryan wrote:
> On Wed, Apr 1, 2015 at 7:17 PM, Nishanth Menon <nm@ti.com> wrote:
>> On 04/01/2015 08:18 AM, Ryan wrote:
>>> Hi,
>>>
>>> I would like to ask a related question here
>> Please try not to top post :).
>>
>>>
>>> If i use performance governor alone - constantly running at the
>>> highest frequency. Does the smart reflex still has a role to play?
>> Yes. cpufreq governor are just policies - cpufreq policies just
>> selects a frequency to run the CPU from a list of frequencies. for
>> each frequency to be achieved, there is ABB, AVS configuration needed
>> (strategy specific to SoC).
>
> I was trying to find out where exactly the voltages for core and IVA
> are set in the code.

The generic layer for dvfs is yet to be implemented in k.org.

> Are they set whenever for every frequency change? - I see that the

yes.

> table is divided into OPP50, OPP100 and
> so on but was not able to trace the entire path.
>
> Also, does smartreflex framework uses the same path to change the
> voltages (omap446x_vdd_core_volt_data,
> omap446x_vdd_core_volt_data)

4460 on Panda-es does not have an implementation yet.
--
Regards,
Nishanth Menon

