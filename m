From: Ming Lei <ming.lei@canonical.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Wed, 18 Jan 2012 12:18:46 +0800
Message-ID: <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
	<4F0B182D.7060507@us.ibm.com>
	<20120109224945.GA23090@mudshark.cambridge.arm.com>
	<CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
	<CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48655 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836Ab2ARESs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jan 2012 23:18:48 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RnMz0-0000Bd-7r
	for linux-omap@vger.kernel.org; Wed, 18 Jan 2012 04:18:46 +0000
Received: by werb13 with SMTP id b13so81185wer.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Jan 2012 20:18:46 -0800 (PST)
In-Reply-To: <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eranian@gmail.com
Cc: Will Deacon <will.deacon@arm.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>

Hi stephane & Will,

On Tue, Jan 10, 2012 at 8:46 AM, stephane eranian
<eranian@googlemail.com> wrote:
> See the dmesg from my 3.2 kernel:
>
>
> [ =A0 =A00.000000] Booting Linux on physical CPU 0[ =A0 =A00.000000]

Looks no obvious failure can be found from your 'dmesg'.

I have run upstream 3.2 kernel plus 6 omap4 pmu patches below and
found perf can work well on my panda board.

	0001-arm-introduce-cross-trigger-interface-helpers.patch
	0002-arm-pmu-allow-platform-specific-irq-enable-disable-h.patch
	0003-arm-omap4-hwmod-introduce-emu-hwmod.patch or Benoit's debugss pat=
ch[2]
	0004-arm-omap4-create-pmu-device-via-hwmod.patch[3]
	0005-arm-omap4-support-pmu.patch[4]
	0006-arm-omap4-pmu-support-runtime-pm.patch[5]

Could you verify the above patches on 3.2 to see if perf can work well?
If it doesn't, I may share my u-boot and mlo for your test if you'd lik=
e to do.

BTW: #1 and #2 have been in Will's -next tree.

thanks,
--
Ming Lei

[1], uname -a & cat /proc/interrupts
[root@root]#uname -a
Linux beagleboard 3.2.0+ #480 SMP PREEMPT Wed Jan 18 11:38:33 CST 2012
armv7l GNU/Linux
[root@root]#cat /proc/interrupts
           CPU0       CPU1
 29:      29014      17353       GIC  twd
 33:      56231          0       GIC  arm-pmu
 34:          0      25778       GIC  arm-pmu

[2], http://marc.info/?l=3Dlinux-omap&m=3D132162118104901&w=3D2
[3],http://marc.info/?t=3D132227621500002&r=3D1&w=3D2
[4],http://marc.info/?t=3D132227621700002&r=3D1&w=3D2
[5],http://marc.info/?t=3D132227621700003&r=3D1&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
