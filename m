From: Nishanth Menon <nm@ti.com>
Subject: Re: omap voltage management
Date: Mon, 6 Apr 2015 11:25:11 -0500
Message-ID: <5522B367.1070109@ti.com>
References: <CAJ2oMhKGG9YrM4+rVdi2wZP=y4OBmCkw3GjgwBq-HpvtbWyNVg@mail.gmail.com>	<20150319202750.GM31346@atomide.com>	<CAJ2oMhLTH5ix0-6i=bzyqsGVuhf3aJUY5RhYyDLacdKOTCLNRg@mail.gmail.com>	<CAJ2oMhKLL8O2Pngg4=YwLmOMApvnJm9UPUhu+SJ421H72ONhTg@mail.gmail.com>	<20150325214725.GC31346@atomide.com>	<CAGo_u6rjAfzZ9YO0xDFcZQi1Su6fThn8xaKUAJ2xH_jK-Lf8mw@mail.gmail.com>	<CANMsd02X43ZpL3PkLJKYKXtTutfi9t=-CUYvxET0DA1jgVm7DA@mail.gmail.com>	<551BF6EA.6060900@ti.com>	<CANMsd02ULXNRT7fpX=Ry+AADosY2OAbdTxGKb2WhJnMXv2zVwQ@mail.gmail.com>	<55228570.9040504@ti.com> <CANMsd00+fRi=gwXh-jdXQ0NhxPzzUf4-DHY8k8ZK1LBni0YFYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48006 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbbDFQZP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Apr 2015 12:25:15 -0400
In-Reply-To: <CANMsd00+fRi=gwXh-jdXQ0NhxPzzUf4-DHY8k8ZK1LBni0YFYQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: Tony Lindgren <tony@atomide.com>, Ran Shalit <ranshalit@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 04/06/2015 10:36 AM, Ryan wrote:
> Hi Nishanth,
> 
> On Mon, Apr 6, 2015 at 6:39 PM, Nishanth Menon <nm@ti.com> wrote:
>> On 04/06/2015 06:42 AM, Ryan wrote:
>>>
>>> On Wed, Apr 1, 2015 at 7:17 PM, Nishanth Menon <nm@ti.com> wrote:
>>>>
>>>> On 04/01/2015 08:18 AM, Ryan wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I would like to ask a related question here
>>>>
>>>> Please try not to top post :).
>>>>
>>>>>
>>>>> If i use performance governor alone - constantly running at the
>>>>> highest frequency. Does the smart reflex still has a role to play?
>>>>
>>>> Yes. cpufreq governor are just policies - cpufreq policies just
>>>> selects a frequency to run the CPU from a list of frequencies. for
>>>> each frequency to be achieved, there is ABB, AVS configuration needed
>>>> (strategy specific to SoC).
>>>
>>>
>>> I was trying to find out where exactly the voltages for core and IVA
>>> are set in the code.
>>
>>
>> The generic layer for dvfs is yet to be implemented in k.org.
>>
> 
> I am using a older TI Kernel. I thought this will a good starting
> point to understand
> as the platform i am working on uses this. if you could provide some pointers
> on who initiates the voltage transition and how for each freq. It
> would be highly helpful. I did add prints and start tracing
> It became too complex for me to fully get a understanding.
> 
> http://git.omapzoom.org/?p=kernel/omap.git;a=tree;h=refs/heads/p-android-omap-3.0;hb=refs/heads/p-android-omap-3.0

The 3.0 kernel uses a TI framework for dvfs. I suggest discussing on
e2e.ti.com for TI kernel forks. different TI kernel forks tend to use
different versions of custom frameworks. It might not be of much
interest in an upstream discussion mailing list to discuss TI kernel
frameworks.


-- 
Regards,
Nishanth Menon
