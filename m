From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
Date: Wed, 29 Sep 2010 12:16:20 -0700
Message-ID: <87lj6kz7gb.fsf@deeprootsystems.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>
	<87d3rxblfu.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF48@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:39479 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab0I2TQX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 15:16:23 -0400
Received: by pxi10 with SMTP id 10so280876pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 12:16:23 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF2DAF48@dbde02.ent.ti.com>
	(Rajendra Nayak's message of "Wed, 29 Sep 2010 21:44:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

> <snip>..
>
>> > > This is with the omap2plus_defconfig and after editing cmdline to have console set
>> > > to ttyO2.
>> > >
>> > > Would be nice to have those fixed before we merge it.
>> >
>> > Rajendra, can you look into this on OMAP2?  This is happening for Tony
>> > on both n8x0 and 2430sdp.
>> 
>> Sure, I'll have a look.
>
> Kevin,
>
> I saw 3 issues with the patch which adds OMAP2 hwmods which I never seem to have
> caught with the boottest on 2430 that I tried before I posted the patches.

Thanks for digging into this.

[...]

>
> These are the fixes that make it boot on 2430sdp. Should I repost the original patch with these fixes?

Yes please.

Kevin
