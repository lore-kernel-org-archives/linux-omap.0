From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 9 Jan 2012 22:49:46 +0000
Message-ID: <20120109224945.GA23090@mudshark.cambridge.arm.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49625 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933477Ab2AIWuH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 17:50:07 -0500
Content-Disposition: inline
In-Reply-To: <4F0B182D.7060507@us.ibm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maynard Johnson <maynardj@us.ibm.com>
Cc: Lik Lik <lik88888@gmail.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eranian@googlemail.com, ming.lei@canonical.com

On Mon, Jan 09, 2012 at 04:39:09PM +0000, Maynard Johnson wrote:
> On 01/08/2012 8:58 PM, Lik Lik wrote:
> > Hi all,

Hi guys [adding a bunch of people to CC because this issue is really
annoying me now],

> > I am an oprofile user and I need to profile one of my applications on a TI OMAP4
> > platform (pandaboard, to be specific). I have ubuntu 11.10 installed. My problem
> > is that oprofile always use the timer interrupt mode but doesn't recognize the
> > hardware counters, which I am sure my platform has.

First and foremost, we can't currently generate PMU interrupts on OMAP4 in
mainline. There are some additional patches required for these to work:

http://marc.info/?l=linux-arm-kernel&m=131946761428296&w=2

However, as Stephane has pointed out here:

http://marc.info/?l=linux-omap&m=132585784125352&w=2

the interrupts still don't seem to work, even with the patches above
applied.

Ming Lei doesn't seem to be replying to email anymore, so maybe somebody
else on linux-omap could please help us? I'm hoping that we're just missing
some patches from somewhere, but it would be great if somebody could verify
this (and indeed, verify that the interrupts we're registering in the thread
above look sane).

> OProfile userspace support for ARM Cortex-A9 was added by Will Deacon in June 
> 2010.  This support is available in OProfile 0.9.7.  According to Will's 
> posting, the kernel support was due to be added to Ubuntu Maverick, so I would 
> expect your version should support CA9 out of the box.  If not already using 
> oprofile 0.9.7, please upgrade to that version and retry.  If it still doesn't 
> work, please re-post with complete information (kernel version, oprofile command 
> output, and contents of /dev/oprofile/cpu_type).

If with the latest OProfile, `timer mode' is still reported then you should
check that you have CONFIG_HW_PERF_EVENTS enabled in your kernel. It still
won't work though, because of the problems I mentioned above.

Cheers,

Will
