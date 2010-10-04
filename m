From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: tidspbridge broken?
Date: Mon, 4 Oct 2010 19:29:51 +0300
Message-ID: <AANLkTimH0+jeFx+zUh6u_uzqhL+rB5W6s3PYOatHMB6b@mail.gmail.com>
References: <AANLkTi=hD1m0jC64KW7gHdywd=2GseX8gqNwPTHOh6s2@mail.gmail.com>
	<27F9C60D11D683428E133F85D2BB4A5304680CC90F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43220 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab0JDQ3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 12:29:53 -0400
Received: by bwz11 with SMTP id 11so3727729bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 09:29:52 -0700 (PDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A5304680CC90F@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>, "Menon, Nishanth" <nm@ti.com>, "ohad@wizery.com" <ohad@wizery.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>

Hi,

On Mon, Oct 4, 2010 at 6:59 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
> Felipe Contreras wrote:
>> I was trying the iommu patches but I noticed the tidspbridge driver
>> doesn't work at all, I found two critical issues:
>>
>> First, the platform device is missing, so there's no way the driver
>> can work. It seems to have been dropped from the migration to staging
>> which happened some time ago... I would have expected somebody to
>> notice a thing like this. I already have patches that fix this.
>
> Yes this is missing from beginning, I seeked advice on whether to send a patch for this or not, and since it would be touching mach dependent files it would be out of the scope of staging tree, however if needed:
>
> http://dev.omapzoom.org/?p=tidspbridge/kernel-dspbridge.git;a=commit;h=4dcb41d484653d162b2bc6e1bf226c2dad0b953c
>
> This was meant to placed under dspbridge wiki, I still have to do that one.

This seems to be worth mentioning in the TODO file:
* Make it actually work

Anyway, first, I think I tried a version similar to that one, and
doesn't apply on mainline any more, also, bootmem doesn't seem to be
working on ARM either, so I had to move to memblock, and third, I
don't think that platform device is correct since it depends on the
headers of a driver.

My version is basically the same, but using memblock, and stands on
it's own. Even if tidspbridge wasn't in staging I think this could go
to mainline, plus, perhaps other implementations like dsp-link could
make use of it (who knows):
http://article.gmane.org/gmane.linux.kernel/1044209

>> And second, since 2.6.35, ioremap() doesn't work on RAM, so this
>> driver cannot work anymore unless 309caa9 is reverted. I am reserving
>> the memory with memblock, but it still fails the ioremap(), and
>> __va() doesn't seem to work (don't know why).
>
> Yes that's true, so far the only solution I have seen is to move the allocation on memory outside kernel control, I believe framebuffer has the same problem, but I haven't contacted them to see if we can align on a common solution.

At least on my N900 the framebuffer is not working either, and I've
heard the same on beagleboard.

Maybe something like this:
http://article.gmane.org/gmane.linux.kernel.mm/52757

>> Has anyone tried the driver on 2.6.36-rcX?
>
> Yes I have,

I guess by applying your patches on top and reverting 309caa9.

> I was rebasing your mailbox hwmod patches but seems something has changed since they don't work, I was trying to write my own version.

You should have said so, I'll try to rebase myself.

Cheers.

-- 
Felipe Contreras
