From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 15:04:00 +0200
Message-ID: <549D5CC0.2090408@linaro.org>
References: <1419271535-4057-1-git-send-email-balbi@ti.com> <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman> <549AA94A.8030209@compulab.co.il> <20141224154948.GA423@saruman> <20141224190401.GN23854@atomide.com> <549BE333.9060709@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:37541 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbaLZNEG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 08:04:06 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so8354184lbv.40
        for <linux-omap@vger.kernel.org>; Fri, 26 Dec 2014 05:04:04 -0800 (PST)
In-Reply-To: <549BE333.9060709@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On 12/25/2014 12:13 PM, Igor Grinberg wrote:
> Hi Tony,
> 
> On 12/24/14 21:04, Tony Lindgren wrote:
>> * Felipe Balbi <balbi@ti.com> [141224 07:52]:
>>> Hi,
>>>
>>> On Wed, Dec 24, 2014 at 01:53:46PM +0200, Igor Grinberg wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> On 12/23/14 18:19, Felipe Balbi wrote:
>>>>> On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
>>>>>> Hi Felipe,
>>>>>>
>>>>>> On 12/22/14 20:05, Felipe Balbi wrote:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>   CONFIG_SCSI_SCAN_ASYNC=y
>>>>>>> -CONFIG_ATA=y
>>>>>>> -CONFIG_SATA_AHCI_PLATFORM=y
>>>>>>> -CONFIG_MD=y
>>>>>>> +CONFIG_ATA=m
>>>>>>> +CONFIG_SATA_AHCI_PLATFORM=m
>>>>>>
>>>>>> Isn't this needed for the rootfs on SATA devices?
>>>>>
>>>>> there's no known boards with rootfs on SATA. Until then, we can reduce
>>>>> the size.
>>>>
>>>> What makes you say so?
>>>> The decision for rootfs on SATA is taken dynamically.
>>>> OMAP5 boards (specifically cm-t54) can have rootfs on SATA...
>>>
>>> I'll leave the decision to Tony. Even though they _can_, they really
>>> don't and IIRC, OMAP5's SATA has so many silicon errata that it'd be
>>> annoying to find that special device which works (e.g it can't negotiate
>>> lower speeds with SATA III devices and it won't support SATA I).
> 
> Yet, it is not that buggy and at least until now, I di not get any
> reports about badly working SATA from customers...
> 
>>>
>>> As of today, we don't know of anybody really shipping anything with
>>> rootfs on SATA and distros would rather ship initiramfs than a giant
>>> zImage anyway.
> 
> So, you just continue to ignore what I'm saying... even after I point
> to a device...
> 
> Is it SATA that makes it so giant?
> Because I find it worth having in SATA than spare some more k's...
> 

SATA code occupies ~179Kbytes - checked on 3.19-rc1
CONFIG_ATA=y
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_MD=y (seems it will give +-0K)

>>>
>>> Tony, your call

May be it will be good thing to split this patch. That way more information
will be stored in commit log about which set of options gives us what benefits.
And also, It will allow to continue with agreed changes.
?

>>
>> I think we should move omap2plus_defconfig to be mostly modular and
>> usable for distros as a base. Most distros prefer to build almost
>> everything as loadable modules. And my preference is that we should
>> only keep the minimum rootfs for devices and serial support as
>> built-in and rely on initramfs for most drivers. And slowly move
>> also the remaining built-in drivers to be loadable modules.
>>
>> The reasons for having drivers as loadable modules are many. It
>> allows distros to use the same kernel for all the devices without
>> bloating the kernel. It makes developing drivers easier as just the
>> module needs to be reloaded. And loadable modules protect us from
>> cross-framework spaghetti calls in the kernel as the interfaces are
>> clearly defined.
>>
>> Are there people really using SATA as rootfs right now on omaps?
> 
> Yes. That is exactly my point.
> 

>From my side I'd like to note that I know about few ongoing projects on DRA7x EVM
where SATA is used as rootfs - now It is the fast possible way to start Android.

-- 
regards,
-grygorii
