From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
Date: Tue, 05 Oct 2010 13:44:03 -0700
Message-ID: <87aamspdyk.fsf@deeprootsystems.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>
	<87tyl8rxwp.fsf@deeprootsystems.com>
	<20100930021819.GD3117@atomide.com>
	<877hi3i9cp.fsf@deeprootsystems.com>
	<87pqvvgt8g.fsf@deeprootsystems.com>
	<877hi3gqq7.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
	<4CA60F88.4020303@ti.com>
	<alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com>
	<0680EC522D0CC943BC586913CF3768C003FF3B2E05@dbde02.ent.ti.com>
	<874od0tvu3.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF3B2F3D@dbde02.ent.ti.com>
	<87y6acpghs.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF3B2F4D@dbde02.ent.ti.com>
	<87hbh0ped5.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF3B2F52@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55850 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab0JEUoG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 16:44:06 -0400
Received: by pzk34 with SMTP id 34so1760611pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 13:44:06 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF3B2F52@dbde02.ent.ti.com>
	(Rajendra Nayak's message of "Wed, 6 Oct 2010 02:11:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Wednesday, October 06, 2010 2:05 AM
>> To: Nayak, Rajendra
>> Cc: Paul Walmsley; Cousson, Benoit; Tony Lindgren; linux-omap@vger.kernel.org; Varadarajan, Charulatha; Raja,
>> Govindraj
>> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
>> 
>> "Nayak, Rajendra" <rnayak@ti.com> writes:
>> 
>> >> -----Original Message-----
>> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> >> Sent: Wednesday, October 06, 2010 1:19 AM
>> >> To: Nayak, Rajendra
>> >> Cc: Paul Walmsley; Cousson, Benoit; Tony Lindgren; linux-omap@vger.kernel.org; Varadarajan, Charulatha; Raja,
>> >> Govindraj
>> >> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
>> >>
>> >> "Nayak, Rajendra" <rnayak@ti.com> writes:
>> >>
>> >> >> -----Original Message-----
>> >> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> >> >> Sent: Tuesday, October 05, 2010 10:34 PM
>> >> >> To: Nayak, Rajendra
>> >> >> Cc: Paul Walmsley; Cousson, Benoit; Tony Lindgren; linux-omap@vger.kernel.org; Varadarajan, Charulatha;
>> Raja,
>> >> >> Govindraj
>> >> >> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
>> >> >>
>> >> >> "Nayak, Rajendra" <rnayak@ti.com> writes:
>> >> >>
>> >> >> > <snip>..
>> >> >> >
>> >> >> >> >
>> >> >> >> > Below is an untested patch to provide some mechanism to deal with this --
>> >> >> >> > I'd appreciate everyone's comments on this, particularly the comments in
>> >> >> >> > the patch code on how to deal with this problem.
>> >> >> >>
>> >> >> >> Hi Paul,
>> >> >> >>
>> >> >> >> I'll test this patch to see if it solves the issue seen with i2c on n800.
>> >> >> >
>> >> >> > Hi Paul, Benoit, Kevin,
>> >> >> >
>> >> >> > So looks like the issue with i2c on n800 isn't really because of additional
>> >> >> > delay needed after a clock enable, but related to the omap_readl/writel's
>> >> >> > done on the 16bit i2c registers as I was suspecting earlier.
>> >> >> >
>> >> >> > The below patch fixes the n800 issue for me. My mailer might mess up the alignment
>> >> >> > hence attaching it too.
>> >> >> >
>> >> >> > From af9733f2e63a16b446635d52015e05d631f0788f Mon Sep 17 00:00:00 2001
>> >> >> > From: Rajendra Nayak <rnayak@ti.com>
>> >> >> > Date: Tue, 5 Oct 2010 16:36:30 +0530
>> >> >> > Subject: [PATCH] OMAP: hwmod: Handle modules with 16bit registers
>> >> >> >
>> >> >> > Some modules which have 16bit registers can cause imprecise
>> >> >> > aborts if a __raw_readl/writel is used to read/write 32 bits.
>> >> >> >
>> >> >> > Add an additional flag to identify modules which have such
>> >> >> > hard requirement, and handle it in the hwmod framework.
>> >> >> >
>> >> >> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> >> >>
>> >> >> Can you also send a corresponding patch to the i2c hwmod data.
>> >> > Hi Kevin,
>> >> >
>> >> > Ok, I'll repost the original patch which adds the omap2 hwmod data with
>> >> > these flags added for omap2420. Does that sound fine?
>> >>
>> >> Since I've alrady done some manual merge conflicts here, you can just
>> >> post an additional patch and I will fold it in.
>> >
>> > Ok, so here's the patch
>> > ------
>> > From 06b4bb7a0ce96776d6d9b344b4786b48fceeffe1 Mon Sep 17 00:00:00 2001
>> > From: Rajendra Nayak <rnayak@ti.com>
>> > Date: Wed, 6 Oct 2010 01:49:32 +0530
>> > Subject: [PATCH] OMAP2: hmwod: Fix impresice aborts seen on n800/n810
>> >
>> > I2C module on OMAP2420 has 16bit registers and causes imprecise
>> > aborts if 32bits are read/wriitten into.
>> > Use the HWMOD_16BIT_REG flag to notify the hmwod framework of this
>> > hard requirement so that __raw_writew/readw is used to read /write
>> > the mdoule registers.
>> >
>> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> > ---
>> >  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    2 ++
>> >  1 files changed, 2 insertions(+), 0 deletions(-)
>> 
>> Thanks.
>> 
>> Shouldn't we do the same for 2430?  I guess the imprecise aborts aren't
>> happening on 2430, but I think we should still use the 16-bit accesses
>> there too.
>> 
>> What do you think?
>
> Yeah, actually i2c modules on all OMAPs including OMAP4 have had 16 bit registers.
> But somehow only 2420 seemed to cause issues.

OK, then let's keep this as a targetted fix for this merge window, and
we can discuss whether this needs to be done for all OMAPs later.

I'll use you current patch,

Thanks,

Kevin
