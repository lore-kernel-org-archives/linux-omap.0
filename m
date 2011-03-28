From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
Date: Mon, 28 Mar 2011 12:27:03 +0400
Message-ID: <4D904657.40401@ru.mvista.com>
References: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>	<4D8E5CD3.8010007@ru.mvista.com> <AANLkTikcV_NSYz+zSRRMA=dQMxB7AS1tKsau95mxbCka@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57129 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab1C1I2g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 04:28:36 -0400
Received: by eyx24 with SMTP id 24so1075735eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 01:28:34 -0700 (PDT)
In-Reply-To: <AANLkTikcV_NSYz+zSRRMA=dQMxB7AS1tKsau95mxbCka@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hello.

On 28-03-2011 5:49, Ramirez Luna, Omar wrote:

>>> If an error occurs in the L3 on any other initiator than MPU,
>>> the interrupt goes unhandled given that the 'base' register
>>> was calculated with the initialized err_base value (which
>>> coincidentally points to MPU) and not with the actual source
>>> of the error.

>>> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/omap_l3_smx.c |    5 +++--
>>>   1 files changed, 3 insertions(+), 2 deletions(-)

>>> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c
>>> b/arch/arm/mach-omap2/omap_l3_smx.c
>>> index 5f2da75..da917c2 100644
>>> --- a/arch/arm/mach-omap2/omap_l3_smx.c
>>> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
>>> @@ -196,11 +196,12 @@ static irqreturn_t omap3_l3_app_irq(int irq, void
>>> *_l3)
>>>                 /* No timeout error for debug sources */
>>>         }
>>>
>>> -       base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
>>> -
>>>         /* identify the error source */
>>>         for (err_source = 0; !(status&    (1<<    err_source)); err_source++)
>>>                                                                         ;
>>> +
>>> +       base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
>>> +

>>    What's the point of having () around rvalue? You could drop them, while at
>> it...

> You're right, will do.

    The same goes about 'l3->rt' and '*(omap3_l3_bases[int_type] + err_source)'...

> Regards,

> Omar

WBR, Sergei
