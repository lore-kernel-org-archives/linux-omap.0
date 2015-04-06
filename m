From: Ryan <ryanphilips19@googlemail.com>
Subject: Re: omap voltage management
Date: Mon, 6 Apr 2015 17:12:23 +0530
Message-ID: <CANMsd02ULXNRT7fpX=Ry+AADosY2OAbdTxGKb2WhJnMXv2zVwQ@mail.gmail.com>
References: <CAJ2oMhKGG9YrM4+rVdi2wZP=y4OBmCkw3GjgwBq-HpvtbWyNVg@mail.gmail.com>
	<20150319202750.GM31346@atomide.com>
	<CAJ2oMhLTH5ix0-6i=bzyqsGVuhf3aJUY5RhYyDLacdKOTCLNRg@mail.gmail.com>
	<CAJ2oMhKLL8O2Pngg4=YwLmOMApvnJm9UPUhu+SJ421H72ONhTg@mail.gmail.com>
	<20150325214725.GC31346@atomide.com>
	<CAGo_u6rjAfzZ9YO0xDFcZQi1Su6fThn8xaKUAJ2xH_jK-Lf8mw@mail.gmail.com>
	<CANMsd02X43ZpL3PkLJKYKXtTutfi9t=-CUYvxET0DA1jgVm7DA@mail.gmail.com>
	<551BF6EA.6060900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36566 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbDFLmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2015 07:42:24 -0400
Received: by iebrs15 with SMTP id rs15so18748231ieb.3
        for <linux-omap@vger.kernel.org>; Mon, 06 Apr 2015 04:42:23 -0700 (PDT)
In-Reply-To: <551BF6EA.6060900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ran Shalit <ranshalit@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, Apr 1, 2015 at 7:17 PM, Nishanth Menon <nm@ti.com> wrote:
> On 04/01/2015 08:18 AM, Ryan wrote:
>> Hi,
>>
>> I would like to ask a related question here
> Please try not to top post :).
>
>>
>> If i use performance governor alone - constantly running at the
>> highest frequency. Does the smart reflex still has a role to play?
> Yes. cpufreq governor are just policies - cpufreq policies just
> selects a frequency to run the CPU from a list of frequencies. for
> each frequency to be achieved, there is ABB, AVS configuration needed
> (strategy specific to SoC).

I was trying to find out where exactly the voltages for core and IVA
are set in the code.
Are they set whenever for every frequency change? - I see that the
table is divided into OPP50, OPP100 and
so on but was not able to trace the entire path.

Also, does smartreflex framework uses the same path to change the
voltages (omap446x_vdd_core_volt_data,
omap446x_vdd_core_volt_data)

Could anyone help me understand this or point to some documentation.


>
>> Does smart-reflex involves reprogramming only the mpu power line alone?
>>
> AVS strategies apply to all rails in TI SoCs which need such strategies.
>
> --
> Regards,
> Nishanth Menon

Thanks.
