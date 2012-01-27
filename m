From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 16:57:25 +0100
Message-ID: <CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
References: <CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
	<CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
	<CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
	<CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
	<CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
	<20120127132826.GD2347@mudshark.cambridge.arm.com>
	<CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
	<CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
	<20120127155454.GH2347@mudshark.cambridge.arm.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47082 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885Ab2A0P50 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 10:57:26 -0500
Received: by vbbfc26 with SMTP id fc26so1348016vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jan 2012 07:57:25 -0800 (PST)
In-Reply-To: <20120127155454.GH2347@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Ming Lei <ming.lei@canonical.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, santosh.shilimkar@ti.com

On Fri, Jan 27, 2012 at 4:54 PM, Will Deacon <will.deacon@arm.com> wrot=
e:
> On Fri, Jan 27, 2012 at 03:45:53PM +0000, stephane eranian wrote:
>> Hi,
>
> Hi Stephane,
>
>> Ok, with the one-line patch [1], this works much better now.
>> No more wrap around a 4 billion cycles.
>
> Hurrah! Thanks Mans and Ming Lei for helping with this. Unfortunately=
, I
> remember Santosh had objections to this patch so that needs to be res=
olved.
>
Yes, this needs to be resolved ASAP.

>> Sampling is okay, though I noticed it tends to not get the
>> correct number of samples for a controlled run:
>>
>> $ perf record -e cycles -c 1009213 noploop 10
>> noploop for 10 seconds
>>
>> $ perf report -D | tail -20
>> cycles stats:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TOTAL events: =C2=A0 =C2=A0=
 =C2=A0 9938
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMAP events: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 13
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COMM events: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A02
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EXIT events: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A02
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 THROTTLE events: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 12
>> =C2=A0 =C2=A0 =C2=A0 UNTHROTTLE events: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
12
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAMPLE events: =C2=A0 =C2=A0 =C2=A0=
 9897
>>
>> Should not get throttled samples. Should get abour 10k samples
>> but only seeing 9897. The max_rate limit is way higher
>> than what I set the period (1000 samples/sec). But then,
>> is 3.2.0 throttling is broken. I posted a patch to fix that
>> yesterday. I will try with my patch applied as well.
>
> Ok. Note that on ARM the PMU generates a standard IRQ (i.e. not an NM=
I) so
> you may miss samples if they occur during critical kernel sections (a=
nd if
> you look at a profile, spin_unlock_irqrestore will be quite high).
>
But I am only running a user space noploop. So it spends 99% in user sp=
ace, no
critical section.

> A7 and A15 have the ability to filter counters based on privilege lev=
el, so
> you can get more accurate userspace counts there.

Ok, that's better. Need to update libpfm4 for A15 with priv levels then=
!

>
> Will
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
