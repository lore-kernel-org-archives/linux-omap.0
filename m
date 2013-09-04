From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>
Subject: Re: [RFC 0/4] Create infrastructure for running C code from SRAM.
Date: Wed, 04 Sep 2013 16:52:36 -0300
Message-ID: <52278F84.2080509@elopez.com.ar>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zetta.elopez.com.ar ([199.30.59.35]:34400 "EHLO
	zetta.elopez.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab3IDTwq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Sep 2013 15:52:46 -0400
In-Reply-To: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, mans@mansr.com, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

Hi,

El 03/09/13 13:44, Russ Dill escribi=F3:
> This RFC patchset explores an idea for loading C code into SRAM.
> Currently, all the code I'm aware of that needs to run from SRAM is w=
ritten
> in assembler. The most common reason for code needing to run from SRA=
M is
> that the memory controller is being disabled/ enabled or is already
> disabled. arch/arm has by far the most examples, but code also exists=
 in
> powerpc and sh.
>
> The code is written in asm for two primary reasons. First so that mar=
kers
> can be put in indicating the size of the code they it can be copied. =
Second
> so that data can be placed along with text and accessed in a position
> independant manner.
>
> SRAM handling code is in the process of being moved from arch directo=
ries
> into drivers/misc/sram.c using device tree and genalloc [1] [2]. This=
 RFC
> patchset builds on that, including the limitation that the SRAM addre=
ss is
> not known at compile time. Because the SRAM address is not known at c=
ompile
> time, the code that runs from SRAM must be compiled with -fPIC. Even =
if
> the code were loaded to a fixed virtual address, portions of the code=
 must
> often be run with the MMU disabled.
>
> The general idea is that for each SRAM user (such as an SoC specific
> suspend/resume mechanism) to create a group of sections. The section =
group
> is created with a single macro for each user, but end up looking like=
 this:
>
> .sram.am33xx : AT(ADDR(.sram.am33xx) - 0) {
>    __sram_am33xx_start =3D .;
>    *(.sram.am33xx.*)
>    __sram_am33xx_end =3D .;
> }
>
> Any data or functions that should be copied to SRAM for this use shou=
ld be
> maked with an appropriate __section() attribute. A helper is then add=
ed for
> translating between the original kernel symbol, and the address of th=
at
> function or variable once it has been copied into SRAM. Once control =
is
> passed to a function within the SRAM section grouping, it can access =
any
> variables or functions within that same SRAM section grouping without
> translation.
>
> [1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D4984c6
> [2] http://www.spinics.net/lists/linux-omap/msg96504.html
>
> Russ Dill (4):
>    Misc: SRAM: Create helpers for loading C code into SRAM
>    ARM: SRAM: Add macro for generating SRAM resume trampoline
>    Misc: SRAM: Hack for allowing executable code in SRAM.
>    ARM: AM33XX: Move suspend/resume assembly to C
>
>   arch/arm/include/asm/suspend.h    |  14 ++
>   arch/arm/kernel/vmlinux.lds.S     |   2 +
>   arch/arm/mach-omap2/Makefile      |   2 +-
>   arch/arm/mach-omap2/pm33xx.c      |  50 ++---
>   arch/arm/mach-omap2/pm33xx.h      |  23 +--
>   arch/arm/mach-omap2/sleep33xx.S   | 394 ---------------------------=
-----------
>   arch/arm/mach-omap2/sleep33xx.c   | 309 +++++++++++++++++++++++++++=
+++
>   arch/arm/mach-omap2/sram.c        |  15 --
>   drivers/misc/sram.c               | 106 +++++++++-
>   include/asm-generic/vmlinux.lds.h |   7 +
>   include/linux/sram.h              |  44 +++++
>   11 files changed, 509 insertions(+), 457 deletions(-)
>   delete mode 100644 arch/arm/mach-omap2/sleep33xx.S
>   create mode 100644 arch/arm/mach-omap2/sleep33xx.c
>   create mode 100644 include/linux/sram.h
>

I'm interested in this, as I'll need something like it for=20
suspend/resume on sunxi. Unfortunately, I only got the cover letter on=20
my email, and the web lakml archives don't seem to have the rest either=
=2E=20
After a bit of searching on Google I found a copy on linux-omap[1], but=
=20
it'd be great if I didn't have to hunt for the patches :)

I only have one comment, from a quick look at the code

+       memcpy((void *) chunk->addr, data, sz);
+       flush_icache_range(chunk->addr, chunk->addr + sz);

How would that behave on Thumb-2 mode? I believe that's the reason why=20
fncpy() got introduced[2] some time ago.

Thanks for working on this!

Emilio

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg94995.htm=
l
[2] http://www.spinics.net/lists/arm-kernel/msg110706.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
