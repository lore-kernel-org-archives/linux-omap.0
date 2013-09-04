From: Russ Dill <Russ.Dill@ti.com>
Subject: Re: [RFC 0/4] Create infrastructure for running C code from SRAM.
Date: Wed, 4 Sep 2013 14:47:51 -0700
Message-ID: <CA+Bv8XaHonrpeNZ6tRCyqpMK1bzgpDTqvLyrsLWEyMY_ky6apQ@mail.gmail.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
	<52278F84.2080509@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:48601 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932449Ab3IDVrw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Sep 2013 17:47:52 -0400
Received: by mail-qa0-f41.google.com with SMTP id hu16so2312244qab.7
        for <linux-omap@vger.kernel.org>; Wed, 04 Sep 2013 14:47:51 -0700 (PDT)
In-Reply-To: <52278F84.2080509@elopez.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>
Cc: mans@mansr.com, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Philipp Zabel <p.zabel@pengutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Wed, Sep 4, 2013 at 12:52 PM, Emilio L=C3=B3pez <emilio@elopez.com.a=
r> wrote:
> Hi,
>
> El 03/09/13 13:44, Russ Dill escribi=C3=B3:
>
>> This RFC patchset explores an idea for loading C code into SRAM.
>> Currently, all the code I'm aware of that needs to run from SRAM is
>> written
>> in assembler. The most common reason for code needing to run from SR=
AM is
>> that the memory controller is being disabled/ enabled or is already
>> disabled. arch/arm has by far the most examples, but code also exist=
s in
>> powerpc and sh.
>>
>> The code is written in asm for two primary reasons. First so that ma=
rkers
>> can be put in indicating the size of the code they it can be copied.
>> Second
>> so that data can be placed along with text and accessed in a positio=
n
>> independant manner.
>>
>> SRAM handling code is in the process of being moved from arch direct=
ories
>> into drivers/misc/sram.c using device tree and genalloc [1] [2]. Thi=
s RFC
>> patchset builds on that, including the limitation that the SRAM addr=
ess is
>> not known at compile time. Because the SRAM address is not known at
>> compile
>> time, the code that runs from SRAM must be compiled with -fPIC. Even=
 if
>> the code were loaded to a fixed virtual address, portions of the cod=
e must
>> often be run with the MMU disabled.
>>
>> The general idea is that for each SRAM user (such as an SoC specific
>> suspend/resume mechanism) to create a group of sections. The section=
 group
>> is created with a single macro for each user, but end up looking lik=
e
>> this:
>>
>> .sram.am33xx : AT(ADDR(.sram.am33xx) - 0) {
>>    __sram_am33xx_start =3D .;
>>    *(.sram.am33xx.*)
>>    __sram_am33xx_end =3D .;
>> }
>>
>> Any data or functions that should be copied to SRAM for this use sho=
uld be
>> maked with an appropriate __section() attribute. A helper is then ad=
ded
>> for
>> translating between the original kernel symbol, and the address of t=
hat
>> function or variable once it has been copied into SRAM. Once control=
 is
>> passed to a function within the SRAM section grouping, it can access=
 any
>> variables or functions within that same SRAM section grouping withou=
t
>> translation.
>>
>> [1]
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D4984c6
>> [2] http://www.spinics.net/lists/linux-omap/msg96504.html
>>
>> Russ Dill (4):
>>    Misc: SRAM: Create helpers for loading C code into SRAM
>>    ARM: SRAM: Add macro for generating SRAM resume trampoline
>>    Misc: SRAM: Hack for allowing executable code in SRAM.
>>    ARM: AM33XX: Move suspend/resume assembly to C
>>
>>   arch/arm/include/asm/suspend.h    |  14 ++
>>   arch/arm/kernel/vmlinux.lds.S     |   2 +
>>   arch/arm/mach-omap2/Makefile      |   2 +-
>>   arch/arm/mach-omap2/pm33xx.c      |  50 ++---
>>   arch/arm/mach-omap2/pm33xx.h      |  23 +--
>>   arch/arm/mach-omap2/sleep33xx.S   | 394
>> --------------------------------------
>>   arch/arm/mach-omap2/sleep33xx.c   | 309 ++++++++++++++++++++++++++=
++++
>>   arch/arm/mach-omap2/sram.c        |  15 --
>>   drivers/misc/sram.c               | 106 +++++++++-
>>   include/asm-generic/vmlinux.lds.h |   7 +
>>   include/linux/sram.h              |  44 +++++
>>   11 files changed, 509 insertions(+), 457 deletions(-)
>>   delete mode 100644 arch/arm/mach-omap2/sleep33xx.S
>>   create mode 100644 arch/arm/mach-omap2/sleep33xx.c
>>   create mode 100644 include/linux/sram.h
>>
>
> I'm interested in this, as I'll need something like it for suspend/re=
sume on
> sunxi. Unfortunately, I only got the cover letter on my email, and th=
e web
> lakml archives don't seem to have the rest either. After a bit of sea=
rching
> on Google I found a copy on linux-omap[1], but it'd be great if I did=
n't
> have to hunt for the patches :)

The mails to arm-kernel are "awaiting moderation".

> I only have one comment, from a quick look at the code
>
> +       memcpy((void *) chunk->addr, data, sz);
> +       flush_icache_range(chunk->addr, chunk->addr + sz);
>
> How would that behave on Thumb-2 mode? I believe that's the reason wh=
y
> fncpy() got introduced[2] some time ago.
>
> Thanks for working on this!

I think this is already taken care of by the way sram.c is using
genalloc. The allocation returned should be aligned to 32 bytes. The
thumb bit shouldn't be an issue as code is copied based on the start
and end makers made by the linker. I may need to add .align statements
in the linker so that the start and end markers for the copied code
are aligned to at least 8 bytes.

Thanks!

> Emilio
>
> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg94995.h=
tml
> [2] http://www.spinics.net/lists/arm-kernel/msg110706.html
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
