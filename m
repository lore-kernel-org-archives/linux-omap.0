From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 30 Jan 2012 11:24:59 +0100
Message-ID: <CAMsRxfJq1-tSQH4bv0BeNWXV9aysi9AUvywkh3e9SaamMDfZ0Q@mail.gmail.com>
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
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57960 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab2A3KZA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 05:25:00 -0500
Received: by vbbfc26 with SMTP id fc26so2698488vbb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 02:24:59 -0800 (PST)
In-Reply-To: <CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

Ok, let me try again with 3.3.0-rc1, that was with 3.2.0.
The only thing that changed was that one line and it made
a big difference.


On Mon, Jan 30, 2012 at 10:40 AM, Ming Lei <ming.lei@canonical.com> wro=
te:
> Hi,
>
> On Mon, Jan 30, 2012 at 1:36 AM, stephane eranian
> <eranian@googlemail.com> wrote:
>> Hi,
>>
>> Ok, so I did a few more tests and there is a serious issue when samp=
ling
>> in frequency mode (the default). I noticed wrong number of samples, =
so
>> I investigated this some more and instrumented the perf_event kernel=
 code.
>> I found some erratic timer ticks causing broken period adjustments.
>>
>> In fact, the problem is visible using top.
>> I am running a noploop program on CPU0 and nothing else besides top.
>> The noploop program =C2=A0does: for(;;);. That is 100% user. On a 2-=
way
>
> Sometimes it is not 100% user, for example irq/exception handling...
>
>> system otherwise idle, I expect top to return 50% user 50% idle.
>>
>> Top with the commit:
>>
>> top - 16:19:21 up 5 min, =C2=A01 user, =C2=A0load average: 0.23, 0.1=
5, 0.07
>> Tasks: =C2=A070 total, =C2=A0 2 running, =C2=A068 sleeping, =C2=A0 0=
 stopped, =C2=A0 0 zombie
>> Cpu(s): 31.1%us, =C2=A02.0%sy, =C2=A00.0%ni, 66.2%id, =C2=A00.0%wa, =
=C2=A00.0%hi, =C2=A00.7%si, =C2=A00.0%st
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^ That's WRONG
>
> Did you reproduce the issue each time or just occasionally?
>
> Looks no such issue on my board with 3.3-rc1 plus the 5 extra pmu/emu=
 patches.
>
> top - 00:59:15 up 7 min, =C2=A01 user, =C2=A0load average: 1.00, 0.73=
, 0.35
> Tasks: =C2=A056 total, =C2=A0 2 running, =C2=A054 sleeping, =C2=A0 0 =
stopped, =C2=A0 0 zombie
> Cpu(s): 42.6%us, =C2=A00.2%sy, =C2=A00.0%ni, 56.8%id, =C2=A00.0%wa, =C2=
=A00.0%hi, =C2=A00.4%si, =C2=A00.0%st
> Mem: =C2=A0 1013560k total, =C2=A0 =C2=A050960k used, =C2=A0 962600k =
free, =C2=A0 =C2=A0 6272k buffers
> Swap: =C2=A0 =C2=A0 =C2=A0 =C2=A00k total, =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0k used, =C2=A0 =C2=A0 =C2=A0 =C2=A00k free, =C2=A0 =C2=A029036k cached
>
> =C2=A0PID USER =C2=A0 =C2=A0 =C2=A0PR =C2=A0NI =C2=A0VIRT =C2=A0RES =C2=
=A0SHR S %CPU %MEM =C2=A0 =C2=A0TIME+ =C2=A0COMMAND
> =C2=A01355 root =C2=A0 =C2=A0 =C2=A020 =C2=A0 0 =C2=A01460 =C2=A0260 =
=C2=A0216 R =C2=A0 99 =C2=A00.0 =C2=A0 5:07.38 busy
> =C2=A0532 root =C2=A0 =C2=A0 =C2=A020 =C2=A0 0 =C2=A0 =C2=A0 0 =C2=A0=
 =C2=A00 =C2=A0 =C2=A00 S =C2=A0 =C2=A00 =C2=A00.0 =C2=A0 0:00.23 kwork=
