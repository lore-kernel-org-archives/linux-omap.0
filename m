From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
Date: Sat, 22 May 2010 02:34:52 +0300
Message-ID: <AANLkTinMFJTlbXYiS9G87VSQyRuGxJfJGHkVejOEfgVQ@mail.gmail.com>
References: <1274478289-22188-1-git-send-email-felipe.contreras@gmail.com>
	 <20100521215730.GK11042@n2100.arm.linux.org.uk>
	 <AANLkTin03gFY1uc9__lGO8lHiKMjuSBRSYcFDhLYDIMD@mail.gmail.com>
	 <20100521221557.GM11042@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47530 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758787Ab0EUXe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 19:34:56 -0400
Received: by bwz7 with SMTP id 7so221150bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 16:34:54 -0700 (PDT)
In-Reply-To: <20100521221557.GM11042@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Felipe Contreras <felipe.contreras@nokia.com>

On Sat, May 22, 2010 at 1:15 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, May 22, 2010 at 01:09:12AM +0300, Felipe Contreras wrote:
>> On Sat, May 22, 2010 at 12:57 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > The only reason 3 would be loaded due to that dependency is if 2 were
>> > being modprobed, which means it's going to be inserted after 3 anyway.
>> >
>> > I don't see anything else in 3 which would trigger it to be loaded.
>> >
>> > The "platform:omap2-mailbox" module alias of 2 should result in 2
>> > being modprobed,
>>
>> I see, at initialization?
>
> That's the theory - and it should be that same mechanism which allows
> things like already plugged in PCMCIA and the like cards to be properly
> dealt with at boot time.
>
>> > causing 3 to be loaded to satisfy the dependency.
>> > As already pointed out, this should happen as a result of udev or
>> > (older) hotplug initialization.
>>
>> Well, in the minimal system I have in my beagleboard it doesn't
>> happen. I load bridgedriver, which loads mailbox, but fails
>> immediately because mailbox_mach is not there.
>
> I assume that having the MMC host driver built in, but the MMC block
> driver as a module also doesn't work on your setup?

I wouldn't know because my file-system is on the MMC.

> I don't see this as something that should be worked around in the
> kernel by making things non-modular - I view the missing userspace
> functionality causing the problem.

First of all, most of the cleanups are independent of the built-in
option, although that was my motivation, the patches are good by
themselves: there's no need to export
omap_mbox_register()/_unregister() unnecessarily when the platform
data can be used, right?

Now, regarding the built-in mode; for the iommu case you said it
should be built-in:
http://article.gmane.org/gmane.linux.ports.arm.kernel/58555

Apparently it's not, so it's not clear to me how omap3-iommu would be
loaded since there's no "platform:" alias.

Moreover, Tony says that anything that registers platform devices
should be built-in, but omap3-iommu does register devices and is not
built-in. We could make it built-in as you suggested, but according to
you, things should be modular.

So, I have a bunch of questions:
1) should platform devices be built-in?
2) should platform modules like omap3-iommu and mailbox-mach have a
"platform:" alias?
3) should such modules follow a guideline like foo-mach, or $mach-foo?

>From what I can see there's already a lot of code that adds platform
data at registering time, which is built-in, but I guess you object
because of the size of all the extra data and code that would come by
making mach-omapX/mailbox.c as built-in. Am I right?

If that's the case I agree, although I have the feeling that the
platform-specific data can be reduced a lot.

But again, only one of the patches makes the code built-in, the rest
of the patches are independent of that.

-- 
Felipe Contreras
