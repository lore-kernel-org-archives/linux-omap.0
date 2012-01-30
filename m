From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 30 Jan 2012 21:45:44 +0100
Message-ID: <CAMsRxfK5Ynpp7AOVeuA-t05qjGUAgibkOV6scEJVHOJwdXENCg@mail.gmail.com>
References: <CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
	<CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
	<CAMsRxfJq1-tSQH4bv0BeNWXV9aysi9AUvywkh3e9SaamMDfZ0Q@mail.gmail.com>
	<CAMsRxf+okps60OxQnPkqHck8pWHrkPnT6boo603pC2XEbFYoRQ@mail.gmail.com>
	<CACVXFVMDXO3DDj0mGh=+uDYfCoS_Ck1STVK0=UXjiAbtJTa=hA@mail.gmail.com>
	<CAMsRxfLqvPN_k7vuC3qzBjwX2ihBdPxZvmSCPZ3frWgptWXQGA@mail.gmail.com>
	<yw1xsjixgolb.fsf@unicorn.mansr.com>
	<CAMsRxfJLsnBnKBrEXOSOWUTbgfeZtVZ6nR8jt388=baL5Mn22Q@mail.gmail.com>
	<20120130172438.GC17814@mudshark.cambridge.arm.com>
	<CAMsRxfLc-wxx9pELJSdV2DmzGHpVmWOg7SAs=jm-s=5jaNh4HQ@mail.gmail.com>
	<20120130191443.GB27764@mudshark.cambridge.arm.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39185 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab2A3Upp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 15:45:45 -0500
Received: by vcbgb30 with SMTP id gb30so3053072vcb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 12:45:44 -0800 (PST)
In-Reply-To: <20120130191443.GB27764@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Ming Lei <ming.lei@canonical.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

On Mon, Jan 30, 2012 at 8:14 PM, Will Deacon <will.deacon@arm.com> wrot=
e:
> On Mon, Jan 30, 2012 at 05:45:19PM +0000, stephane eranian wrote:
>> There you go, no attachment, not sure the omap list
>> supports this.
>
> Cheers Stephane.
>
>> There is something quite interesting to observe.
>>
>> While I run perf record -e cycles -F 100 noploop 10, I watch
>> /proc/interrupts. The number of interrupts is way lower than
>> expected. Therefore the number of samples is way too low:
>>
>> $ perf record -e cycles -F 100 noploop 10
>> $ perf report -D | tail -20
>> cycles stats:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TOTAL events: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0535
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMAP events: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 11
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COMM events: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A02
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EXIT events: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A02
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAMPLE events: =C2=A0 =C2=A0 =C2=A0=
 =C2=A0520
>>
>> The delta in /proc/interrupts on CPU1 is 520 interrupts.
>
> Yes, that is about half of what you'd expect. Running on my A9 platfo=
rm
> (vexpress) I get:
>
> $ perf record -e cycles -F 100 noploop 10
> $ perf report -D | tail -20
> cycles stats:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TOTAL events: =C2=A0 =C2=A0 =C2=A0=
 1007
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMAP events: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 18
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COMM events: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EXIT events: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAMPLE events: =C2=A0 =C2=A0 =C2=A0=
 =C2=A0985
>
>> So looks like the frequency adjustment which is hooked off of the
>> timer tick is either not called at each timer tick, the timer ticks =
are
>> not at regular interval, or the math is wrong.
>
> My hunch is that that the interval is probably varying, but I don't k=
now much
> about OMAP4 and its clocks.
>
Glad you tested this. At least, it seems the generic perf_event code
is allright.
I agree with you, something is fishy with the clocks. Just out of
curiosity, what is
the HZ value for your board? On my Panda it's 128Hz.

>> If I go with the fixed period mode:
>> $ perf stat -e cycles noploop 10
>> noploop for 10 seconds
>> =C2=A0Performance counter stats for 'noploop 10':
>> =C2=A0 =C2=A0 =C2=A0 =C2=A010079156960 cycles =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A00.000 GHz
>> =C2=A0 =C2=A0 =C2=A0 10.004547117 seconds time elapsed
>>
>> That means, if I want 100 samples/sec: =3D 10079156960/(10*100)=3D10=
079157
>> $ perf record -e cycles -c 10079157 noploop 10
>> $ perf report -D | tail -20
>> cycles stats:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TOTAL events: =C2=A0 =C2=A0=
 =C2=A0 1003
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMAP events: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 11
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 COMM events: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A02
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EXIT events: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A02
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 THROTTLE events: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01
>> =C2=A0 =C2=A0 =C2=A0 UNTHROTTLE events: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A01
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAMPLE events: =C2=A0 =C2=A0 =C2=A0=
 =C2=A0986
>>
>> Now, we're getting the right answer!
>
> Just to confirm, for me:
>
> $ perf stat -e cycles ./noploop 10
> noploop for 10 seconds
>
> =C2=A0Performance counter stats for './noploop 10':
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A04001163930 cycles =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 =C2=A00.000 GHz
>
> =C2=A0 =C2=A0 =C2=A010.006534024 seconds time elapsed
>
> $ perf record -e cycles -c 4001163 ./noploop 10
> $ perf report -D | tail -20
> =C2=A0Aggregated stats:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TOTAL events: =C2=A0 =C2=A0 =C2=A0=
 1020
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMAP events: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 18
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COMM events: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EXIT events: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAMPLE events: =C2=A0 =C2=A0 =C2=A0=
 =C2=A0998
> cycles stats:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TOTAL events: =C2=A0 =C2=A0 =C2=A0=
 1020
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMAP events: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 18
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0COMM events: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EXIT events: =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAMPLE events: =C2=A0 =C2=A0 =C2=A0=
 =C2=A0998
>
> which is close enough :)
>
>> We need to elucidate what's going on in perf_event_task_tick().
>> I have tried with my throttling fix and it did not help. We are
>> not subject to throttling with such a low rate.
>
> Ok. I would start by looking at the clock ticks if I were you, since =
this
> seems to be alright on my board.
>
> Will
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
