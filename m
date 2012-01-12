From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap changes
Date: Thu, 12 Jan 2012 21:20:38 +0100
Message-ID: <CAMQu2gw+cYgY-Pn=3wbYBVxtGULvRG9H326-z_aHP+yMeD8RLg@mail.gmail.com>
References: <20120112184256.GA2287@atomide.com> <20120112200443.GA16726@n2100.arm.linux.org.uk>
 <20120112201112.GB16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:47563 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753711Ab2ALUVE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 15:21:04 -0500
Received: by mail-qw0-f53.google.com with SMTP id b10so45390qad.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 12:21:02 -0800 (PST)
In-Reply-To: <20120112201112.GB16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 12, 2012 at 9:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 12, 2012 at 08:04:43PM +0000, Russell King - ARM Linux wr=
ote:
>> On Thu, Jan 12, 2012 at 10:42:57AM -0800, Tony Lindgren wrote:
>> > Commit 73829af71fdb8655e7ba4b5a2a6612ad34a75a11
>> > (Merge branch 'vmalloc' of git://git.linaro.org/people/nico/linux
>> > into devel-stable) merged generic ioremap changes.
>> >
>> > Commit 137d105d50f6e6c373c1aa759f59045e6239cf66
>> > (ARM: OMAP4: Fix errata i688 with MPU interconnect barriers)
>> > added a workaround for omap4.
>> >
>> > In order for the errata to work, we now need the following
>> > patch or else we'll get:
>> >
>> > kernel BUG at mm/vmalloc.c:1134!
>>
>> Oh my, I've just read this, and I'm extremely annoyed that this even=
 hit
>> mainline in the first place. =A0It's utter crap.
>>
>> It's trying to use memblock to allocate memory _AFTER_ that memory h=
as
>> been passed on from memblock's control to other allocators. =A0Calli=
ng
>> memblock_alloc() at *any* initcall is Bad News (it _may_ appear to w=
ork
>> but there's no way for memblock_alloc to tell anything else that the
>> memory is being re-used.)
>>
>> Calling it and then trying to reserve it at ->map_io time is also Ba=
d
>> News - the memory at that point has already been mapped, and if you'=
re
>> expecting to be able to remap it with different attributes, you're g=
oing
>> to double-map it with differing attributes. =A0You lose.
>>
>> Not only that, but it's an abuse of the various callback functions i=
nto
>> machine code. =A0Don't do it.
>>
>> By all means, allocate the memory via memblock, but do it in the ->r=
eserve
>> callback. =A0It's *exactly* what that callback is there for. =A0The =
map it in
>> the ->map_io callback.
>>
>> Don't try to be clever and abuse these callbacks. =A0They aren't nam=
ed just
>> for fun and my delectation. =A0They have *specific* purposes. =A0Sti=
ck to
>> those purposes in them and don't try to be clever, or you'll be moan=
ed at.
>>
>> So, NAK. =A0NAK for the original patch too. =A0Do it properly.
>
> It seems I missed this detail when I quickly read through the origina=
l
> patch last September, which is rather unfortunate.
>
> That doesn't stop this being completely the wrong approach though - a=
nd
> being very very broken as it currently stands.

May be I have missed you point but I thought below
should remove the initial mapping.

memblock_free(paddr, size);
memblock_remove(paddr, size);

This patch actually got under various versions. Indeed the
first version did implement the ->reserve callback method
but then it kept changing and you might have lost track of it.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
