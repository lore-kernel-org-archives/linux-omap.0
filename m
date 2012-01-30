From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 30 Jan 2012 18:15:53 +0100
Message-ID: <CAMsRxfJLsnBnKBrEXOSOWUTbgfeZtVZ6nR8jt388=baL5Mn22Q@mail.gmail.com>
References: <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
	<20120127132826.GD2347@mudshark.cambridge.arm.com>
	<CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
	<CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
	<20120127155454.GH2347@mudshark.cambridge.arm.com>
	<CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
	<20120127165941.GK2347@mudshark.cambridge.arm.com>
	<CAMsRxf+iv06zOCMzhYONeLaf6RvOLp38T53mR--8ESHvCXMeFQ@mail.gmail.com>
	<20120127171009.GL2347@mudshark.cambridge.arm.com>
	<CAMsRxfJufRMrcfGZp53ALOdEFLk+YDMvQMrHw-jR9tQ8ThE+-Q@mail.gmail.com>
	<CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
	<CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
	<CAMsRxfJq1-tSQH4bv0BeNWXV9aysi9AUvywkh3e9SaamMDfZ0Q@mail.gmail.com>
	<CAMsRxf+okps60OxQnPkqHck8pWHrkPnT6boo603pC2XEbFYoRQ@mail.gmail.com>
	<CACVXFVMDXO3DDj0mGh=+uDYfCoS_Ck1STVK0=UXjiAbtJTa=hA@mail.gmail.com>
	<CAMsRxfLqvPN_k7vuC3qzBjwX2ihBdPxZvmSCPZ3frWgptWXQGA@mail.gmail.com>
	<yw1xsjixgolb.fsf@unicorn.mansr.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45338 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab2A3RPy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 12:15:54 -0500
Received: by vcbgb30 with SMTP id gb30so2861336vcb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 09:15:53 -0800 (PST)
In-Reply-To: <yw1xsjixgolb.fsf@unicorn.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

On Mon, Jan 30, 2012 at 5:08 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:
> stephane eranian <eranian@googlemail.com> writes:
>
>> Same result for me on CPU1:
>>
>> top - 16:20:24 up =C2=A01:45, =C2=A01 user, =C2=A0load average: 0.29=
, 0.08, 0.07
>> Tasks: =C2=A070 total, =C2=A0 2 running, =C2=A068 sleeping, =C2=A0 0=
 stopped, =C2=A0 0 zombie
>> Cpu(s): 30.7%us, =C2=A02.7%sy, =C2=A00.0%ni, 66.7%id, =C2=A00.0%wa, =
=C2=A00.0%hi, =C2=A00.0%si, =C2=A00.0%st
>> Mem: =C2=A0 =C2=A0940232k total, =C2=A0 228984k used, =C2=A0 711248k=
 free, =C2=A0 =C2=A082244k buffers
>> Swap: =C2=A0 524240k total, =C2=A0 =C2=A0 =C2=A0 =C2=A00k used, =C2=A0=
 524240k free, =C2=A0 =C2=A091400k cached
>>
>> =C2=A0 PID USER =C2=A0 =C2=A0 =C2=A0PR =C2=A0NI =C2=A0VIRT =C2=A0RES=
 =C2=A0SHR S %CPU %MEM =C2=A0 =C2=A0TIME+ =C2=A0P COMMAND
>> =C2=A03968 eranian =C2=A0 20 =C2=A0 0 =C2=A0 644 =C2=A0160 =C2=A0128=
 R =C2=A0100 =C2=A00.0 =C2=A0 0:21.98 1 noploop
>> =C2=A03969 eranian =C2=A0 20 =C2=A0 0 =C2=A02184 1056 =C2=A0804 R =C2=
=A0 =C2=A03 =C2=A00.1 =C2=A0 0:00.53 0 top
>> =C2=A0 =C2=A082 root =C2=A0 =C2=A0 =C2=A020 =C2=A0 0 =C2=A0 =C2=A0 0=
 =C2=A0 =C2=A00 =C2=A0 =C2=A00 S =C2=A0 =C2=A01 =C2=A00.0 =C2=A0 0:01.3=
5 0
>> kworker/0:1
>>
>> With 3.3.0-rc1, if I revert the clockdomain patch, I get the same re=
sult.
>> So it must be coming from somewhere else, as you suggested.
>>
>> If the processor was spending time processing interrupts, then this =
would be
>> accounted for in as sys time. But that's not what I observe here. It=
's either
>> idle or user. That line, leads me to believe that the processor can =
only run
>> my program for 30% of the time. The rest is spent idling even though=
 my
>> program is non-blocking. How could that be possible? Power-saving?
>
> In top, press 1 to see the statistics for the CPUs separately.
>
Ok, when I pin my program to CPU1, and press 1 in top I get:
asks:  69 total,   2 running,  67 sleeping,   0 stopped,   0 zombie
Cpu0  :  0.9%us,  3.8%sy,  0.0%ni, 94.3%id,  0.0%wa,  0.0%hi,  0.9%si, =
 0.0%st
Cpu1  :100.0%us,  0.0%sy,  0.0%ni,  0.0%id,  0.0%wa,  0.0%hi,  0.0%si, =
 0.0%st
Mem:    940232k total,    75480k used,   864752k free,     8148k buffer=
s
Swap:   524240k total,        0k used,   524240k free,    37568k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3788 eranian   20   0   644  160  128 R  100  0.0   0:47.93 noploop
 3758 eranian   20   0  9900 1512  712 S    2  0.2   0:01.17 sshd
 3789 eranian   20   0  2184 1056  804 R    2  0.1   0:01.22 top

Which gives me the right answer. But in 'collapsed mode', press 1 again=
,
the aggregate value is bogus. Could be wrong math in top. Ok, that was
a false alarm then. Thanks for the help.

Still need to investigate why the frequency mode does
not yield the correct number of samples even with low frequency.


$ taskset -c 1 perf record -e cycles -F 100 noploop 10
$ perf report -D | tail -20
Aggregated stats:
           TOTAL events:        475
            MMAP events:         11
            COMM events:          2
            EXIT events:          2
          SAMPLE events:        460
cycles stats:
           TOTAL events:        475
            MMAP events:         11
            COMM events:          2
            EXIT events:          2
          SAMPLE events:        460

460 samples is way too low. Should be 100x10 =3D 1000 samples or close =
to it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