er/1:1
> =C2=A01356 root =C2=A0 =C2=A0 =C2=A020 =C2=A0 0 =C2=A02552 1120 =C2=A0=
916 R =C2=A0 =C2=A00 =C2=A00.1 =C2=A0 0:01.93 top
>
>>
>> Mem: =C2=A0 =C2=A0940292k total, =C2=A0 =C2=A074984k used, =C2=A0 86=
5308k free, =C2=A0 =C2=A0 8020k buffers
>> Swap: =C2=A0 524240k total, =C2=A0 =C2=A0 =C2=A0 =C2=A00k used, =C2=A0=
 524240k free, =C2=A0 =C2=A037420k cached
>>
>> =C2=A0PID USER =C2=A0 =C2=A0 =C2=A0PR =C2=A0NI =C2=A0VIRT =C2=A0RES =
=C2=A0SHR S %CPU %MEM =C2=A0 =C2=A0TIME+ =C2=A0COMMAND
>> =C2=A03770 eranian =C2=A0 20 =C2=A0 0 644 160 128 R =C2=A0 99 =C2=A0=
0.0 =C2=A0 0:14.21 noploop
>> =C2=A03771 eranian =C2=A0 20 =C2=A0 0 =C2=A02184 1052 =C2=A0804 R =C2=
=A0 =C2=A02 =C2=A00.1 =C2=A0 0:00.32 top
>> =C2=A0 =C2=A01 root =C2=A0 =C2=A0 =C2=A020 =C2=A0 0 =C2=A02564 1528 =
=C2=A0952 S =C2=A0 =C2=A00 =C2=A00.2 =C2=A0 0:01.26 init
>>
>>
>> I removed that one liner patch from Ming. The one fiddling with the
>> clockdomains:
>>
>> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
>> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
>> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm =3D=
 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.prcm_partition =C2=A0 =3D OMAP4430_PRM_P=
ARTITION,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.cm_inst =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D OMAP4430_PRM_EMU_CM_INST,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.clkdm_offs =C2=A0 =C2=A0 =C2=A0 =3D OMAP=
4430_PRM_EMU_CM_EMU_CDOFFS,
>> - =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D CLKDM_CAN_HWSUP,
>> + =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D CLKDM_CAN_SWSUP,
>
> The patch should not affect timer tick logic, and what the patch does=
 is
> just to revert the commit [1] =C2=A0wrt. emu clock domain.
>
>>
>> When I rerun, the test, it now work:
>>
>> top - 16:02:51 up 15 min, =C2=A01 user, =C2=A0load average: 1.02, 0.=
46, 0.21
>> Tasks: =C2=A070 total, =C2=A0 2 running, =C2=A068 sleeping, =C2=A0 0=
 stopped, =C2=A0 0 zombie
>> Cpu(s): 47.2%us, =C2=A01.0%sy, =C2=A00.0%ni, 50.8%id, =C2=A00.0%wa, =
=C2=A00.0%hi, =C2=A01.0%si, =C2=A00.0%st
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^ close enough (in it stab=
ilize somehow around 49%
>> which is good)
>>
>> Mem: =C2=A0 =C2=A0940292k total, =C2=A0 =C2=A075288k used, =C2=A0 86=
5004k free, =C2=A0 =C2=A0 8004k buffers
>> Swap: =C2=A0 524240k total, =C2=A0 =C2=A0 =C2=A0 =C2=A00k used, =C2=A0=
 524240k free, =C2=A0 =C2=A037408k cached
>>
>> =C2=A0PID USER =C2=A0 =C2=A0 =C2=A0PR =C2=A0NI =C2=A0VIRT =C2=A0RES =
=C2=A0SHR S %CPU %MEM =C2=A0 =C2=A0TIME+ =C2=A0COMMAND
>> =C2=A03771 eranian =C2=A0 20 =C2=A0 0 644 160 128 R =C2=A0100 =C2=A0=
0.0 =C2=A0 0:34.44 noploop
>>
>> Although the patch fixes PMU interrupts, it breaks the timer tick lo=
gic somehow.
>> The perf problem is related to timer tick.
>>
>> I am hoping that the tradeoff is not:
>> =C2=A0 =C2=A0 PMU interrupts but broken timer ticks
>> vs.
>> =C2=A0 =C2=A0No PMU interrupts but working timer ticks
>
>
>
> [1], 3c50729b3fa1cd8ca1f347e6caf1081204cf1a7c
> ARM: OMAP4: PM: Initialise all the clockdomains to supported states
>
> thanks
> --
> Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
