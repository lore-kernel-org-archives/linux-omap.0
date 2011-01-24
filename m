From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 1/4] TI816X: Update common omap platform files
Date: Mon, 24 Jan 2011 12:02:44 -0800
Message-ID: <87aaiq9ijf.fsf@ti.com>
References: <1294677465-18658-1-git-send-email-hemantp@ti.com>
	<87oc79evo2.fsf@ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB4B3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:42960 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630Ab1AXUCs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 15:02:48 -0500
Received: by mail-px0-f177.google.com with SMTP id 7so819563pxi.36
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 12:02:48 -0800 (PST)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB4B3@dbde02.ent.ti.com>
	(Hemant Pedanekar's message of "Sat, 22 Jan 2011 07:40:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

"Pedanekar, Hemant" <hemantp@ti.com> writes:

> Hi Kevin,
>
> Hilman, Kevin wrote on Saturday, January 22, 2011 4:01 AM:
>
>> Hi Hemant,
>> 
>> Hemant Pedanekar <hemantp@ti.com> writes:
>> 
>>> This patch updates the common platform files with TI816X support. Also
>>> adds new files for TI816X module base addresses and irq definitions.
>> [...]
>> 
>>> diff --git a/arch/arm/plat-omap/include/plat/irqs-ti816x.h
>> b/arch/arm/plat-omap/include/plat/irqs-ti816x.h
>>> new file mode 100644
>>> index 0000000..3ec5d1b
> [...]
>>> +#define TI816X_IRQ_SECPUBINT	116
>>> +#define TI816X_IRQ_SECSECINT	117
>>> +#define TI816X_IRQ_SECPUBSWINT	118
>>> +#define TI816X_IRQ_SECSECSWINT	119
>>> +#define TI816X_IRQ_SMRFLX0	120
>>> +#define TI816X_IRQ_SMRFLX1	121
>>> +#define TI816X_IRQ_SYS_MMU	122
>>> +#define TI816X_IRQ_MC_MMU	123
>>> +#define TI816X_IRQ_DMM		124
>>> +
>>> +
>>> +#endif
>> 
>> For new platforms, We don't need to have a list of all the
>> IRQ numbers.
>> 
>> Driver code should always be getting IRQ numbers (and base addresses
>> etc.) from struct resource/platform_data, which is populated
>> from omap_hwmod.
>>
>
> Are you suggesting to get rid of this file altogether or the IRQs which 
> may never be used from kernel be removed from this file (and added later
> If needed)?
>   
> Or shall I add this file only in hwmod patch which will be submitted later?

You can get rid of the file altogether.  Even the hwmod data can just
have IRQ numbers and you shouldn't need to add a header file with the
defines.

Kevin 
