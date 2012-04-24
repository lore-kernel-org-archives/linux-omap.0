From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V3 3/3] ARM: OMAP: Make OMAP clocksource source selection using kernel param
Date: Mon, 23 Apr 2012 17:32:57 -0700
Message-ID: <87ehreezpi.fsf@ti.com>
References: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
	<1334309947-25214-4-git-send-email-hvaibhav@ti.com>
	<87k41bqm0j.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A83E9F9AD0@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:49190 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751064Ab2DXAcv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 20:32:51 -0400
Received: by dadn15 with SMTP id n15so167196dad.2
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 17:32:50 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83E9F9AD0@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Mon, 23 Apr 2012 17:35:19 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

> On Fri, Apr 20, 2012 at 06:04:20, Hilman, Kevin wrote:

[...]

>> Also note that because you're adding an offset of 0x10 to the start, the
>> ioremap later is actually mapping 0x10 past the end.  More on the base
>> address later...
>> 
>
> Comment on top of this code will enough, isn't it?
>

No.  ioremapping() the range that goes past the end of the device is
just wrong.  But if you fix the offset as described below, that would be
fine.

[...]

>> > @@ -68,54 +66,43 @@ void read_persistent_clock(struct timespec *ts)
>> >  	*ts = *tsp;
>> >  }
>> >
>> > -int __init omap_init_clocksource_32k(void)
>> > +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
>> 
>> Now that this takes some arguments, this function wants some kerneldoc.
>> 
>
> Should I create new documentation inside Documentation/arm/OMAP/
> with name "counter_32k"?

by kerneldoc, I mean comments in the code, not in Documenation.

IOW, just add a comment before this function in the code, but make sure
it is of the format described in Documentation/kernel-doc-nano-HOWTO.txt.

>> In particular, you should document that 'pbase' is the address of the
>> counter register, not the base of the IP.
>> 
>> That being said, I think the pbase passed in should probably be the base
>> of the IP register, not the address of the counter register. It seems to
>> me that it's at offset 0x10 on all SoCs anyways.
>> 
>> Doing that will also ensure that the ioremap'd range covers the whole
>> IP, and not from the counter register to 0x10 past the end.
>> 
>
> Yeah, you are right, I can get rid of this offset and move it to 
> counter_32k.c file.

Perfect.

Kevin

