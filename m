From: Jeroen Hofstee <jeroen@myspectrum.nl>
Subject: Re: [PATCH] ARM: dts: AM35xx: fix system control module clocks
Date: Mon, 08 Jun 2015 23:43:29 +0200
Message-ID: <55760C81.3020602@myspectrum.nl>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com> <1433172627-28052-1-git-send-email-t-kristo@ti.com> <556C8ED5.5050000@myspectrum.nl> <20150601173126.GY30984@atomide.com> <alpine.DEB.2.02.1506011733180.14902@utopia.booyaka.com> <5571576E.6020207@myspectrum.nl> <557157FA.7080305@myspectrum.nl> <557411DC.9020109@myspectrum.nl> <alpine.DEB.2.02.1506071952490.15153@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from orange.myspectrum.nl ([149.210.134.247]:59987 "EHLO
	orange.myspectrum.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257AbbFHVnd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2015 17:43:33 -0400
In-Reply-To: <alpine.DEB.2.02.1506071952490.15153@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tom Rini <trini@konsulko.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Paul,

On 07-06-15 21:56, Paul Walmsley wrote:
> On Sun, 7 Jun 2015, Jeroen Hofstee wrote:
>
>>
>> Turns out my suspicion was wrong. This is what I know at the moment,
>> depending on the bootpins, u-boot will trigger a bad access when loading
>> a file over ethernet, but only the first time. Clearing the pending interrupt
>> before booting linux make the "USB_OTG address hole seen" go away.
> Oh, too bad.  I had been hoping that you were right and that I was wrong
> ;-)  I'll try this on the CM-T3517 here.
>
> I'd like to solicit your opinion on what to do here.  I wonder if, in the
> L3 bus drivers, we should simply report, in a line or two, if any bus
> errors were logged before the kernel starts?  That would help discriminate
> between problems that the kernel is responsible for, vs. problems that
> occur earlier in the boot process.  Any thoughts?
>

I am not sure this can be easily done in a general manner.  Since in general
linux doesn't know the bootloader, it can't rely on what peripherals are 
setup,
so I doubt it is in general possible to store a copy of the interrupt 
registers
really early. Besides that, when not hacking around, I guess during the 
really
early boot stage it is unknown what the interrupt registers are in the 
first place
and which clocks are needed. And even if it could be done, if there is a 
bug in
that code, it would lead to bigger problems than it is trying to solve 
(a bit weird
backlogs).

I guess it would be easier to check these flags in u-boot right before 
the jump
to linux  (there is a cleanup_before_linux() or something name like 
that). [ Or fake
the boot and run the check as a separate command]. Unfortunately u-boot does
not have a complete driver model, so a implementation of that in todays 
u-boot
will lead to a complete #ifdef CONFIG_foo mesh.

So, if you ask me, no don't add it to linux, but to u-boot instead. But 
likely as feature
for a later release which can query all drivers. (and doubt this should 
be limited to
interrupt flags, runtime_test() could be called on all of them e.g. when 
entering a
command like runtime_test).

Regards,
Jeroen

