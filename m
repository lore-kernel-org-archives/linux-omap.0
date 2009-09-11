From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: FW: [RFC][PATCH]: Adding support for omap-serail driver
Date: Fri, 11 Sep 2009 14:25:30 -0700
Message-ID: <8763bp5g39.fsf@deeprootsystems.com>
References: <F12CE1A68F023D498A2691C7B539311503935BC4@ZMY16EXM66.ds.mot.com>
	<87ws46aj2a.fsf@deeprootsystems.com>
	<d6a0f7aa0909102315r3ec682a3u9b3da26eb031ca27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:44113 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbZIKVZa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 17:25:30 -0400
Received: by pxi27 with SMTP id 27so1084959pxi.15
        for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 14:25:33 -0700 (PDT)
In-Reply-To: <d6a0f7aa0909102315r3ec682a3u9b3da26eb031ca27@mail.gmail.com> (Govindraj's message of "Fri\, 11 Sep 2009 11\:45\:02 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: HU TAO-TGHK48 <taohu@motorola.com>, linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> Hi,
>
>>
>> FWIW, as the author of much of the PM hacker in mach-omap2/serial.c, I
>> agree with Tao.
>>
>> The only reason for the PM hackery in mach-omap2/serial.c is because
>> of the limitations of the 8250 driver.
>>
>
> I have an query,
>
> We have following functionality in serial.c:
> 1.) Enabling and disabling uart clocks.
> 2.) Adding rx wakeup capabilities.
> 3.) Preparing UARTs for idle mode.
> 4.) Context save and restore.
>
> What functionality should be retained in serial.c file?
>
> AFAIK currently no serial driver has incorporated their platform
> specific PM functionality like context_save and restore into their
> serial driver, shouldn't these things be retained into
> */mach-omap2/serial.c ?

Only SoC and/or board-specific settings should be done in serial.c
(setup of base addresses, IRQs, DMA channels, etc.)

The driver is an OMAP specific driver, but should be general enough to
independent of any board/SoC specifics.

IMO, all of 1-4 above above belong in the driver.  Evenutally the
enabling/disabling of clocks will be handled by the runtime PM layer,
but the driver will have a similar enable/disable API.

Kevin


