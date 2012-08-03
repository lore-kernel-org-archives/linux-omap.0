From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: timer: allow gp timer clock-event to be
 used on both cpus
Date: Fri, 3 Aug 2012 15:44:32 +0530
Message-ID: <CAMQu2gz-93W9zWD_v3m1nQkqmnvFwcWKDTxNsf0v39y9_rhQPA@mail.gmail.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
 <1333114048-26136-2-git-send-email-santosh.shilimkar@ti.com>
 <501B7AE6.8080405@gmail.com> <76308EBE-F802-411A-973A-7BBC7575FE5A@dominion.thruhere.net>
 <BDB76D4F-31B0-47D0-B1A1-64A743D091D3@dominion.thruhere.net>
 <CAMQu2gxLAVk-LN8R1xBeeL1=iZ-mLSRmtZe4wpQYQPTBsY5RMA@mail.gmail.com>
 <FF29FBF3-67EC-478E-9A74-65F8A2870BDC@dominion.thruhere.net>
 <79CD15C6BA57404B839C016229A409A83EA7F59B@DBDE01.ent.ti.com> <A6396D46-C6B9-44A4-A960-657668AF08E4@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:59152 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752496Ab2HCKPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 06:15:01 -0400
Received: by yhnn12 with SMTP id n12so544852yhn.10
        for <linux-omap@vger.kernel.org>; Fri, 03 Aug 2012 03:14:55 -0700 (PDT)
In-Reply-To: <A6396D46-C6B9-44A4-A960-657668AF08E4@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Daniel Mack <zonque@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ccross@android.com" <ccross@android.com>, Paul Walmsley <paul@pwsan.com>

On Fri, Aug 3, 2012 at 3:34 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
>
> Op 3 aug. 2012, om 11:42 heeft "Hiremath, Vaibhav" <hvaibhav@ti.com> het volgende geschreven:
>
>> On Fri, Aug 03, 2012 at 15:03:07, Koen Kooi wrote:
>>>
>>> Op 3 aug. 2012, om 11:27 heeft "Shilimkar, Santosh" <santosh.shilimkar@ti.com> het volgende geschreven:
>>>
>>>> On Fri, Aug 3, 2012 at 2:00 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
>>>>>
>>>>> Op 3 aug. 2012, om 09:21 heeft Koen Kooi <koen@dominion.thruhere.net> het volgende geschreven:
>>>>>
>>>>>>
>>>>>> Op 3 aug. 2012, om 09:16 heeft Daniel Mack <zonque@gmail.com> het volgende geschreven:
>>>>>>
>>>>>>> On 30.03.2012 15:27, Santosh Shilimkar wrote:
>>>>>>>> For coupled cpuidle to work when both cpus are active, it needs a global timer
>>>>>>>> that can handle events for both cpus.  This timer is used as the broadcast
>>>>>>>> clock-event when the per-cpu timer hardware stop in low power states.
>>>>>>>> Set the cpumask of clockevent_gpt to all cpus, set the rating correctly, and
>>>>>>>> set the irq to allow the clockevent core to determine the affinity of the
>>>>>>>> timer.
>>>>>>>
>>>>>>> These patches made it to mainline now, shortly befor 3.6-rc1, and it
>>>>>>> breaks boot on my AM33xx board.
>>>>>>>
>>>>>>> Once I revert 1/3, the board boots again but crashes with the Ooops
>>>>>>> below. With the entire series reverted, everything works again as
>>>>>>> expected. Any idea?
>>>>>>>
>>>>>>> The upstream commit ids are
>>>>>>>
>>>>>>> 11d6ec2e "ARM: OMAP: timer: allow gp timer clock-event to be used on
>>>>>>> both cpus"
>>>>>>> 5b4d5bcc "ARM: OMAP4: CPUidle: add synchronization for coupled idle states"
>>>>>>> b93d70ae "ARM: OMAP4: CPUidle: Open broadcast clock-event device."
>>>>>>
>>>>>> I've had boot problems with cpuidle enabled as well, what happens if you disable it? Is the revert still needed in that case?
>>>>>
>>>>> To answer my own question: No, the reverts aren't needed if you disable cpuidle.
>>>>
>>>> This is really strange since CPUIDLE code is really OMAP4 specific.
>>>> obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
>>>>
>>>> May be omap2plus build some how the code gets executed on AMXX
>>>>
>>>> Can you try below and see if the boot with CPUIDLE enabled goes away on
>>>> AMXX
>>>>
>>>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
>>>> index ea24174..195e756 100644
>>>> --- a/arch/arm/mach-omap2/pm44xx.c
>>>> +++ b/arch/arm/mach-omap2/pm44xx.c
>>>> @@ -147,6 +147,9 @@ int __init omap4_pm_init(void)
>>>>       struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm, *l4wkup;
>>>>       struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
>>>>
>>>> +       if (!cpu_is_omap44xx())
>>>> +               return -ENODEV;
>>>> +
>>>>       if (omap_rev() == OMAP4430_REV_ES1_0) {
>>>>               WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
>>>>               return -ENODEV;
>>>
>>> That does seem to fix it:
>>>
>>> root@beaglebone:~# zcat /proc/config.gz | grep -i cpu_idle
>>> CONFIG_CPU_IDLE=y
>>> CONFIG_CPU_IDLE_GOV_LADDER=y
>>> CONFIG_CPU_IDLE_GOV_MENU=y
>>> CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED=y
>>> root@beaglebone:~# zcat /proc/config.gz | grep -i omap4
>>> CONFIG_ARCH_OMAP4=y
>>> CONFIG_MACH_OMAP4_PANDA=y
>>> # CONFIG_OMAP4_ERRATA_I688 is not set
>>> # CONFIG_KEYBOARD_OMAP4 is not set
>>> CONFIG_OMAP4_DSS_HDMI=y
>>>
>>
>> This patch is not required, Without this patch is works for me,
>
> I just retested and I don't need Santosh' patch, booting with cpuidle enable works now, after refreshing your patchset (and dropping the rtc commit, it conflicts with the other rtc patches out there).
>
Thanks Koen for confirming. That means the issues was coming from
additional patching on top of 3.6-rc1
where some patches were not refreshed for AMXX.

Regards
Santosh

Regards
Santosh
