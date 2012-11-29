From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH RESEND v5 0/4] OMAP GPMC DT bindings
Date: Thu, 29 Nov 2012 16:23:01 +0100
Message-ID: <50B77DD5.4090001@gmail.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com> <518397C60809E147AF5323E0420B992E3EA07317@DBDE01.ent.ti.com> <50B74DCC.5060808@gmail.com> <518397C60809E147AF5323E0420B992E3EA0BB6B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53474 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab2K2PXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Nov 2012 10:23:06 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so6327197bkw.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Nov 2012 07:23:05 -0800 (PST)
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA0BB6B@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>, "jacmet@sunsite.dk" <jacmet@sunsite.dk>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 29.11.2012 16:08, Philip, Avinash wrote:
> On Thu, Nov 29, 2012 at 17:28:04, Daniel Mack wrote:
>> Hi Avinash,
>>
>> On 29.11.2012 06:24, Philip, Avinash wrote:
>>> On Wed, Nov 28, 2012 at 22:28:55, Daniel Mack wrote:
>>>> [Resending +devicetree-discuss, +Rob, +Grant]
>>>>
>>>>
>>>> This is a series of patches to support GPMC peripherals on OMAP boards.
>>>>
>>>> Depends on Linus' master +
>>>> omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)
>>>
>>> Can you resend this series on top of linux_next?
>>
>> The only branch these patches depend on is the
>> "omap-for-v3.8/cleanup-headers-gpmc" branch from omap_next. Are you
>> actually seeing any merge conflicts with my series? If so, which branch
>> are you referring to exactly?
>>
>>> Some of the missing items I seen 
>>> 1. Of_node not populated in  omap_nand_platform_data structure.
>>
>> Hmm - gpmc_probe_nand_child() from 4/4 adds
>>
>>   gpmc_nand_data->of_node = child;
>>
>> Do I miss anything?
> 
> I didn't found definition for of_node member in omap_nand_platform_data
> structure. This also might be missing in liniux-next?

Ah, right. I got that entry from your patch ("mtd: nand: omap2: Support
for hardware BCH error correction"). But you're right, it should be part
of my series. Will add that when resending, but note that your ELM
series will then cause a (trivial) merge conflict.

>>> 2. Remove platform device creation from hwmod as GPMC DT is populating.
>>>    Currently GPMC device creaing from DT & HWMOD.
>>
>> This is already addressed in cd00b0530 ("ARM: OMAP2+: gpmc: Fix kernel
>> BUG for DT boot mode") by Vaibhav Hiremath, which I got via Afzal's USB
>> branch:
> 
> Purpose of VH's patch was to get beagle bone booting, but Jon sent another
> patch that made beagle bone boot and it has reached mainline by v3.7-rc2,
> hence the patch you are referring to is currently not going upstream. Still to
> have GPMC DT work, we need that patch as other wise there would be two GPMC
> devices. In earlier versions of your series, you had a similar patch, it is
> required, can you please add it to your series as otherwise with your series
> GPMC DT won't work.

Ok, fine. Will do.


Daniel

