From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
 	cache line size
Date: Mon, 11 May 2009 13:26:11 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AF66543@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E2AF66245@dlee03.ent.ti.com>
	 <20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905110931i3b81b991x9b7686c5bda25ff8@mail.gmail.com>
	 <20090511.203528.258116329.Hiroshi.DOYU@nokia.com>
 <94a0d4530905111054x138375e3p5e2b6d08c9b31120@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58965 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754983AbZEKS0Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 14:26:24 -0400
In-Reply-To: <94a0d4530905111054x138375e3p5e2b6d08c9b31120@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

To summarize the discussion.

We need to have the check for 128 bytes alignment (upper and lower). Th=
e 2 places that this can be done are in flush function or in Map functi=
on.

	- I prefer the check is done in Map function as Felipe mentioned this =
function is bound to be called by MM components as opposed to Flush fun=
ction. Also, another reason is the flush function in Bridge driver is g=
oing to be removed eventually.
=09
The open issue is the impact on the OMX components. Once if we finalize=
 that there is no impact on the existing OMX components or we have a pl=
an to take this into account we can enforce this check.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Monday, May 11, 2009 12:54 PM
> To: Hiroshi DOYU
> Cc: Kanigeri, Hari; Menon, Nishanth; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment f=
or
> dsp cache line size
>=20
> On Mon, May 11, 2009 at 8:35 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
>
> wrote:
> > From: ext Felipe Contreras <felipe.contreras@gmail.com>
> > Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment=
 for
> dsp cache line size
> > Date: Mon, 11 May 2009 18:31:28 +0200
> >
> >> On Mon, May 11, 2009 at 6:47 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.=
com>
> wrote:
> >> > Hi Hari,
> >> >
> >> > From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> >> > Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignm=
ent
> for dsp cache line size
> >> > Date: Mon, 11 May 2009 17:09:03 +0200
> >> >
> >> >> Hi Doyu-san,
> >> >>
> >> >> > A buffer shared with MPU and DSP has to be aligned on both ca=
che
> line
> >> >> > size to avoid memory corrupton with some DSP cache operations=
=2E
> Since
> >> >> > there's no way for dspbridge to know how the shared buffer wi=
ll be
> >> >> > used like: "read-only", "write-only", "rw" through its life s=
pan,
> any
> >> >> > shared buffer passed to DSP should be on this alignment. This
> patch
> >> >> > adds checking those shared buffer alignement in bridgedriver =
cache
> >> >> > operations and prevents userland applications from causing th=
e
> above
> >> >> > memory corruption.
> >> >> >
> >> >>
> >> >> -- It looks like the buffer that are passed to the Bridge are n=
ot
> necessarily 128 byte aligned.
> >> >>
> >> >> This is the comment I received from Nikhil Mande (MM Engineer).
> >> >>
> >> >> [Nikhil Mande] "They are not necessarily "aligned" all the time=
=2E
> >> >> Sometimes they just have 128 byte padding at the start & end of=
 the
> buffer and the buffer pointer passed to bridge is not guaranteed to b=
e 128
> aligned.
> >> >> So if you are adding such a check, it will require modification=
s OMX
> >> >> components & test apps."
> >> >
> >> > The above means that passing unaligned address to dsp can cause
> memory
> >> > corruption in kernel and this problem can be avoided only in the=
 case
> >> > where OMX(userland) is always supposed to pass aligned address. =
=A0The
> >> > above assumption cannot be accepted because kernel should always=
 be
> >> > robust against any incorrect behaviour of userland application. =
=46or
> >> > example, even if an userland application passes any incorrect
> >> > parameters to kernel through ioctl(), kernel shouldn't crash, bu=
t
> just
> >> > returns -EINVAL.
> >>
> >> Yes, but flush and invalidate are not the right places to do that.=
 An
> >> application in user-space might be buggy and decide not to do any
> >> flush or invalidation, therefore the checks won't happen. A more
> >> proper use-case could be to flush only parts of a big buffer.
> >
> > Without cache flushing/invalidating from ARM, memory won't be
> > corrupted. The problem here is cache operation with incorrect addre=
ss.
>=20
> From ARM point of view flushing is done after ARM side writes to the
> buffer and before DSP *reads*, right? So invalidate happens after DSP
> *writes* to the buffer and before ARM reads it, right?
>=20
> If that's the case then the check should happen only on invalidate,
> not flush. But oh wait a second, omx is not invalidating any memory.
> So can you explain to me what is happening?
>=20
> But the DSP side also does the same; before reading a buffer from ARM
> it invalidates it, and after writing it flushes it.
>=20
> I thought the last operation (DSP flush) is the one that generated th=
e
> memory corruption.
>=20
> >> Also, you are not checking for the upper limit, which also should =
be
> >> 128-byte aligned.
> >
> > The further sanity checking should be done with VMA. That's the uni=
x
> way.
>=20
> The VMA would check the flush from DSP side is not touching wrong ARM
> memory?
>=20
> >> A more correct place to do this would be on PROC_Map, which user-s=
pace
> >> cannot avoid in any way, and also you have the upper limit too.
> >> Unfortunately TI's OpenMAX IL is sending a fake upper limit (page
> >> aligned).
> >
> > Mapping is done with page aligned at least. no sense to do it in
> "PROC_Map()"
>=20
> With page aligned what? MPU address or memory area size?
>=20
> The omx code is page aligning the size but so is the the PROC_Map
> code, so that's redundant.
>=20
> In any case the ARM address (pMpuAddr) the one that should be 128-byt=
e
> aligned:
> DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ul=
Size,
> 		   void *pReqAddr, void **ppMapAddr, u32 ulMapAttr)
>=20
> --
> Felipe Contreras

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
