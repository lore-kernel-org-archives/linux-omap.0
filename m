From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [RFC 0/4] Create infrastructure for running C code from SRAM.
Date: Fri, 6 Sep 2013 12:32:03 -0700
Message-ID: <CA+Bv8XbbWoBgrv83RmXLiO8AM0TDP9wNQMUFJKMbN82-0w3Scg@mail.gmail.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
	<20130906111221.GH25647@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:47166 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab3IFTcF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Sep 2013 15:32:05 -0400
Received: by mail-qa0-f43.google.com with SMTP id bv4so706549qab.9
        for <linux-omap@vger.kernel.org>; Fri, 06 Sep 2013 12:32:03 -0700 (PDT)
In-Reply-To: <20130906111221.GH25647@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: mans@mansr.com, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Philipp Zabel <p.zabel@pengutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 6, 2013 at 4:12 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Sep 03, 2013 at 09:44:21AM -0700, Russ Dill wrote:
>> SRAM handling code is in the process of being moved from arch directories
>> into drivers/misc/sram.c using device tree and genalloc [1] [2]. This RFC
>> patchset builds on that, including the limitation that the SRAM address is
>> not known at compile time. Because the SRAM address is not known at compile
>> time, the code that runs from SRAM must be compiled with -fPIC. Even if
>> the code were loaded to a fixed virtual address, portions of the code must
>> often be run with the MMU disabled.
>
> What are you doing about the various gcc utility functions that may be
> implicitly called from C code such as memcpy and memset?

That would create a problem. Would '-ffreestanding' be the correct
flag to add? As far as the family of __aeabi_*, I need to add
documentation stating that on ARM, you can't divide, perform modulo,
and can't do 64 bit multiplications. I can then add a make rule that
will grep the symbol lists of .sram sections for ^__aeabi_. Is this
enough?

>> The general idea is that for each SRAM user (such as an SoC specific
>> suspend/resume mechanism) to create a group of sections. The section group
>> is created with a single macro for each user, but end up looking like this:
>>
>> .sram.am33xx : AT(ADDR(.sram.am33xx) - 0) {
>>   __sram_am33xx_start = .;
>>   *(.sram.am33xx.*)
>>   __sram_am33xx_end = .;
>> }
>>
>> Any data or functions that should be copied to SRAM for this use should be
>> maked with an appropriate __section() attribute. A helper is then added for
>> translating between the original kernel symbol, and the address of that
>> function or variable once it has been copied into SRAM. Once control is
>> passed to a function within the SRAM section grouping, it can access any
>> variables or functions within that same SRAM section grouping without
>> translation.
>
> What about the relocations which will need to be fixed up - eg, addresses
> in the literal pool, the GOT table contents, etc?  You say nothing about
> this.

The C code would need to be written so that such accesses do not
occur. From functions that are in the sram text section, only accesses
to other sram sections in their group would be allowed. And above, a
compilation step could be added to make the compilation fail when such
things happen.

The direction you are going though is good, if this is fragile, it
doesn't put us in a better place then having fragile asm that at least
complies reliably. As I'm looking towards the future and platforms
that are similar to am335x in that they are placing more and more of
the PM state machine burden on the CPU, I'd really like to try to make
this happen.
