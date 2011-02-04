From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 01/13] OMAP: hwmod: Add member 'name' to omap_hwmod_addr_space struct
Date: Fri, 04 Feb 2011 14:16:09 -0800
Message-ID: <87d3n7la3a.fsf@ti.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<1296485437-12806-2-git-send-email-kishon@ti.com>
	<8762szpor3.fsf@ti.com> <4D4C5FDC.7050008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52231 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751749Ab1BDWQO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 17:16:14 -0500
Received: by gwaa20 with SMTP id a20so1108385gwa.10
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 14:16:13 -0800 (PST)
In-Reply-To: <4D4C5FDC.7050008@ti.com> (Benoit Cousson's message of "Fri, 4
	Feb 2011 21:21:48 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "paul@pwsan.com" <paul@pwsan.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "Basak, Partha" <p-basak2@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 2/4/2011 8:45 PM, Hilman, Kevin wrote:
>> Kishon Vijay Abraham I<kishon@ti.com>  writes:
>>
>>> Adds a structure member 'name' to 'omap_hwmod_addr_space' structure.
>>> The drivers can use platform_get_resource_byname() to get resource of
>>> type 'IORESOURCE_MEM' by name so that it need not rely on the order to get
>>> the proper resource.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/omap_hwmod.c             |    1 +
>>>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +++-
>>>   2 files changed, 4 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>> index 709543a..7bd4900 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -1898,6 +1898,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res)
>>>   		os = oh->slaves[i];
>>>
>>>   		for (j = 0; j<  os->addr_cnt; j++) {
>>> +			(res + r)->name = (os->addr + j)->name;
>>>   			(res + r)->start = (os->addr + j)->pa_start;
>>>   			(res + r)->end = (os->addr + j)->pa_end;
>>>   			(res + r)->flags = IORESOURCE_MEM;
>>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> index 76f0274..85899a7 100644
>>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> @@ -178,7 +178,8 @@ struct omap_hwmod_omap2_firewall {
>>>   #define ADDR_TYPE_RT		(1<<  1)
>>>
>>>   /**
>>> - * struct omap_hwmod_addr_space - MPU address space handled by the hwmod
>>> + * struct omap_hwmod_addr_space - address space handled by the hwmod
>>
>> Any reason you modified the comment here?
>
> The idea of that patch is to allow hwmod to provide address space
> accessible from SDMA (though L3). Hence the suppression of the MPU.
> In the future, we might even be able to provide the address for the
> DSP or the IPU viewpoint
>

OK, this rationale is missing from the changelog, and seems very much
unrelated to $SUBJECT patch.

Kevin


