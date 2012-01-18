From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Wed, 18 Jan 2012 22:58:10 +0100
Message-ID: <CAMsRxfJmHkZw2f0A+4FsStJpXk_vrxvDduRcRGkcWpqp8a9m_w@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
	<4F0B182D.7060507@us.ibm.com>
	<20120109224945.GA23090@mudshark.cambridge.arm.com>
	<CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
	<CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
	<CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
	<CAMsRxfLtLnMiP0ZGr6rNLv-UeLUwOSJ=7do2nezOU5OkOA+MbQ@mail.gmail.com>
	<CACVXFVMbrQGi4Sg9TUPP5Bcc5kzFoX74n=ii4QrDRudbuDHOGg@mail.gmail.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50703 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab2ARV6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jan 2012 16:58:12 -0500
Received: by vbbfp1 with SMTP id fp1so2284817vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Jan 2012 13:58:11 -0800 (PST)
In-Reply-To: <CACVXFVMbrQGi4Sg9TUPP5Bcc5kzFoX74n=ii4QrDRudbuDHOGg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>, Maynard Johnson <maynardj@us.ibm.com>, Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>

Ming,

Ok, so I used Linus' tree @

It already includes patches #1 and #2. I applied 4-6.
Recompiled but my kernel does not boot, I don't see
anything on the serial console. Could be a broken
.config file. Could you send me your .config for Panda?

Thanks.

On Wed, Jan 18, 2012 at 11:07 AM, Ming Lei <ming.lei@canonical.com> wrote:
> Hi,
>
> On Wed, Jan 18, 2012 at 5:54 PM, stephane eranian <eranian@googlemail.com>
>> Should I use Will's -next tree as the base instead of Linus'?
>
> Either one is OK. If you use linus tree as base, you need to apply the #1 and
> #2 patch manually.
>
>> Given that MARC is shutdown today, would you mind packing those patches
>> into a tarball and sending them to me directly?
>
> See attachment, which includes the patches from #3 to #6.
>
>>
>> When you mention Will's -next tree, are you talking about:
>> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
>
> It is perf/omap4 brach, you can pick up the two patches[1][2] directly from
> the branch.
>
>
> thanks,
> --
> Ming Lei
>
> [1], http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=commit;h=7924a3eba0766348d6d6a56cbb9873cdbcab0d8c
>
> [2], http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=commit;h=bde071f005e2dc71378aff69e86b961d8cd7922f
