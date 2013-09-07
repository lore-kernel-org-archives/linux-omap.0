From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC 0/4] Create infrastructure for running C code from SRAM.
Date: Sat, 7 Sep 2013 18:21:25 +0200
Message-ID: <CAKv+Gu-eaS9djmz0d5hzY=jkVb-aPZWrLCUOr8wNb6fWoNpMiA@mail.gmail.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
	<20130906111221.GH25647@n2100.arm.linux.org.uk>
	<CA+Bv8XbbWoBgrv83RmXLiO8AM0TDP9wNQMUFJKMbN82-0w3Scg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:57634 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab3IGQV1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Sep 2013 12:21:27 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so3654778lab.5
        for <linux-omap@vger.kernel.org>; Sat, 07 Sep 2013 09:21:26 -0700 (PDT)
In-Reply-To: <CA+Bv8XbbWoBgrv83RmXLiO8AM0TDP9wNQMUFJKMbN82-0w3Scg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, mans@mansr.com, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Philipp Zabel <p.zabel@pengutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 6 September 2013 21:32, Russ Dill <Russ.Dill@ti.com> wrote:
> On Fri, Sep 6, 2013 at 4:12 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Tue, Sep 03, 2013 at 09:44:21AM -0700, Russ Dill wrote:
>>> SRAM handling code is in the process of being moved from arch directories
>>> into drivers/misc/sram.c using device tree and genalloc [1] [2]. This RFC
>>> patchset builds on that, including the limitation that the SRAM address is
>>> not known at compile time. Because the SRAM address is not known at compile
>>> time, the code that runs from SRAM must be compiled with -fPIC. Even if
>>> the code were loaded to a fixed virtual address, portions of the code must
>>> often be run with the MMU disabled.
>>
>> What are you doing about the various gcc utility functions that may be
>> implicitly called from C code such as memcpy and memset?
>
> That would create a problem. Would '-ffreestanding' be the correct
> flag to add?

No, unfortunately, -ffreestanding won't prevent GCC from generating
implicit calls to memzero() et al. These are mainly issued when using
initialized non-POD stack variables so avoiding those might help you
there.

> As far as the family of __aeabi_*, I need to add
> documentation stating that on ARM, you can't divide, perform modulo,
> and can't do 64 bit multiplications. I can then add a make rule that
> will grep the symbol lists of .sram sections for ^__aeabi_. Is this
> enough?
>

Well, even printk() needs integer division for its %d/%u modifiers, so
this is really not so easy to achieve.

>>> The general idea is that for each SRAM user (such as an SoC specific
>>> suspend/resume mechanism) to create a group of sections. The section group
>>> is created with a single macro for each user, but end up looking like this:
>>>
>>> .sram.am33xx : AT(ADDR(.sram.am33xx) - 0) {
>>>   __sram_am33xx_start = .;
>>>   *(.sram.am33xx.*)
>>>   __sram_am33xx_end = .;
>>> }
>>>
>>> Any data or functions that should be copied to SRAM for this use should be
>>> maked with an appropriate __section() attribute. A helper is then added for
>>> translating between the original kernel symbol, and the address of that
>>> function or variable once it has been copied into SRAM. Once control is
>>> passed to a function within the SRAM section grouping, it can access any
>>> variables or functions within that same SRAM section grouping without
>>> translation.
>>
>> What about the relocations which will need to be fixed up - eg, addresses
>> in the literal pool, the GOT table contents, etc?  You say nothing about
>> this.
>
> The C code would need to be written so that such accesses do not
> occur. From functions that are in the sram text section, only accesses
> to other sram sections in their group would be allowed. And above, a
> compilation step could be added to make the compilation fail when such
> things happen.
>

The point is that, sadly, GCC is just not very good at generating
relocatable code for embedded targets. Playing with -fvisibility may
result in code that contains fewer dynamic relocations, but you will
always end up with a few that need to be fixed up before the code can
run. Another thing to note is that usually, these relocations can only
be fixed up once, as the addend is overwritten by the fixed-up
address. This means that the code can only run in SRAM, and you should
probably best avoid the module loader machinery as it may clobber the
addends before you get to process them.

One thing that remains implicit in this discussion is that you are
executing from SRAM because DRAM is not available (I presume).
Wouldn't it be better to treat the code that lives in the SRAM as a
completely separate executable? You can generate a PIE executable that
supplies minimal memzero et al,  fixup the relocations yourself (look
at the uboot sources for an example of this) and you will be
absolutely sure that the code can run completely autonomously. In
fact, some of this stuff could potentially be reused for other
disjoint execution domains such as TZ secure world.

Regards,
Ard.



> The direction you are going though is good, if this is fragile, it
> doesn't put us in a better place then having fragile asm that at least
> complies reliably. As I'm looking towards the future and platforms
> that are similar to am335x in that they are placing more and more of
> the PM state machine burden on the CPU, I'd really like to try to make
> this happen.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
