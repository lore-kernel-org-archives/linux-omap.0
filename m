From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
	changes
Date: Thu, 12 Jan 2012 20:27:12 +0000
Message-ID: <20120112202712.GC16726@n2100.arm.linux.org.uk>
References: <20120112184256.GA2287@atomide.com> <20120112200443.GA16726@n2100.arm.linux.org.uk> <20120112201112.GB16726@n2100.arm.linux.org.uk> <CAMQu2gw+cYgY-Pn=3wbYBVxtGULvRG9H326-z_aHP+yMeD8RLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47898 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235Ab2ALU1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 15:27:25 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gw+cYgY-Pn=3wbYBVxtGULvRG9H326-z_aHP+yMeD8RLg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 12, 2012 at 09:20:38PM +0100, Shilimkar, Santosh wrote:
> On Thu, Jan 12, 2012 at 9:11 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jan 12, 2012 at 08:04:43PM +0000, Russell King - ARM Linux =
wrote:
> >> On Thu, Jan 12, 2012 at 10:42:57AM -0800, Tony Lindgren wrote:
> >> > Commit 73829af71fdb8655e7ba4b5a2a6612ad34a75a11
> >> > (Merge branch 'vmalloc' of git://git.linaro.org/people/nico/linu=
x
> >> > into devel-stable) merged generic ioremap changes.
> >> >
> >> > Commit 137d105d50f6e6c373c1aa759f59045e6239cf66
> >> > (ARM: OMAP4: Fix errata i688 with MPU interconnect barriers)
> >> > added a workaround for omap4.
> >> >
> >> > In order for the errata to work, we now need the following
> >> > patch or else we'll get:
> >> >
> >> > kernel BUG at mm/vmalloc.c:1134!
> >>
> >> Oh my, I've just read this, and I'm extremely annoyed that this ev=
en hit
> >> mainline in the first place. =A0It's utter crap.
> >>
> >> It's trying to use memblock to allocate memory _AFTER_ that memory=
 has
> >> been passed on from memblock's control to other allocators. =A0Cal=
ling
> >> memblock_alloc() at *any* initcall is Bad News (it _may_ appear to=
 work
> >> but there's no way for memblock_alloc to tell anything else that t=
he
> >> memory is being re-used.)
> >>
> >> Calling it and then trying to reserve it at ->map_io time is also =
Bad
> >> News - the memory at that point has already been mapped, and if yo=
u're
> >> expecting to be able to remap it with different attributes, you're=
 going
> >> to double-map it with differing attributes. =A0You lose.
> >>
> >> Not only that, but it's an abuse of the various callback functions=
 into
> >> machine code. =A0Don't do it.
> >>
> >> By all means, allocate the memory via memblock, but do it in the -=
>reserve
> >> callback. =A0It's *exactly* what that callback is there for. =A0Th=
e map it in
> >> the ->map_io callback.
> >>
> >> Don't try to be clever and abuse these callbacks. =A0They aren't n=
amed just
> >> for fun and my delectation. =A0They have *specific* purposes. =A0S=
tick to
> >> those purposes in them and don't try to be clever, or you'll be mo=
aned at.
> >>
> >> So, NAK. =A0NAK for the original patch too. =A0Do it properly.
> >
> > It seems I missed this detail when I quickly read through the origi=
nal
> > patch last September, which is rather unfortunate.
> >
> > That doesn't stop this being completely the wrong approach though -=
 and
> > being very very broken as it currently stands.
>=20
> May be I have missed you point but I thought below
> should remove the initial mapping.
>=20
> memblock_free(paddr, size);
> memblock_remove(paddr, size);

Yes - but _only_ in the ->reserve callback, which was specifically adde=
d
to allow this to happen.  It is _only_ possible in _that_ callback and
nowhere else.

And, as I've said, memblock_alloc() elsewhere[*] is _potentially_ _dang=
erous_
because although it succeeds, the memory has _already_ been handed off =
to
other kernel allocators, and memblock no longer has control over how th=
e
memory it holds will be used.

> This patch actually got under various versions. Indeed the
> first version did implement the ->reserve callback method
> but then it kept changing and you might have lost track of it.

Which "it" kept changing ?  The ->reserve callback hasn't, neither has
the above condition - and neither will it change.

As I've said, it's the whole point why the ->reserve callback as added:=
 to
allow platforms to mark various regions of RAM as reserved, and remove
regions of RAM from the kernel's control _before_ they get mapped by th=
e
kernel.



* - actually, the latest memblock_alloc() can be called is the map_io
callback, but at that point a call to memblock_free() would be buggy.
So lets not dilute the message.  ->reserve ONLY.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
