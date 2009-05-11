From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
 cache line size
Date: Mon, 11 May 2009 20:35:28 +0300 (EEST)
Message-ID: <20090511.203528.258116329.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E2AF66245@dlee03.ent.ti.com>
	<20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
	<94a0d4530905110931i3b81b991x9b7686c5bda25ff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24992 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbZEKRfi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 13:35:38 -0400
In-Reply-To: <94a0d4530905110931i3b81b991x9b7686c5bda25ff8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: h-kanigeri2@ti.com, nm@ti.com, linux-omap@vger.kernel.org

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for=
 dsp cache line size
Date: Mon, 11 May 2009 18:31:28 +0200

> On Mon, May 11, 2009 at 6:47 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
> wrote:
> > Hi Hari,
> >
> > From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> > Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment=
 for dsp cache line size
> > Date: Mon, 11 May 2009 17:09:03 +0200
> >
> >> Hi Doyu-san,
> >>
> >> > A buffer shared with MPU and DSP has to be aligned on both cache=
 line
> >> > size to avoid memory corrupton with some DSP cache operations. S=
ince
> >> > there's no way for dspbridge to know how the shared buffer will =
be
> >> > used like: "read-only", "write-only", "rw" through its life span=
, any
> >> > shared buffer passed to DSP should be on this alignment. This pa=
tch
> >> > adds checking those shared buffer alignement in bridgedriver cac=
he
> >> > operations and prevents userland applications from causing the a=
bove
> >> > memory corruption.
> >> >
> >>
> >> -- It looks like the buffer that are passed to the Bridge are not =
necessarily 128 byte aligned.
> >>
> >> This is the comment I received from Nikhil Mande (MM Engineer).
> >>
> >> [Nikhil Mande] "They are not necessarily "aligned" all the time.
> >> Sometimes they just have 128 byte padding at the start & end of th=
e buffer and the buffer pointer passed to bridge is not guaranteed to b=
e 128 aligned.
> >> So if you are adding such a check, it will require modifications O=
MX
> >> components & test apps."
> >
> > The above means that passing unaligned address to dsp can cause mem=
ory
> > corruption in kernel and this problem can be avoided only in the ca=
se
> > where OMX(userland) is always supposed to pass aligned address. =A0=
The
> > above assumption cannot be accepted because kernel should always be
> > robust against any incorrect behaviour of userland application. For
> > example, even if an userland application passes any incorrect
> > parameters to kernel through ioctl(), kernel shouldn't crash, but j=
ust
> > returns -EINVAL.
>=20
> Yes, but flush and invalidate are not the right places to do that. An
> application in user-space might be buggy and decide not to do any
> flush or invalidation, therefore the checks won't happen. A more
> proper use-case could be to flush only parts of a big buffer.

Without cache flushing/invalidating from ARM, memory won't be
corrupted. The problem here is cache operation with incorrect address.

> Also, you are not checking for the upper limit, which also should be
> 128-byte aligned.

The further sanity checking should be done with VMA. That's the unix wa=
y.

> A more correct place to do this would be on PROC_Map, which user-spac=
e
> cannot avoid in any way, and also you have the upper limit too.
> Unfortunately TI's OpenMAX IL is sending a fake upper limit (page
> aligned).

Mapping is done with page aligned at least. no sense to do it in "PROC_=
Map()"

> IMHO the only sensible way to approach this is to create a new ioctl
> for a special restrictive mapping where user-space specifies if the
> memory area is read-only or write-only and the size must be the real
> size. This also has advantage that it does not break legacy
> applications. While we are at it, this new mapping could do
> PROC_ReserveMemory at the same time so that the user-space applicatio=
n
> doesn't get a chance to modify the pa.
>=20
> --=20
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
