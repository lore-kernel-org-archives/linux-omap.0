From: Ming Lei <ming.lei@canonical.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 30 Jan 2012 17:40:11 +0800
Message-ID: <CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38143 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab2A3JkP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 04:40:15 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1Rrnif-0000dC-8R
	for linux-omap@vger.kernel.org; Mon, 30 Jan 2012 09:40:13 +0000
Received: by dadi2 with SMTP id i2so3403394dad.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 01:40:11 -0800 (PST)
In-Reply-To: <CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eranian@gmail.com
Cc: Will Deacon <will.deacon@arm.com>, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

Hi,

On Mon, Jan 30, 2012 at 1:36 AM, stephane eranian
<eranian@googlemail.com> wrote:
> Hi,
>
> Ok, so I did a few more tests and there is a serious issue when sampl=
ing
> in frequency mode (the default). I noticed wrong number of samples, s=
o
> I investigated this some more and instrumented the perf_event kernel =
code.
> I found some erratic timer ticks causing broken period adjustments.
>
> In fact, the problem is visible using top.
> I am running a noploop program on CPU0 and nothing else besides top.
> The noploop program =A0does: for(;;);. That is 100% user. On a 2-way

Sometimes it is not 100% user, for example irq/exception handling...

> system otherwise idle, I expect top to return 50% user 50% idle.
>
> Top with the commit:
>
> top - 16:19:21 up 5 min, =A01 user, =A0load average: 0.23, 0.15, 0.07
> Tasks: =A070 total, =A0 2 running, =A068 sleeping, =A0 0 stopped, =A0=
 0 zombie
> Cpu(s): 31.1%us, =A02.0%sy, =A00.0%ni, 66.2%id, =A00.0%wa, =A00.0%hi,=
 =A00.7%si, =A00.0%st
> =A0 =A0 =A0 =A0 =A0 =A0^^^^^^^^ That's WRONG

Did you reproduce the issue each time or just occasionally?

Looks no such issue on my board with 3.3-rc1 plus the 5 extra pmu/emu p=
atches.

top - 00:59:15 up 7 min,  1 user,  load average: 1.00, 0.73, 0.35
Tasks:  56 total,   2 running,  54 sleeping,   0 stopped,   0 zombie
Cpu(s): 42.6%us,  0.2%sy,  0.0%ni, 56.8%id,  0.0%wa,  0.0%hi,  0.4%si, =
 0.0%st
Mem:   1013560k total,    50960k used,   962600k free,     6272k buffer=
s
Swap:        0k total,        0k used,        0k free,    29036k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 1355 root      20   0  1460  260  216 R   99  0.0   5:07.38 busy
  532 root      20   0     0    0    0 S    0  0.0   0:00.23 kworker/1:=
1
 1356 root      20   0  2552 1120  916 R    0  0.1   0:01.93 top

>
> Mem: =A0 =A0940292k total, =A0 =A074984k used, =A0 865308k free, =A0 =
=A0 8020k buffers
> Swap: =A0 524240k total, =A0 =A0 =A0 =A00k used, =A0 524240k free, =A0=
 =A037420k cached
>
> =A0PID USER =A0 =A0 =A0PR =A0NI =A0VIRT =A0RES =A0SHR S %CPU %MEM =A0=
 =A0TIME+ =A0COMMAND
> =A03770 eranian =A0 20 =A0 0 644 160 128 R =A0 99 =A00.0 =A0 0:14.21 =
noploop
> =A03771 eranian =A0 20 =A0 0 =A02184 1052 =A0804 R =A0 =A02 =A00.1 =A0=
 0:00.32 top
> =A0 =A01 root =A0 =A0 =A020 =A0 0 =A02564 1528 =A0952 S =A0 =A00 =A00=
=2E2 =A0 0:01.26 init
>
>
> I removed that one liner patch from Ming. The one fiddling with the
> clockdomains:
>
> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm =3D =
{
> =A0 =A0 =A0 =A0.prcm_partition =A0 =3D OMAP4430_PRM_PARTITION,
> =A0 =A0 =A0 =A0.cm_inst =A0 =A0 =A0 =A0 =A0=3D OMAP4430_PRM_EMU_CM_IN=
ST,
> =A0 =A0 =A0 =A0.clkdm_offs =A0 =A0 =A0 =3D OMAP4430_PRM_EMU_CM_EMU_CD=
OFFS,
> - =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_HWSUP,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D CLKDM_CAN_SWSUP,

The patch should not affect timer tick logic, and what the patch does i=
s
just to revert the commit [1]  wrt. emu clock domain.

>
> When I rerun, the test, it now work:
>
> top - 16:02:51 up 15 min, =A01 user, =A0load average: 1.02, 0.46, 0.2=
1
> Tasks: =A070 total, =A0 2 running, =A068 sleeping, =A0 0 stopped, =A0=
 0 zombie
> Cpu(s): 47.2%us, =A01.0%sy, =A00.0%ni, 50.8%id, =A00.0%wa, =A00.0%hi,=
 =A01.0%si, =A00.0%st
> =A0 =A0 =A0 =A0 =A0 ^^^^^^^^ close enough (in it stabilize somehow ar=
ound 49%
> which is good)
>
> Mem: =A0 =A0940292k total, =A0 =A075288k used, =A0 865004k free, =A0 =
=A0 8004k buffers
> Swap: =A0 524240k total, =A0 =A0 =A0 =A00k used, =A0 524240k free, =A0=
 =A037408k cached
>
> =A0PID USER =A0 =A0 =A0PR =A0NI =A0VIRT =A0RES =A0SHR S %CPU %MEM =A0=
 =A0TIME+ =A0COMMAND
> =A03771 eranian =A0 20 =A0 0 644 160 128 R =A0100 =A00.0 =A0 0:34.44 =
noploop
>
> Although the patch fixes PMU interrupts, it breaks the timer tick log=
ic somehow.
> The perf problem is related to timer tick.
>
> I am hoping that the tradeoff is not:
> =A0 =A0 PMU interrupts but broken timer ticks
> vs.
> =A0 =A0No PMU interrupts but working timer ticks



[1], 3c50729b3fa1cd8ca1f347e6caf1081204cf1a7c
ARM: OMAP4: PM: Initialise all the clockdomains to supported states

thanks
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
