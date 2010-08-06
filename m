From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/6] TI816X: Update common omap platform files
Date: Fri, 06 Aug 2010 16:12:13 -0700
Message-ID: <87mxsznxo2.fsf@deeprootsystems.com>
References: <1280523096-25041-1-git-send-email-hemantp@ti.com>
	<87ocdh2kwx.fsf@deeprootsystems.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E65C19B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52399 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762159Ab0HFXMQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 19:12:16 -0400
Received: by pzk26 with SMTP id 26so3037292pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Aug 2010 16:12:15 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E65C19B@dbde02.ent.ti.com>
	(Hemant Pedanekar's message of "Fri, 6 Aug 2010 23:53:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

"Pedanekar, Hemant" <hemantp@ti.com> writes:

> Hi Kevin,
>
> Kevin Hilman wrote:
>> Hemant Pedanekar <hemantp@ti.com> writes:
>> 
>>> This patch updates the common platform files with TI816X specific
>>> additions. 
>>> 
>>> Also adds new files for TI816X modules base addresseses and irq
>>> definitions. 
>>> 
>>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
>>> ---
> [...]
>>> 
>>> diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S
>> b/arch/arm/mach-omap2/include/mach/entry-macro.S
>>> index 50fd749..6516cbd 100644
>>> --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
>>> +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S @@ -34,7 +34,7 @@
>>>  		.endm
>>> 
>>>  /*
>>> - * Unoptimized irq functions for multi-omap2, 3 and 4
>>> + * Unoptimized irq functions for multi-omap2, 3, 4 and ti816x   */
>>> 
>>>  #ifdef MULTI_OMAP2
>>> @@ -57,7 +57,8 @@ omap_irq_base:	.word	0
> [...]
>>> +		bne	9998f
>>> +
>>> +		/*
>>> +		 * ti816x has additional IRQ pending register. Checking this
>>> +		 * register on omap2 & omap3 has no effect (read as 0). +		 */
>>> +		ldr	\irqnr, [\base, #0xf8] /* IRQ pending reg 4 */
>>> +		cmp	\irqnr, #0x0
>> 
>> This part makes me a slightly nervous.  At least according to
>> the TRMs,
>> this address is undefined on OMAP2 & OMAP3 (yet still in the
>> INTC block.)
>> Was this tested on OMAP2/3 hardware and verified to return 0?
>> 
>> You might also consider wrapping this section in
>> #ifdef CONFIG_ARCH_TI816X so a multi-OMAP kernel without 816x support would
>> avoid this extra read. 
>> 
>
> Won't the usage of #ifdef inside MULTI_OMAP2 make things look strange?
> E.g.,
>
> #ifdef MULTI_OMAP2
> ...
> #ifdef CONFIG_ARCH_TI816X
> ...
> #endif
> #endif
>
> (Specifically, since there is already a custom block present in #else part?)
>

Yeah, I thought about that too.  That's why I said "you might
consider..." above.

But thinking more, you're right.  When we want an optimized version for
a specific SoC, we just compile for that SoC and get the optimized
version.

Go ahead and leave out the #ifdef, but I'd still like to see some tests
on OMAP2 that show that reading this undefined part of the INTC block
does indeed return zero.

Kevin
