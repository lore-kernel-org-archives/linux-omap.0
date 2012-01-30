From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 30 Jan 2012 16:08:32 +0000
Message-ID: <yw1xsjixgolb.fsf@unicorn.mansr.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:50558 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab2A3QIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 11:08:34 -0500
In-Reply-To: <CAMsRxfLqvPN_k7vuC3qzBjwX2ihBdPxZvmSCPZ3frWgptWXQGA@mail.gmail.com>
	(stephane eranian's message of "Mon, 30 Jan 2012 17:02:06 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eranian@gmail.com
Cc: Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

stephane eranian <eranian@googlemail.com> writes:

> Same result for me on CPU1:
>
> top - 16:20:24 up  1:45,  1 user,  load average: 0.29, 0.08, 0.07
> Tasks:  70 total,   2 running,  68 sleeping,   0 stopped,   0 zombie
> Cpu(s): 30.7%us,  2.7%sy,  0.0%ni, 66.7%id,  0.0%wa,  0.0%hi,  0.0%si=
,  0.0%st
> Mem:    940232k total,   228984k used,   711248k free,    82244k buff=
ers
> Swap:   524240k total,        0k used,   524240k free,    91400k cach=
ed
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  P COMMAN=
D
>  3968 eranian   20   0   644  160  128 R  100  0.0   0:21.98 1 noploo=
p
>  3969 eranian   20   0  2184 1056  804 R    3  0.1   0:00.53 0 top
>    82 root      20   0     0    0    0 S    1  0.0   0:01.35 0
> kworker/0:1
>
> With 3.3.0-rc1, if I revert the clockdomain patch, I get the same res=
ult.
> So it must be coming from somewhere else, as you suggested.
>
> If the processor was spending time processing interrupts, then this w=
ould be
> accounted for in as sys time. But that's not what I observe here. It'=
s either
> idle or user. That line, leads me to believe that the processor can o=
nly run
> my program for 30% of the time. The rest is spent idling even though =
my
> program is non-blocking. How could that be possible? Power-saving?

In top, press 1 to see the statistics for the CPUs separately.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
