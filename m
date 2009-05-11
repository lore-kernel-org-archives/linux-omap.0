From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
	cache line size
Date: Mon, 11 May 2009 20:54:18 +0300
Message-ID: <94a0d4530905111054x138375e3p5e2b6d08c9b31120@mail.gmail.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E2AF66245@dlee03.ent.ti.com>
	 <20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905110931i3b81b991x9b7686c5bda25ff8@mail.gmail.com>
	 <20090511.203528.258116329.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:16708 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989AbZEKRyT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 13:54:19 -0400
Received: by fg-out-1718.google.com with SMTP id d23so621655fga.17
        for <linux-omap@vger.kernel.org>; Mon, 11 May 2009 10:54:18 -0700 (PDT)
In-Reply-To: <20090511.203528.258116329.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: h-kanigeri2@ti.com, nm@ti.com, linux-omap@vger.kernel.org

On Mon, May 11, 2009 at 8:35 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment f=
or dsp cache line size
> Date: Mon, 11 May 2009 18:31:28 +0200
>
>> On Mon, May 11, 2009 at 6:47 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.co=
m> wrote:
>> > Hi Hari,
>> >
>> > From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
>> > Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignmen=
t for dsp cache line size
>> > Date: Mon, 11 May 2009 17:09:03 +0200
>> >
>> >> Hi Doyu-san,
>> >>
>> >> > A buffer shared with MPU and DSP has to be aligned on both cach=
e line
>> >> > size to avoid memory corrupton with some DSP cache operations. =
Since
>> >> > there's no way for dspbridge to know how the shared buffer will=
 be
>> >> > used like: "read-only", "write-only", "rw" through its life spa=
n, any
>> >> > shared buffer passed to DSP should be on this alignment. This p=
atch
>> >> > adds checking those shared buffer alignement in bridgedriver ca=
che
>> >> > operations and prevents userland applications from causing the =
above
>> >> > memory corruption.
>> >> >
>> >>
>> >> -- It looks like the buffer that are passed to the Bridge are not=
 necessarily 128 byte aligned.
>> >>
>> >> This is the comment I received from Nikhil Mande (MM Engineer).
>> >>
>> >> [Nikhil Mande] "They are not necessarily "aligned" all the time.
>> >> Sometimes they just have 128 byte padding at the start & end of t=
he buffer and the buffer pointer passed to bridge is not guaranteed to =
be 128 aligned.
>> >> So if you are adding such a check, it will require modifications =
OMX
>> >> components & test apps."
>> >
>> > The above means that passing unaligned address to dsp can cause me=
mory
>> > corruption in kernel and this problem can be avoided only in the c=
ase
>> > where OMX(userland) is always supposed to pass aligned address. =C2=
=A0The
>> > above assumption cannot be accepted because kernel should always b=
e
>> > robust against any incorrect behaviour of userland application. Fo=
r
>> > example, even if an userland application passes any incorrect
>> > parameters to kernel through ioctl(), kernel shouldn't crash, but =
just
>> > returns -EINVAL.
>>
>> Yes, but flush and invalidate are not the right places to do that. A=
n
>> application in user-space might be buggy and decide not to do any
>> flush or invalidation, therefore the checks won't happen. A more
>> proper use-case could be to flush only parts of a big buffer.
>
> Without cache flushing/invalidating from ARM, memory won't be
> corrupted. The problem here is cache operation with incorrect address=
=2E

=46rom ARM point of view flushing is done after ARM side writes to the
buffer and before DSP *reads*, right? So invalidate happens after DSP
*writes* to the buffer and before ARM reads it, right?

If that's the case then the check should happen only on invalidate,
not flush. But oh wait a second, omx is not invalidating any memory.
So can you explain to me what is happening?

But the DSP side also does the same; before reading a buffer from ARM
it invalidates it, and after writing it flushes it.

I thought the last operation (DSP flush) is the one that generated the
memory corruption.

>> Also, you are not checking for the upper limit, which also should be
>> 128-byte aligned.
>
> The further sanity checking should be done with VMA. That's the unix =
way.

The VMA would check the flush from DSP side is not touching wrong ARM m=
emory?

>> A more correct place to do this would be on PROC_Map, which user-spa=
ce
>> cannot avoid in any way, and also you have the upper limit too.
>> Unfortunately TI's OpenMAX IL is sending a fake upper limit (page
>> aligned).
>
> Mapping is done with page aligned at least. no sense to do it in "PRO=
C_Map()"

With page aligned what? MPU address or memory area size?

The omx code is page aligning the size but so is the the PROC_Map
code, so that's redundant.

In any case the ARM address (pMpuAddr) the one that should be 128-byte =
aligned:
DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSi=
ze,
		   void *pReqAddr, void **ppMapAddr, u32 ulMapAttr)

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
