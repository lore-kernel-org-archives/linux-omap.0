From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v4 1/4] TI816X: Update common omap platform files
Date: Tue, 25 Jan 2011 06:40:42 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A986366@dbde02.ent.ti.com>
References: <1294677465-18658-1-git-send-email-hemantp@ti.com>
	<87oc79evo2.fsf@ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB4B3@dbde02.ent.ti.com>
 <87aaiq9ijf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40115 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1AYBKw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 20:10:52 -0500
In-Reply-To: <87aaiq9ijf.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Kevin Hilman wrote on Tuesday, January 25, 2011 1:33 AM:

> "Pedanekar, Hemant" <hemantp@ti.com> writes:
> 
>> Hi Kevin,
>> 
>> Hilman, Kevin wrote on Saturday, January 22, 2011 4:01 AM:
>> 
>>> Hi Hemant,
>>> 
>>> Hemant Pedanekar <hemantp@ti.com> writes:
>>> 
>>>> This patch updates the common platform files with TI816X support. Also
>>>> adds new files for TI816X module base addresses and irq
> definitions.
>>> [...]
>>> 
>>>> diff --git a/arch/arm/plat-omap/include/plat/irqs-ti816x.h
>>> b/arch/arm/plat-omap/include/plat/irqs-ti816x.h
>>>> new file mode 100644
>>>> index 0000000..3ec5d1b
>> [...]
>>>> +#define TI816X_IRQ_SECPUBINT	116
>>>> +#define TI816X_IRQ_SECSECINT	117
>>>> +#define TI816X_IRQ_SECPUBSWINT	118
>>>> +#define TI816X_IRQ_SECSECSWINT	119
>>>> +#define TI816X_IRQ_SMRFLX0	120
>>>> +#define TI816X_IRQ_SMRFLX1	121
>>>> +#define TI816X_IRQ_SYS_MMU	122
>>>> +#define TI816X_IRQ_MC_MMU	123
>>>> +#define TI816X_IRQ_DMM		124
>>>> +
>>>> +
>>>> +#endif
>>> 
>>> For new platforms, We don't need to have a list of all the IRQ numbers.
>>> 
>>> Driver code should always be getting IRQ numbers (and base addresses
>>> etc.) from struct resource/platform_data, which is populated from
>>> omap_hwmod. 
>>> 
>> 
>> Are you suggesting to get rid of this file altogether or the IRQs which
>> may never be used from kernel be removed from this file (and added later
>> If needed)? 
>> 
>> Or shall I add this file only in hwmod patch which will be submitted later?
> 
> You can get rid of the file altogether.  Even the hwmod data can just
> have IRQ numbers and you shouldn't need to add a header file with the
> defines. 
> 
> Kevin

Ok got it. Thanks.

   Hemant