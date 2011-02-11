From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have SMP_ON_UP fixups
Date: Fri, 11 Feb 2011 09:33:56 +0000
Message-ID: <AANLkTim0RRw-xHQYTdHLCXCS_GXkaCiW8y9Fz=jMmwPa@mail.gmail.com>
References: <alpine.LFD.2.00.1101251618230.8580@xanadu.home>
	<AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
	<20110126124452.GB4232@n2100.arm.linux.org.uk>
	<20110126172535.GA15983@arm.com>
	<20110209142211.GA11460@n2100.arm.linux.org.uk>
	<20110210125624.GA3652@n2100.arm.linux.org.uk>
	<AANLkTin3+4pwxQRz1J_1B6dJxJm0_5ou0OWteDFZNbo9@mail.gmail.com>
	<AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com>
	<20110210144617.GD3652@n2100.arm.linux.org.uk>
	<AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com>
	<20110210191125.GA12582@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61158 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978Ab1BKJd6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 04:33:58 -0500
Received: by wwi17 with SMTP id 17so4001419wwi.1
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 01:33:57 -0800 (PST)
In-Reply-To: <20110210191125.GA12582@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 10, 2011 at 7:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 10, 2011 at 06:29:41PM +0000, Dave Martin wrote:
>> On Thu, Feb 10, 2011 at 2:46 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Thu, Feb 10, 2011 at 02:13:13PM +0000, Dave Martin wrote:
>> >> Note that this tree contains some extra patches (though I believe
>> >> nothing is there which should cause the problem), and does not co=
ntain
>> >> everything from rmk/devel -- so it's possible this has been fixed=
 in
>> >> the meantime or no longer occurs for some other reason...
>> >
>> > No need - I now have some modules which contain SMP alternatives, =
so we
>> > do need to fix the module loader for this, and keep the SMP altern=
atives
>> > replacement code around. =A0It's not worth eliminating the code as=
 if we
>> > include an informative printk() to say why we're refusing to load =
the
>> > module, the string would be larger than the code it eliminates. =A0=
So, I
>> > think we need to merge the patch below to avoid run-time problems.
>>
>> I thought the problem was not caused by removal of the fixup code, b=
ut
>> rather by the removal of code referenced by fixups?
>
> It is. =A0But:
>
> arm-linux-objdump -h sound/core/snd-timer.ko
>
> sound/core/snd-timer.ko: =A0 =A0 file format elf32-littlearm
>
> Sections:
> Idx Name =A0 =A0 =A0 =A0 =A0Size =A0 =A0 =A0VMA =A0 =A0 =A0 LMA =A0 =A0=
 =A0 File off =A0Algn
> =A00 .text =A0 =A0 =A0 =A0 00002f34 =A000000000 =A000000000 =A0000000=
34 =A02**2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CONTENTS, ALLOC, LOAD, RELOC, READ=
ONLY, CODE
> =A01 .exit.text =A0 =A000000070 =A000000000 =A000000000 =A000002f68 =A0=
2**2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CONTENTS, ALLOC, LOAD, RELOC, READ=
ONLY, CODE
> =A02 .init.text =A0 =A0000001b4 =A000000000 =A000000000 =A000002fd8 =A0=
2**2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CONTENTS, ALLOC, LOAD, RELOC, READ=
ONLY, CODE
> =A03 .rodata =A0 =A0 =A0 000000bc =A000000000 =A000000000 =A00000318c=
 =A02**2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CONTENTS, ALLOC, LOAD, RELOC, READ=
ONLY, DATA
> =A04 .rodata.str1.1 00000156 =A000000000 =A000000000 =A000003248 =A02=
**0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CONTENTS, ALLOC, LOAD, READONLY, D=
ATA
> =A05 .alt.smp.init 00000088 =A000000000 =A000000000 =A00000339e =A02*=
*0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CONTENTS, ALLOC, LOAD, RELOC, READ=
ONLY, DATA
> ...
>
> Here we have a module which contains the spin_unlock assembly, which
> contains the SMP alternatives. =A0If we insert that into a kernel als=
o
> built with SMP alternatives support, but which is running on a UP
> system, we need to run these fixups as well when the module is loaded=
=2E
>

Agreed -- actually, I suspected we might need to support this.  But I
don't think solving this problem (=3D keeping the fixup implementation
in memory and enhancing the module loader) solved the
fixups-referencing-sections-discarded-from-vmlinux problem.  These
seem to be two separate issues.  I am filing to understand something?

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
