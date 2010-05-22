From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
Date: Sat, 22 May 2010 17:16:00 +0300
Message-ID: <AANLkTinAg5EtKRBMIPFypLnuPaRA1rXLZEd--jl8VZ8p@mail.gmail.com>
References: <AANLkTin03gFY1uc9__lGO8lHiKMjuSBRSYcFDhLYDIMD@mail.gmail.com>
	 <20100521221557.GM11042@n2100.arm.linux.org.uk>
	 <AANLkTinMFJTlbXYiS9G87VSQyRuGxJfJGHkVejOEfgVQ@mail.gmail.com>
	 <20100522.081415.258113387.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35157 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab0EVOQC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 10:16:02 -0400
Received: by bwz7 with SMTP id 7so355346bwz.19
        for <linux-omap@vger.kernel.org>; Sat, 22 May 2010 07:16:00 -0700 (PDT)
In-Reply-To: <20100522.081415.258113387.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, felipe.contreras@nokia.com

On Sat, May 22, 2010 at 8:14 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: ext Felipe Contreras <felipe.contreras@gmail.com>

>> Apparently it's not, so it's not clear to me how omap3-iommu would be
>> loaded since there's no "platform:" alias.
>
> This alias is only necessary for platform drivers.

So, omap3-iommu should be built-in (since it would not be loaded
automatically), so the "platform:" alias is not _required_, but can't
hurt anyway. Right?

>> Moreover, Tony says that anything that registers platform devices
>> should be built-in, but omap3-iommu does register devices and is not
>> built-in.
>
> It seems that this makes you confused. It should have been
> build-in;). This is going to be integrated into omap hwmod framework
> soon.

The hwmod framework will deal with the resources, not with the
platform device. Somebody, presumably the current omap3-iommu, would
have to call omap_device_build() with the right hwmod and platform
data.

>> We could make it built-in as you suggested, but according to
>> you, things should be modular.
>>
>> So, I have a bunch of questions:
>> 1) should platform devices be built-in?
>
> Yes.
>
>> 2) should platform modules like omap3-iommu and mailbox-mach have a
>> "platform:" alias?
>
> No.

They must have it when compiled as a module, but if not, it's not
_needed_, but does it hurt?

>> 3) should such modules follow a guideline like foo-mach, or $mach-foo?
>
> No, this is not a guideline. Just to avoid the module name cofliction.

I know there is no guideline, I'm asking if there _should_ be one. It
would be interesting to do lsmod | grep "^*-mach".

>> From what I can see there's already a lot of code that adds platform
>> data at registering time, which is built-in, but I guess you object
>> because of the size of all the extra data and code that would come by
>> making mach-omapX/mailbox.c as built-in. Am I right?
>
> Yes.
>
>> If that's the case I agree, although I have the feeling that the
>> platform-specific data can be reduced a lot.
>
> Then, eventually the code would result in the one which the current
> "devices.ko" has at present.
>
> The point is that, only 17 lines of patch does the same, more
> simply. The conversion of your fake platform device doesn't make
> much sense.

I'm not sure what you mean.

Anyway, I started playing with hwmod on top of my branch and I found
that there same cleanups are possible without the need to move
platform_device resources.

I will split the series in two: one for cleanups, and one for hwmod +
platform_device split (RFC). And hopefully the possibilities would be
clear.

Cheers.

-- 
Felipe Contreras
