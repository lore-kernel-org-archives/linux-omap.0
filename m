From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 18:03:28 +0100
Message-ID: <CAMsRxf+iv06zOCMzhYONeLaf6RvOLp38T53mR--8ESHvCXMeFQ@mail.gmail.com>
References: <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
	<CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
	<CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
	<20120127132826.GD2347@mudshark.cambridge.arm.com>
	<CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
	<CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
	<20120127155454.GH2347@mudshark.cambridge.arm.com>
	<CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
	<20120127165941.GK2347@mudshark.cambridge.arm.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57255 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab2A0RD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 12:03:29 -0500
Received: by vbbfc26 with SMTP id fc26so1408834vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jan 2012 09:03:28 -0800 (PST)
In-Reply-To: <20120127165941.GK2347@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Ming Lei <ming.lei@canonical.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

On Fri, Jan 27, 2012 at 5:59 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jan 27, 2012 at 03:57:25PM +0000, stephane eranian wrote:
>> On Fri, Jan 27, 2012 at 4:54 PM, Will Deacon <will.deacon@arm.com> wrote:
>> >
>> > Ok. Note that on ARM the PMU generates a standard IRQ (i.e. not an NMI) so
>> > you may miss samples if they occur during critical kernel sections (and if
>> > you look at a profile, spin_unlock_irqrestore will be quite high).
>> >
>> But I am only running a user space noploop. So it spends 99% in user space, no
>> critical section.
>
> and your result is almost 99% of the way there :)
>
> There are also potential overheads from the PMU interrupts themselves, since
> there is a latency between overflow and taking the interrupt and then
> between there are actually reading the counter (they continue to count after
> overflow).
>
> That said, if you see any bugs in the code please do shout!
>
I suspect there is something wrong, we shouldn't hit the max_rate_limit.
You may have bursts of interrupts (samples). I'll check on that this week-end.

>> > A7 and A15 have the ability to filter counters based on privilege level, so
>> > you can get more accurate userspace counts there.
>>
>> Ok, that's better. Need to update libpfm4 for A15 with priv levels then!
>
> How do you handle that in libpfm4? On ARM, the event encodings remain the same,
> you just need to set some extra bits to determine which levels are included or
> excluded (you can do this with the perf tool by using the :{u,k,h} suffix on an
> event description).
>
It depends what you call the encoding? If the priv level can be encoded in the
attr->config field, then that's easy. If it needs to be set somewhere else, then
we need to figure out how you encode it in the attr struct. Either in some other
bits in attr->config or use attr->config1, for instance. You tell me.

> Will
