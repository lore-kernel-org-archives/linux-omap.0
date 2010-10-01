From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
Date: Fri, 01 Oct 2010 08:07:04 -0700
Message-ID: <87k4m2c5pj.fsf@deeprootsystems.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>
	<87tyl8rxwp.fsf@deeprootsystems.com>
	<20100930021819.GD3117@atomide.com>
	<877hi3i9cp.fsf@deeprootsystems.com>
	<87pqvvgt8g.fsf@deeprootsystems.com>
	<877hi3gqq7.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34257 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab0JAPHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 11:07:06 -0400
Received: by pwj5 with SMTP id 5so573316pwj.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 08:07:06 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
	(Rajendra Nayak's message of "Fri, 1 Oct 2010 18:58:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

[...]

>> >>
>> >> Hmm, this fault is very early and long before any PM code has
>> >> initialzed.  I suspect this happens with the master branch too ??
>> >
>> > I've reproduced this now, and it doesn't happen on the master branch and
>> > only happens after merge pm-hwmods.
>> >
>> > Debugging now...
>> 
>> OK, so this failure is (somehow) related to the i2c hwmods, but I did
>> not figure out how.  Rajendra, can you dig into this?  It only seems to
>> happen on 2420/n800, and all other platforms seem OK.
>
> Hi Kevin,
>
> I was able to reproduce the crash on the n800 and have been debugging
> it for a while.  Like you said putting a HWMOD_INIT_NO_RESET did not
> seem to fix it for me, and the only way I can get the n800 to
> completely bootup is by removing the sysc completely for i2c.  That is
> quite surprising since the only thing that can be done using the
> sysconfig on omap2420 is a softreset.
>
> I verified that its not the sysc read itself that causes a crash
> (clocks seem to be enabled, idlest seems fine) but somehow just these
> sysc reads (if I have HWMOD_INIT_NO_RESET set) seem to be enough to
> cause the crash.  Nothing gets written back to the sysc register
> either.  I was suspecting the omap_readl's done in hmwod framework on
> the 16bit 2420 registers to be an issue, but I am yet to figure out
> how.
>
> I am debugging this further, but in the meantime since this is gating
> all other patches to get merged in omap-testing, should I just remove
> the sysc for i2c on 2420? The only thing it will prevent is a i2c
> softreset at boot, which anyway does not seem to be causing any issues
> on n800.

For omap-testing, I will just drop the i2c series for now until this is
better understood.

Happy debugging!   this sounds like a tricky one,

Kevin
