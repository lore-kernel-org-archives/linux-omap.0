From: Ming Lei <ming.lei@canonical.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 10 Jan 2012 07:30:07 +0800
Message-ID: <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
	<4F0B182D.7060507@us.ibm.com>
	<20120109224945.GA23090@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47734 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933481Ab2AIXaL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 18:30:11 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RkOfJ-0002ed-LU
	for linux-omap@vger.kernel.org; Mon, 09 Jan 2012 23:30:09 +0000
Received: by dajs34 with SMTP id s34so2491085daj.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 15:30:07 -0800 (PST)
In-Reply-To: <20120109224945.GA23090@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eranian@googlemail.com

Hi,

On Tue, Jan 10, 2012 at 6:49 AM, Will Deacon <will.deacon@arm.com> wrot=
e:
> On Mon, Jan 09, 2012 at 04:39:09PM +0000, Maynard Johnson wrote:
>> On 01/08/2012 8:58 PM, Lik Lik wrote:
>> > Hi all,
>
> Hi guys [adding a bunch of people to CC because this issue is really
> annoying me now],
>
>> > I am an oprofile user and I need to profile one of my applications=
 on a TI OMAP4
>> > platform (pandaboard, to be specific). I have ubuntu 11.10 install=
ed. My problem
>> > is that oprofile always use the timer interrupt mode but doesn't r=
ecognize the
>> > hardware counters, which I am sure my platform has.
>
> First and foremost, we can't currently generate PMU interrupts on OMA=
P4 in
> mainline. There are some additional patches required for these to wor=
k:
>
> http://marc.info/?l=3Dlinux-arm-kernel&m=3D131946761428296&w=3D2
>
> However, as Stephane has pointed out here:
>
> http://marc.info/?l=3Dlinux-omap&m=3D132585784125352&w=3D2
>
> the interrupts still don't seem to work, even with the patches above
> applied.
>
> Ming Lei doesn't seem to be replying to email anymore, so maybe someb=
ody

Sorry, I am on a trip now and no pandboard at my hand, so I may have
time to verify
the latest mainline next week after I return home.

I remembered that last time I verified these patches on 3.2-rc2 and
3.2-rc2 next tree,
and perf did work well on my pandaboard.

Also seems there were reports that omap4 perf may not work on some spec=
ific
uboot version even with these patches.

> else on linux-omap could please help us? I'm hoping that we're just m=
issing
> some patches from somewhere, but it would be great if somebody could =
verify
> this (and indeed, verify that the interrupts we're registering in the=
 thread
> above look sane).
>
>> OProfile userspace support for ARM Cortex-A9 was added by Will Deaco=
n in June
>> 2010. =A0This support is available in OProfile 0.9.7. =A0According t=
o Will's
>> posting, the kernel support was due to be added to Ubuntu Maverick, =
so I would
>> expect your version should support CA9 out of the box. =A0If not alr=
eady using
>> oprofile 0.9.7, please upgrade to that version and retry. =A0If it s=
till doesn't
>> work, please re-post with complete information (kernel version, opro=
file command
>> output, and contents of /dev/oprofile/cpu_type).
>
> If with the latest OProfile, `timer mode' is still reported then you =
should
> check that you have CONFIG_HW_PERF_EVENTS enabled in your kernel. It =
still
> won't work though, because of the problems I mentioned above.

If debug message from 'dmesg' can be provided, maybe we can find clue
about the problem.

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
