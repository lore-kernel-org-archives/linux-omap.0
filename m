From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
Date: Tue, 05 Oct 2010 10:04:20 -0700
Message-ID: <874od0tvu3.fsf@deeprootsystems.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40839 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab0JERE3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 13:04:29 -0400
Received: by pzk34 with SMTP id 34so1702342pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 05 Oct 2010 10:04:28 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF3B2E05@dbde02.ent.ti.com>
	(Rajendra Nayak's message of "Tue, 5 Oct 2010 18:03:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> <snip>..
>
>> >
>> > Below is an untested patch to provide some mechanism to deal with this --
>> > I'd appreciate everyone's comments on this, particularly the comments in
>> > the patch code on how to deal with this problem.
>> 
>> Hi Paul,
>> 
>> I'll test this patch to see if it solves the issue seen with i2c on n800.
>
> Hi Paul, Benoit, Kevin,
>
> So looks like the issue with i2c on n800 isn't really because of additional
> delay needed after a clock enable, but related to the omap_readl/writel's
> done on the 16bit i2c registers as I was suspecting earlier.
>
> The below patch fixes the n800 issue for me. My mailer might mess up the alignment
> hence attaching it too.
>
> From af9733f2e63a16b446635d52015e05d631f0788f Mon Sep 17 00:00:00 2001
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Tue, 5 Oct 2010 16:36:30 +0530
> Subject: [PATCH] OMAP: hwmod: Handle modules with 16bit registers
>
> Some modules which have 16bit registers can cause imprecise
> aborts if a __raw_readl/writel is used to read/write 32 bits.
>
> Add an additional flag to identify modules which have such
> hard requirement, and handle it in the hwmod framework.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Can you also send a corresponding patch to the i2c hwmod data.

I'll rebase the rest of the series against current l-o master, and maybe
we can still get this in for .37.

Kevin
