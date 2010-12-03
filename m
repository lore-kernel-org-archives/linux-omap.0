From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Date: Fri, 3 Dec 2010 15:15:07 +0200
Message-ID: <AANLkTimfj_J-P29Eqx29PGVqmUZs65SbwKewwrqib6ZC@mail.gmail.com>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
	<20101202215837.GW17222@atomide.com>
	<20101202221612.GJ10461@n2100.arm.linux.org.uk>
	<20101202223208.GA17222@atomide.com>
	<20101203030954.GD3367@linux-sh.org>
	<20101203084102.GA30957@n2100.arm.linux.org.uk>
	<AANLkTim3573_MUZNpo2+tKa=ZJgQf26x5of_ZkMM6BR8@mail.gmail.com>
	<20101203130724.GB30957@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37103 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab0LCNPM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 08:15:12 -0500
In-Reply-To: <20101203130724.GB30957@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 3, 2010 at 3:07 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 03, 2010 at 02:10:23PM +0200, Felipe Contreras wrote:
>> On Fri, Dec 3, 2010 at 10:41 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Dec 03, 2010 at 12:09:55PM +0900, Paul Mundt wrote:
>> >> This has been fixed since -rc2.
>> >
>> > So it is. =C2=A0However, the ioremap fix is wrong.
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0paddr =3D m=
emblock_alloc(size, PAGE_SIZE);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0memblock_free(paddr, size);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0memblock_remove(paddr, size);
>> >
>> > Didn't I say that such blocks were supposed to be aligned to a 2MB
>> > boundary - and the size also so aligned?
>>
>> I asked you if there was something special and I didn't receive any =
response:
>> http://article.gmane.org/gmane.linux.kernel/1048434
>
> So you thought you could ride rough-shod over my statement and ignore=
 it?
> Thank you for treating me like shit, I'll remember that for future an=
d
> treat you in a similar manner.

No, you didn't make any statement, just provided code. I thought SZ_2M
might have just been an example for something that required that
alignment, thus my request for clarification.

>> So, why SZ_2M?
>
> Firstly, that's the granularity which we allocate page tables - one
> Linux page table covers 2MB of memory. =C2=A0We want to avoid creatin=
g page
> tables for the main memory mapping as that increases TLB pressure thr=
ough
> the use of additional TLB entries, and more page table walks.
>
> Plus, we never used to allow the kernel's direct memory mapping to be
> mapped at anything less than section size - this restriction has sinc=
e
> been lifted due to OMAP SRAM problems, but I'd rather we stuck with i=
t
> to ensure that we have proper behaviour from all parts of the system.
>
> Secondly, we don't want to end up with lots of fragmentation at the e=
nd
> of the memory mapping as that'll reduce performance, not only by maki=
ng
> the pfn_valid() search more expensive.
>
> Emsuring a minimum allocation size and alignment makes sure that the
> regions can be coalesced together into one block, and minimises run-t=
ime
> expenses.
>
> So please, 2MB, or if you object, at the _very_ _least_ 1MB. =C2=A0Bu=
t
> definitely not PAGE_SIZE.

=46air enough. If nobody beats me to it I would send patches to fix
that, although perhaps it would make sense to write a helper function
that does exactly this.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
