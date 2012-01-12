From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap changes
Date: Thu, 12 Jan 2012 21:32:40 +0100
Message-ID: <CAMQu2gxR4jXb_Sx_d4r-v_KKVXW=f5vOSJNKGfHy6F7_W1OquQ@mail.gmail.com>
References: <20120112184256.GA2287@atomide.com> <20120112200443.GA16726@n2100.arm.linux.org.uk>
 <20120112201112.GB16726@n2100.arm.linux.org.uk> <CAMQu2gw+cYgY-Pn=3wbYBVxtGULvRG9H326-z_aHP+yMeD8RLg@mail.gmail.com>
 <20120112202712.GC16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:54241 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755126Ab2ALUdD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 15:33:03 -0500
Received: by mail-qy0-f173.google.com with SMTP id d15so1571727qcs.18
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 12:33:02 -0800 (PST)
In-Reply-To: <20120112202712.GC16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 12, 2012 at 9:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 12, 2012 at 09:20:38PM +0100, Shilimkar, Santosh wrote:
>> On Thu, Jan 12, 2012 at 9:11 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Thu, Jan 12, 2012 at 08:04:43PM +0000, Russell King - ARM Linux=
 wrote:
>> >> On Thu, Jan 12, 2012 at 10:42:57AM -0800, Tony Lindgren wrote:
>> >> > Commit 73829af71fdb8655e7ba4b5a2a6612ad34a75a11
>> >> > (Merge branch 'vmalloc' of git://git.linaro.org/people/nico/lin=
ux
>> >> > into devel-stable) merged generic ioremap changes.
>> >> >
>> >> > Commit 137d105d50f6e6c373c1aa759f59045e6239cf66
>> >> > (ARM: OMAP4: Fix errata i688 with MPU interconnect barriers)
>> >> > added a workaround for omap4.
>> >> >
>> >> > In order for the errata to work, we now need the following
>> >> > patch or else we'll get:
>> >> >
>> >> > kernel BUG at mm/vmalloc.c:1134!
>> >>
>> >> Oh my, I've just read this, and I'm extremely annoyed that this e=
ven hit
>> >> mainline in the first place. =A0It's utter crap.
>> >>
>> >> It's trying to use memblock to allocate memory _AFTER_ that memor=
y has
>> >> been passed on from memblock's control to other allocators. =A0Ca=
lling
>> >> memblock_alloc() at *any* initcall is Bad News (it _may_ appear t=
o work
>> >> but there's no way for memblock_alloc to tell anything else that =
the
>> >> memory is being re-used.)
>> >>
>> >> Calling it and then trying to reserve it at ->map_io time is also=
 Bad
>> >> News - the memory at that point has already been mapped, and if y=
ou're
>> >> expecting to be able to remap it with different attributes, you'r=
e going
>> >> to double-map it with differing attributes. =A0You lose.
>> >>
>> >> Not only that, but it's an abuse of the various callback function=
s into
>> >> machine code. =A0Don't do it.
>> >>
>> >> By all means, allocate the memory via memblock, but do it in the =
->reserve
>> >> callback. =A0It's *exactly* what that callback is there for. =A0T=
he map it in
>> >> the ->map_io callback.
>> >>
>> >> Don't try to be clever and abuse these callbacks. =A0They aren't =
named just
>> >> for fun and my delectation. =A0They have *specific* purposes. =A0=
Stick to
>> >> those purposes in them and don't try to be clever, or you'll be m=
oaned at.
>> >>
>> >> So, NAK. =A0NAK for the original patch too. =A0Do it properly.
>> >
>> > It seems I missed this detail when I quickly read through the orig=
inal
>> > patch last September, which is rather unfortunate.
>> >
>> > That doesn't stop this being completely the wrong approach though =
- and
>> > being very very broken as it currently stands.
>>
>> May be I have missed you point but I thought below
>> should remove the initial mapping.
>>
>> memblock_free(paddr, size);
>> memblock_remove(paddr, size);
>
> Yes - but _only_ in the ->reserve callback, which was specifically ad=
ded
> to allow this to happen. =A0It is _only_ possible in _that_ callback =
and
> nowhere else.
>
> And, as I've said, memblock_alloc() elsewhere[*] is _potentially_ _da=
ngerous_
> because although it succeeds, the memory has _already_ been handed of=
f to
> other kernel allocators, and memblock no longer has control over how =
the
> memory it holds will be used.
>
>> This patch actually got under various versions. Indeed the
>> first version did implement the ->reserve callback method
>> but then it kept changing and you might have lost track of it.
>
> Which "it" kept changing ? =A0The ->reserve callback hasn't, neither =
has
> the above condition - and neither will it change.
>
I mean my patch and not the ->reserve callback.

> As I've said, it's the whole point why the ->reserve callback as adde=
d: to
> allow platforms to mark various regions of RAM as reserved, and remov=
e
> regions of RAM from the kernel's control _before_ they get mapped by =
the
> kernel.
>
>
>
> * - actually, the latest memblock_alloc() can be called is the map_io
> callback, but at that point a call to memblock_free() would be buggy.
> So lets not dilute the message. =A0->reserve ONLY.

OK. Point taken.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
