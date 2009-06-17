From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: MMC: Add mux for pins
Date: Wed, 17 Jun 2009 15:57:58 -0700
Message-ID: <87zlc6v56x.fsf@deeprootsystems.com>
References: <1244846488-28313-1-git-send-email-vikram.pandita@ti.com>
	<20090615081242.GE4474@atomide.com>
	<5C07676A-0A93-48DE-B4C0-5A6709BE34A8@gmail.com>
	<20090615110431.GO4474@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D146A@dbde02.ent.ti.com>
	<87y6rs2nu0.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D14A4@dbde02.ent.ti.com>
	<20090617081206.GD6605@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D18B1@dbde02.ent.ti.com>
	<87my86yau1.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D18C6@dbde02.ent.ti.com>
	<878wjqy1yj.fsf@deeprootsystems.com> <4A3972C8.2090502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f192.google.com ([209.85.222.192]:64694 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757417AbZFQW57 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 18:57:59 -0400
Received: by pzk30 with SMTP id 30so139043pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 15:58:01 -0700 (PDT)
In-Reply-To: <4A3972C8.2090502@ti.com> (Jon Hunter's message of "Wed\, 17 Jun 2009 17\:48\:40 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, Hugo Vincent <hugo.vincent@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

Jon Hunter <jon-hunter@ti.com> writes:

> Kevin Hilman wrote:
>> "Pandita, Vikram" <vikram.pandita@ti.com> writes:
>>
>>>> -----Original Message-----
>>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>
>>>>>> If some pins are always needed, and don't have alternative pinouts, then
>>>>>> the common pins could be muxed in devices.c.
>>>>> This is the algo we can use for MMC pin muxing in that case:
>>>>>
>>>>> MMC1: No pin has mux clash
>>>>> 	Mux all 10 pins in devices.c
>>>> Is this common across 34xx and 35xx?
>>> Yes this is common.
>>> Both are same OMAP3 marketed differently.
>>
>> Yes, but they are in different packages, so I was curious if the pin
>> muxing is identical across the different packages.
>
> The ball/pad numbers may change due to the package, but the registers
> used to configure the pin muxing and the pin muxing options will not
> change. So from a software standpoint it is the same.
>
> The OMAP3530 is available in 3 packages, namely CBB, CBC and CUS
> according to the data manual [1]. The OMAP3430 is only available in
> the CBB package.
>
> What this means is that the name "N28_3430_MMC1_CLK", which associates
> ball N28 with signal MMC1_CLK, is appliable to the OMAP3430 and
> OMAP3530 CBB package, but not applicable to the OMAP3530 CBC and CUS
> packages
> as this ball number does not exist on these packages. This is simply a
> difference in naming of the balls between the packages but does not
> impact the pin muxing options.

OK, good.  Thanks for the clarification.

Tony and I were thinking a few weeks back that we should drop the ball
names from these mux options anyways as they don't really add any
value, and seem to add more confusion.  Sounds like it's the right
thing to do in this context.

Kevin



