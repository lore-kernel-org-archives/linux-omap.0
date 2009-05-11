From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
	cache line size
Date: Mon, 11 May 2009 19:36:01 +0300
Message-ID: <94a0d4530905110936gc0ab62cr6d870f5bcbe3c97b@mail.gmail.com>
References: <1242017713-25795-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <1242017713-25795-2-git-send-email-Hiroshi.DOYU@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF66245@dlee03.ent.ti.com>
	 <20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF663CA@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:61426 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbZEKQgC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 12:36:02 -0400
Received: by fg-out-1718.google.com with SMTP id 16so961871fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 11 May 2009 09:36:01 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2AF663CA@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, May 11, 2009 at 7:26 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Hi Doyu-san,
>
>>
>> Hi Hari,
>>
>> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
>> Subject: RE: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for
>> dsp cache line size
>> Date: Mon, 11 May 2009 17:09:03 +0200
>>
>> > Hi Doyu-san,
>> >
>> > > A buffer shared with MPU and DSP has to be aligned on both cache line
>> > > size to avoid memory corrupton with some DSP cache operations. Since
>> > > there's no way for dspbridge to know how the shared buffer will be
>> > > used like: "read-only", "write-only", "rw" through its life span, any
>> > > shared buffer passed to DSP should be on this alignment. This patch
>> > > adds checking those shared buffer alignement in bridgedriver cache
>> > > operations and prevents userland applications from causing the above
>> > > memory corruption.
>> > >
>> >
>> > -- It looks like the buffer that are passed to the Bridge are not
>> necessarily 128 byte aligned.
>> >
>> > This is the comment I received from Nikhil Mande (MM Engineer).
>> >
>> > [Nikhil Mande] "They are not necessarily "aligned" all the time.
>> > Sometimes they just have 128 byte padding at the start & end of the
>> buffer and the buffer pointer passed to bridge is not guaranteed to be 128
>> aligned.
>> > So if you are adding such a check, it will require modifications OMX
>> > components & test apps."
>>
>> The above means that passing unaligned address to dsp can cause memory
>> corruption in kernel and this problem can be avoided only in the case
>> where OMX(userland) is always supposed to pass aligned address.
>
> -- Why would there be memory corruption if the OMX components did the 128 bytes padding? The padding is dummy region which is not used by any other process.

It's the kernel's job to enforce proper usage of memory, it should not
blindly trust that user-space is doing the right thing.

-- 
Felipe Contreras
