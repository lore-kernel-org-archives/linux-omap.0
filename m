From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Wed, 18 Jan 2012 10:54:46 +0100
Message-ID: <CAMsRxfLtLnMiP0ZGr6rNLv-UeLUwOSJ=7do2nezOU5OkOA+MbQ@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
	<4F0B182D.7060507@us.ibm.com>
	<20120109224945.GA23090@mudshark.cambridge.arm.com>
	<CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
	<CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
	<CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59529 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757193Ab2ARJyr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jan 2012 04:54:47 -0500
Received: by vbbfp1 with SMTP id fp1so1735260vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Jan 2012 01:54:46 -0800 (PST)
In-Reply-To: <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>

On Wed, Jan 18, 2012 at 5:18 AM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> Hi stephane & Will,
>
> On Tue, Jan 10, 2012 at 8:46 AM, stephane eranian
> <eranian@googlemail.com> wrote:
>> See the dmesg from my 3.2 kernel:
>>
>>
>> [ =C2=A0 =C2=A00.000000] Booting Linux on physical CPU 0[ =C2=A0 =C2=
=A00.000000]
>
> Looks no obvious failure can be found from your 'dmesg'.
>
> I have run upstream 3.2 kernel plus 6 omap4 pmu patches below and
> found perf can work well on my panda board.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A00001-arm-introduce-cross-trigger-interface=
-helpers.patch
> =C2=A0 =C2=A0 =C2=A0 =C2=A00002-arm-pmu-allow-platform-specific-irq-e=
nable-disable-h.patch
> =C2=A0 =C2=A0 =C2=A0 =C2=A00003-arm-omap4-hwmod-introduce-emu-hwmod.p=
atch or Benoit's debugss patch[2]
> =C2=A0 =C2=A0 =C2=A0 =C2=A00004-arm-omap4-create-pmu-device-via-hwmod=
=2Epatch[3]
> =C2=A0 =C2=A0 =C2=A0 =C2=A00005-arm-omap4-support-pmu.patch[4]
> =C2=A0 =C2=A0 =C2=A0 =C2=A00006-arm-omap4-pmu-support-runtime-pm.patc=
h[5]
>
> Could you verify the above patches on 3.2 to see if perf can work wel=
l?
> If it doesn't, I may share my u-boot and mlo for your test if you'd l=
ike to do.
>
> BTW: #1 and #2 have been in Will's -next tree.
>
Should I use Will's -next tree as the base instead of Linus'?
Given that MARC is shutdown today, would you mind packing those patches
into a tarball and sending them to me directly?

When you mention Will's -next tree, are you talking about:
git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/p=
erf

Thanks.

> thanks,
> --
> Ming Lei
>
> [1], uname -a & cat /proc/interrupts
> [root@root]#uname -a
> Linux beagleboard 3.2.0+ #480 SMP PREEMPT Wed Jan 18 11:38:33 CST 201=
2
> armv7l GNU/Linux
> [root@root]#cat /proc/interrupts
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU0 =C2=A0 =C2=A0 =C2=A0 CPU1
> =C2=A029: =C2=A0 =C2=A0 =C2=A029014 =C2=A0 =C2=A0 =C2=A017353 =C2=A0 =
=C2=A0 =C2=A0 GIC =C2=A0twd
> =C2=A033: =C2=A0 =C2=A0 =C2=A056231 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0 =C2=A0 =C2=A0 =C2=A0 GIC =C2=A0arm-pmu
> =C2=A034: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A0257=
78 =C2=A0 =C2=A0 =C2=A0 GIC =C2=A0arm-pmu
>
> [2], http://marc.info/?l=3Dlinux-omap&m=3D132162118104901&w=3D2
> [3],http://marc.info/?t=3D132227621500002&r=3D1&w=3D2
> [4],http://marc.info/?t=3D132227621700002&r=3D1&w=3D2
> [5],http://marc.info/?t=3D132227621700003&r=3D1&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
