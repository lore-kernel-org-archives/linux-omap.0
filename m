From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in asm/spinlock.h
Date: Wed, 26 Jan 2011 16:59:59 +0000
Message-ID: <AANLkTikG4bPmesNPvLGt8G+Q8YWwRzyYL3i+uL1FE=K2@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
	<AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
	<20110125165919.GD17286@n2100.arm.linux.org.uk>
	<AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
	<20110125174636.GE17286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101251618230.8580@xanadu.home>
	<AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
	<alpine.LFD.2.00.1101261023470.8580@xanadu.home>
	<20110126155203.GA10141@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50661 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab1AZRAB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 12:00:01 -0500
Received: by ewy5 with SMTP id 5so292433ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 08:59:59 -0800 (PST)
In-Reply-To: <20110126155203.GA10141@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 26, 2011 at 3:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 26, 2011 at 10:42:41AM -0500, Nicolas Pitre wrote:
>> On Wed, 26 Jan 2011, Dave Martin wrote:
>> > Alternatively, I wonder .alt.smp.init could make weak references
>> > instead of normal references: then if the referenced section is
>> > discarded, the reference will revert to 0 and the fixup code can
>> > ignore it (at the expense of wasting a bit of space in the fixup t=
able
>> > ... but it's no worse than the current situation). =A0From
>> > experimentation, it seems this doesn't work if the referenced symb=
ol
>> > is defined in the same file, since the linker resolves the referen=
ce
>> > before discarding sections, but maybe there's a way around it...
>>
>> That's strange. =A0How can the linker resolve the reference if the
>> referenced symbol is not in the same section as the reference source=
?
>> What happens when the final link completes?
>
> $ cat t.s
> =A0 =A0 =A0 =A0.section ".exit.text", "ax", %progbits
> =A0 =A0 =A0 =A0mov =A0 =A0 r0, r0
> a: =A0 =A0 =A0mov =A0 =A0 r0, r0
>
> =A0 =A0 =A0 =A0.pushsection ".alt.smp.fixup", "a"
> =A0 =A0 =A0 =A0.weak =A0 a
> =A0 =A0 =A0 =A0.long =A0 a
> =A0 =A0 =A0 =A0mov =A0 =A0 r0, r1
> =A0 =A0 =A0 =A0.popsection
> $ arm-linux-as -o t.o t.s
> $ arm-linux-nm t.o
> 00000004 W a
> $ arm-linux-objdump -Dr t.o
>
> Disassembly of section .exit.text:
>
> 00000000 <a-0x4>:
> =A0 0: =A0 e1a00000 =A0 =A0 =A0 =A0nop =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (mov r0,r0)
>
> 00000004 <a>:
> =A0 4: =A0 e1a00000 =A0 =A0 =A0 =A0.word =A0 0xe1a00000
>
> Disassembly of section .alt.smp.fixup:
>
> 00000000 <.alt.smp.fixup>:
> =A0 0: =A0 00000000 =A0 =A0 =A0 =A0.word =A0 0x00000000
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00: R_ARM_ABS32 =A0a
> =A0 4: =A0 e1a00001 =A0 =A0 =A0 =A0mov =A0 =A0 r0, r1
>
> which when linked with:
>
> SECTIONS
> {
> =A0 =A0 =A0 =A0.alt.smp.init : { *(.alt.smp.init) }
>
> =A0 =A0 =A0 =A0/DISCARD/ : { *(.exit.text) }
> }
>
> $ arm-linux-ld -T t.lds -r -o t.oo t.o
> `a' referenced in section `.alt.smp.fixup' of t.o: defined in discard=
ed section `.exit.text' of t.o
>
> So I don't think weak symbols work like we want them to.
>

That was the conclusion I came to also ... the linker seems to resolve
references in each object before discarding sections, so the weak
reference has already become concrete and section discard breaks it.

---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
