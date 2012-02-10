From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Fri, 10 Feb 2012 18:29:30 +0200
Message-ID: <CAMP44s3S3qFEfOE-cJtaLCS7DYVG4GnnmYdoj5PFnTqFzreAwg@mail.gmail.com>
References: <20120201034445.GA2979@kroah.com>
	<CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
	<20120209173528.GA31726@kroah.com>
	<CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
	<20120209185923.GB10284@kroah.com>
	<CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
	<CAB-zwWj0z9N_2RRHBBNcHPLYWRii2T8q+gMgBnA3+ux8Ojg9JA@mail.gmail.com>
	<20120210051849.GE1565@kroah.com>
	<20120210073554.e9047c25c3fff71028f03fb2@gmail.com>
	<CAMP44s29yn-vYThbr6cDsvvFgKVELW1nA=onkkVHwp4h2yi_hQ@mail.gmail.com>
	<20120210161657.GA4162@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34892 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753497Ab2BJQ3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 11:29:32 -0500
Received: by lagu2 with SMTP id u2so2493494lag.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Feb 2012 08:29:30 -0800 (PST)
In-Reply-To: <20120210161657.GA4162@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Justin P. Mattock" <justinmattock@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org

On Fri, Feb 10, 2012 at 6:16 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 10, 2012 at 06:05:59PM +0200, Felipe Contreras wrote:
>> > From 5c7ad6c00d051d5444474007cdbecdf14bf3d0cb Mon Sep 17 00:00:00 2001
>> > From: "Justin P. Mattock" <justinmattock@gmail.com>
>> > Date: Fri, 10 Feb 2012 07:19:45 -0800
>> > Subject: [PATCH] Add dependency TIDSBRIDGE_WDT3 to TIDSBRIDGE.
>> >
>> > This would add the missing _dependency_ to tidsbridge to prevent a warning from happening.
>> >
>> > Note: my Kconfig skills are not the greatest so the below may or may not work.
>> > I can't test this because I dont have the hardware.
>>
>> Your patch *always* turns on TIDSPBRIDGE_WDT3, which is not what we
>> want. Depending on the firmware, some people might want it off.
>
> What firmware?

What do you think is the purpose of tidspbridge?

> Why not document this properly somewhere in the help
> entries?

It is documented (kinda). If you are using a non-standard baseimage,
you should know what is the watchdog timer, and whether or not your
baseimage supports it.

Fortunately, the vast majority of users don't need to care about it.
They can just use the default.

> Why not detect this automatically in the kernel based on the
> firmware version?

There is no firmware version. The "firmware", or rather baseimage, is
an operating system.

You can't detect if Linux has USB support based on the Linux version, can you?

>> Basically, right now on the typical firmware, people have to either
>> manually turn TIDSPBRIDGE_WDT3 on, or they will see the warning.
>
> So, for the "typical" firmware, you do want this on, so the patch makes
> sense.

Yes.

> How about the code be fixed so that it doesn't generate this type of
> warning when using the "typical" firmware, instead of having to rely on
> confusing Kconfig entries.

Patches welcome.

I for one don't know a way, and I'd rather concentrate on one of the
myriad other tasks that need to be done for this driver. I just
thought it would be nice to make it easier for most users to avoid
this warning.

Cheers.

-- 
Felipe Contreras
