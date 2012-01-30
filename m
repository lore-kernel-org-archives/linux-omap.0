From: Ming Lei <ming.lei@canonical.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 30 Jan 2012 22:49:57 +0800
Message-ID: <CACVXFVMDXO3DDj0mGh=+uDYfCoS_Ck1STVK0=UXjiAbtJTa=hA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39614 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab2A3OuB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 09:50:01 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RrsYR-0002qy-Em
	for linux-omap@vger.kernel.org; Mon, 30 Jan 2012 14:49:59 +0000
Received: by dadi2 with SMTP id i2so3606173dad.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 06:49:57 -0800 (PST)
In-Reply-To: <CAMsRxf+okps60OxQnPkqHck8pWHrkPnT6boo603pC2XEbFYoRQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eranian@gmail.com
Cc: Will Deacon <will.deacon@arm.com>, =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

On Mon, Jan 30, 2012 at 9:43 PM, stephane eranian
<eranian@googlemail.com> wrote:
> Same results for me with 3.3.0-rc1 + 5 patches.

In fact, I think the only effect of the patch is to enable pmu
interrupt handling,
which may cause so much difference?

Also maybe you should put 'noploop' to run on CPU1 and you may observe
a more accurate result of 'top'.

On ARM, almost handling of all IRQs from gic is run on CPU0 at default,
which may cause your issue.

>
>
> top - 14:42:34 up 8 min, =A01 user, =A0load average: 0.70, 0.29, 0.15
> Tasks: =A075 total, =A0 2 running, =A073 sleeping, =A0 0 stopped, =A0=
 0 zombie
> Cpu(s): 32.9%us, =A01.3%sy, =A00.0%ni, 65.8%id, =A00.0%wa, =A00.0%hi,=
 =A00.0%si, =A00.0%st
> Mem: =A0 =A0940232k total, =A0 118520k used, =A0 821712k free, =A0 =A0=
 8080k buffers
> Swap: =A0 524240k total, =A0 =A0 =A0 =A00k used, =A0 524240k free, =A0=
 =A079432k cached
>
> =A0 PID USER =A0 =A0 =A0PR =A0NI =A0VIRT =A0RES =A0SHR S %CPU %MEM =A0=
 =A0TIME+ =A0COMMAND
> =A03868 eranian =A0 20 =A0 0 =A0 644 =A0160 =A0128 R =A0 99 =A00.0 =A0=
 0:53.34 noploop
> =A03870 eranian =A0 20 =A0 0 =A02284 1060 =A0804 R =A0 =A03 =A00.1 =A0=
 0:00.63 top
> =A0 =A0 1 root =A0 =A0 =A020 =A0 0 =A02564 1532 =A0952 S =A0 =A00 =A0=
0.2 =A0 0:01.26 init
>
> I am connecting to the board via ssh.
> But the results don't look correct to me.

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
